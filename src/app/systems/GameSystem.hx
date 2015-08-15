package app.systems;


import ash.core.System;
import ash.core.Entity;
import ash.core.NodeList;
import ash.core.Engine;
import ash.signals.Signal1;

import app.scenes.LevelOpeningScene;
import app.systems.SystemEvents;
import app.entities.Level;
import app.math.CollisionResponse;

class GameSystem extends System {


    private var events: SystemEvents;
    private var level: Level;
    private var configuration: Configuration;

    public function new(events: SystemEvents) {
		super();

        this.events = events;
        this.configuration = new Configuration();

        events.ENTITY_COLLIDED.add(onEntityCollided);
        events.LOAD_LEVEL.add(onLoadLevel);
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
    private function onLoadLevel(newLevel: Level) : Void {

        //Aktuelles Level setzen
        this.level = newLevel;

        //Zeige Popup mit Levelinformationen
        new app.scenes.LevelOpeningScene(level, events, function() {
            
            //Popup mit Ok bestätigt.

            //Zuerst auf Auto zoomen und Blur entfernen
            events.GAME_ZOOM_IN.dispatch(function () {

                //Dann Countdown (3...2...1...Los!) anzeigen
                events.GAME_COUNTDOWN.dispatch(function () {


                });

            });

        }).show();
    }

    private function showOpeningPopup(callback: Void->Void) : Void {

        //Popup in der Mitte des Bildschirms anzeigen
        new app.scenes.LevelOpeningScene(level, events, callback).show();

    }


	//Wird aufgerufen, wenn System der Engine hinzugefügt wird
    public override function addToEngine(engine: Engine):Void {

   	}


   	//Wird aufgerufen, wenn System von der Engine entfernt wird
    public override function removeFromEngine(engine: Engine):Void {

    }


}