package app.nodes;

import ash.core.Node;
import app.components.Vehicle;
import app.components.Camera;

class CameraVehicleNode extends Node<CameraVehicleNode> {

    public var vehicle: Vehicle;
    public var camera: Camera;

}