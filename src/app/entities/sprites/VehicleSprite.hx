package app.entities.sprites;

import openfl.display.Sprite;
import openfl.events.Event;

import app.components.Vehicle;

class VehicleSprite extends Sprite {

    private var vehicle: Vehicle; //Repräsentiert das Auto, das dieses Sprite darstellt

    private var wheeltopLeft: Sprite;  
    private var wheelTopRight: Sprite;
    private var wheelBottomLeft: Sprite;
    private var wheelBottomRight: Sprite;

	public function new(vehicle: Vehicle) {
        super();
        this.vehicle = vehicle;

        //Reifen-Sprites erstellen und positionieren
        wheeltopLeft = this.getWheelSprite();
        wheeltopLeft.x = 50;
        wheeltopLeft.y = -70;
        addChild(this.wheeltopLeft);

        wheelTopRight = this.getWheelSprite();
        wheelTopRight.x = -50;
        wheelTopRight.y = -70;
        addChild(this.wheelTopRight);

        wheelBottomLeft = this.getWheelSprite();
        wheelBottomLeft.x = 50;
        wheelBottomLeft.y = 70;
        addChild(this.wheelBottomLeft);

        wheelBottomRight = this.getWheelSprite();
        wheelBottomRight.x = -50;
        wheelBottomRight.y = 70;
        addChild(this.wheelBottomRight);


        //Chassis und Dach erstellen und postionieren
        var chassis: Sprite = new Sprite();
        chassis.graphics.beginFill(0xFF0000);
        chassis.graphics.drawRect (-50, -100, 100, 200);   //Chassis zeichnen
        chassis.graphics.beginFill(0xE24A4A);
        chassis.graphics.drawRect (-40, -40, 80, 120); //Dach zeichnen
        chassis.graphics.endFill();
        addChild(chassis);

        //Events registrieren
        addEventListener(Event.ENTER_FRAME, onEnterFrame); 

	}


    //Wird aufgerufen, bevor gezeichnet wird.
    private function onEnterFrame(event: Event) : Void {

        //Reifenwinkel aktualisieren
        wheelTopRight.rotation = vehicle.steerAngle;
        wheeltopLeft.rotation = vehicle.steerAngle;

    }

    //Gibt einen neuen Reifensprite zurück
    private function getWheelSprite() : Sprite {

        var wheel: Sprite = new Sprite();
        wheel.graphics.beginFill(0x222222);
        wheel.graphics.drawRect(-9, -18, 18, 36); //Reifen zeichnen

        return wheel;
    }

}