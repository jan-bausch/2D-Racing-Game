package app.entities.sprites;

import openfl.display.Sprite;
import openfl.Assets;
import hxmath.math.Vector2;


//Sprite einer Grassfläche
class RoadSprite extends Sprite {


	public function new(Start: Vector2, End: Vector2, StartAngle: Float, EndAngle: Float, Width) {
        super();

        var Image = Assets.getBitmapData("res/images/ground/Asphalt.png");


        //Eckpunkte der Straße berechnen
        var Corner1: Vector2 = Vector2.fromPolar(-StartAngle, Width) + Start, 	//Ecke links oben
        	Corner2: Vector2 = Vector2.fromPolar(StartAngle, Width) + Start, 	//Ecke links unten
        	Corner3: Vector2 = Vector2.fromPolar(-EndAngle, Width) + End, 	//Ecke rechts oben
        	Corner4: Vector2 = Vector2.fromPolar(EndAngle, Width) + End; 	//Ecke rechts unten


        //Straßeuntergrund zeichnen
       	graphics.beginBitmapFill(Image);

        graphics.moveTo(Corner1.x, Corner1.y);
        graphics.lineTo(Corner2.x, Corner2.y);
        graphics.lineTo(Corner4.x, Corner4.y);
        graphics.lineTo(Corner3.x, Corner3.y);

        graphics.endFill();


        //Seitenmarkierung zeichnen (Weiß)
       	graphics.lineStyle(20, 0xE6E6E6, 1, false, openfl.display.LineScaleMode.NONE, openfl.display.CapsStyle.SQUARE);
        graphics.moveTo(Corner1.x, Corner1.y);
        graphics.lineTo(Corner3.x, Corner3.y);
        graphics.endFill();

        graphics.lineStyle(20, 0xE6E6E6, 1, false, openfl.display.LineScaleMode.NONE, openfl.display.CapsStyle.SQUARE);
        graphics.moveTo(Corner2.x, Corner2.y);
        graphics.lineTo(Corner4.x, Corner4.y);
        graphics.endFill();

	}


}