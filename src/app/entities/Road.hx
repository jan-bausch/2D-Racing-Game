package app.entities;

import ash.core.Entity;
import hxmath.math.Vector2;

import app.components.Position;
import app.components.Display;
import app.entities.sprites.RoadSprite;


class Road extends Entity {

	public function new(Start: Vector2, End: Vector2, StartAngle: Float, EndAngle: Float, Width) {
		super();

		var Middle: Vector2 = (Start + End) / 2;

		this.add( new Position( Middle.x , Middle.y ) ); //Mitte beider Vektoren ist die Position der Straße
		this.add( new Display(new RoadSprite(Start - Middle, End - Middle, StartAngle, EndAngle, Width)) );

	}

}