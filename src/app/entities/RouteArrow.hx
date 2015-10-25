package app.entities;

import openfl.Assets;

import ash.core.Entity;
import app.components.Position;
import app.components.Display;
import app.math.Vector2;
import app.entities.sprites.ArrowSprite;

enum TurnRadius {
    Small;
    Medium;
    Fullturn;
}

enum Direction {
    Right;
    Left;
}

class RouteArrow extends Entity {

    public function new(position: Vector2, rotation: Float, turnRadius: TurnRadius, direction: Direction) {
        super();

        this.add( new Position(position, rotation) );
        this.add( new Display(new ArrowSprite(turnRadius, direction)) );


    }

}