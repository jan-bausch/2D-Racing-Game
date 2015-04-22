package app;


import openfl.display.Sprite;
import app.scenes.MainMenuScene;
import app.scenes.GameScene;

class Main extends Sprite {
	
	
	public function new () {		
		super();

		var StartScene: Sprite = new GameScene(this);
		this.addChild(StartScene);

			
	}
	
	
}