package app;

import openfl.net.SharedObject;

//Konfigurationsdatei, um Optionen und Levelstände zu speichern
class Configuration{

	private static inline var id: String = "configuration";

	public var SHOW_COLLISION: Bool;
	public var INPUT_KEYBOARD: Bool;
	public var FULLSCREEN: Bool;

	public var HIGHSCORES: Array<Float>;


	public function new() {
		load();
	}

	public function load() : Void {

		//Datei auslesen
		var io: SharedObject = SharedObject.getLocal(id);

		//Werte herauslesen, falls sie gesetzt sind
		SHOW_COLLISION = (io.data.SHOW_COLLISION == null) ? false : io.data.SHOW_COLLISION;
		INPUT_KEYBOARD = (io.data.INPUT_KEYBOARDN == null) ? true : io.data.INPUT_KEYBOARD;
		FULLSCREEN = (io.data.FULLSCREEN == null) ? false : io.data.FULLSCREEN;
		HIGHSCORES = (io.data.HIGHSCORES == null) ? [0] : io.data.HIGHSCORES;


	}

	public function save() : Void {

		//Datei auslesen
		var io: SharedObject = SharedObject.getLocal(id);

		//Werte in Datei schreiben
		io.data.SHOW_COLLISION = SHOW_COLLISION;	
		io.data.INPUT_KEYBOARD = INPUT_KEYBOARD;			
		io.data.FULLSCREEN = FULLSCREEN;				
		io.data.HIGHSCORES = HIGHSCORES;

		//Datei auf Festplatte schreiben
		try { 
			io.flush(); 
		} catch(e: Dynamic) { 
			throw "Couldn't save configuration: " + e; 
		}

	}

	public function clear() : Void {

		//Datei auslesen
		var io: SharedObject = SharedObject.getLocal(id);
		//Daten löschen
		io.clear();

		load();

	}



}