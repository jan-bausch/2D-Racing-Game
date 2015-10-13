package app.components;

import app.math.Vector2;

//Speichert nötige Daten für Autosimulation
class Vehicle {

	public var velocity: Float;
	public var boost: Vector2;

	public var MASS: Float;
	public var ENGINE_FORCE: Float;
	public var BRAKE_FORCE: Float;
	public var REVERSE_FORCE: Float;

	public var throttle: Bool;
	public var brake: Bool;
	public var handbrake: Bool;
	public var steerAngle: Float;	//Winkel der Vorderräder
	public var axisDistance: Float;	//Entfernung zwischen beiden Achsen

	public function new() {

		this.velocity = 0;
		this.boost = new Vector2(0,0);


		this.MASS = 1200;
		this.ENGINE_FORCE = 5000;
		this.BRAKE_FORCE = 12000;
		this.REVERSE_FORCE = 1000;

		this.throttle = false;
		this.brake = false;
		this.handbrake = false;
		this.steerAngle = 0;
		this.axisDistance = 130; //Konstante Variale anghängig vom Fahrzeug

	}

}