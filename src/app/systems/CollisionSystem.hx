package app.systems;

import ash.core.System;
import ash.core.NodeList;
import ash.core.Engine;
import ash.signals.Signal1;

import app.systems.SystemEvents;
import app.nodes.CollisionNode;
import app.components.Collision;
import app.components.Position;
import app.math.Vector2;
import app.math.CollisionResponse;

class CollisionSystem extends System {


    private var collisionNodes: NodeList<CollisionNode>;

    private var events: SystemEvents;

    public function new(events: SystemEvents) {
		super();

        this.events = events;
	}


	public override function update(elapsed: Float) : Void {

        for (collisionNode1 in collisionNodes) {

            var collision1: Collision = collisionNode1.collision,
                position1: Position = collisionNode1.position;

            //Dieses Entity wiederum mit jedem Entity vergleichen
            for (collisionNode2 in collisionNodes) {

            	//Wenn es sich dabei um das selbe Entity handelt, wird dieses übersprungen
            	if (collisionNode1.entity == collisionNode2.entity) continue;

                var collision2: Collision = collisionNode2.collision,
					position2: Position = collisionNode2.position;   	


				//Da ein Vergleich zweier Vielecke sehr rechenaufwändig ist, wird zuerst nur grob geprüft
				//Schneiden sich schon die groben Kreise nicht, können genauere Prüfungen übersprungen werden
				//Überschneidung von zwei Kreisen: (Abstand der Mittelpunkte ist kleiner als die Summe der Radien)
				if ( position1.vector.distanceTo(position2.vector) > collision1.boundingRadius + collision2.boundingRadius ) continue;


				//Zuerst Vielecke um den Winkel drehen, der in der Positions-Komponente gespeichert ist.
				var polygon1: Array<Vector2> = rotatePolygon(collision1.polygon, position1.rotation),
					polygon2: Array<Vector2> = rotatePolygon(collision2.polygon, position2.rotation);


	
 


            }
        }



	}



	private function rotatePolygon(polygon: Array<Vector2>, angle: Float) : Array<Vector2> {

		var rotated: Array<Vector2> = new Array<Vector2>();
		for (point in polygon) rotated.push(point.rotate(angle));

		return rotated;
	}

	//Wird aufgerufen, wenn System der Engine hinzugefügt wird
    public override function addToEngine(engine: Engine):Void {
        collisionNodes = engine.getNodeList(CollisionNode);
   	}

   	//Wird aufgerufen, wenn System von der Engine entfernt wird
    public override function removeFromEngine(engine: Engine):Void {
        collisionNodes = null;
    }


}