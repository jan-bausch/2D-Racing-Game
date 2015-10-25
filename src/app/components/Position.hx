package app.components;

import app.math.Vector2;

//Spiegelt den Mittelpunkt eines Entitys wider
class Position {

    public var vector: Vector2;
    public var rotation: Float;

    public function new(position: Vector2, rotation: Float = 0) {
        this.vector = position;
        this.rotation = rotation;
    }

}