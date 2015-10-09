package app.math;

import app.math.Vector2;

class CollisionResponse {

	public var collision: Bool;
	public var distance: Vector2;
	public var solid: Bool;

	public function new() {
		collision = false;
		solid = true;
		distance = new Vector2(0,0);
	}

}