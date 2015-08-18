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
        events.CAN_ENTITY_MOVE.add(canEntityMove); //Event registrieren
	}


	public override function update(elapsed: Float) : Void {

    //     for (collisionNode1 in collisionNodes) {

    //         var collision1: Collision = collisionNode1.collision,
    //             position1: Position = collisionNode1.position;

    //         var collisionResponse: CollisionResponse = new CollisionResponse();  
    //         var distance: Float = 0,
    //         	lastCollisionEntity: Entity = new Entity(); 

    //         //Dieses Entity wiederum mit jedem Entity vergleichen
    //         for (collisionNode2 in collisionNodes) {

    //         	//Wenn es sich dabei um das selbe Entity handelt, wird dieses übersprungen
    //         	if (collisionNode1.entity == collisionNode2.entity) continue;

    //             var collision2: Collision = collisionNode2.collision,
				// 	position2: Position = collisionNode2.position;   	


				// //Da ein Vergleich zweier Vielecke sehr rechenaufwändig ist, wird zuerst nur grob geprüft
				// //Schneiden sich schon die groben Kreise nicht, können genauere Prüfungen übersprungen werden
				// //Überschneidung von zwei Kreisen: (Abstand der Mittelpunkte ist kleiner als die Summe der Radien)
				// if ( position1.vector.distanceTo(position2.vector) > collision1.boundingRadius + collision2.boundingRadius ) continue;


				// //----- Vieleck Kollision: Seperating Axis Theorem -----

				// //Zuerst Vielecke um den Winkel drehen, der in der Positions-Komponente gespeichert ist.
				// var polygon1: Array<Vector2> = rotatePolygon(collision1.polygon, position1.rotation),
				// 	polygon2: Array<Vector2> = rotatePolygon(collision2.polygon, position2.rotation);

				// //Danach absolute Position bestimmen
				// polygon1 = getAbsolutePolygon(polygon1, position1.vector);
				// polygon2 = getAbsolutePolygon(polygon2, position2.vector);

				// collisionResponse.isColliding = true;

				// //Gehe durch alle Kanten der Vielecke und prüfe die Projektion
				// for (edge in getPolygonEdges(polygon1).concat(getPolygonEdges(polygon2))) {

				// 	//Senkrechte Achse bilden
				// 	var axis: Vector2 = edge.rotateLeft().normalize();

				// 	//Beide Vielecke auf Achse projezieren
				// 	var range1 = projectPolygon(polygon1, axis),
				// 		range2 = projectPolygon(polygon2, axis);

				// 	//Wenn sich die Projektionen nicht überschneiden, kollidieren die Vielecke nicht!
				// 	if (range1.distanceTo(range2) > 0) {
				// 		collisionResponse.isColliding = false;
				// 		lastCollisionEntity = collisionNode2.entity;
				// 		break;
				// 	}

				// 	if (range1.distanceTo(range2) < distance) distance = range1.distanceTo(range2);

				// }	


 
    //         }

    //         //trace(distance + " " + Type.getClassName(Type.getClass(collisionNode1.entity)));

    //         //Wenn die Entities kollidieren, wird ein Event ausgelöst, das andere System verarbeiten können.
    //         if (collisionResponse.isColliding) events.ENTITY_COLLIDED.dispatch(collisionNode1.entity, lastCollisionEntity, collisionResponse);

    //     }



	}


	private function canEntityMove(entity: Entity, movement: Vector2, response: CollisionResponse -> Void) : Void {


		var collisionResponse: CollisionResponse = new CollisionResponse();
		collisionResponse.distance = movement;

		//Es kann sein, dass das Entity, dass die Anfrage gemacht hat, keine Collision-Komponente besitzt.
		//In diesem Fall überspringen wir den restlichen Code und geben gleich eine Antwort.
		if (!entity.has(Collision)) {
			response(collisionResponse); //Antworten, dass Entity nicht kollidiert
			return; //Funktion abbrechen
		}

		var collision1: Collision = entity.get(Collision),
			position1: Position = entity.get(Position);

		//Absolutes Vieleck des Entities berechnen
		var polygon1: Array<Vector2> = getAbsolutePolygon(collision1.polygon, position1.vector, position1.rotation);

		//Kollision mit jedem Entity prüfen
		for (collisionNode2 in collisionNodes) {

			//Wenn es sich dabei um das selbe Entity handelt, wird dieses übersprungen
			if (entity == collisionNode2.entity) continue;

			var collision2: Collision = collisionNode2.collision,
				position2: Position = collisionNode2.position;   	


			//Da ein Vergleich zweier Vielecke sehr rechenaufwändig ist, wird zuerst nur grob geprüft
			//Schneiden sich schon die groben Kreise nicht, können genauere Prüfungen übersprungen werden
			//Überschneidung von zwei Kreisen: (Abstand der Mittelpunkte ist kleiner als die Summe der Radien)
			if ( position1.vector.distanceTo(position2.vector) > collision1.boundingRadius + collision2.boundingRadius ) continue;

			//if (Type.getClass(collisionNode2.entity) == app.entities.StoneWall) trace(getAbsolutePolygon(collision2.polygon, position2.vector, position2.rotation));

			//Nun prüfen wir detaillierter ob, die Vielecke kollidieren
			var polygonResponse: CollisionResponse = collide(polygon1, getAbsolutePolygon(collision2.polygon, position2.vector, position2.rotation), movement);

			if (polygonResponse.isColliding) collisionResponse.isColliding = true;
			if (polygonResponse.willCollide) collisionResponse.willCollide = true;
			if (!collision1.solid || !collision2.solid) collisionResponse.solid = false;

			//Wenn das Entity kollidiert, lösen wir gleichzeitig noch ein Event asu
			if (polygonResponse.isColliding || polygonResponse.willCollide) events.ENTITY_COLLIDED.dispatch(entity, collisionNode2.entity, polygonResponse);


		}


		response(collisionResponse);
	}


	private function collide(polygon1: Array<Vector2>, polygon2: Array<Vector2>, movement: Vector2) : CollisionResponse {

		var response: CollisionResponse = new CollisionResponse();
		response.isColliding = true; 
		response.willCollide = true;

		//var minProjectionDistance: Float = Math.POSITIV_INFINTY; 

		//Gehe durch alle Kanten der Vielecke und prüfe die Projektion
		for (edge in getPolygonEdges(polygon1).concat(getPolygonEdges(polygon2))) {

			//Orthogonale Achse zur Kante bestimmen
			var axis: Vector2 = new Vector2(-edge.y, edge.x).normalize();

			//Beide Vielecke auf Achse projezieren
			var projection1: Range = projectPolygon(polygon1, axis),
				projection2: Range = projectPolygon(polygon2, axis);

			//Wenn sich die Projektionen nicht überschneiden, ist bestätigt, dass es eine Lücke gibt
			//Daher kollidieren die Vielecke nicht
			if (projection1.distanceTo(projection2) > 0) response.isColliding = false;
			

			//=== Nun prüfen wir, ob die das Vieleck in der Bewegung kolldiert ===
			var movementProjection: Float = axis.dot(movement);

			//Intervall von Projektion1 um Projektion der Geschwindigkeit anpassen
			if (movementProjection < 0) {
				projection1.min += movementProjection;
			} else {
				projection1.max += movementProjection;
			}

			//Jetzt wieder erneut prüfen, ob sich die Projektionen überschneidne
			if (projection1.distanceTo(projection2) > 0) response.willCollide = false;

			// //Wenn der Abstand der Intervalle/Projektionen der kleinste ist, speichern
			// if ( Math.abs(projection1.distanceTo(projection2)) < minProjectionDistance) {

			// 	minProjectionDistance = Math.abs(projection1.distanceTo(projection2));

			// }	

		}


		return response;
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



	//Berechnet aus relativer Position und dem Winkel das absolute Vieleck
	private function getAbsolutePolygon(polygon: Array<Vector2>, position: Vector2, angle: Float) : Array<Vector2> {

		var absolute: Array<Vector2> = new Array<Vector2>();
		for (point in polygon) absolute.push(point.clone().rotate(angle) + position);

		return absolute;
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