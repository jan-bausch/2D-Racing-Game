package app.math;

import app.math.Vector2;

class CollisionResponse {

	public var isColliding: Bool;
	public var willCollide: Bool;
	public var distance: Vector2;

	public function new() {
		isColliding = false;
		willCollide = false;
		distance = new Vector2(0,0);
	}

}