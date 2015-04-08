package app.scenes;

import openfl.display.Sprite;
import openfl.text.TextFormat;
import openfl.events.Event;
import openfl.events.MouseEvent;

import app.ui.Button;
import app.scenes.GameScene;

class MainMenuScene extends Sprite {

	//Haupt-Sprite des Spiels
	private var RootScene: Sprite;
	//Menü-Buttons
	private var StartGameButton: Button;

	public function new(RootScene: Sprite) {
		super();
		this.RootScene = RootScene;

		this.intializeUI();
		
	}

	//Buttons intialisieren und hinzufügen
	private function intializeUI() : Void {

		this.StartGameButton = new Button("Start game", new TextFormat("Katamotz Ikasi", 30, 0x7A0026));
		this.StartGameButton.x = 0;
		this.StartGameButton.y = 0;
		this.addChild(this.StartGameButton);
		//Funktion des StartButtons festelegen
		this.StartGameButton.addEventListener(MouseEvent.CLICK, function(event: Event) { 
			this.setScene(new GameScene(this.RootScene)); 
		});

	}


	//Eine Szene als neuer Hauptsprite setzen.
	private function setScene(NewScene: Sprite) : Void {

		//Alle Kinder des Hauptsprites löschen
		while (this.RootScene.numChildren > 0) {
		    this.RootScene.removeChildAt(0);
		}

		//Neue Szene hinzufügen
		this.RootScene.addChild(NewScene);

	}

}