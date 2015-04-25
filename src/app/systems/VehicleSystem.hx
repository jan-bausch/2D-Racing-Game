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

            //Die Mathematik-Funktionen von Haxe rechnen mit Bogenmaß/Radianz, also muss ich die Werte erstmal umrechnen
            var rRotation: Float = (Position.Rotation),
                rSteerAngle: Float = Vehicle.SteerAngle;

            //Aktuelle Positionen von Front- und Rückrad berechnen
            var FrontWheel: Vector2 = Position.Vector - Vehicle.AxisDistance/2 * new Vector2(Math.sin(-rRotation) , Math.cos(-rRotation));
            var BackWheel: Vector2 = Position.Vector + Vehicle.AxisDistance/2 * new Vector2(Math.sin(-rRotation) , Math.cos(-rRotation));

            //Front- und Rückrad bewegen
            FrontWheel -= Vehicle.Speed * elapsed * new Vector2(Math.sin(-rSteerAngle - rRotation) , Math.cos(-rSteerAngle - rRotation));
            BackWheel -= Vehicle.Speed * elapsed * new Vector2(Math.sin(-rRotation), Math.cos(-rRotation));


            //Neue Rotation des Autos ermitteln
            Position.Rotation = -Math.atan2( BackWheel.x - FrontWheel.x , BackWheel.y - FrontWheel.y );

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