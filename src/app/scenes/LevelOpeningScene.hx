package app.scenes;

import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.controls.Text;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.events.UIEvent;

import app.scenes.WindowScene;
import app.systems.SystemEvents;
import app.Configuration;
import app.entities.Level;

class LevelOpeningScene extends WindowScene {

	private var events: SystemEvents;

	public function new(level: Level, callback: Void->Void) {
	
		//Grundeinstellungen festlegen
		width = 400;
		height = 300;
		var configuration: Configuration = new Configuration();
		super();


		//Layout laden
		view = Toolkit.processXmlResource("assets/ui/layout/level-opening.xml");

        //Levelinformationen in UI schreiben
        view.findChild("level-id", Text, true).text = (level.id + 1) + "";
        view.findChild("level-name", Text, true).text = level.name;
        view.findChild("level-description", Text, true).text = level.description;
        view.findChild("personal-time", Text, true).text = (configuration.HIGHSCORES[level.id] != 0) ? (configuration.HIGHSCORES[level.id] / 1000) + " Sekunden" : "-" ;
        view.findChild("level-time", Text, true).text = (level.time / 1000) + " Sekunden";

        //Buttonevents festlegen
        view.findChild("start", Button, true).onClick = function(e:UIEvent){    close(); callback();    };
        view.findChild("abort", Button, true).onClick = function(e:UIEvent){	new app.scenes.MainMenuScene().show();     };

	}

}