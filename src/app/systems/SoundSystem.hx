package app.systems;


import ash.core.System;
import ash.core.Entity;
import ash.core.NodeList;
import ash.core.Engine;

import openfl.Assets;
import openfl.media.Sound;
import openfl.media.SoundTransform;


import app.systems.SystemEvents;
import app.math.CollisionResponse;

class SoundSystem extends System {


    private var events: SystemEvents;
    private var volume: Float;

    private var SOUND_BREAK: Sound;

    public function new(events: SystemEvents) {
		super();

        this.events = events;
        this.volume = 1;
        events.CAR_BREAK_BEGIN.add(onBreakBegin);
        events.CAR_BREAK_END.add(onBreakEnd);

        SOUND_BREAK = Assets.getSound("res/sounds/drift.ogg");

	}


	public override function update(elapsed: Float) : Void {


	}


    private function onBreakBegin() : Void {

    }

    private function onBreakEnd() : Void {

    }

	//Wird aufgerufen, wenn System der Engine hinzugefügt wird
    public override function addToEngine(engine: Engine):Void {
        
   	}

   	//Wird aufgerufen, wenn System von der Engine entfernt wird
    public override function removeFromEngine(engine: Engine):Void {

    }


}