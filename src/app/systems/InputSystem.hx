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

    //Steurungsinput
    private var up: Bool;
    private var down: Bool;
    private var right: Bool;
    private var left: Bool;
    private var space: Bool;

    private var events: SystemEvents;

    public function new(events: SystemEvents, scene: Sprite) {
        super();

        this.events = events;
		this.scene = scene;
        up = false;
        down = false;
        right = false;
        left = false;
        space = false;

        //Physikalische Konstanten festlegen
        MAX_STEER_ANGLE = 45;

        STEER_SPEED = 80;


        //Events registrieren
        scene.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);

	}


	public override function update(elapsed: Float) : Void {

        for (inputNode in inputNodes) {
            var vehicle: Vehicle = inputNode.vehicle;


            //Lenkrad wieder in Nullstellung bringen
            var STRAIGHTENING_SPEED = STEER_SPEED * elapsed * vehicle.velocity / 50;

            if (vehicle.steerAngle > 0) {
                vehicle.steerAngle = (vehicle.steerAngle - STRAIGHTENING_SPEED) > 0 ? vehicle.steerAngle - STRAIGHTENING_SPEED : 0;
            }

            if (vehicle.steerAngle < 0) {
                vehicle.steerAngle = (vehicle.steerAngle + STRAIGHTENING_SPEED) < 0 ? vehicle.steerAngle + STRAIGHTENING_SPEED : 0;
            }   



            //Lenkrad drehen, sofern nicht über maximalem Ausschlag.
            if (right && vehicle.steerAngle + STEER_SPEED * elapsed <= MAX_STEER_ANGLE) vehicle.steerAngle += STEER_SPEED * elapsed;
            if (left && vehicle.steerAngle - STEER_SPEED * elapsed >= -MAX_STEER_ANGLE) vehicle.steerAngle -= STEER_SPEED * elapsed;

            vehicle.throttle = up;
            vehicle.brake = down;



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
            case Keyboard.S: down = true;
            case Keyboard.LEFT: left = true;
            case Keyboard.A: left = true;
            case Keyboard.RIGHT: right = true;
            case Keyboard.D: right = true;
            case Keyboard.UP: up = true;
            case Keyboard.W: up = true;
        }

        if (event.keyCode == Keyboard.DOWN) events.CAR_BREAK_BEGIN.dispatch();

    }

    private function onKeyUp(event: KeyboardEvent) : Void {

        switch (event.keyCode) {   
            case Keyboard.DOWN: down = false;
            case Keyboard.S: down =false;
            case Keyboard.LEFT: left = false;
            case Keyboard.A: left = false;
            case Keyboard.RIGHT: right = false;
            case Keyboard.D: right = false;
            case Keyboard.UP: up = false;
            case Keyboard.W: up = false;
        }

        if (event.keyCode == Keyboard.DOWN) events.CAR_BREAK_END.dispatch();

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