package app.entities;

import ash.core.Entity;

import app.components.Position;
import app.components.Display;
import app.entities.sprites.VehicleSprite;


class Car extends Entity {

	public function new(X: Float, Y: Float) {
		super();

		this.add( new Position(X, Y) );
		this.add( new Display(new VehicleSprite()) );


	}

}