package app;


import openfl.display.Sprite;

import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.core.Macros;

import app.scenes.MainMenuScene;
import app.scenes.GameScene;

import haxe.ui.toolkit.core.PopupManager;

class Main extends Sprite {
	
	
	public function new () {		
		super();

		//HaxeUI-Bibliothek initialisieren
		Toolkit.theme = new  haxe.ui.toolkit.themes.GradientTheme();
        Toolkit.init();
        Macros.addStyleSheet("assets/ui/layout/style.css"); //Stylesheet laden
        

		//Startmenü anzeigen
		new MainMenuScene().show();

	}
	
	
}