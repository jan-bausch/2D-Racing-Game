package app.scenes;

import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
import hxmath.math.Vector2;
import ash.core.System;
import ash.core.Entity;
import ash.core.Engine;
import ash.signals.Signal1;

import app.systems.SystemPriorities;
import app.systems.RenderSystem;
import app.systems.InputSystem;
import app.systems.VehicleSystem;
import app.systems.LevelLoadingSystem;
import app.systems.GameSystem;
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
		var LOAD_LEVEL: Signal1<Int> = new Signal1<Int>();

		//Ein Entity erstellen, das das Spiel repräsentiert
		engine.addEntity( new Entity().add(new GameState()) );


		//Systeme der Engine hinzufügen
		engine.addSystem( new InputSystem(this), SystemPriorities.update );
		engine.addSystem( new VehicleSystem(), SystemPriorities.update );
		engine.addSystem( new RenderSystem(this), SystemPriorities.render );
		engine.addSystem( new LevelLoadingSystem(LOAD_LEVEL), SystemPriorities.last);
		engine.addSystem( new GameSystem(LOAD_LEVEL), SystemPriorities.preUpdate);

	

	}

	//Wird jedes Frame aufgerufen (~ 30x pro Sekunde)
	private function onEnterFrame(event: Event) : Void {

		//Das ECS muss wissen, wie lange ein Frame dauert.

        var elapsedTime: Float = Lib.getTimer() - previousTime; //Vergangene Zeit seit vergangenem Frame ermitteln (in Milisekunden).
        previousTime = Lib.getTimer(); //Aktuelle Zeit für das nächste Frame zwischenspeichern.

        engine.update(elapsedTime / 1000); //An ECS weitergeben

	}

} 