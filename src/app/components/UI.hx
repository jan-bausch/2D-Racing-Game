package app.components;

import haxe.ui.toolkit.core.interfaces.IDisplayObjectContainer;

/*
    UI-Komponente:
    Einzig "Infobox"-Entitäten besitzen diese Komponente. In ihr das
    Benutzeroberflächen-Element gespeichert, die angeigt wird, wenn man sich
    in einer definierten Fläche befindet.
*/
class UI {

    public var view: IDisplayObjectContainer;

    public function new(view: IDisplayObjectContainer) {
        
        this.view = view;
    }

}