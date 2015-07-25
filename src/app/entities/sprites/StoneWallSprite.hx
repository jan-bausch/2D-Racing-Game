package app.entities.sprites;

import openfl.display.Sprite;
import openfl.Assets;

import app.math.Vector2;


//Sprite einer Grassfläche
class StoneWallSprite extends Sprite {


	public function new(polygon: Array<Vector2>) {
        super();

        var image = Assets.getBitmapData("res/textures/stonewall.png");

       	graphics.beginBitmapFill(image);
      
       	var first: Bool = true;
       	for (point in polygon) {
       		trace(point);
       		if (first) {
       			graphics.moveTo(point.x, point.y);
       			first = false;
       		} else {
       			graphics.lineTo(point.x, point.y);
       		}
       	}



	}


}