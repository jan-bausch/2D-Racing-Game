package app.scenes;

import app.scenes.Scene;


import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.core.PopupManager;

class PopupScene extends Scene {

    private var title: String;
    private var buttons: Array<Dynamic>;
    private var width: Float;
    private var callback: Dynamic->Void;

    public function new() {
        super();
        
        this.title = "";
        this.buttons = [PopupButton.OK];
        this.width = 300;
        this.callback = function(btn: Dynamic) {};

    }

    public override function show() : Void {

        //Popup-Fenster mit Einstellungen anzeigen
        PopupManager.instance.showCustom(view, title, { buttons: buttons, width: width },callback);

    }

}