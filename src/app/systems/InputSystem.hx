package app.systems;

import ash.core.System;
import ash.core.NodeList;
import ash.core.Engine;

import lime.ui.Gamepad;
import lime.ui.GamepadAxis;
import lime.ui.GamepadButton;
import openfl.events.Event;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import openfl.display.Sprite;

import app.nodes.InputNode;
import app.components.Vehicle;

class InputSystem extends System {

    private var inputNodes: NodeList<InputNode>;
    private var scene: Sprite;  //Verweis auf die Applikation, um Zugriff auf Keyboard-Events zu erhalten.

    //Physikalische Konstanten
    private var MAX_STEER_ANGLE: Float;   //Maximaler Auschlag der Räder
    private var STEER_SPEED: Float;     //Empfindlichkeit des Lenkrads

    //Steurungsinput
    private var up: Float;
    private var down: Float;
    private var right: Float;
    private var left: Float;

    private var events: SystemEvents;

    public function new(events: SystemEvents, scene: Sprite) {
        super();

        this.events = events;
        this.scene = scene;
        up = 0;
        down = 0;
        right = 0;
        left = 0;


        //Physikalische Konstanten festlegen
        MAX_STEER_ANGLE = 30;

        STEER_SPEED = 60;


        //Events registrieren
        scene.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);



    }


    public override function update(elapsed: Float) : Void {

        for (inputNode in inputNodes) {
            var vehicle: Vehicle = inputNode.vehicle;

            //Lenkrad wieder in Nullstellung bringen
            var STRAIGHTENING_SPEED = Math.pow(STEER_SPEED * elapsed * Math.abs(vehicle.velocity), 1.5) / 300;

            if (vehicle.steerAngle > 0) {
                vehicle.steerAngle = (vehicle.steerAngle - STRAIGHTENING_SPEED) > 0 ? vehicle.steerAngle - STRAIGHTENING_SPEED : 0;
            }

            if (vehicle.steerAngle < 0) {
                vehicle.steerAngle = (vehicle.steerAngle + STRAIGHTENING_SPEED) < 0 ? vehicle.steerAngle + STRAIGHTENING_SPEED : 0;
            }   



            //Lenkrad drehen, sofern nicht über maximalem Ausschlag.
            if (vehicle.steerAngle + STEER_SPEED * right * elapsed <= MAX_STEER_ANGLE) vehicle.steerAngle += STEER_SPEED * right *  elapsed;
            if (vehicle.steerAngle - STEER_SPEED * left *  elapsed >= -MAX_STEER_ANGLE) vehicle.steerAngle -= STEER_SPEED * left * elapsed;

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
            case Keyboard.DOWN: down = 1;
            case Keyboard.S: down = 1;
            case Keyboard.LEFT: left = 1;
            case Keyboard.A: left = 1;
            case Keyboard.RIGHT: right = 1;
            case Keyboard.D: right = 1;
            case Keyboard.UP: up = 1;
            case Keyboard.W: up = 1;
        }

        if (event.keyCode == Keyboard.DOWN) events.CAR_BREAK_BEGIN.dispatch();

    }

    private function onKeyUp(event: KeyboardEvent) : Void {

        switch (event.keyCode) {   
            case Keyboard.DOWN: down = 0;
            case Keyboard.S: down =0;
            case Keyboard.LEFT: left = 0;
            case Keyboard.A: left = 0;
            case Keyboard.RIGHT: right = 0;
            case Keyboard.D: right = 0;
            case Keyboard.UP: up = 0;
            case Keyboard.W: up = 0;
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