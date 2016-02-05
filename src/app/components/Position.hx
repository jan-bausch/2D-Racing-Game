package app.components;

import app.math.Vector2;

/*
    Positions-Komponente:
    Repräsentiert aktuelle Koordinate und Drehehung einer Entität.
    Die meisten Entitäten besitzen diese Komponente.
*/
class Position {

    public var vector: Vector2; //Absolute Position vom Koordinatenursprung
    public var rotation: Float; //Drehung in 360° Grad

    public function new(position: Vector2, rotation: Float = 0) {
        this.vector = position;
        this.rotation = rotation;
    }

}