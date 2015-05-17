package app.entities.sprites;

import openfl.display.Sprite;
import openfl.Assets;


//Sprite einer Grassfläche
class GrassGroundSprite extends Sprite {


	public function new(Width: Float, Height: Float) {
        super();

        var Image = Assets.getBitmapData("res/images/ground/Grass.png");

        this.graphics.beginBitmapFill(Image);
        this.graphics.drawRect(0, 0, Width, Height);


	}


}