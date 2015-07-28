package app.entities.sprites;

import openfl.display.Sprite;
import openfl.Assets;
import openfl.display.BitmapData;

import app.math.Vector2;


//Sprite eines generischen Vielecks mit Bild
class PolygonSprite extends Sprite {


	public function new(polygon: Array<Vector2>, bitmapData: BitmapData) {
        super();

       	graphics.beginBitmapFill(bitmapData);
      
       	var first: Bool = true;
       	for (point in polygon) {
       		if (first) {
       			graphics.moveTo(point.x, point.y);
       			first = false;
       		} else {
       			graphics.lineTo(point.x, point.y);
       		}
       	}



	}


}