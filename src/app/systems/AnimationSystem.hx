package app.systems;


import ash.core.System;
import ash.core.Entity;
import ash.core.NodeList;
import ash.core.Engine;

import motion.Actuate;
import motion.easing.Quad;

import app.systems.SystemEvents;
import app.math.CollisionResponse;
import app.nodes.CameraNode;
import app.components.Camera;

class AnimationSystem extends System {


    private var events: SystemEvents;
    private var cameraNodes: NodeList<CameraNode>;

    public function new(events: SystemEvents) {
		super();

        this.events = events;

        events.GAME_ZOOM_IN.add(onZoomIn);
	}


	public override function update(elapsed: Float) : Void {


	}

    private function onZoomIn(callback: Void->Void) : Void {
        
        for (cameraNode in cameraNodes) {
            Actuate.tween(cameraNode.camera, 1, {zoom: 1, blur: 0}).ease(Quad.easeInOut).delay(0.2).onComplete(callback);

        }


    }

	//Wird aufgerufen, wenn System der Engine hinzugefügt wird
    public override function addToEngine(engine: Engine):Void {
        cameraNodes = engine.getNodeList(CameraNode);
   	}

   	//Wird aufgerufen, wenn System von der Engine entfernt wird
    public override function removeFromEngine(engine: Engine):Void {
        cameraNodes = null;
    }


}