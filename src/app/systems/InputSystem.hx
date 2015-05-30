package app.systems;

import ash.core.System;
import ash.core.NodeList;
import ash.core.Engine;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import openfl.display.Sprite;

import app.nodes.InputNode;
import app.components.Vehicle;

class InputSystem extends System {

	private var inputNodes: NodeList<InputNode>;
	private var scene: Sprite;	//Verweis auf die Applikation, um Zugriff auf Keyboard-Events zu erhalten.

    private var maxSteerAngle: Float;   //Maximaler Auschlag der Räder
    private var steerAmount: Float;     //Empfindlichkeit des Lenkrads
    private var maxSpeed: Float;    //Maximale Geschwindigkeit des Autos
    private var acceleration: Float;    //Beschleunigung
    private var deceleration: Float;
    private var up: Bool;
    private var down: Bool;
    private var right: Bool;
    private var left: Bool;

	public function new(scene: Sprite) {
		super();

		this.scene = scene;
        up = false;
        down = false;
        right = false;
        left = false;

        //Physikalische Konstanten festlegen
        maxSteerAngle = 45 * (Math.PI / 180);  //45°
        steerAmount = 200 * (Math.PI / 180);                     
        maxSpeed = 200;
        acceleration = 30;
        deceleration = 15;

        //Events registrieren
        scene.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

	}


	public override function update(elapsed: Float) : Void {

        for (inputNode in inputNodes) {
            var vehicle: Vehicle = inputNode.vehicle;


            //Lenkrad drehen, sofern nicht über maximalem Ausschlag.
            if (right && vehicle.steerAngle + steerAmount * elapsed <= maxSteerAngle) vehicle.steerAngle += steerAmount * elapsed;
            if (left && vehicle.steerAngle - steerAmount * elapsed >= -maxSteerAngle) vehicle.steerAngle -= steerAmount * elapsed;

            if (up && maxSpeed >= vehicle.speed + acceleration * elapsed) {
                vehicle.speed += acceleration * elapsed;
            } else {
                vehicle.speed -= deceleration * elapsed;
                if (vehicle.speed < 0) vehicle.speed = 0;
            }


        }   


	}


    //Wird aufgerufen, wenn das "GameScene"-Sprite zum eigentlichen Spiel hinzugefügt wird.
    private function onAddedToStage(event: Event) : Void {

        //Nun kann man die Keyboard-Events registrieren, das jetzt die Stage-Variable festgelegt ist.
        scene.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
        scene.stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
    }

    private function onKeyDown(event: KeyboardEvent) : Void {

        switch (event.keyCode) {   
            case Keyboard.DOWN: down = true;
            case Keyboard.LEFT: left = true;
            case Keyboard.RIGHT: right = true;
            case Keyboard.UP: up = true; 
        }

    }

    private function onKeyUp(event: KeyboardEvent) : Void {

        switch (event.keyCode) {   
            case Keyboard.DOWN: down = false;
            case Keyboard.LEFT: left = false;
            case Keyboard.RIGHT: right = false;
            case Keyboard.UP: up = false; 
        }

    }


	//Wird aufgerufen, wenn System der Engine hinzugefügt wird
	public override function addToEngine(engine: Engine):Void {
        inputNodes = engine.getNodeList(InputNode);
   	}

   	//Wird aufgerufen, wenn System von der Engine entfernt wird
    public override function removeFromEngine(engine: Engine):Void {
        inputNodes = null;

    }


}