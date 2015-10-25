package app.systems;


import ash.core.System;
import ash.core.Entity;
import ash.core.NodeList;
import ash.core.Engine;


import app.nodes.CameraNode;
import app.systems.SystemEvents;
import app.math.Vector2;


class CameraSystem extends System {


    private var events: SystemEvents;
    private var cameraNodes: NodeList<CameraNode>;

    public function new(events: SystemEvents) {
        super();

        this.events = events;
    }


    public override function update(elapsed: Float) : Void {

        for (cameraNode in cameraNodes) {

            var delta: Vector2 = cameraNode.camera.target - cameraNode.camera.focus;
            //Position der Kamera näher an Zielposition bewegen
            cameraNode.camera.focus += delta.normalize() * Math.min(cameraNode.camera.inertia * elapsed, delta.length); 
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