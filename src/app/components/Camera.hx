package app.components;

import app.math.Vector2;

//Camera fokussiert dieses Entity
class Camera {

    public var zoom: Float;
    public var blur: Float;

    public var target: Vector2; //Angepeilter Fokuspunkt
    public var focus: Vector2;  //Aktueller Fokuspunkt
    public var inertia: Float; //Geschwindigkeit, mit der sich der aktuelle Fokuspunkt dem tatsächlichen Fokuspunkt nähert

    public function new(zoom: Float = 1, blur: Float = 0, inertia: Float = 0) {
        this.zoom = zoom;
        this.blur = blur;
        this.inertia = inertia;

        target = new Vector2(0,0);
        focus = new Vector2(0,0);

    }

}