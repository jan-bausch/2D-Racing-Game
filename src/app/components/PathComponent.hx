package app.components;

import app.math.Vector2;
import ash.core.Entity;


class PathComponent {

    public var start: Vector2;
    public var end : Vector2;
    public var target: Entity;
    
    public function new(target: Entity, start: Vector2, end: Vector2) {
        this.target = target;
        this.start = start;
        this.end = end;
    }

}