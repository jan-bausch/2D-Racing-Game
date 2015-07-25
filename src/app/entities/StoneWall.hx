package app.entities;

import ash.core.Entity;

import app.components.Position;
import app.components.Display;
import app.components.Collision;
import app.math.Vector2;
import app.entities.sprites.StoneWallSprite;


class StoneWall extends Entity {

	public function new(polygon: Array<Vector2>) {
		super();


		//Mittelpunkt berrechnen
		var center: Vector2 = new Vector2(0,0);
		for (point in polygon) center += point;
		center /= polygon.length;

		//Vieleck relativ zum Mittelpunkt umschreiben
		var relativePolygon: Array<Vector2> = new Array<Vector2>();
		for (point in polygon) relativePolygon.push(point - center);
			

		this.add( new Position(center.x, center.y) );
		this.add( new Display(new StoneWallSprite(relativePolygon)) );
		this.add( new Collision(relativePolygon, true) );


	}

}