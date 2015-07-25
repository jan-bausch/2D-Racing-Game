package app.scenes;

import openfl.Lib;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.display.BitmapData;
import openfl.Assets;
import openfl.events.Event;


//Ressourcen vorladen
@:bitmap("res/ui/loading.png") class LoadingCircle extends BitmapData {}

class Preloader extends NMEPreloader {

	public var loadingCircle: Sprite;
	public var orginalBackgroundColor: UInt;

	public function new() {
		super();

		//Alte Hintergrundfarbe speichern und neue setzen
		orginalBackgroundColor = Lib.current.stage.color;
		Lib.current.stage.color = 0x333333;


		//Ladekreis laden
		loadingCircle = new Sprite();
		var bitmap: Bitmap = new Bitmap(new LoadingCircle(0,0));
		bitmap.x = -(bitmap.width / 2);
		bitmap.y = -(bitmap.height / 2);

		loadingCircle.addChild(bitmap);

		//Events registrieren
		addEventListener(Event.ENTER_FRAME, onEnterFrame); //Events registrieren
		addEventListener(Event.RESIZE, onResize);
		onResize(new Event("RESIZE"));

	}

	public function onEnterFrame(event: Event) : Void {

	}

	public function onResize(event: Event) : Void {

		//Ladekreis zentrieren


	}

	public function onComplete(event: Event) : Void {
		Lib.current.stage.color = orginalBackgroundColor;
	}

}