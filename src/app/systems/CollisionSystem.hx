package app.systems;

import ash.core.System;
import ash.core.NodeList;
import ash.core.Engine;
import ash.core.Entity;
import ash.signals.Signal1;

import app.systems.SystemEvents;
import app.nodes.CollisionNode;
import app.components.Collision;
import app.components.Position;
import app.math.Vector2;
import app.math.Range;
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

            var collisionResponse: CollisionResponse = new CollisionResponse();  
            var distance: Float = 0,
            	lastCollisionEntity: Entity = new Entity(); 

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


				//----- Vieleck Kollision: Seperating Axis Theorem -----

				//Zuerst Vielecke um den Winkel drehen, der in der Positions-Komponente gespeichert ist.
				var polygon1: Array<Vector2> = rotatePolygon(collision1.polygon, position1.rotation),
					polygon2: Array<Vector2> = rotatePolygon(collision2.polygon, position2.rotation);

				//Danach absolute Position bestimmen
				polygon1 = getAbsolutePolygon(polygon1, position1.vector);
				polygon2 = getAbsolutePolygon(polygon2, position2.vector);

				collisionResponse.isColliding = true;

				//Gehe durch alle Kanten der Vielecke und prüfe die Projektion
				for (edge in getPolygonEdges(polygon1).concat(getPolygonEdges(polygon2))) {

					//Senkrechte Achse bilden
					var axis: Vector2 = edge.rotateLeft().normalize();

					//Beide Vielecke auf Achse projezieren
					var range1 = projectPolygon(polygon1, axis),
						range2 = projectPolygon(polygon2, axis);

					//Wenn sich die Projektionen nicht überschneiden, kollidieren die Vielecke nicht!
					if (range1.distanceTo(range2) > 0) {
						collisionResponse.isColliding = false;
						lastCollisionEntity = collisionNode2.entity;
						break;
					}

					if (range1.distanceTo(range2) < distance) distance = range1.distanceTo(range2);

				}	


 
            }

            //trace(distance + " " + Type.getClassName(Type.getClass(collisionNode1.entity)));

            //Wenn die Entities kollidieren, wird ein Event ausgelöst, das andere System verarbeiten können.
            if (collisionResponse.isColliding) events.ENTITY_COLLIDED.dispatch(collisionNode1.entity, lastCollisionEntity, collisionResponse);

        }



	}

	//Array von Punkten eines Vielecks in Array von Kanten des Vielecks umwandeln
	private function getPolygonEdges(polygon: Array<Vector2>) : Array<Vector2> {

		var edges: Array<Vector2> = new Array<Vector2>();

		for (i in 0...polygon.length-1) edges.push(polygon[i+1] - polygon[i]);
		edges.push(polygon[0] - polygon[polygon.length-1]);

		return edges;
	}

	//Berechnet die Projektion eines Vielecks auf einen Vektor und gibt Mininum und Maximum zurück.
	private function projectPolygon(polygon: Array<Vector2>, axis: Vector2) : Range {

		var dotProduct: Float = axis.dot(polygon[0]),
			range: Range = new Range(dotProduct, dotProduct);

		//Alle Punkte auf den Vektor projezieren
		for (point in polygon) {

			//Skalarprodukt des Punktes auf den Vektor berechnen
			var dotProduct: Float = axis.dot(point);

			//Evt. Grenzen der Projektion aktualisieren
			if (dotProduct < range.min) range.min = dotProduct;
			if (dotProduct > range.max) range.max = dotProduct;

		}

		return range;
	}



	//Berechnet die absolute Postion der Punkte eines Vielecks
	private function getAbsolutePolygon(polygon: Array<Vector2>, position: Vector2) : Array<Vector2> {

		for (i in 0...polygon.length) {
			polygon[i] += position;
		}

		return polygon;
	}

	//Vieleck um den Mittelpunkt drehen
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