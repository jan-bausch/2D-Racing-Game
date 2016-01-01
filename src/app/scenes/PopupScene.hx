package app.scenes;

import app.scenes.Scene;


import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.core.PopupManager;
import haxe.ui.toolkit.controls.popups.Popup;

class PopupScene extends Scene {

    private var popup: Popup;
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
        popup = PopupManager.instance.showCustom(view, title, { buttons: buttons, width: width },callback);

    }

    public override function close() : Void {
        PopupManager.instance.hidePopup(popup);
    }


}