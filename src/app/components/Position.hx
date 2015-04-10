package app.components;

//Spiegelt den Mittelpunkt eines Entitys wider
class Position {

	public var X: Float;
	public var Y: Float;
	public var Rotation: Float;

	public function new(X: Float, Y: Float, Rotation: Float = 50) {
		this.X = X;
		this.Y = Y;
		this.Rotation = Rotation;
	}

}