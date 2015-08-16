package app.systems;


import ash.core.System;
import ash.core.Entity;
import ash.core.NodeList;
import ash.core.Engine;
import ash.signals.Signal1;

import app.scenes.LevelOpeningScene;
import app.systems.SystemEvents;
import app.entities.Level;
import app.nodes.GameNode;
import app.nodes.VehicleNode;
import app.components.Input;
import app.components.GameState;
import app.math.CollisionResponse;

class GameSystem extends System {


    private var events: SystemEvents;
    private var level: Level;
    private var configuration: Configuration;
    private var gameNodes: NodeList<GameNode>;
    private var playerNodes: NodeList<VehicleNode>;

    private var running: Bool; //Soll Zeitmessung beginnen?

    public function new(events: SystemEvents) {
		super();

        this.events = events;
        this.configuration = new Configuration();
        this.running = false;

        events.ENTITY_COLLIDED.add(onEntityCollided);
        events.LOAD_LEVEL.add(onLoadLevel);
        events.GAME_START.add(onGameStart);
	}


	public override function update(elapsed: Float) : Void {

        for (gameNode in gameNodes) {
            //Wenn Zeitmessung aktiviert ist, wird Zeit hinzugefügt
            if (running) gameNode.gameState.time += elapsed * 1000;
        }


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

        //Aktuelles Level in Game-Entity speichern
        for (gameNode in gameNodes) gameNode.gameState.level = level;

        //Zeige Popup mit Levelinformationen
        new app.scenes.LevelOpeningScene(level, events, function() {
            
            //Popup mit Ok bestätigt.

            //Zuerst auf Auto zoomen und Blur entfernen
            events.GAME_ZOOM_IN.dispatch(function () {

                //Dann Countdown (3...2...1...Los!) anzeigen
                events.GAME_COUNTDOWN.dispatch(function () {

                    //Spiel starten
                    events.GAME_START.dispatch();

                });

            });

        }).show();
    }
    
    //Wird aufgerufen, wenn das Spiel gestartet wurde. (bzw. Countdown heruntergezählt wurde)
    private function onGameStart() : Void {

        //Dem Spieler-Entity eine Steuerungskomponente geben, damit er fahren kann
        for (player in playerNodes) player.entity.add(new Input());

        //Zeitmessung starten
        running = true;

    }

	//Wird aufgerufen, wenn System der Engine hinzugefügt wird
    public override function addToEngine(engine: Engine):Void {
        gameNodes = engine.getNodeList(GameNode);
        playerNodes = engine.getNodeList(VehicleNode);
   	}


   	//Wird aufgerufen, wenn System von der Engine entfernt wird
    public override function removeFromEngine(engine: Engine):Void {
        gameNodes = null;
        playerNodes = null;
    }


}