package app;

import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
import ash.core.System;
import ash.core.Entity;
import ash.core.Engine;

import haxe.ui.toolkit.core.RootManager;

import app.systems.SystemPriorities;
import app.systems.CameraSystem;
import app.systems.SystemEvents;
import app.systems.RenderSystem;
import app.systems.UISystem;
import app.systems.InputSystem;
import app.systems.VehicleSystem;
import app.systems.LevelLoadingSystem;
import app.systems.GameSystem;
import app.systems.CollisionSystem;
import app.systems.SoundSystem;
import app.systems.AnimationSystem;
import app.scenes.MainMenuScene;
import app.components.GameState;

import app.scenes.Scene;
import app.Configuration;

import openfl.events.KeyboardEvent;

class Game extends Sprite {

    private var engine: Engine;     //Engine des Entity-Component-System
    private var previousTime: Float;    //Hilfsvariable, um Framerate zu ermiteln
    public var systemEvents: SystemEvents;
    private var scene: Scene;
    private var configuration: Configuration;

    public function new(systemEvents: SystemEvents, scene: Scene) {
        super();

        this.systemEvents = systemEvents;
        this.scene = scene;
        this.configuration = new Configuration();
        previousTime = 0;

        startGame(); //ECS starten
        addEventListener(Event.ENTER_FRAME, onEnterFrame); //Events registrieren

    }

    private function startGame() : Void {

        engine = new Engine();


        //Systeme der Engine hinzufügen
        engine.addSystem( new InputSystem(systemEvents, this),      SystemPriorities.update );
        engine.addSystem( new VehicleSystem(systemEvents),          SystemPriorities.update );
        engine.addSystem( new CameraSystem(systemEvents),           SystemPriorities.update );
        if (configuration.VOLUME)
            engine.addSystem( new SoundSystem(systemEvents),            SystemPriorities.update );
        engine.addSystem( new AnimationSystem(systemEvents),        SystemPriorities.update );
        engine.addSystem( new CollisionSystem(systemEvents),        SystemPriorities.collisions );
        engine.addSystem( new RenderSystem(systemEvents, this),     SystemPriorities.render );
        engine.addSystem( new UISystem(systemEvents, scene),        SystemPriorities.render );
        engine.addSystem( new LevelLoadingSystem(systemEvents),     SystemPriorities.last);
        engine.addSystem( new GameSystem(systemEvents),         SystemPriorities.preUpdate);

    }



    //Wird jedes Frame aufgerufen (~ 30x pro Sekunde)
    private function onEnterFrame(event: Event) : Void {

        //Das ECS muss wissen, wie lange ein Frame dauert.

        var elapsedTime: Float = Lib.getTimer() - previousTime; //Vergangene Zeit seit vergangenem Frame ermitteln (in Milisekunden).
        previousTime = Lib.getTimer(); //Aktuelle Zeit für das nächste Frame zwischenspeichern.

        engine.update(elapsedTime / 1000); //Verstrichene Zeit (in Sekunden) an ECS weitergeben

    }


} 