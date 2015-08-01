package app.entities.sprites;

import openfl.display.Sprite;
import openfl.Assets;
import openfl.display.BitmapData;

import app.components.Collision;


//Zu Debugging-Zwecken wird das Kollisionsvieleck als Sprite angezeigt.
class CollisionSprite extends Sprite {


	public function new(collision: Collision) {
        super();

            //Vieleck als blau Linie darstellen
       	graphics.lineStyle(2, 0x0000FF);
      
       	var first: Bool = true;
       	for (point in collision.polygon) {
       		if (first) {
       			graphics.moveTo(point.x, point.y);
       			first = false;
       		} else {
       			graphics.lineTo(point.x, point.y);
       		}
       	}
            graphics.lineTo(collision.polygon[0].x, collision.polygon[0].y);
            graphics.endFill();


	}


}