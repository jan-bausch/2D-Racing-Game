package app.components;

import app.math.Vector2;
import ash.core.Entity;

/*
    Pfad-Komponente:
    In der Pfad-Komponente wird die Animation definiert, mit der sich
    die "Ziel"-Enität bewegt. Die Animation pendelt durchgehend zwischen
    Start- und Endpunkt.
*/
class PathComponent {

    public var start: Vector2; //Startpunkt
    public var end : Vector2; //Endpunkt
    public var target: Entity; //Referenz auf Enität, die animiert werden soll.
    
    public function new(target: Entity, start: Vector2, end: Vector2) {
        this.target = target;
        this.start = start;
        this.end = end;
    }

}