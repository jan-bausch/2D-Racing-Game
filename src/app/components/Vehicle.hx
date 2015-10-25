package app.components;

import app.math.Vector2;

//Speichert nötige Daten für Autosimulation
class Vehicle {

    public var velocity: Float;
    public var boost: Float;

    public var MASS: Float;
    public var ENGINE_FORCE: Float;
    public var BRAKE_FORCE: Float;
    public var REVERSE_FORCE: Float;

    public var throttle: Float;
    public var brake: Float;
    public var steerAngle: Float;   //Winkel der Vorderräder
    public var axisDistance: Float; //Entfernung zwischen beiden Achsen

    public function new() {

        this.velocity = 0;
        this.boost = 0;


        this.MASS = 1200;
        
        this.ENGINE_FORCE = 10000;
        this.BRAKE_FORCE = 20000;
        this.REVERSE_FORCE = 3000;

        this.throttle = 0;
        this.brake = 0;
        this.steerAngle = 0;
        this.axisDistance = 130; //Konstante Variale anghängig vom Fahrzeug

    }

}