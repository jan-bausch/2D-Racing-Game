package app.scenes;

import openfl.display.Sprite;
import openfl.text.TextFormat;
import app.ui.Button;
class GameScene extends Sprite {

	//Haupt-Sprite des Spiels
	private var RootScene: Sprite;
	//Menü-Buttons
	private var StartGameButton: Button;

	public function new(RootScene: Sprite) {
		super();
		this.RootScene = RootScene;


		//Buttons hinzufügen
		this.StartGameButton = new Button("Ingame", new TextFormat("Katamotz Ikasi", 30, 0x7A0026));
		this.StartGameButton.x = 0;
		this.StartGameButton.y = 0;
		this.addChild(this.StartGameButton);

	}

}