package app.scenes;

import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
//import app.math.Vector2;
import ash.core.System;
import ash.core.Entity;
import ash.core.Engine;

import haxe.ui.toolkit.core.RootManager;

import app.systems.SystemPriorities;
import app.systems.SystemEvents;
import app.systems.RenderSystem;
import app.systems.InputSystem;
import app.systems.VehicleSystem;
import app.systems.LevelLoadingSystem;
import app.systems.GameSystem;
import app.systems.CollisionSystem;
import app.systems.SoundSystem;
import app.systems.AnimationSystem;
import app.scenes.MainMenuScene;
import app.components.GameState;

import openfl.events.KeyboardEvent;

class GameScene extends Sprite {

	private var rootScene: Sprite;	//Haupt-Sprite des Spiels
	private var engine: Engine;		//Engine des Entity-Component-System
	private var previousTime: Float;	//Hilfsvariable, um Framerate zu ermiteln
	private var level: Int;

	public function new(rootScene: Sprite, level: Int) {
		super();

		this.rootScene = rootScene;
		previousTime = 0;
		this.level = level;

		startGame(); //ECS starten
		addEventListener(Event.ENTER_FRAME, onEnterFrame); //Events registrieren

	}

	private function startGame() : Void {

		engine = new Engine();

		//Events, die zwischen Systemen ausgetauscht werden
		var systemEvents: SystemEvents = new SystemEvents();


		//Events registrieren
		systemEvents.SHOW_MAINMENU.add(function () { setScene(new MainMenuScene(rootScene)); });

		//Ein Entity erstellen, das das Spiel repräsentiert
		engine.addEntity( new Entity().add(new GameState()) );


		//Systeme der Engine hinzufügen
		engine.addSystem( new InputSystem(systemEvents, this), 		SystemPriorities.update );
		engine.addSystem( new VehicleSystem(systemEvents), 			SystemPriorities.update );
		engine.addSystem( new SoundSystem(systemEvents), 			SystemPriorities.update );
		engine.addSystem( new AnimationSystem(systemEvents), 		SystemPriorities.update );
		engine.addSystem( new CollisionSystem(systemEvents), 		SystemPriorities.collisions );
		engine.addSystem( new RenderSystem(systemEvents, this), 	SystemPriorities.render );
		engine.addSystem( new LevelLoadingSystem(systemEvents), 	SystemPriorities.last);
		engine.addSystem( new GameSystem(systemEvents, level), 		SystemPriorities.preUpdate);

	

	}



	//Wird jedes Frame aufgerufen (~ 30x pro Sekunde)
	private function onEnterFrame(event: Event) : Void {

		//Das ECS muss wissen, wie lange ein Frame dauert.

        var elapsedTime: Float = Lib.getTimer() - previousTime; //Vergangene Zeit seit vergangenem Frame ermitteln (in Milisekunden).
        previousTime = Lib.getTimer(); //Aktuelle Zeit für das nächste Frame zwischenspeichern.

        engine.update(elapsedTime / 1000); //Verstrichene Zeit (in Sekunden) an ECS weitergeben

	}


	//Eine Szene als neuer Hauptsprite setzen.
	private function setScene(newScene: Sprite) : Void {

		//Alle Kinder des Hauptsprites löschen
		while (rootScene.numChildren > 0) {
		    rootScene.removeChildAt(0);
		}


		//UI entfernen
		RootManager.instance.destroyAllRoots();

		//Neue Szene hinzufügen
		rootScene.addChild(newScene);

	}

} 