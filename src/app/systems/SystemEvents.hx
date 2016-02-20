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

/*
    Hier werden alle die globalen Ereignisse definiert, die von allen
    System abonniert und ausgelöst werden können.
*/
class SystemEvents {

    public var LOAD_LEVEL: Signal1<Level>; //Level soll geladen werden
    public var LOADED_LEVEL: Signal1<Level>; //Level wurde geladen
    public var GAME_ZOOM_IN: Signal1<Void->Void>; //Zoom auf Spieler zu Beginn des Spiels
    public var GAME_COUNTDOWN: Signal1<Void->Void>; //Countdown zu Beginn des Spiels
    public var GAME_START: Signal0; //Countdown abgelaufen
    public var GAME_QUIT: Signal0; //Spiel beendet (durch Escapemenü)
    public var GAME_PAUSE: Signal0; //Spiel pausiert
    public var GAME_UNPAUSE: Signal0; //Pausemenü geschlossen
    public var GAME_END: Signal2<Float, Result>; //Spiel beendet (durch Erreichen des Ziels)

    public var COLLISION: Signal3<Entity, Entity, CollisionResponse>; //Wird jeden Schleifendurchlauf aufgerufen, wenn zwei Entitäten kollidieren
    public var COLLISION_ENTER: Signal3<Entity, Entity, CollisionResponse>; //Beginn einer Kollision
    public var COLLISION_LEAVE: Signal2<Entity, Entity>; //Ende einer Kollision

    public var CHECKPOINT_ACTIVATED: Signal1<Int>; //Checkpoint überquert

    public var CAN_ENTITY_MOVE: Signal3<Entity, Vector2, CollisionResponse -> Void>; //Frage an Kollisionssystem, ob sich Entität bewegen darf

    public var CAR_CRASH: Signal0; //Auto kollidiert
    public var CAR_BREAK_BEGIN: Signal0;
    public var CAR_BREAK_END: Signal0;

    public function new() {

        LOAD_LEVEL = new Signal1<Level>();
        LOADED_LEVEL = new Signal1<Level>();
        GAME_ZOOM_IN = new Signal1<Void->Void>();
        GAME_COUNTDOWN = new Signal1<Void->Void>();
        GAME_START = new Signal0();
        GAME_QUIT = new Signal0();
        GAME_PAUSE = new Signal0();
        GAME_UNPAUSE = new Signal0();
        GAME_END = new Signal2<Float, Result>();

        COLLISION = new Signal3<Entity, Entity, CollisionResponse>();
        COLLISION_ENTER = new Signal3<Entity, Entity, CollisionResponse>();
        COLLISION_LEAVE = new Signal2<Entity, Entity>();

        CHECKPOINT_ACTIVATED = new Signal1<Int>();

        CAN_ENTITY_MOVE = new Signal3<Entity, Vector2, CollisionResponse -> Void>();
        CAR_CRASH = new Signal0();
        CAR_BREAK_BEGIN = new Signal0();
        CAR_BREAK_END = new Signal0();
    }

}
