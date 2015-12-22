package app.scenes;

import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.events.UIEvent;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.containers.Grid;

import app.scenes.GameScene;
import app.scenes.FullscreenScene;
import app.Configuration;

class LevelMenuScene extends FullscreenScene {


    public function new() {
        super();

        //UI laden und anzeigen
        view = Toolkit.processXmlResource("assets/ui/layout/level-menu.xml");

        var configuration: Configuration = new Configuration();
        var container: Grid = view.findChild("level-container", Grid, true);

        //Buttons für jedes Level dynamisch hinzufügen
        for (i in 0...configuration.TOTALLEVELS) {
            var button: Button = new Button();
            button.text = i+1 + ".";
            button.autoSize = false;
            button.styleName = "level-button";
            button.disabled = i > configuration.LEVEL;
            button.onClick = function(e:UIEvent){ new GameScene(i).show(); };
            container.addChild(button); 
        }

    }

}