package app;


import openfl.display.Sprite;
import app.scenes.MainMenuScene;
import app.scenes.GameScene;

class Main extends Sprite {
	
	
	public function new () {		
		super();

		var startScene: Sprite = new GameScene(this);
		addChild(startScene);

			
	}
	
	
}