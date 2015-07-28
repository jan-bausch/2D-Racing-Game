package app.entities;

import ash.core.Entity;
import app.math.Vector2;

import app.components.Position;
import app.components.Display;
import app.entities.sprites.RoadSprite;


class Road extends Entity {

	public function new(start: Vector2, end: Vector2, startAngle: Float, endAngle: Float, width) {
		super();

		var middle: Vector2 = (start + end) / 2;

		this.add( new Position( middle ) ); //Mitte beider Vektoren ist die Position der Straße
		this.add( new Display(new RoadSprite(start - middle, end - middle, startAngle, endAngle, width)) );

	}

}