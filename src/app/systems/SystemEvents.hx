package app.systems;

import ash.signals.SignalBase;
import ash.signals.Signal0;
import ash.signals.Signal1;
import ash.signals.Signal2;
import ash.signals.Signal3;

import ash.core.Entity;

import app.entities.Level;
import app.math.CollisionResponse;
import app.math.Vector2;

class SystemEvents {

	public var LOAD_LEVEL: Signal1<Level>;
	public var LOADED_LEVEL: Signal0;
	public var GAME_ZOOM_IN: Signal1<Void->Void>;
	public var GAME_COUNTDOWN: Signal1<Void->Void>;
	public var GAME_START: Signal0;
	public var GAME_END: Signal2<Float, Result>;

	public var COLLISION: Signal3<Entity, Entity, CollisionResponse>;
	public var COLLISION_ENTER: Signal3<Entity, Entity, CollisionResponse>;
	public var COLLISION_LEAVE: Signal2<Entity, Entity>;

	public var CHECKPOINT_ACTIVATED: Signal1<Int>;

	public var CAN_ENTITY_MOVE: Signal3<Entity, Vector2, CollisionResponse -> Void>;

	public var CAR_BREAK_BEGIN: Signal0;
	public var CAR_BREAK_END: Signal0;

	public function new() {

		LOAD_LEVEL = new Signal1<Level>();
		LOADED_LEVEL = new Signal0();
		GAME_ZOOM_IN = new Signal1<Void->Void>();
		GAME_COUNTDOWN = new Signal1<Void->Void>();
		GAME_START = new Signal0();
		GAME_END = new Signal2<Float, Result>();

		COLLISION = new Signal3<Entity, Entity, CollisionResponse>();
		COLLISION_ENTER = new Signal3<Entity, Entity, CollisionResponse>();
		COLLISION_LEAVE = new Signal2<Entity, Entity>();

		CHECKPOINT_ACTIVATED = new Signal1<Int>();

		CAN_ENTITY_MOVE = new Signal3<Entity, Vector2, CollisionResponse -> Void>();
		CAR_BREAK_BEGIN = new Signal0();
		CAR_BREAK_END = new Signal0();
	}

}

//Die "Ash"-Bibliothek kommt nur mit Signalen bis zu 3 Parametern. Daher erstellen wir Signal4 selbst
class Signal4<T1, T2, T3, T4> extends SignalBase<T1->T2->T3->T4->Void> {}