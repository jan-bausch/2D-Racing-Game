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
import haxe.ui.toolkit.controls.CheckBox;
import haxe.ui.toolkit.controls.OptionBox;
import haxe.ui.toolkit.core.PopupManager;

import app.scenes.GameScene;
import app.Configuration;

class MainMenuScene extends Sprite {

	//Haupt-Sprite des Spiels
	private var rootScene: Sprite;
	private var configuration: Configuration;

	public function new(rootScene: Sprite) {
		super();
		
		this.rootScene = rootScene;
		this.configuration = new Configuration();

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

		//Layout laden
		var view:IDisplayObjectContainer = Toolkit.processXmlResource("res/ui/layout/options.xml");
		//Konfigurationseinstellungen auf UI anzeigen
		view = loadOptions(view);

		//Popup-Fenster mit Einstellungen anzeigen
		PopupManager.instance.showCustom(view, "Einstellungen", 
			{ buttons: [PopupButton.OK, PopupButton.CANCEL], width: 500 },
			function(btn:Dynamic) {
				//Konfiguration speichern, wenn OK-Button gedrückt wurde
				if (btn == PopupButton.OK) saveOptions(view);
			});


	}

	private function showAboutScreen() : Void {

		var view:IDisplayObject = Toolkit.processXmlResource("res/ui/layout/about.xml");
		PopupManager.instance.showCustom(view, "Über", { buttons: [PopupButton.OK], width: 500 });


	}


	//Einstellungen aus der Konfigurationsdatei auslesen und im Optionsmenu anzeigen
	private function loadOptions(view: IDisplayObjectContainer) : IDisplayObjectContainer {
		

		view.findChild("fullscreen", OptionBox, true).selected = configuration.FULLSCREEN;
		view.findChild("keyboard", OptionBox, true).selected = configuration.INPUT_KEYBOARD;
		view.findChild("collision", CheckBox, true).selected = configuration.SHOW_COLLISION;

		return view;
	}

	//Getätigte Einstellungen aus dem Optionsmenü auslesen und in die Konfigurationsdatei schreiben
	private function saveOptions(view: IDisplayObjectContainer) : Void {


		configuration.FULLSCREEN = view.findChild("fullscreen", OptionBox, true).selected;
		configuration.INPUT_KEYBOARD = view.findChild("keyboard", OptionBox, true).selected;
		configuration.SHOW_COLLISION = view.findChild("collision", CheckBox, true).selected;

		configuration.save();



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