package app.components;


//Camera fokussiert dieses Entity
class Camera {

	public var zoom: Float;
	public var blur: Float;

	public function new(zoom: Float = 1, blur: Float = 0) {
		this.zoom = zoom;
		this.blur = blur;
	}

}