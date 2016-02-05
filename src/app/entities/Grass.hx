package app.entities;

import ash.core.Entity;
import openfl.Assets;

import app.components.Position;
import app.components.Display;
import app.math.Vector2;
import app.entities.sprites.PolygonSprite;

/*
    Ein Vieleck mit Grasflächentextur.
*/
class Grass extends Entity {

    public function new(absolutepolygon: Array<Vector2>) {
        super();

        //Die Koordinaten des Polygons werden in absoluten Zahlen übergeben.
        //Zuerst wird der Mittelpunkt aller Ecken berechnet, der sich aus dem Schnitt aller Punkte ergibt.
        var center: Vector2 = new Vector2(0,0);
        for (point in absolutepolygon) center += point;
        center /= absolutepolygon.length;

        //Danach lässt sich das relative Vieleck berechnen.
        var polygon: Array<Vector2> = new Array<Vector2>();
        for (point in absolutepolygon) polygon.push(point -center);



        this.add( new Position(center) );
        this.add( new Display(new PolygonSprite(polygon, Assets.getBitmapData("assets/textures/grass-ground.png"))) );


    }

}