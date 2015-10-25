package app.entities.sprites;

import openfl.display.Sprite;
import openfl.Assets;
import openfl.display.BitmapData;

import app.components.Collision;


//Zu Debugging-Zwecken wird das Kollisionsvieleck als Sprite angezeigt.
class CollisionSprite extends Sprite {


    public function new(collision: Collision) {
        super();

            //Eine Ecke mit Kreis markieren
            graphics.beginFill(0x0000FF);
            graphics.drawCircle(collision.width/2, collision.height/2, 5);
            graphics.endFill();

            //Rechteck als blau Linie darstellen
        graphics.lineStyle(2, 0x0000FF);
      
        graphics.moveTo(collision.width/2, collision.height/2);
            graphics.lineTo(collision.width/2, -collision.height/2);
            graphics.lineTo(-collision.width/2, -collision.height/2);
            graphics.lineTo(-collision.width/2, collision.height/2);
            graphics.lineTo(collision.width/2, collision.height/2);

            graphics.endFill();


    }


}