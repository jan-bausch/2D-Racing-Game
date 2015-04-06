package app.scenes;

import openfl.display.Sprite;
import openfl.text.TextFormat;

import app.ui.Button;

class MainMenuScene extends Sprite {

	//Haupt-Sprite des Spiels
	private var GameScene: Sprite;
	//Menü-Buttons
	private var StartGameButton: Button;

	public function new(GameScene: Sprite) {
		super();
		this.GameScene = GameScene;

		//Buttons hinzufügen
		this.StartGameButton = new Button("Start game", new TextFormat("Katamotz Ikasi", 30, 0x7A0026));
		this.StartGameButton.x = 0;
		this.StartGameButton.y = 0;
		this.addChild(this.StartGameButton);

	}

}