package app.scenes;

import openfl.Lib;
import openfl.display.Sprite;
import openfl.events.Event;
import ash.core.System;
import ash.core.Entity;
import ash.core.Engine;

import app.systems.SystemPriorities;
import app.systems.RenderSystem;
import app.systems.InputSystem;
import app.components.GameState;

import openfl.events.KeyboardEvent;

class GameScene extends Sprite {

	private var RootScene: Sprite;	//Haupt-Sprite des Spiels
	private var Engine: Engine;		//Engine des Entity-Component-System
	private var previousTime: Float;	//Hilfsvariable, um Framerate zu ermiteln

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
		this.Engine.addEntity( new app.entities.Car(300, 300) );

		//Systeme der Engine hinzufügen
		this.Engine.addSystem( new RenderSystem(this), SystemPriorities.Render );
		this.Engine.addSystem( new InputSystem(this), SystemPriorities.Update );

	}

	//Wird jedes Frame aufgerufen (~ 30x pro Sekunde)
	private function onEnterFrame(event: Event) : Void {

		//Das ECS muss wissen, wie lange ein Frame dauert.

        var elapsedTime: Float = Lib.getTimer() - previousTime; //Unterschied zum letzen Frame ermitteln (in Milisekunden).
        previousTime = Lib.getTimer(); //Aktuelle Zeit für das nächste Frame zwischenspeichern.

        this.Engine.update(elapsedTime / 1000); //An ECS weitergeben

	}

} 