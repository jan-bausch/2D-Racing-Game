package app.systems;


import ash.core.System;
import ash.core.Entity;
import ash.core.NodeList;
import ash.core.Engine;
import ash.signals.Signal1;

import haxe.ui.toolkit.core.interfaces.IDisplayObjectContainer;
import haxe.ui.toolkit.controls.Button;
import haxe.ui.toolkit.controls.Text;
import haxe.ui.toolkit.events.UIEvent;
import haxe.ui.toolkit.core.Root;
import haxe.ui.toolkit.core.RootManager;
import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.core.PopupManager;

import openfl.Lib;

import app.Configuration;
import app.systems.SystemEvents;
import app.entities.Level;
import app.math.CollisionResponse;

class GameSystem extends System {


    private var events: SystemEvents;
    private var level: Level;
    private var configuration: Configuration;

    public function new(events: SystemEvents, levelId: Int) {
		super();

        this.events = events;
        this.level  = new Level(levelId);
        this.configuration = new Configuration();
        events.ENTITY_COLLIDED.add(onEntityCollided);
	}


	public override function update(elapsed: Float) : Void {


	}



	private function onEntityCollided(entity1: Entity, entity2: Entity, collisionResponse: CollisionResponse) : Void {

        trace(Type.getClassName(Type.getClass(entity1)) + "" + Type.getClassName(Type.getClass(entity2)));

		if (Type.getClass(entity1) == app.entities.Car && Type.getClass(entity2) == app.entities.Finish) {
			trace("load level");
		}

	}


    //Wird aufgerufen, wenn ein neues Level geladen wird.
    private function onLevelLoad() : Void {

        //Zeige Popup mit Levelinformationen
        showOpeningPopup( function() {
            //Popup mit Ok bestätigt.

            //Zuerst auf Auto zoomen und Blur entfernen
            events.GAME_ZOOM_IN.dispatch();

            //Danach Countdown anzeigen


        });

    }

    private function showOpeningPopup(callback: Void->Void) : Void {

        //Popup in der Mitte des Bildschirms anzeigen
        Toolkit.openPopup( { x:(Lib.current.stage.stageWidth-400)/2, y:(Lib.current.stage.stageHeight-300)/2, width:400, height:300 }, function(root:Root) {
                
            //Layout laden
            var view:IDisplayObjectContainer = Toolkit.processXmlResource("res/ui/layout/level-opening.xml");


            //Levelinformationen in UI schreiben
            view.findChild("level-id", Text, true).text = (level.id + 1) + "";
            view.findChild("level-name", Text, true).text = level.name;
            view.findChild("level-description", Text, true).text = level.description;
            view.findChild("personal-time", Text, true).text = (configuration.HIGHSCORES.length > level.id) ? (configuration.HIGHSCORES[level.id] / 1000) + " Sekunden" : "-" ;
            view.findChild("level-time", Text, true).text = (level.time / 1000) + " Sekunden";

            //Buttonevents festlegen
            view.findChild("start", Button, true).onClick = function(e:UIEvent){    RootManager.instance.destroyRoot(root); callback();    };
            view.findChild("abort", Button, true).onClick = function(e:UIEvent){    events.SHOW_MAINMENU.dispatch();    };

            root.addChild(view);


        } );



    }


	//Wird aufgerufen, wenn System der Engine hinzugefügt wird
    public override function addToEngine(engine: Engine):Void {

    	//Erstes Level laden
        events.LOAD_LEVEL.dispatch(level);
        onLevelLoad();
        
   	}


   	//Wird aufgerufen, wenn System von der Engine entfernt wird
    public override function removeFromEngine(engine: Engine):Void {

    }


}