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

    //Physikalische Konstanten
    private var MAX_STEER_ANGLE: Float;   //Maximaler Auschlag der Räder
    private var STEER_SPEED: Float;     //Empfindlichkeit des Lenkrads
    private var MAX_SPEED: Float;    //Maximale Geschwindigkeit des Autos
    private var ACCELERATION: Float;    //Beschleunigung
    private var DECELERATION: Float;    //Entschleunigung
    private var BREAK: Float;    //Bremskraft

    //Steurungsinput
    private var up: Bool;
    private var down: Bool;
    private var right: Bool;
    private var left: Bool;

    private var events: SystemEvents;

    public function new(events: SystemEvents, scene: Sprite) {
        super();

        this.events = events;
		this.scene = scene;
        up = false;
        down = false;
        right = false;
        left = false;

        //Physikalische Konstanten festlegen
        MAX_STEER_ANGLE = 45;

        STEER_SPEED = 120;
        MAX_SPEED = 800;
        ACCELERATION = 100;
        DECELERATION = 130;
        BREAK = 200;


        //Events registrieren
        scene.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

	}


	public override function update(elapsed: Float) : Void {

        for (inputNode in inputNodes) {
            var vehicle: Vehicle = inputNode.vehicle;


            //Lenkrad wieder in Nullstellung bringen
            var STRAIGHTENING_SPEED = STEER_SPEED * elapsed * vehicle.speed / 1000;

            if (vehicle.steerAngle > 0) {
                vehicle.steerAngle = (vehicle.steerAngle - STRAIGHTENING_SPEED) > 0 ? vehicle.steerAngle - STRAIGHTENING_SPEED : 0;
            }

            if (vehicle.steerAngle < 0) {
                vehicle.steerAngle = (vehicle.steerAngle + STRAIGHTENING_SPEED) < 0 ? vehicle.steerAngle + STRAIGHTENING_SPEED : 0;
            }   



            //Lenkrad drehen, sofern nicht über maximalem Ausschlag.
            if (right && vehicle.steerAngle + STEER_SPEED * elapsed <= MAX_STEER_ANGLE) vehicle.steerAngle += STEER_SPEED * elapsed;
            if (left && vehicle.steerAngle - STEER_SPEED * elapsed >= -MAX_STEER_ANGLE) vehicle.steerAngle -= STEER_SPEED * elapsed;

            //Wenn geradeaus gefahren wird und maximale Geschwindigkeit noch nicht erreich ist, wird das Auto beschleunigt.
            if (up && MAX_SPEED >= vehicle.speed + ACCELERATION * elapsed) {
                vehicle.speed += ACCELERATION * elapsed;
            } else {
                vehicle.speed -= DECELERATION * elapsed;
            }

            //Abbremsen
            if (down) vehicle.speed -= BREAK * elapsed;
            if (vehicle.speed < 0) vehicle.speed = 0;


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