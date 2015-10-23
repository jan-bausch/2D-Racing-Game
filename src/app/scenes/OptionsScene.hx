package app.scenes;

import haxe.ui.toolkit.core.interfaces.IDisplayObjectContainer;
import haxe.ui.toolkit.core.PopupManager;
import haxe.ui.toolkit.controls.CheckBox;
import haxe.ui.toolkit.controls.OptionBox;
import haxe.ui.toolkit.controls.HSlider;
import haxe.ui.toolkit.core.Toolkit;

import app.scenes.PopupScene;
import app.Configuration;

class OptionsScene extends PopupScene {

	private var configuration: Configuration;

	public function new() {
		super();

		//Grundeinstellungen festlegen
		title = "Einstellungen";
		width = 500;
		buttons = [PopupButton.OK, PopupButton.CANCEL];
		configuration = new Configuration();


		//Layout laden und Werte festlegen
		view = loadOptions(Toolkit.processXmlResource("assets/ui/layout/options.xml"));

		//Aktionen festlegen, falls OK-Button gedrückt wurde
		callback = function(btn:Dynamic) {
			if (btn == PopupButton.OK) saveOptions(view); //Konfiguration speichern
		};


	}


	//Einstellungen aus der Konfigurationsdatei auslesen und im Optionsmenu anzeigen
	private function loadOptions(view: IDisplayObjectContainer) : IDisplayObjectContainer {
		

		view.findChild("fullscreen", OptionBox, true).selected = configuration.FULLSCREEN;
		view.findChild("keyboard", OptionBox, true).selected = configuration.INPUT_KEYBOARD;
		view.findChild("debug", CheckBox, true).selected = configuration.DEBUG;
		view.findChild("volume", HSlider, true).pos = configuration.VOLUME * 100;

		return view;
	}

	//Getätigte Einstellungen aus dem Optionsmenü auslesen und in die Konfigurationsdatei schreiben
	private function saveOptions(view: IDisplayObjectContainer) : Void {


		configuration.FULLSCREEN = view.findChild("fullscreen", OptionBox, true).selected;
		configuration.INPUT_KEYBOARD = view.findChild("keyboard", OptionBox, true).selected;
		configuration.DEBUG = view.findChild("debug", CheckBox, true).selected;
		configuration.VOLUME = view.findChild("volume", HSlider, true).pos / 100;

		configuration.save();
	}

}