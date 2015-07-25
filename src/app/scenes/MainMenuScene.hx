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

class MainMenuScene extends Sprite {

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

		//Start- und Settingsbutton mit verschiedenen Zuständen (normal, Maus drüber, gedrückt) initialisieren
		startButton = new SimpleButton(	new Bitmap(Assets.getBitmapData("res/ui/play.png")) );
		settingsButton = new SimpleButton(	new Bitmap(Assets.getBitmapData("res/ui/settings.png")) );

		//Wenn startButton gedrückt ist, soll die Spielszene geladen werden.
		startButton.addEventListener(MouseEvent.CLICK, function(event: Event) {
			setScene(new GameScene(this.rootScene)); 
		});

		//Wenn settingsButton gedrückt ist, sollen die Einstellungen angezeigt werden.
		settingsButton.addEventListener(MouseEvent.CLICK, function(event: Event) {
			setScene(new GameScene(this.rootScene)); 
		});


		background = new Bitmap(Assets.getBitmapData("res/ui/background.png"));
		car = new Bitmap(Assets.getBitmapData("res/ui/car.png"));

		//Überschrift
		heading = new TextField();
		heading.embedFonts = true;
		heading.width = 1000;
		heading.text = "Hello World";

		addChild(background);
		addChild(car);
		addChild(heading);
		addChild(startButton);
		addChild(settingsButton);
	}

	private function layout(event: Event) : Void {
		

		//Hintergrundgröße
		background.width = Lib.current.stage.stageWidth;
		background.height = Lib.current.stage.stageHeight;

		//Auto seitlich rechts positionieren
		car.height = Lib.current.stage.stageHeight * 0.8;
		car.width = (2/3) * car.height;
		car.y = (Lib.current.stage.stageHeight - car.height) / 2;
		car.x = Lib.current.stage.stageWidth - car.width;

		//Größe von Start- und Settingsbutton auf 1/7 der Fenstergröße setzen
		startButton.width = startButton.height = settingsButton.width = settingsButton.height = Lib.current.stage.stageWidth / 7;

		//Buttons vertikal anordnern
		startButton.x = settingsButton.x = Lib.current.stage.stageWidth / 6;

		//Buttons horizontal anordnen
		startButton.y = Lib.current.stage.stageHeight / 3;
		settingsButton.y = Lib.current.stage.stageHeight / 1.5;

		//Überschrift positionieren
		heading.x = Lib.current.stage.stageWidth / 8;
		heading.y = Lib.current.stage.stageHeight / 20;
		//heading.setTextFormat(new TextFormat("Katamotz Ikasi", Lib.current.stage.stageHeight / 7, 0x7A0026));


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