package app.entities.sprites;

import openfl.display.Sprite;
import openfl.Assets;


//Sprite einer Grassfläche
class GrassGroundSprite extends Sprite {


	public function new(width: Float, height: Float) {
        super();

        var image = Assets.getBitmapData("res/images/ground/Grass.png");

       	graphics.beginBitmapFill(image);
        graphics.drawRect(0, 0, width, height);


	}


}