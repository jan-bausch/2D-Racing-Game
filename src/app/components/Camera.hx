package app.components;


//Camera fokussiert dieses Entity
class Camera {

	public var zoom: Float;
	public var blur: Float;
	public var rotation: Float;

	public function new(zoom: Float = 1) {
		this.zoom = zoom;
		this.blur = 0;
		this.rotation = 0;
	}

}