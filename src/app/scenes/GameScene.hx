package app.scenes;

import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.containers.SpriteContainer;

import app.scenes.FullscreenScene;
import app.scenes.MainMenuScene;
import app.systems.SystemEvents;
import app.Game;
import app.entities.Level;

class GameScene extends FullscreenScene {

	private var level: Int;
	public var systemEvents: SystemEvents; //Events, die zwischen Systemen ausgetauscht werden

	public function new(level: Int) {
		super();

		this.level = level;
		this.systemEvents = new SystemEvents();


		//Events registrieren
		systemEvents.SHOW_MAINMENU.add(function () { new MainMenuScene().show(); });

		//Layout laden
		view = Toolkit.processXmlResource("assets/ui/layout/game.xml");

		//GameSprite in der untersten Ebene hinzufügen
		view.addChildAt(new SpriteContainer(new Game(systemEvents, this)), 0);


	}

	public override function show() {
		super.show();

		//Zuletzt das Event auslösen, dass das Spiel startet
		systemEvents.LOAD_LEVEL.dispatch(new Level(level));
	}

} 