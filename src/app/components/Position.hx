package app.components;

import app.math.Vector2;

//Spiegelt den Mittelpunkt eines Entitys wider
class Position {

	public var vector: Vector2;
	public var rotation: Float;

	public function new(x: Float, y: Float, rotation: Float = 0) {
		this.vector = new Vector2(x, y);
		this.rotation = rotation;
	}

}