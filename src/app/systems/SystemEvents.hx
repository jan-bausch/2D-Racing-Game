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
	public var GAME_ZOOM_IN: Signal1<Void->Void>;
	public var GAME_COUNTDOWN: Signal1<Void->Void>;
	public var GAME_START: Signal0;
	public var GAME_END: Signal1<Float>;

	public var SHOW_MAINMENU: Signal0;
	public var SHOW_PAUSEMENU: Signal0;

	public var ENTITY_COLLIDED: Signal3<Entity, Entity, CollisionResponse>;
	public var CAN_ENTITY_MOVE: Signal3<Entity, Vector2, CollisionResponse -> Void>;

	public var CAR_BREAK_BEGIN: Signal0;
	public var CAR_BREAK_END: Signal0;

	public function new() {

		LOAD_LEVEL = new Signal1<Level>();
		GAME_ZOOM_IN = new Signal1<Void->Void>();
		GAME_COUNTDOWN = new Signal1<Void->Void>();
		GAME_START = new Signal0();
		GAME_END = new Signal1<Float>();

		SHOW_MAINMENU = new Signal0();
		SHOW_PAUSEMENU = new Signal0();

		ENTITY_COLLIDED = new Signal3<Entity, Entity, CollisionResponse>();
		CAN_ENTITY_MOVE = new Signal3<Entity, Vector2, CollisionResponse -> Void>();
		CAR_BREAK_BEGIN = new Signal0();
		CAR_BREAK_END = new Signal0();
	}

}

//Die "Ash"-Bibliothek kommt nur mit Signalen bis zu 3 Parametern. Daher erstellen wir Signal4 selbst
class Signal4<T1, T2, T3, T4> extends SignalBase<T1->T2->T3->T4->Void> {}