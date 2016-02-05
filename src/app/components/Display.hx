package app.components;

import openfl.display.Sprite;

/*
    Display-Komponente:
    Entitäten, die eine Textur besitzen, besitzen diese Komponente.
*/
class Display {

    public var sprite: Sprite; //Diese Grafik soll angezeigt werden.

    public function new(sprite: Sprite) {
        this.sprite = sprite;
    }

}