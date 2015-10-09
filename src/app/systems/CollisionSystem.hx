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

	}


	private function canEntityMove(entity: Entity, movement: Vector2, callback: CollisionResponse -> Void) : Void {


		var collisionResponse: CollisionResponse = new CollisionResponse();
		collisionResponse.distance = movement;

		//Es kann sein, dass das Entity, dass die Anfrage gemacht hat, keine Collision-Komponente besitzt.
		//In diesem Fall überspringen wir den restlichen Code und geben gleich eine Antwort.
		if (!entity.has(Collision)) {
			callback(collisionResponse); //Antworten, dass Entity nicht kollidiert
			return; //Funktion abbrechen
		}

		var collision1: Collision = entity.get(Collision),
			position1: Position = entity.get(Position);


		//Kollision mit jedem Entity prüfen
		for (collisionNode2 in collisionNodes) {

			//Wenn es sich dabei um das selbe Entity handelt, wird dieses übersprungen
			if (entity == collisionNode2.entity) continue;

			var collision2: Collision = collisionNode2.collision,
				position2: Position = collisionNode2.position;   	


			//Da ein Vergleich zweier gedrehter Rechtecke rechenaufwändig ist, wird zuerst nur grob geprüft
			//Schneiden sich schon die Radi der Rechtecke nicht, wird Schleifendurchgang übersprungen
			//Überschneidung von zwei Kreisen: (Abstand der Mittelpunkte ist kleiner als die Summe der Radien)
			//if ( position2.vector.distanceTo(position1.vector + movement) > collision1.radius + collision2.radius ) continue;

			//Nun prüfen wir detaillierter, ob die aktuellen Rechtecke kollidieren
			var response: CollisionResponse = collide(position1.vector + movement, collision1.width, collision1.height, position1.rotation, position2.vector, collision2.width, collision2.height, position2.rotation);


			//Wenn die aktuellen Rechtecke kollidieren, dann kollidiert auch das Entity
			if (response.collision) collisionResponse.collision = true;
			if (!collision1.solid && !collision2.solid) collisionResponse.solid = false;

			//Wenn das Entity kollidiert, lösen wir gleichzeitig noch ein Event aus
			if (response.collision) events.ENTITY_COLLIDED.dispatch(entity, collisionNode2.entity, response);


		}

		//Nachdem alle möglichen Kombinationen probiert wurden, geben wir das Ergebniss zurück
		callback(collisionResponse);
	}

	//Prüft, ob sich zwei rotierte Rechtecke überschneiden (mithilfe des Separating Axis Theorem)
	private function collide(position1: Vector2, width1: Float, height1: Float, rotation1: Float, position2: Vector2, width2: Float, height2: Float, rotation2: Float) : CollisionResponse {

		//Wir gehen anfangs davon aus, dass sich die Rechtecke überschneiden und versuchen dann, dies zu widerlegen
		var response: CollisionResponse = new CollisionResponse();
		response.collision = true;


		//Beide Rechtecke besitzen je zwei Achsen (X- und Y-Achse) - insgesammt gibt es also vier verschiedene Achsen
		//Wir projezieren nun beide Rechtecke auf diese vier Achsen. Wenn es eine Achse gibt, bei der sich die Projektion
		//der beiden Rechtecke nicht überschneidet, ist bewiesen, dass die Rechtecke nicht kollidieren

		//Eine Schleife, die durch die vier Achsen läuft (Y1, X1, Y2, X2)
		for (axis in [Vector2.fromPolar(rotation1), Vector2.fromPolar(rotation1 + 90), Vector2.fromPolar(rotation2), Vector2.fromPolar(rotation2 + 90)]) {

			//Zuerst auf Rechteck 1 auf Achse projezieren
			var projection1: Range = new Range();
			//Ecke * Achse
			projection1.add( (new Vector2(width1/2, height1/2).rotate(rotation1) + position1) * axis); //Rechts unten
			projection1.add( (new Vector2(width1/2, -height1/2).rotate(rotation1) + position1) * axis);
			projection1.add( (new Vector2(-width1/2, -height1/2).rotate(rotation1) + position1) * axis);
			projection1.add( (new Vector2(-width1/2, height1/2).rotate(rotation1) + position1) * axis);


			trace((new Vector2(width1/2, height1/2).rotate(rotation1) + position1));
			trace((new Vector2(width2/2, height2/2).rotate(rotation2) + position2));

			//Dann Rechteck 2 auf Achse projezieren
			var projection2: Range = new Range();
			projection2.add( (new Vector2(width2/2, height2/2).rotate(rotation2) + position2) * axis);
			projection2.add( (new Vector2(width2/2, -height2/2).rotate(rotation2) + position2) * axis);
			projection2.add( (new Vector2(-width2/2, -height2/2).rotate(rotation2) + position2) * axis);
			projection2.add( (new Vector2(-width2/2, height2/2).rotate(rotation2) + position2) * axis);



			//Wenn sich die Projektionen nicht überschneiden, ist bestätigt, dass es eine Lücke gibt
			//Daher kollidieren die Vielecke nicht
			if (projection1.distanceTo(projection2) > 0) response.collision = false;
		}

		return response;
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