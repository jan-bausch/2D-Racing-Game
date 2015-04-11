package app;


import openfl.display.Sprite;
import app.scenes.MainMenuScene;

class Main extends Sprite {
	
	
	public function new () {		
		super ();

		var StartScene: Sprite = new MainMenuScene(this);
		this.addChild(StartScene);

			
	}
	
	
}