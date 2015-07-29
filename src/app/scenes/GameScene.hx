package app.scenes;

import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
//import app.math.Vector2;
import ash.core.System;
import ash.core.Entity;
import ash.core.Engine;

import app.systems.SystemPriorities;
import app.systems.SystemEvents;
import app.systems.RenderSystem;
import app.systems.InputSystem;
import app.systems.VehicleSystem;
import app.systems.LevelLoadingSystem;
import app.systems.GameSystem;
import app.systems.CollisionSystem;
import app.systems.SoundSystem;
import app.components.GameState;

import openfl.events.KeyboardEvent;

class GameScene extends Sprite {

	private var rootScene: Sprite;	//Haupt-Sprite des Spiels
	private var engine: Engine;		//Engine des Entity-Component-System
	private var previousTime: Float;	//Hilfsvariable, um Framerate zu ermiteln

	public function new(rootScene: Sprite) {
		super();

		this.rootScene = rootScene;
		previousTime = 0;

		startGame(); //ECS starten
		addEventListener(Event.ENTER_FRAME, onEnterFrame); //Events registrieren

	}

	private function startGame() : Void {

		engine = new Engine();

		//Events, die zwischen Systemen ausgetauscht werden
		var systemEvents: SystemEvents = new SystemEvents();

		//Ein Entity erstellen, das das Spiel repräsentiert
		engine.addEntity( new Entity().add(new GameState()) );


		//Systeme der Engine hinzufügen
		engine.addSystem( new InputSystem(systemEvents, this), 		SystemPriorities.update );
		engine.addSystem( new VehicleSystem(systemEvents), 			SystemPriorities.update );
		engine.addSystem( new SoundSystem(systemEvents), 			SystemPriorities.update );
		engine.addSystem( new CollisionSystem(systemEvents), 		SystemPriorities.collisions );
		engine.addSystem( new RenderSystem(systemEvents, this), 	SystemPriorities.render );
		engine.addSystem( new LevelLoadingSystem(systemEvents), 	SystemPriorities.last);
		engine.addSystem( new GameSystem(systemEvents), 			SystemPriorities.preUpdate);

	

	}

	//Wird jedes Frame aufgerufen (~ 30x pro Sekunde)
	private function onEnterFrame(event: Event) : Void {

		//Das ECS muss wissen, wie lange ein Frame dauert.

        var elapsedTime: Float = Lib.getTimer() - previousTime; //Vergangene Zeit seit vergangenem Frame ermitteln (in Milisekunden).
        previousTime = Lib.getTimer(); //Aktuelle Zeit für das nächste Frame zwischenspeichern.

        engine.update(elapsedTime / 1000); //An ECS weitergeben

	}

} 