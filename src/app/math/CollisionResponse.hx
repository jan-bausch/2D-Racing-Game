package app.math;

import app.math.Vector2;

class CollisionResponse {

	public var isColliding: Bool;
	public var willCollide: Bool;
	public var distance: Vector2;
	public var solid: Bool;

	public function new() {
		isColliding = false;
		willCollide = false;
		solid = true;
		distance = new Vector2(0,0);
	}

}