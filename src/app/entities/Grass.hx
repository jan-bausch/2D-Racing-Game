package app.entities;

import ash.core.Entity;

import app.components.Position;
import app.components.Display;
import app.entities.sprites.GrassGroundSprite;


class Grass extends Entity {

	public function new(x: Float, y: Float, width: Float, height: Float) {
		super();

		this.add( new Position(x, y) );
		this.add( new Display(new GrassGroundSprite(width, height)) );

	}

}