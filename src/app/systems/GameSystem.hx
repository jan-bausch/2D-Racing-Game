package app.systems;

import ash.core.System;
import ash.core.NodeList;
import ash.core.Engine;
import ash.signals.Signal1;

import app.systems.SystemEvents;

class GameSystem extends System {


    private var events: SystemEvents;

    public function new(events: SystemEvents) {
		super();

        this.events = events;


	}


	public override function update(elapsed: Float) : Void {


	}


	//Wird aufgerufen, wenn System der Engine hinzugefügt wird
    public override function addToEngine(engine: Engine):Void {

    	//Erstes Level laden
        events.LOAD_LEVEL.dispatch(0);
        
   	}

   	//Wird aufgerufen, wenn System von der Engine entfernt wird
    public override function removeFromEngine(engine: Engine):Void {

    }


}