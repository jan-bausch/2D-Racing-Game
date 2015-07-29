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

	public var CAR_BREAK_BEGIN: Signal0;
	public var CAR_BREAK_END: Signal0;

	public function new() {

		LOAD_LEVEL = new Signal1<Int>();
		ENTITY_COLLIDED = new Signal3<Entity, Entity, CollisionResponse>();
		CAR_BREAK_BEGIN = new Signal0();
		CAR_BREAK_END = new Signal0();
	}

}