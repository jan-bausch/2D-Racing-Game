package app.scenes;

import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
import hxmath.math.Vector2;
import ash.core.System;
import ash.core.Entity;
import ash.core.Engine;

import app.systems.SystemPriorities;
import app.systems.RenderSystem;
import app.systems.InputSystem;
import app.systems.VehicleSystem;
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

		//Ein Entity erstellen, das das Spiel repräsentiert
		engine.addEntity( new Entity().add(new GameState()) );

		engine.addEntity( new app.entities.Grass(300, 300, 2000,2000) );
		engine.addEntity( new app.entities.Road(new Vector2(-300,0),  new Vector2(300,300), Math.PI / 2, Math.PI / 2, 250) );
		engine.addEntity( new app.entities.Car(0, 0) );

		//Systeme der Engine hinzufügen
		engine.addSystem( new InputSystem(this), SystemPriorities.update );
		engine.addSystem( new VehicleSystem(), SystemPriorities.update );
		engine.addSystem( new RenderSystem(this), SystemPriorities.render );

	}

	//Wird jedes Frame aufgerufen (~ 30x pro Sekunde)
	private function onEnterFrame(event: Event) : Void {

		//Das ECS muss wissen, wie lange ein Frame dauert.

        var elapsedTime: Float = Lib.getTimer() - previousTime; //Vergangene Zeit seit vergangenem Frame ermitteln (in Milisekunden).
        previousTime = Lib.getTimer(); //Aktuelle Zeit für das nächste Frame zwischenspeichern.

        engine.update(elapsedTime / 1000); //An ECS weitergeben

	}

} 