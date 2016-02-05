package app.components;

import app.entities.Level;

/*
    GameState-Komponente:
    Es gibt einige generelle Informationen über den aktuellen Spielstand, die mehrere
    System auslesen müssen. In einem "sauberen" ECS-Modell gibt es daher genau eine Entität,
    die nur eine Komponente besitzt - nämlich die GameState-Komponente.
    Diese Entität bzw. diese Komponente kann dann von allen Systemen ausgelesen werden.
*/
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