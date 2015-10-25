package app.scenes;

import app.scenes.Scene;


import haxe.ui.toolkit.core.interfaces.IDisplayObject;
import haxe.ui.toolkit.core.interfaces.IDisplayObjectContainer;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.RootManager;
import haxe.ui.toolkit.core.Toolkit;

class FullscreenScene extends Scene {

    public function new() {
        super();

        view = Toolkit.processXmlResource("assets/ui/layout/main-menu.xml");

    }

    public override function show() : Void {

        //Alte Scenen entfernen
        RootManager.instance.destroyAllRoots();
    
        //Anzeigen
        Toolkit.openFullscreen(function(root:Root) {
            this.root = root;
            root.addChild(view);
        });

    }

}