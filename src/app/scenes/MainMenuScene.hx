package app.scenes;

import openfl.display.Sprite;
import openfl.display.DisplayObjectContainer;

import haxe.ui.toolkit.core.interfaces.IDisplayObject;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.RootManager;
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.events.UIEvent;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.core.PopupManager;

import app.scenes.GameScene;

class MainMenuScene extends Sprite {

	//Haupt-Sprite des Spiels
	private var rootScene: Sprite;

	public function new(rootScene: Sprite) {
		super();
		
		this.rootScene = rootScene;

		//Hauptmenü-UI laden und anzeigen
		Toolkit.openFullscreen(function(root:Root) {
			var view: IDisplayObject = Toolkit.processXmlResource("res/ui/layout/main-menu.xml");
			root.addChild(view);

			//onClick-Events registrieren
			root.findChild("start", Button, true).onClick = function(e:UIEvent){	setScene(new GameScene(this.rootScene));	};
			root.findChild("options", Button, true).onClick = function(e:UIEvent){	showOptionsScreen();	};
			root.findChild("about", Button, true).onClick = function(e:UIEvent){	showAboutScreen();	};

		});

        //setScene(new GameScene(this.rootScene)); 

	}


	private function showOptionsScreen() : Void {

	}

	private function showAboutScreen() : Void {

		var view:IDisplayObject = Toolkit.processXmlResource("res/ui/layout/about.xml");
		PopupManager.instance.showCustom(view, "Über", { buttons: [PopupButton.OK], width: 500 });


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