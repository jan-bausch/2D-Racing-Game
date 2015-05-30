package app.scenes;

import openfl.display.Sprite;
import openfl.text.TextFormat;
import openfl.events.Event;
import openfl.events.MouseEvent;

import app.ui.Button;
import app.scenes.GameScene;

class MainMenuScene extends Sprite {

	//Haupt-Sprite des Spiels
	private var rootScene: Sprite;
	//Menü-Buttons
	private var startGameButton: Button;

	public function new(rootScene: Sprite) {
		super();
		
		this.rootScene = rootScene;
		intializeUI();
		
	}

	//Buttons intialisieren und hinzufügen
	private function intializeUI() : Void {

		startGameButton = new Button("Start game", new TextFormat("Katamotz Ikasi", 30, 0x7A0026));
		startGameButton.x = 0;
		startGameButton.y = 0;
		addChild(this.startGameButton);

		//Funktion des StartButtons festelegen
		startGameButton.addEventListener(MouseEvent.CLICK, function(event: Event) {
			//Wenn Button gedrückt, soll Spiel gestartet werden
			this.setScene(new GameScene(this.rootScene)); 
		});

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