package app.scenes;

import haxe.ui.toolkit.core.interfaces.IDisplayObjectContainer;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.RootManager;

class Scene {

	public var view: IDisplayObjectContainer;
	public var root: Root;

	public function new() {



		//Auf 100% der Bildschirmgröße setzen
		// percentWidth = 1;
		// percentHeight = 1;
	}

	public function show() : Void {

	}

	public function close() : Void {
		RootManager.instance.destroyRoot(root);
	}

}