package app.scenes;

import haxe.ui.toolkit.core.interfaces.IDisplayObjectContainer;
import haxe.ui.toolkit.core.PopupManager;
import haxe.ui.toolkit.controls.CheckBox;
import haxe.ui.toolkit.controls.OptionBox;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.events.UIEvent;
import haxe.ui.toolkit.core.Toolkit;

import app.scenes.PopupScene;
import app.Configuration;

class AboutScene extends PopupScene {

    public function new() {
        super();

        //Grundeinstellungen festlegen
        title = "Über";
        width = 500;
        buttons = [PopupButton.OK];

        //Layout laden
        view = Toolkit.processXmlResource("assets/ui/layout/about.xml");

        
        //Wenn "Zurücksetzen"-Button gedrückt wird, Daten löschen.
        view.findChild("reset", Button).onClick = function (e:UIEvent) {
            new Configuration().clear();
        }
        
    }

}