package app.systems;

import ash.core.System;
import ash.core.NodeList;
import ash.core.Engine;
import hxmath.math.Vector2;

import app.nodes.VehicleNode;
import app.components.Vehicle;
import app.components.Position;

class VehicleSystem extends System {

	private var VehicleNodes: NodeList<VehicleNode>;

	public function new() {
		super();
    }

	public override function update(elapsed: Float) : Void {

        for (VehicleNode in this.VehicleNodes) {
            var Vehicle: Vehicle = VehicleNode.Vehicle,
                Position: Position = VehicleNode.Position;


            //Aktuelle Positionen von Front- und Rückrad berechnen
            var FrontWheel: Vector2 = Position.Vector + Vehicle.AxisDistance/2 * new Vector2(Math.sin( -Position.Rotation) , Math.cos( -Position.Rotation));
            var BackWheel: Vector2 = Position.Vector - Vehicle.AxisDistance/2 * new Vector2(Math.sin( -Position.Rotation) , Math.cos( -Position.Rotation));

            //Front- und Rückrad bewegen
            FrontWheel += Vehicle.Speed * elapsed * new Vector2(Math.sin( -Position.Rotation - Vehicle.SteerAngle) , Math.cos( -Position.Rotation - Vehicle.SteerAngle));
            BackWheel += Vehicle.Speed * elapsed * new Vector2(Math.sin( -Position.Rotation), Math.cos( -Position.Rotation));

            //Neue Rotation des Autos ermitteln
            Position.Rotation = -Math.atan2( FrontWheel.x - BackWheel.x , FrontWheel.y - BackWheel.y );

            //Zuletzt Auto positionieren
            Position.Vector = (FrontWheel + BackWheel) / 2;


        }   


	}


	//Wird aufgerufen, wenn System der Engine hinzugefügt wird
	public override function addToEngine(Engine:Engine):Void {
        this.VehicleNodes = Engine.getNodeList(VehicleNode);
   	}

   	//Wird aufgerufen, wenn System von der Engine entfernt wird
    public override function removeFromEngine(Engine:Engine):Void {
        this.VehicleNodes = null;

    }


}