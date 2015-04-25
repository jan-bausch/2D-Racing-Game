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

	private var InputNodes: NodeList<InputNode>;
	private var Scene: Sprite;	//Verweis auf die Applikation, um Zugriff auf Keyboard-Events zu erhalten.

    private var maxSteerAngle: Float;   //Maximaler Auschlag der Räder
    private var SteerAmount: Float;
    private var maxSpeed: Float;    //Maximale Geschwindigkeit des Autos
    private var Acceleration: Float;    //Beschleunigung
    private var Deceleration: Float;
    private var Up: Bool;
    private var Down: Bool;
    private var Right: Bool;
    private var Left: Bool;

	public function new(Scene: Sprite) {
		super();
		this.Scene = Scene;
        this.Up = false;
        this.Down = false;
        this.Right = false;
        this.Left = false;

        this.maxSteerAngle = 45 * (Math.PI / 180);  //45°
        this.SteerAmount = 200 * (Math.PI / 180);                     
        this.maxSpeed = 200;
        this.Acceleration = 30;
        this.Deceleration = 15;

        //Events registrieren
        this.Scene.addEventListener(Event.ADDED_TO_STAGE, this.onAddedToStage);

	}


	public override function update(elapsed: Float) : Void {

        for (InputNode in this.InputNodes) {
            var Vehicle: Vehicle = InputNode.Vehicle;


            //Lenkrad drehen, sofern nicht über maximalem Ausschlag.
            if (this.Right && Vehicle.SteerAngle + this.SteerAmount * elapsed <= this.maxSteerAngle) Vehicle.SteerAngle += this.SteerAmount * elapsed;
            if (this.Left && Vehicle.SteerAngle - this.SteerAmount * elapsed >= -this.maxSteerAngle) Vehicle.SteerAngle -= this.SteerAmount * elapsed;

            if (this.Up && this.maxSpeed >= Vehicle.Speed + this.Acceleration * elapsed) {
                Vehicle.Speed += this.Acceleration * elapsed;
            } else {
                Vehicle.Speed -= this.Deceleration * elapsed;
                if (Vehicle.Speed < 0) Vehicle.Speed = 0;
            }


        }   


	}


    //Wird aufgerufen, wenn das "GameScene"-Sprite zum eigentlichen Spiel hinzugefügt wird.
    private function onAddedToStage(event: Event) : Void {

        //Nun kann man die Keyboard-Events registrieren, das jetzt die Stage-Variable festgelegt ist.
        this.Scene.stage.addEventListener(KeyboardEvent.KEY_DOWN, this.onKeyDown);
        this.Scene.stage.addEventListener(KeyboardEvent.KEY_UP, this.onKeyUp);
    }

    private function onKeyDown(event: KeyboardEvent) : Void {

        switch (event.keyCode) {   
            case Keyboard.DOWN: Down = true;
            case Keyboard.LEFT: Left = true;
            case Keyboard.RIGHT: Right = true;
            case Keyboard.UP: Up = true; 
        }

    }

    private function onKeyUp(event: KeyboardEvent) : Void {

        switch (event.keyCode) {   
            case Keyboard.DOWN: Down = false;
            case Keyboard.LEFT: Left = false;
            case Keyboard.RIGHT: Right = false;
            case Keyboard.UP: Up = false; 
        }

    }


	//Wird aufgerufen, wenn System der Engine hinzugefügt wird
	public override function addToEngine(Engine:Engine):Void {
        this.InputNodes = Engine.getNodeList(InputNode);
   	}

   	//Wird aufgerufen, wenn System von der Engine entfernt wird
    public override function removeFromEngine(Engine:Engine):Void {
        this.InputNodes = null;

    }


}