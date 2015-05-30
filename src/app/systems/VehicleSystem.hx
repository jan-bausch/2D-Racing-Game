package app.systems;

import ash.core.System;
import ash.core.NodeList;
import ash.core.Engine;
import hxmath.math.Vector2;

import app.nodes.VehicleNode;
import app.components.Vehicle;
import app.components.Position;

class VehicleSystem extends System {

	private var vehicleNodes: NodeList<VehicleNode>;

	public function new() {
		super();
    }

	public override function update(elapsed: Float) : Void {

        for (vehicleNode in vehicleNodes) {

            var vehicle: Vehicle = vehicleNode.vehicle,
                position: Position = vehicleNode.position;


            //Aktuelle Positionen von Front- und Rückrad berechnen
            var frontWheel: Vector2 = position.vector + vehicle.axisDistance/2 * new Vector2(Math.sin( -position.rotation) , Math.cos( -position.rotation));
            var backWheel: Vector2 = position.vector - vehicle.axisDistance/2 * new Vector2(Math.sin( -position.rotation) , Math.cos( -position.rotation));

            //Front- und Rückrad bewegen
            frontWheel += vehicle.speed * elapsed * new Vector2(Math.sin( -position.rotation - vehicle.steerAngle) , Math.cos( -position.rotation - vehicle.steerAngle));
            backWheel += vehicle.speed * elapsed * new Vector2(Math.sin( -position.rotation), Math.cos( -position.rotation));

            //Neue Rotation des Autos ermitteln
            position.rotation = -Math.atan2( frontWheel.x - backWheel.x , frontWheel.y - backWheel.y );

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