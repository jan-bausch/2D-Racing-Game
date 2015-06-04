package app.systems;

import ash.core.System;
import ash.core.NodeList;
import ash.core.Engine;
import ash.signals.Signal1;


class GameSystem extends System {


    private var LOAD_LEVEL: Signal1<Int>;

    public function new(LOAD_LEVEL: Signal1<Int>) {
		super();

        this.LOAD_LEVEL = LOAD_LEVEL;


	}


	public override function update(elapsed: Float) : Void {


	}


	//Wird aufgerufen, wenn System der Engine hinzugefügt wird
    public override function addToEngine(engine: Engine):Void {
        LOAD_LEVEL.dispatch(0);
   	}

   	//Wird aufgerufen, wenn System von der Engine entfernt wird
    public override function removeFromEngine(engine: Engine):Void {

    }


}