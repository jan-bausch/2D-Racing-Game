package app.systems;

import ash.core.System;
import ash.core.NodeList;
import ash.core.Engine;
import app.math.Vector2;
import app.math.MathUtil;
import app.math.CollisionResponse;

import app.nodes.VehicleNode;
import app.components.Vehicle;
import app.components.Position;

class VehicleSystem extends System {

    private var vehicleNodes: NodeList<VehicleNode>;

    private var events: SystemEvents;

    //Naturkonstanten
    private static inline var ROLLING_RESISTANCE: Float = 180;
    private static inline var AIR_RESISTANCE: Float = 5;

    public function new(events: SystemEvents) {
        super();

        this.events = events;

    }

    public override function update(elapsed: Float) : Void {

        for (vehicleNode in vehicleNodes) {

            var vehicle: Vehicle = vehicleNode.vehicle,
                position: Position = vehicleNode.position;


            /*  
                ---------------------
                Zuerst berechnen wir die Antriebskraft (in N), die durch Gas, Bremsen und 
                Rückwärtsgang beeinflusst wird.
                ---------------------
            */    
            var tractionForce: Float =  (vehicle.throttle * vehicle.ENGINE_FORCE) //Wenn Gas gedrückt ist, soll beschleunigt werden
                                       - (vehicle.velocity > 0 ? vehicle.brake * vehicle.BRAKE_FORCE: 0)  //Wenn Bremse gedrückt und Geschwindigkeit ÜBER 0m/s ist, soll gebremst werden
                                       - (vehicle.velocity <= 0 ? vehicle.brake * vehicle.REVERSE_FORCE: 0); //Wenn Bremse gedrückt und Geschwindigkeit UNTER 0m/s ist, soll rückwärts gefahren werden.


            /*  
                ---------------------
                Dann berücksichtigen wir die Widerstandskräfte (in N)
                ---------------------
            */    
            //Rollwiderstand: -Rollwiderstands-Konstante * v
            var rollingForce: Float = -ROLLING_RESISTANCE * vehicle.velocity;
            //Luftwiderstand: -Luftwiderstands-Konstante * v * v
            var dragForce: Float = -AIR_RESISTANCE * vehicle.velocity * vehicle.velocity;
                

            /*  
                ---------------------
                Antriebs- und Widerstandskräfte, sowie die "Boost"-Kraft (erzeugt z.B. durch
                Boosterflächen) werden addiert.
                ---------------------
            */  
            var longForce: Float = tractionForce + dragForce + rollingForce + vehicle.boost;


            /*  
                ---------------------
                Mithilfe der Masse des Autos lässt sich die Beschleunigung (in m/s^2) und schließlich
                die Geschwindigkeit ermitteln.
                ---------------------
            */  
            var acceleration: Float = longForce / vehicle.MASS;
            vehicle.velocity += elapsed * acceleration;


            /*  
                ---------------------
                Ausgehend von der Position des Autos (der Mittelpunkt der Karosserie) 
                lassen sich die Position von Vorder- und Hinterrad berechen.
                ---------------------
            */
            //Das Vorderrad befindet sich in Fahrtrichtung in einer Entfernung von 1/2 Radstand
            var frontWheel: Vector2 = position.vector + Vector2.fromPolar(position.rotation, vehicle.WHEELBASE/2);
            //Das Hinterrad befindet sich gegen Fahrtrichtung in einer Entfernung von 1/2 Radstand
            var backWheel: Vector2 = position.vector + Vector2.fromPolar(position.rotation + 180, vehicle.WHEELBASE/2);


            /*  
                ---------------------
                Danach bewegen wir Vorder- und Hinterrad.
                Bisher haben wir der Basiseinheit Meter gerechnet. Da die Position aller Spielobjekte
                in Pixel angegeben sind, nehmen wir Variablen in Meter mit 200/5 mal, um sie in
                Pixel umzuwandeln (da ungefähr gilt 200px = 5m).
                ---------------------
            */
            //Das Vorderrad wird in Fahrtrichtung addiert mit Lenkwinkel bewegt.
            frontWheel += Vector2.fromPolar(position.rotation + vehicle.steerAngle, vehicle.velocity * 200/5 * elapsed);
            //Das Hinterrad wird nur in Fahrtrichtung bewegt
            backWheel += Vector2.fromPolar(position.rotation, vehicle.velocity * 200/5 * elapsed);
            

            /*  
                ---------------------
                Die neue Rotation des Autos ergibt sich aus dem Winkel vom neuen Hinterrad
                zum neuen Vorderrad.
                ---------------------
            */
            var rotation: Float = backWheel.angleTo(frontWheel);


            /*
                ---------------------
                Zuletzt die neue Position des Autos berechnen, die der Mittelpunkt zwischen
                Hinter- und Vorderrad ist.
                ---------------------
            */
            var newPosition: Vector2 = (frontWheel + backWheel) / 2;
            var movement: Vector2 = newPosition - position.vector;


            /*
                ---------------------
                Danach das CollisionSystem fragen, ob sich das Auto sich bewegen kann.
                ---------------------
            */
            events.CAN_ENTITY_MOVE.dispatch(vehicleNode.entity, movement, function (response: CollisionResponse) {

                if (response.collision == false || response.solid == false) {

                    //Wenn es nicht kollidiert, können Rotation und Bewegung angewendet werden.
                    position.rotation = rotation;
                    position.vector += response.offset;

                } else {
                    if (response.solid) {

                        //Wenn es mit einem soliden Objekt kollidiert, wird Geschwindigkeit reduziert.
                        vehicle.velocity /= 2;
                        position.vector -= response.offset;

                        //Zuletzt Event auslösen
                        if (vehicle.velocity > 5) events.CAR_CRASH.dispatch();

                    }
                }

            });


        }   


    }


    //Wird aufgerufen, wenn System der Engine hinzugefügt wird
    public override function addToEngine(engine: Engine):Void {
        vehicleNodes = engine.getNodeList(VehicleNode);
    }

    //Wird aufgerufen, wenn System von der Engine entfernt wird
    public override function removeFromEngine(engine: Engine):Void {
        vehicleNodes = null;
    }


}