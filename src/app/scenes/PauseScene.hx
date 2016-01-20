package app.scenes;

import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.controls.Text;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.events.UIEvent;
import openfl.events.KeyboardEvent;
import openfl.ui.Keyboard;
import openfl.Lib;

import app.scenes.PopupScene;
import app.systems.SystemEvents;
import app.Configuration;
import app.entities.Level;
import app.math.Time;

class PauseScene extends PopupScene {

    private var events: SystemEvents;

    public function new(events: SystemEvents, level: Level) {

        super();

        //Grundeinstellungen festlegen
        width = 300;
        title = "Spiel pausiert";
        buttons = [];
        this.events = events;


        //Layout laden
        view = Toolkit.processXmlResource("assets/ui/layout/pause.xml");

        //Events für "Zurück zum Spiel" festlegen
        view.findChild("resume", Button, true).onClick = function(e:UIEvent){    resume();    };

        //Events für Hauptmenü und Neustart festlegen
        view.findChild("main-menu", Button, true).onClick = function(e:UIEvent){    events.GAME_QUIT.dispatch(); new app.scenes.MainMenuScene().show();     };
        view.findChild("restart", Button, true).onClick = function(e:UIEvent){   events.GAME_QUIT.dispatch(); new GameScene(level.id).show();    };


    }



    //Pause-Menü schließen und Gameloop wiederstarten
    private function resume() {
        events.GAME_UNPAUSE.dispatch();
        close(); 
    }

}