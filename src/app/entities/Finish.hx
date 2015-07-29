package app.entities;

import ash.core.Entity;
import openfl.Assets;

import app.components.Position;
import app.components.Display;
import app.math.Vector2;
import app.components.Collision;
import app.entities.sprites.ImageSprite;


class Finish extends Entity {

	public function new(position: Vector2, width: Float, height: Float) {
		super();


		this.add( new Position(position) );
		this.add( new Display(new ImageSprite(width, height, Assets.getBitmapData("res/textures/finish.png"))) );
		this.add( new Collision([ new Vector2(-width/2, -height/2), new Vector2(width/2, -height/2), new Vector2(width/2, height/2), new Vector2(-width/2, height/2) ], false) );


	}

}