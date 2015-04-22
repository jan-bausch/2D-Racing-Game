package app.components;

import hxmath.math.Vector2;

//Spiegelt den Mittelpunkt eines Entitys wider
class Position {

	public var Vector: Vector2;
	public var Rotation: Float;

	public function new(X: Float, Y: Float, Rotation: Float = 0) {
		this.Vector = new Vector2(X, Y);
		this.Rotation = Rotation;
	}

}