package app.scenes;

import openfl.Lib;

import haxe.ui.toolkit.events.UIEvent;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.core.Toolkit;

import app.scenes.FullscreenScene;
import app.scenes.LevelMenuScene;
import app.scenes.AboutScene;
import app.scenes.OptionsScene;

/*
    Zeigt dem Spieler einen Pokal, wenn er alle Level bestanden hat.
*/
class GameBeatenScene extends FullscreenScene {


    public function new() {
        super();
        
        //Layout laden
        view = Toolkit.processXmlResource("assets/ui/layout/game-beaten.xml");


        //onClick-Events registrieren
        view.findChild("main-menu", Button, true).onClick = function(e:UIEvent){    new MainMenuScene().show();    };
    }

}