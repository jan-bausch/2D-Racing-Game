package app.entities.sprites;

import openfl.display.Sprite;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.display.Bitmap;

import app.math.Vector2;


//Sprite eines generischen Vielecks mit Bild
class ImageSprite extends Sprite {


	public function new(width: Float, height: Float, bitmapData: BitmapData) {
        super();

		graphics.beginBitmapFill(bitmapData);
			graphics.drawRect(-width/2, -height/2, width, height);
		graphics.endFill();

	}


}