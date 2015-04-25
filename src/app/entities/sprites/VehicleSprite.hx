package app.entities.sprites;

import openfl.display.Sprite;
import openfl.events.Event;

import app.components.Vehicle;

class VehicleSprite extends Sprite {

    private var Vehicle: Vehicle; //Repräsentiert das Auto, das dieses Sprite darstellt

    private var WheelTopLeft: Sprite;  
    private var WheelTopRight: Sprite;
    private var WheelBottomLeft: Sprite;
    private var WheelBottomRight: Sprite;

	public function new(Vehicle: Vehicle) {
        super();
        this.Vehicle = Vehicle;

        //Reifen-Sprites erstellen und positionieren
        this.WheelTopLeft = this.getWheelSprite();
        this.WheelTopLeft.x = 50;
        this.WheelTopLeft.y = 70;
        this.addChild(this.WheelTopLeft);

        this.WheelTopRight = this.getWheelSprite();
        this.WheelTopRight.x = -50;
        this.WheelTopRight.y = 70;
        this.addChild(this.WheelTopRight);

        this.WheelBottomLeft = this.getWheelSprite();
        this.WheelBottomLeft.x = 50;
        this.WheelBottomLeft.y = -70;
        this.addChild(this.WheelBottomLeft);

        this.WheelBottomRight = this.getWheelSprite();
        this.WheelBottomRight.x = -50;
        this.WheelBottomRight.y = -70;
        this.addChild(this.WheelBottomRight);


        //Chassis und Dach erstellen und postionieren
        var Chassis: Sprite = new Sprite();
        Chassis.graphics.beginFill(0xFF0000);
        Chassis.graphics.drawRect (-50, -100, 100, 200);   //Chassis zeichnen
        Chassis.graphics.beginFill(0xE24A4A);
        Chassis.graphics.drawRect (-40, -80, 80, 120); //Dach zeichnen
        this.addChild(Chassis);

        //Events registrieren
        this.addEventListener(Event.ENTER_FRAME, this.onEnterFrame); 

	}


    //Wird aufgerufen, bevor gezeichnet wird.
    private function onEnterFrame(event: Event) : Void {

        //Reifenwinkel aktualisieren
        //OpenFl misst in Grad, daher müssen wir vom Bogenmaß umrechnen
        this.WheelTopRight.rotation = this.Vehicle.SteerAngle * (180 / Math.PI);
        this.WheelTopLeft.rotation = this.Vehicle.SteerAngle * (180 / Math.PI);

    }

    //Gibt einen neuen Reifensprite zurück
    private function getWheelSprite() : Sprite {

        var Wheel: Sprite = new Sprite();
        Wheel.graphics.beginFill(0x222222);
        Wheel.graphics.drawRect(-9, -18, 18, 36); //Reifen zeichnen

        return Wheel;
    }

}