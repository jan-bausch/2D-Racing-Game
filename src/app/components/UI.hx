package app.components;

import haxe.ui.toolkit.core.interfaces.IDisplayObjectContainer;

//UI element von Infobox
class UI {

    public var view: IDisplayObjectContainer;

    public function new(view: IDisplayObjectContainer) {
        
        this.view = view;
    }

}