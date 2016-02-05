package app.entities.sprites;

import openfl.display.Sprite;
import openfl.Assets;
import openfl.display.BitmapData;

import app.math.Vector2;


/*
    Zeichnet ein beliebiges Vieleck, dass mit einem Bildmuster gefüllt ist. (z.B. für Grasboden)
*/
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

            graphics.endFill();


      }


}