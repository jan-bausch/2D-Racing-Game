package app.entities;

import ash.core.Entity;
import openfl.Assets;
import openfl.display.BitmapData;

import app.components.Position;
import app.components.Display;
import app.math.Vector2;
import app.components.Collision;
import app.entities.sprites.ImageSprite;


class Finish extends Entity {

	public function new(position: Vector2, scale: Vector2) {
		super();

		var bitmap: BitmapData = Assets.getBitmapData("assets/textures/finish.png");
		var width = bitmap.width * scale.x,
			height = bitmap.height * scale.y;
			
		this.add( new Position(position) );
		this.add( new Display(new ImageSprite(width, height, bitmap)) );
		this.add( new Collision([ new Vector2(-width/2, -height/2), new Vector2(width/2, -height/2), new Vector2(width/2, height/2), new Vector2(-width/2, height/2) ], false) );



	}

}