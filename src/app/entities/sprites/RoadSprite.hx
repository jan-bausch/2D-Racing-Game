package app.entities.sprites;

import openfl.display.Sprite;
import openfl.Assets;
import app.math.Vector2;


/*
    Dieses Sprite rendert einen Straßenabschnitt mit Asphalthintergrund.
    Wie bei einem Trapez stehen die Seitenlinien der Straße parallel zueinander, während die beiden
    Enden rotiert sein können.
*/
class RoadSprite extends Sprite {

    /*
        start: Startpunkt des Abschnitts, von Mittellinie gemessen
        end: Endpunkt des Abschnitts, von Mittellinie gemessen
        startAngle: Winkel des Starts der Straße (in Grad°)
        endAngle: Winkel des Ende der Straße (in Grad°)
        width: Straßenbreite in Pixel
    */
    public function new(start: Vector2, end: Vector2, startAngle: Float, endAngle: Float, width: Float) {
        super();

        var image = Assets.getBitmapData("assets/textures/asphalt-ground.png");


         /*
            Die Straße bleibt immer gleich-breit, allerdings variert die Länge der Straßenendkante je nach
            schärfe der Kurve.
            Ist beispiel ein Straßenende stark angewinkelt, ist diese Kante sehr lang.

            cos(Straßenverlaufswinkel - Kantenwinkel) = Straßenbreite / Kantenbreite
            <=> Kantenbreite = Straßenbreite / cos(Straßenverlaufswinkel - Kantenwinkel)
        */
        var startWidth: Float = width / Math.cos((start.angleTo(end)-startAngle) * (Math.PI/180)),
            endWidth: Float = width / Math.cos((start.angleTo(end)-endAngle) * (Math.PI/180));

        //Eckpunkte der Straße berechnen
        var corner1: Vector2 = Vector2.fromPolar(startAngle - 90, startWidth) + start,  //Ecke links oben
            corner2: Vector2 = Vector2.fromPolar(startAngle + 90, startWidth) + start,  //Ecke links unten
            corner3: Vector2 = Vector2.fromPolar(endAngle - 90, endWidth) + end,    //Ecke rechts oben
            corner4: Vector2 = Vector2.fromPolar(endAngle +90, endWidth) + end;     //Ecke rechts unten




        //Straßeuntergrund zeichnen
        graphics.beginBitmapFill(image);

        graphics.moveTo(corner1.x, corner1.y);
        graphics.lineTo(corner2.x, corner2.y);
        graphics.lineTo(corner4.x, corner4.y);
        graphics.lineTo(corner3.x, corner3.y);

        graphics.endFill();


        //Seitenmarkierungen zeichnen (Weiß)
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