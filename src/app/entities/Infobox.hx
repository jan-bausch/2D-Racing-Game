package app.entities;

import ash.core.Entity;
import openfl.Assets;
import openfl.display.BitmapData;

import app.components.Position;
import app.components.UI;
import app.math.Vector2;
import app.components.Collision;
import app.entities.sprites.StretchedImageSprite;

import haxe.ui.toolkit.core.interfaces.IDisplayObjectContainer;

/*
    Wenn der Spieler diese Fläche berührt, wird eine Infobox angezeigt.
*/
class Infobox extends Entity {

    public function new(position: Vector2, scale: Vector2, rotation: Float, view: IDisplayObjectContainer) {
        super();

        var width = 100 * scale.x,
            height = 100 * scale.y;

        this.add( new Position(position, rotation) );
        this.add( new Collision(width, height, false) );
        this.add( new UI(view) );


    }

}