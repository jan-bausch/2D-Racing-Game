package app.entities;

import ash.core.Entity;
import openfl.Assets;
import openfl.display.BitmapData;

import app.components.Position;
import app.components.Display;
import app.math.Vector2;
import app.components.Collision;
import app.entities.sprites.StretchedImageSprite;

/*
    Wenn der Spieler diese Fläche berührt, ist er im Ziel.
*/
class Finish extends Entity {


    
    public function new(position: Vector2, scale: Vector2, rotation: Float) {
        super();

        var bitmap: BitmapData = Assets.getBitmapData("assets/textures/finish.png");
        var width = bitmap.width * scale.x,
            height = bitmap.height * scale.y;
            
        this.add( new Position(position, rotation) );
        this.add( new Display(new StretchedImageSprite(width, height, bitmap)) );
        this.add( new Collision(width, height, false) );



    }

}