package app.scenes;

import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
import ash.core.System;
import ash.core.Entity;
import ash.core.Engine;

import app.systems.SystemPriorities;
import app.components.GameState;


class GameScene extends Sprite {

	private var RootScene: Sprite;	//Haupt-Sprite des Spiels
	private var Engine: Engine;		//Engine des Entity-Component-System
	private var previousTime: Int;	//Hilfsvariable, um Framerate zu ermiteln

	public function new(RootScene: Sprite) {
		super();
		this.RootScene = RootScene;
		this.previousTime = 0;

		this.startGame(); //ECS starten
		this.addEventListener(Event.ENTER_FRAME, this.onEnterFrame); //Events registrieren

	}

	private function startGame() : Void {

		this.Engine = new Engine();

		//Ein Entity erstellen, das das Spiel repräsentiert
		this.Engine.addEntity( new Entity().add(new GameState()) );

	}

	//Wird jedes Frame aufgerufen (~ 30x pro Sekunde)
	private function onEnterFrame(event: Event) : Void {

		//Das ECS muss wissen, wie lange ein Frame dauert.

        var elapsedTime = Lib.getTimer() - previousTime; //Unterschied zum letzen Frame ermitteln (in Milisekunden).
        previousTime = Lib.getTimer(); //Aktuelle Zeit für das nächste Frame zwischenspeichern.

        this.Engine.update(elapsedTime); //An ECS weitergeben

	}

} 