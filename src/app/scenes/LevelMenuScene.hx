package app.scenes;

import openfl.Lib;
import openfl.display.Sprite;
import openfl.text.TextFormat;
import openfl.text.TextField;
import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.Assets;
import openfl.display.Bitmap;
import openfl.display.SimpleButton;

import app.scenes.GameScene;
import app.ui.LevelButton;

class LevelMenuScene extends Sprite {

	//Haupt-Sprite des Spiels
	private var rootScene: Sprite;
	//UI-Elemente
	private var startButton: SimpleButton;
	private var settingsButton: SimpleButton;
	private var background: Bitmap;
	private var car: Bitmap;
	private var heading: TextField;

	public function new(rootScene: Sprite) {
		super();
		
		this.rootScene = rootScene;
		intializeUI();

		//Wenn sich die Fenstergröße ändert, soll die Funktion "layout()" aufgerufen werden
		Lib.current.stage.addEventListener(Event.RESIZE, layout);
		//Um Elemente beim Start anzuordnen, wird die Funktion einmal manuell aufgerufen
		layout(new Event("RESIZE"));

	}


	private function intializeUI() : Void {



		background = new Bitmap(Assets.getBitmapData("res/ui/background.png"));


		//Überschrift
		heading = new TextField();
		heading.embedFonts = true;
		heading.width = 1000;
		heading.text = "Wähle ein Level:";

		addChild(background);
		addChild(heading);

		var LevelButton: LevelButton = new LevelButton(1);
		LevelButton.x = 100;
		LevelButton.y = 100;

		addChild(LevelButton);


		LevelButton.width = 100;
	}

	private function layout(event: Event) : Void {
		

		//Hintergrundgröße
		background.width = Lib.current.stage.stageWidth;
		background.height = Lib.current.stage.stageHeight;

		//Überschrift positionieren
		heading.x = Lib.current.stage.stageWidth / 15;
		heading.y = Lib.current.stage.stageHeight / 20;
		heading.setTextFormat(new TextFormat ("Katamotz Ikasi", Lib.current.stage.stageHeight / 15, 0x7A0026));


	}

	//Eine Szene als neuer Hauptsprite setzen.
	private function setScene(newScene: Sprite) : Void {

		//Alle Kinder des Hauptsprites löschen
		while (rootScene.numChildren > 0) {
		    rootScene.removeChildAt(0);
		}

		//Neue Szene hinzufügen
		rootScene.addChild(newScene);

	}

}