package app.systems;


import ash.core.System;
import ash.core.Entity;
import ash.core.NodeList;
import ash.core.Engine;
import ash.signals.Signal1;

import app.scenes.LevelOpeningScene;
import app.systems.SystemEvents;
import app.entities.Level;
import app.entities.Car;
import app.entities.Finish;
import app.nodes.GameNode;
import app.nodes.VehicleNode;
import app.nodes.CheckpointNode;
import app.components.Input;
import app.components.GameState;
import app.components.Vehicle;
import app.components.Position;
import app.components.CheckpointComponent;
import app.math.CollisionResponse;
import app.math.Vector2;

class GameSystem extends System {


    private var events: SystemEvents;
    private var level: Level;
    private var configuration: Configuration;
    private var gameNodes: NodeList<GameNode>;
    private var checkpointNodes: NodeList<CheckpointNode>;
    private var playerNodes: NodeList<VehicleNode>;

    private var running: Bool; //Soll Zeitmessung beginnen?

    public function new(events: SystemEvents) {
        super();

        this.events = events;
        this.configuration = new Configuration();
        this.running = false;

        //Events registrieren
        events.COLLISION.add(onCollision);
        events.LOAD_LEVEL.add(onLoadLevel);
        events.LOADED_LEVEL.add(onLoadedLevel);
        events.GAME_START.add(onGameStart);
        events.GAME_END.add(onGameEnd);
    }


    public override function update(elapsed: Float) : Void {

        //Zeit messen
        for (gameNode in gameNodes) {
            //Wenn Zeitmessung aktiviert ist, wird Zeit hinzugefügt
            if (running) gameNode.gameState.time += elapsed * 1000;
        }

        //"Boost"-Effekt stetig sinken lassen
        for (playerNode in playerNodes) {
            playerNode.vehicle.boost *= .90;
        }


    }


    private function onGameEnd(time: Float, result: Result) : Void {

        //Dem Spieler wieder die Kontrolle über die Steuerung nehmen
        for (player in playerNodes) {
            //"Fuß vom Gas nehmen"
            player.vehicle.throttle = 0;
            //Steurungs-Komponente entfernen
            player.entity.remove(Input);
        }

        //Falls sich Spieler verbessert hat, neue Bestzeit speichern
        if (configuration.HIGHSCORES[level.id] > time || configuration.HIGHSCORES[level.id] == 0) configuration.HIGHSCORES[level.id] = time;
        
        //Wenn Level gewonnnen, nächstes Level freischalten
        if (configuration.LEVEL == level.id && result != Result.Fail) {
            configuration.HIGHSCORES.push(0);
            configuration.LEVEL++;
        }

        configuration.save();

    }

    private function onCollision(entity1: Entity, entity2: Entity, collisionResponse: CollisionResponse) : Void {

        //Kollision zwischen Spieler und Zielfläche
        if (Type.getClass(entity1) == app.entities.Car && Type.getClass(entity2) == app.entities.Checkpoint && running) {
            var checkpoint: CheckpointComponent = entity2.get(CheckpointComponent);

            //Wenn Spieler noch nicht den Checkpoint betreten hat, wird Checkpoint aktiviert
            if (checkpoint.activated == false) {
                checkpoint.activated = true;

                //Zähler für aktivierte Checkpoints hochzählen
                for (gameNode in gameNodes) {
                    gameNode.gameState.activatedCheckpoints++;
                    //Event auslösen
                    events.CHECKPOINT_ACTIVATED.dispatch(gameNode.gameState.activatedCheckpoints);
                }

            }
        }

        //Kollision zwischen Spieler und Zielfläche
        if (Type.getClass(entity1) == app.entities.Car && Type.getClass(entity2) == app.entities.Finish && running) {

            for (gameNode in gameNodes) {
                //Prüfen, ob alle Checkpoints erreicht wurden
                if (gameNode.gameState.activatedCheckpoints >= gameNode.gameState.totalCheckpoints) {

                    //Level beendet
                    running = false;
                    //GameEnd-Event auslösen
                    for (gameNode in gameNodes) events.GAME_END.dispatch(gameNode.gameState.time, level.rate(gameNode.gameState.time));

                }
            }
        }

        //Kollision zwischen Spieler und Boosterfläche
        if (Type.getClass(entity1) == app.entities.Car && Type.getClass(entity2) == app.entities.Boost && running) {
            //Boost-Effekt von Spieler aktivieren
            entity1.get(Vehicle).boost =  20000;
        }   

    }

 
    //Wird aufgerufen, wenn ein neues Level geladen wird.
    private function onLoadLevel(newLevel: Level) : Void {

        //Aktuelles Level setzen
        this.level = newLevel;

        //Aktuelles Level in Game-Entity speichern
        for (gameNode in gameNodes) gameNode.gameState.level = level;

    }
    
    //Wird aufgerufen, wenn ein neues Level geladen wurde.
    private function onLoadedLevel(newLevel: Level) : Void {


        //Einmalig zählen, wieviele Checkpoints das Level besitzt
        var totalCheckpoints: Int = 0;
        for (checkpointNode in checkpointNodes) totalCheckpoints++;

        //Schließlich im Game-Entity speichern
        for (gameNode in gameNodes) gameNode.gameState.totalCheckpoints = totalCheckpoints;

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
        checkpointNodes = engine.getNodeList(CheckpointNode);
    }


    //Wird aufgerufen, wenn System von der Engine entfernt wird
    public override function removeFromEngine(engine: Engine):Void {
        gameNodes = null;
        playerNodes = null;
        checkpointNodes = null;
    }


}