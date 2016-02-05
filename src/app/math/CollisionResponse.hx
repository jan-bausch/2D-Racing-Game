package app.math;

import app.math.Vector2;

/*
    Das Kollisions-System gibt diese Klasse als Antwort zurück.
*/
class CollisionResponse {

    public var collision: Bool; //Überschneiden sich beide Entitäten?
    public var offset: Vector2; //Um wieviel muss die Entität verschoben werden, damit sie genau an der Kante liegt
    public var solid: Bool; //Ist es eine Kollision zwischen zwei festen Objekten?

    public function new() {
        collision = false;
        solid = false;
        offset = new Vector2(0,0);
    }

}