package app.components;

import app.entities.Level;
//In dieser Komponente werden generelle Informationen zum aktuellen Spielzustand gespeichert.
//Sie gehört zum GameEntity, das es nur einmal geben sollte.
class GameState {

    public var time: Float; //Die verstrichene Zeit des Levels in Milisekunden
    public var level: Level; //Referenz auf aktuelle Levelinformationen
    public var activatedCheckpoints: Int; //Wieviele Checkpoints wurden schon aktiviert.
    public var totalCheckpoints: Int; //So viele Checkpoints hat das Level insgesamt.

    public function new() {
        this.time = 0;
        this.activatedCheckpoints = 0;
        this.totalCheckpoints = 0;
    }

} 