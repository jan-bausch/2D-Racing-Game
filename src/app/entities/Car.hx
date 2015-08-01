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

		this.add( new Camera() );
		this.add( new Position(position, rotation) );
		this.add( new Input() );
		this.add( new Display(new VehicleSprite(vehicleComponent)) );
		this.add( new Collision([ new Vector2(-42, -100), new Vector2(42, -100), new Vector2(42, 100), new Vector2(-42, 100) ]) );
		this.add( vehicleComponent );


	}

}