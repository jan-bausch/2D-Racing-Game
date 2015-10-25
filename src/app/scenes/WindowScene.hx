package app.scenes;

import app.scenes.Scene;

import openfl.Lib;

import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.core.PopupManager;

class WindowScene extends Scene {

    private var x: Null<Float>;
    private var y: Null<Float>;
    private var width: Null<Float>;
    private var height: Null<Float>;

    public function new() {
        super();
            
        if (width == null) width = 400;
        if (height == null) height = 300;
        if (x == null) x = (Lib.current.stage.stageWidth-width)/2;
        if (y == null) y = (Lib.current.stage.stageHeight-height)/2;

    }

    public override function show() : Void {

        //Popup-Fenster mit Einstellungen anzeigen
        Toolkit.openPopup( { x:x, y:y, width:width, height:height }, function(root:Root) {
            this.root = root;
            root.addChild(view);
        });

    }


}