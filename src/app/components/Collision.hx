package app.components;


import app.math.Vector2;
import ash.core.Entity;

//Entity soll kollidieren können
class Collision {

	public var solid: Bool;
	public var width: Float;
	public var height: Float;
	public var collidingEntities: Array<Entity>;
	public var radius: Float; //Der Abstand zum entferntesten Punkt des Rechtecks. Er wird benutzt, um grob auf Kollision zu prüfen.

	public function new(width: Float, height: Float, solid: Bool = true) {
		
		this.width = width;
		this.height = height;
		this.solid = solid;
		this.radius = new Vector2(width/2, height/2).length;
		this.collidingEntities = [];

	}

}