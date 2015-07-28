package app.entities;

import openfl.Assets;

import ash.core.Entity;
import app.components.Position;
import app.components.Display;
import app.components.Collision;
import app.math.Vector2;
import app.entities.sprites.PolygonSprite;


class StoneWall extends Entity {

	public function new(position: Vector2, polygon: Array<Vector2>) {
		super();


		this.add( new Position(position) );
		this.add( new Display(new PolygonSprite(polygon, Assets.getBitmapData("res/textures/stone-wall.png")) ));
		this.add( new Collision(polygon, true) );


	}

}