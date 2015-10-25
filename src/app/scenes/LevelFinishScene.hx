package app.scenes;

import haxe.ui.toolkit.core.interfaces.IDisplayObjectContainer;
import haxe.ui.toolkit.core.PopupManager;
import haxe.ui.toolkit.core.RootManager;
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.controls.Text;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.Image;
import haxe.ui.toolkit.events.UIEvent;

import app.scenes.WindowScene;
import app.scenes.LevelOpeningScene;
import app.systems.SystemEvents;
import app.entities.Level;

class LevelFinishScene extends WindowScene {

<<<<<<< HEAD
    private var events: SystemEvents;

    public function new(level: Level, result: Result) {
=======
        private var events: SystemEvents;

        public function new(level: Level, result: Result) {
        
                //Grundeinstellungen festlegen
                width = 400;
                height = 300;
                super();
>>>>>>> e5d474a9cf18fe6217cbbd46425eb61bae5b0b88

        //Grundeinstellungen festlegen
        width = 400;
        height = 300;
        super();

<<<<<<< HEAD
=======
                //Layout laden
                view = Toolkit.processXmlResource("assets/ui/layout/level-finish.xml");
>>>>>>> e5d474a9cf18fe6217cbbd46425eb61bae5b0b88

        //Layout laden
        view = Toolkit.processXmlResource("assets/ui/layout/level-finish.xml");

            //Ergebniss anzeigen
        switch (result) {
<<<<<<< HEAD
            case Result.Fail:
                view.findChild("result", Text, true).text = "Fehlgeschlagen!";
                view.findChild("icon", Image, true).resource = "assets/ui/result_fail.png";
            case Result.Bronze:
                view.findChild("result", Text, true).text = "Geschafft!";
                view.findChild("icon", Image, true).resource = "assets/ui/result_bronze.png";
            case Result.Silver:
                view.findChild("result", Text, true).text = "Gute Zeit!";
                view.findChild("icon", Image, true).resource = "assets/ui/result_silver.png";
            case Result.Gold:
                view.findChild("result", Text, true).text = "Herausragend!";
                view.findChild("icon", Image, true).resource = "assets/ui/result_gold.png";
=======
                case Result.Fail:
                        view.findChild("result", Text, true).text = "Fehlgeschlagen!";
                        view.findChild("icon", Image, true).resource = "assets/ui/result_fail.png";
                case Result.Bronze:
                        view.findChild("result", Text, true).text = "Geschafft!";
                        view.findChild("icon", Image, true).resource = "assets/ui/result_bronze.png";
                case Result.Silver:
                        view.findChild("result", Text, true).text = "Gute Zeit!";
                        view.findChild("icon", Image, true).resource = "assets/ui/result_silver.png";
                case Result.Gold:
                        view.findChild("result", Text, true).text = "Herausragend!";
                        view.findChild("icon", Image, true).resource = "assets/ui/result_gold.png";
>>>>>>> e5d474a9cf18fe6217cbbd46425eb61bae5b0b88

        }

        //"Weiter"-Button sperren, wenn Level nicht geschafft wurde
        view.findChild("continue", Button, true).disabled = (result == Result.Fail);



        //Buttonevents festlegen
        view.findChild("restart", Button, true).onClick = function(e:UIEvent){   new GameScene(level.id).show();    };
        view.findChild("continue", Button, true).onClick = function(e:UIEvent){    new app.scenes.LevelMenuScene().show();    };

<<<<<<< HEAD
    }
=======
        }
>>>>>>> e5d474a9cf18fe6217cbbd46425eb61bae5b0b88

}