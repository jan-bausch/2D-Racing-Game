package app.components;

import app.math.Vector2;

//Speichert nötige Daten für Autosimulation
class Vehicle {

    public var velocity: Float; //Geschwindigkeit (in m/s)
    public var boost: Float; //Boost-Kraft (z.B. von Boosterflächen) (in Nm)

    public var MASS: Float; //Masse des Autos (in kg)
    public var WHEELBASE: Float; //Radstand (Entfernung zwischen beiden Achsen) (in px)
    public var ENGINE_FORCE: Float; //Motorkraft (in Nm)
    public var BRAKE_FORCE: Float; //Bremskraft (in Nm)
    public var REVERSE_FORCE: Float; //Kraft des Rückwärtsgang (in Nm)

    public var throttle: Float; //Gas-Input (zwischen 0...1)
    public var brake: Float; //Brems-Input (zwischen 0...1)
    public var steerAngle: Float;  //Winkel des Lenkrads relativ zur Richtung des Autos (in Grad°)

    public function new() {

        this.velocity = 0;
        this.boost = 0;


        this.MASS = 1200;
        this.WHEELBASE = 130;
        
        this.ENGINE_FORCE = 10000;
        this.BRAKE_FORCE = 20000;
        this.REVERSE_FORCE = 3000;

        this.throttle = 0;
        this.brake = 0;
        this.steerAngle = 0;

    }

}