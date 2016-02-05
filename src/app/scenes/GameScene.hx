package app.scenes;

import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.containers.SpriteContainer;

import app.scenes.FullscreenScene;
import app.scenes.MainMenuScene;
import app.systems.SystemEvents;
import app.Game;
import app.entities.Level;

/*
    Die Spielszene
*/
class GameScene extends FullscreenScene {

    private var level: Int;
    public var systemEvents: SystemEvents; //Events, die zwischen Systemen ausgetauscht werden

    public function new(level: Int) {
        super();

        this.level = level;
        this.systemEvents = new SystemEvents();

        //Layout laden
        view = Toolkit.processXmlResource("assets/ui/layout/game.xml");

        //Das Spiel wird der Szene dynamisch hinzugefügt.
        view.addChildAt(new SpriteContainer(new Game(systemEvents, this)), 0);


    }

    public override function show() {
        super.show();

        //Zuletzt das Event auslösen, dass das Spiel startet
        systemEvents.LOAD_LEVEL.dispatch(new Level(level));
    }

} 