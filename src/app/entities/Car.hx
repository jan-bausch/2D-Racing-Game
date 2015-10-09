package app.entities;

import ash.core.Entity;

import app.components.Position;
import app.components.Display;
import app.components.Vehicle;
import app.components.Input;
import app.components.Camera;
import app.components.Collision;
import app.math.Vector2;
import app.entities.sprites.VehicleSprite;


class Car extends Entity {

	public function new(position: Vector2, rotation: Float) {
		super();

		var vehicleComponent: Vehicle = new Vehicle();

		this.add( new Camera(.4, 10, 150) );
		this.add( new Position(position, rotation) );

		//Steurungs-Komponente wird erst hinzugefügt, wenn der Countdown beim Level-Start abgelaufen ist.
		//this.add( new Input() );

		this.add( new Display(new VehicleSprite(vehicleComponent)) );
		this.add( new Collision(84, 200) );
		this.add( vehicleComponent );


	}

}