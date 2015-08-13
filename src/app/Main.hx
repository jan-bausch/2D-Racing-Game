package app;


import openfl.display.Sprite;

import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.core.Macros;

import app.scenes.MainMenuScene;
import app.scenes.GameScene;

class Main extends Sprite {
	
	
	public function new () {		
		super();

		//HaxeUI-Bibliothek initialisieren
		Toolkit.theme = new  haxe.ui.toolkit.themes.GradientTheme();
        Toolkit.init();
        Macros.addStyleSheet("res/ui/layout/style.css"); //Stylesheet laden
        
		//Startmenü anzeigen
		var startScene: Sprite = new MainMenuScene(this);
		addChild(startScene);

	}
	
	
}