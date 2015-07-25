package app.components;


import app.math.Vector2;
import app.math.Rectangle;

//Entity soll kollidieren können
class Collision {

	public var solid: Bool;
	public var polygon: Array<Vector2>; //Repräsentiert das Vieleck, das kollidiert
	public var boundingRadius: Float; //Der Abstand zum entferntesten Punkt des Vielecks. Er wird benutzt, um grob auf Kollision zu prüfen.

	public function new(polygon: Array<Vector2>, solid: Bool = true) {
		
		this.polygon = polygon;
		this.solid = solid;
		calculateFarthestPoint();

	}

	//Errechnet den Abstand zum entferntesten Punkt
	public function calculateFarthestPoint() : Void {

		var distance: Float = 0;

		for (point in polygon) {
			if (point.length > distance) distance = point.length;
		}
		
		boundingRadius = distance;
	}

}