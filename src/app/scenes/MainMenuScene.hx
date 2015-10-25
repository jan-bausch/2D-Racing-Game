package app.scenes;

import openfl.Lib;

import haxe.ui.toolkit.events.UIEvent;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.core.Toolkit;

import app.scenes.FullscreenScene;
import app.scenes.LevelMenuScene;
import app.scenes.AboutScene;
import app.scenes.OptionsScene;

class MainMenuScene extends FullscreenScene {


    public function new() {
        super();
        
        //Layout laden
        view = Toolkit.processXmlResource("assets/ui/layout/main-menu.xml");


        //onClick-Events registrieren
        view.findChild("start", Button, true).onClick = function(e:UIEvent){    new LevelMenuScene().show();    };
        view.findChild("options", Button, true).onClick = function(e:UIEvent){  new OptionsScene().show();  };
        view.findChild("about", Button, true).onClick = function(e:UIEvent){    new AboutScene().show();    };
        view.findChild("quit", Button, true).onClick = function(e:UIEvent){ Lib.exit(); };

    }

}