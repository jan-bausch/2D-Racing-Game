package app.systems;

import ash.signals.Signal0;
import ash.signals.Signal1;
import ash.signals.Signal2;
import ash.signals.Signal3;

import ash.core.Entity;

import app.math.CollisionResponse;

class SystemEvents {

	public var LOAD_LEVEL: Signal1<Int>;
	public var ENTITY_COLLIDED: Signal3<Entity, Entity, CollisionResponse>;

	public function new() {

		LOAD_LEVEL = new Signal1<Int>();
		ENTITY_COLLIDED = new Signal3<Entity, Entity, CollisionResponse>();

	}

}