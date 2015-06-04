package app.entities.sprites;

import openfl.display.Sprite;
import openfl.Assets;
import hxmath.math.Vector2;


//Sprite einer Grassfläche
class RoadSprite extends Sprite {


	public function new(start: Vector2, end: Vector2, startAngle: Float, endAngle: Float, width: Float) {
        super();

        var image = Assets.getBitmapData("res/images/ground/Asphalt.png");

        //
        var startWidth: Float = width / Math.cos((end-start).angle - startAngle + Math.PI / 2),
            endWidth: Float = width / Math.cos((end-start).angle - startAngle + Math.PI / 2);

        //Eckpunkte der Straße berechnen
        var corner1: Vector2 = Vector2.fromPolar(-startAngle, startWidth) + start, 	//Ecke links oben
        	corner2: Vector2 = Vector2.fromPolar(startAngle, startWidth) + start, 	//Ecke links unten
        	corner3: Vector2 = Vector2.fromPolar(-endAngle, endWidth) + end, 	//Ecke rechts oben
        	corner4: Vector2 = Vector2.fromPolar(endAngle, endWidth) + end; 	//Ecke rechts unten


        //Straßeuntergrund zeichnen
       	graphics.beginBitmapFill(image);

        graphics.moveTo(corner1.x, corner1.y);
        graphics.lineTo(corner2.x, corner2.y);
        graphics.lineTo(corner4.x, corner4.y);
        graphics.lineTo(corner3.x, corner3.y);

        graphics.endFill();


        //Seitenmarkierung zeichnen (Weiß)
       	graphics.lineStyle(10, 0xE6E6E6, 1, false, openfl.display.LineScaleMode.NONE, openfl.display.CapsStyle.NONE);
        graphics.moveTo(corner1.x, corner1.y);
        graphics.lineTo(corner3.x, corner3.y);
        graphics.endFill();

        graphics.lineStyle(10, 0xE6E6E6, 1, false, openfl.display.LineScaleMode.NONE, openfl.display.CapsStyle.NONE);
        graphics.moveTo(corner2.x, corner2.y);
        graphics.lineTo(corner4.x, corner4.y);
        graphics.endFill();

	}


}