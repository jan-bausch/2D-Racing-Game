package app.entities.sprites;

import openfl.display.Sprite;

class VehicleSprite extends Sprite {

	public function new() {
		super();

		this.graphics.beginFill(0xFF0000);
		this.graphics.drawCircle (0, 0, 50);
	}

}