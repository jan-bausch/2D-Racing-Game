package app.components;

import app.math.Vector2;

/*
    Kamera-Komponente:
    Das Entitiy, das diese Komponente trägt, wird von der Kamera in den Mittelgrund gestellt bzw. fokussiert.
    Um die Kamera dynamischer wirken zu lassen, kann man zwei Dinge einstellen:
    Erstens muss die Kamera nicht immer genau die Position der Entität fokussieren, sondern kann z.B. etwas
    vor der Entität positioniert sein.
    Zweitens kann die Kamera eine gewisse Trägheit besitzen, mit der sie sich dem angepeiltem Fokuspunkt nähert.
*/
class Camera {

    public var zoom: Float;
    public var blur: Float;

    public var target: Vector2; //Angepeilter Fokuspunkt
    public var focus: Vector2;  //Aktueller Fokuspunkt
    public var inertia: Float; //Geschwindigkeit, mit der sich der aktuelle Fokuspunkt dem angepeiltem Fokuspunkt nähert

    public function new(zoom: Float = 1, blur: Float = 0, inertia: Float = 0) {
        this.zoom = zoom;
        this.blur = blur;
        this.inertia = inertia;

        target = new Vector2(0,0);
        focus = new Vector2(0,0);

    }

}