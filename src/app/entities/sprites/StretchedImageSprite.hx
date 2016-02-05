package app.entities.sprites;

import openfl.display.Sprite;
import openfl.Assets;
import openfl.display.BitmapData;
import openfl.display.Bitmap;

import app.math.Vector2;


/*
    Zeichnet ein einfaches Bild, das auf Höhe und Breite skaliert wird.
*/
class StretchedImageSprite extends Sprite {


    public function new(width: Float, height: Float, bitmapData: BitmapData) {
        super();

        var image: Bitmap = new Bitmap(bitmapData);
        image.width = width;
        image.height = height;
        image.x = -width/2;
        image.y = -height/2;

        addChild(image);

    }


}