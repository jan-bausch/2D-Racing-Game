package app.systems;


import ash.core.System;
import ash.core.Entity;
import ash.core.NodeList;
import ash.core.Engine;

import motion.Actuate;
import motion.easing.Quad;

import app.entities.Level;
import app.systems.SystemEvents;
import app.math.CollisionResponse;
import app.math.Vector2;
import app.nodes.CameraNode;
import app.nodes.PathNode;
import app.components.Camera;
import app.components.Position;
import app.components.PathComponent;

class AnimationSystem extends System {


    private var events: SystemEvents;
    private var cameraNodes: NodeList<CameraNode>;
    private var pathNodes: NodeList<PathNode>;

    public function new(events: SystemEvents) {
        super();

        this.events = events;

        events.GAME_ZOOM_IN.add(onZoomIn);
        events.LOADED_LEVEL.add(onLoadedLevel);
    }


    public override function update(elapsed: Float) : Void {


    }

    private function onZoomIn(callback: Void->Void) : Void {
        
        for (cameraNode in cameraNodes) {
            Actuate.tween(cameraNode.camera, 1, {zoom: 1, blur: 0}).ease(Quad.easeInOut).delay(0.2).onComplete(callback);

        }


    }


    private function startPath(pathComponent: PathComponent) : Void {

        //Zuerst werden Start und Ziel getauscht, damit die Animation geloopt wird
        var temp: Vector2 = pathComponent.start;
        pathComponent.start = pathComponent.end;
        pathComponent.end = temp;

        var position: Vector2 = pathComponent.target.get(Position).vector;

        //Dann wird der Positionsvektor zum End-Vektor bewegen
        Actuate.tween (position, 2, { x: pathComponent.end.x, y: pathComponent.end.y }).ease(Quad.easeInOut).onComplete(function () {


            //Wenn die Animation beendet ist, wird die Animation in die andere Richtung wiederholt
            startPath(pathComponent);

        });


    }

    //Wird aufgerufen, wenn ein neues Level geladen wurde.
    private function onLoadedLevel(newLevel: Level) : Void {

        //Nachdem das Level geladen wurde, werden alle Pfad-Animationen gestartet
        for (pathNode in pathNodes) {

            //Entität auf die Startposition versetzen
            pathNode.pathComponent.target.get(Position).vector = pathNode.pathComponent.start.clone(); 

            //Dann Animation starten
            startPath(pathNode.pathComponent);
        }

    }    

    //Wird aufgerufen, wenn System der Engine hinzugefügt wird
    public override function addToEngine(engine: Engine):Void {
        cameraNodes = engine.getNodeList(CameraNode);
        pathNodes = engine.getNodeList(PathNode);
    }

    //Wird aufgerufen, wenn System von der Engine entfernt wird
    public override function removeFromEngine(engine: Engine):Void {
        cameraNodes = null;
        pathNodes = null;
    }


}