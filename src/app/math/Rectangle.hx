package app.math;

import app.math.Vector2;

class Rectangle {

	public var Position: Vector2;
	public var Width: Float;
	public var Height: Float;

	public function new(Position, Width, Height) {
		this.Position = Position;
		this.Width = Width; 
		this.Height = Height;
	}

}