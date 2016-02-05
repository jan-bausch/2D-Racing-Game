package app.entities.sprites;

import openfl.display.Sprite;
import openfl.Assets;
import openfl.display.BitmapData;

import app.components.Collision;


/*
    Wenn der Debugmodus in den Optionen aktiviert ist, erhalten alle Entitäten
    mit Kollisions-Komponente zusätlich diesen Sprite. Um diese Entitäten 
    wird ein schlichtes Rechteck gezeichnet.
*/
class CollisionSprite extends Sprite {

    //Der "Collisions"-Parameter enthält Informationen über die Größe des Rechtecks
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