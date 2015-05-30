package app.components;


//Speichert nötige Daten für Autosimulation
class Vehicle {

	public var speed: Float;	//Geschwindigkeit
	public var steerAngle: Float;	//Winkel der Vorderräder
	public var axisDistance: Float;	//Entfernung zwischen beiden Achsen

	public function new() {
		
		this.speed = 0;
		this.steerAngle = 0;
		this.axisDistance = 130; //Konstante Variale anghängig vom Fahrzeug

	}

}