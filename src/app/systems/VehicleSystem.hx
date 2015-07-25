package app.systems;

import ash.core.System;
import ash.core.NodeList;
import ash.core.Engine;
import app.math.Vector2;

import app.nodes.VehicleNode;
import app.components.Vehicle;
import app.components.Position;

class VehicleSystem extends System {

	private var vehicleNodes: NodeList<VehicleNode>;

    private var events: SystemEvents;

    public function new(events: SystemEvents) {
        super();

        this.events = events;
    }

	public override function update(elapsed: Float) : Void {

        for (vehicleNode in vehicleNodes) {

            var vehicle: Vehicle = vehicleNode.vehicle,
                position: Position = vehicleNode.position;


            //Aktuelle Positionen von Front- und Rückrad berechnen
            var frontWheel: Vector2 = position.vector + Vector2.fromPolar(position.rotation, vehicle.axisDistance/2);
            var backWheel: Vector2 = position.vector  + Vector2.fromPolar(position.rotation + 180, vehicle.axisDistance/2);

            //Front- und Rückrad bewegen
            frontWheel += Vector2.fromPolar(position.rotation + vehicle.steerAngle, vehicle.speed * elapsed);
            backWheel += Vector2.fromPolar(position.rotation, vehicle.speed * elapsed);

            //Neue Rotation des Autos ermitteln
            position.rotation = backWheel.angleTo(frontWheel);

            //Die neue Position des Autos ergibt sich aus Mittelpunkt zwischen Vorder- und Hinterrad
            position.vector = (frontWheel + backWheel) / 2;



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