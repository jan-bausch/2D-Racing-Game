package app.components;

import app.entities.Level;
//In dieser Komponente werden generelle Informationen zum aktuellen Spielzustand gespeichert.
//Sie gehört zum GameEntity, das es nur einmal geben sollte.
class GameState {

	public var time: Float; //Die verstrichene Zeit des Levels in Milisekunden
	public var level: Level;

	public function new() {
		this.time = 0;
	}

} 