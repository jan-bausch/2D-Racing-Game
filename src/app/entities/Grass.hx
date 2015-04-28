package app.entities;

import ash.core.Entity;

import app.components.Position;
import app.components.Display;
import app.entities.sprites.GrassGroundSprite;


class Grass extends Entity {

	public function new(X: Float, Y: Float, Width: Float, Height: Float) {
		super();

		this.add( new Position(X, Y) );
		this.add( new Display(new GrassGroundSprite(Width, Height)) );

	}

}