package app.entities;

import ash.core.Entity;
import openfl.Assets;

import app.components.Position;
import app.components.Display;
import app.math.Vector2;
import app.entities.sprites.PolygonSprite;


class Grass extends Entity {

	public function new(position: Vector2, polygon: Array<Vector2>) {
		super();


		this.add( new Position(position) );
		this.add( new Display(new PolygonSprite(polygon, Assets.getBitmapData("res/textures/grass-ground.png"))) );


	}

}