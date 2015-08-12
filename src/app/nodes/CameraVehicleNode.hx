package app.nodes;

import ash.core.Node;
import app.components.Vehicle;
import app.components.Camera;
import app.components.Input;

class CameraVehicleNode extends Node<CameraVehicleNode> {

    public var vehicle: Vehicle;
    public var camera: Camera;
    public var input: Input;

}