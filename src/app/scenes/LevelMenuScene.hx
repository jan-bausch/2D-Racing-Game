package app.scenes;

import openfl.display.Sprite;
import openfl.display.DisplayObjectContainer;

import haxe.ui.toolkit.core.interfaces.IDisplayObject;
import haxe.ui.toolkit.core.interfaces.IDisplayObjectContainer;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.RootManager;
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.events.UIEvent;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.containers.Grid;
import haxe.ui.toolkit.core.PopupManager;

import app.scenes.GameScene;
import app.Configuration;

class LevelMenuScene extends Sprite {

	//Haupt-Sprite des Spiels
	private var rootScene: Sprite;
	private var configuration: Configuration;

	public function new(rootScene: Sprite) {
		super();
		
		this.rootScene = rootScene;
		this.configuration = new Configuration();

		//UI laden und anzeigen
		Toolkit.openFullscreen(function(root:Root) {
			var view: IDisplayObject = Toolkit.processXmlResource("res/ui/layout/level-menu.xml");
			root.addChild(view);

			var container: Grid = root.findChild("level-container", Grid, true);

			//Buttons für jedes Level dynamisch hinzufügen
			for (i in 0...10) {
				var button: Button = new Button();
				button.text = i+1 + ".";
				button.autoSize = false;
				button.styleName = "level-button";
				button.disabled = i >= configuration.HIGHSCORES.length;
				button.onClick = function(e:UIEvent){ setScene(new GameScene(rootScene, i)); };
				container.addChild(button); 
			}



		});

        //setScene(new GameScene(this.rootScene)); 

	}




	//Eine Szene als neuer Hauptsprite setzen.
	private function setScene(newScene: Sprite) : Void {

		//Alle Kinder des Hauptsprites löschen
		while (rootScene.numChildren > 0) {
		    rootScene.removeChildAt(0);
		}


		//UI entfernen
		RootManager.instance.destroyAllRoots();

		//Neue Szene hinzufügen
		rootScene.addChild(newScene);

	}

}