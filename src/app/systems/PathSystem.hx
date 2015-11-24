package app.systems;


import ash.core.System;
import ash.core.Entity;
import ash.core.NodeList;
import ash.core.Engine;

import motion.Actuate;
import motion.easing.Quad;
import motion.MotionPath;

import app.math.Vector2;
import app.systems.SystemEvents;
import app.math.CollisionResponse;
import app.nodes.PathNode;
import app.components.Position;
import app.components.PathComponent;

class PathSystem extends System {


    private var events: SystemEvents;
    private var pathNodes: NodeList<PathNode>;

    public function new(events: SystemEvents) {
        super();

        this.events = events;

        events.LOADED_LEVEL.add()
    }


    public override function update(elapsed: Float) : Void {

        for (pathNode in pathNodes) {
            var path: PathComponent = pathNode.pathComponent;

            path.target.get(Position).vector = path.waypoints[0];

        }

    }

    //Wird aufgerufen, wenn System der Engine hinzugefügt wird
    public override function addToEngine(engine: Engine):Void {
        pathNodes = engine.getNodeList(PathNode);
    }

    //Wird aufgerufen, wenn System von der Engine entfernt wird
    public override function removeFromEngine(engine: Engine):Void {
        pathNodes = null;
    }


}