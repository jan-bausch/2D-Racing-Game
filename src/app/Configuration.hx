package app;

import openfl.net.SharedObject;

//Konfigurationsdatei, um Optionen und Levelstände zu speichern
class Configuration{

    private static inline var id: String = "configuration";

    public var DEBUG: Bool;
    public var VOLUME: Bool;
    public var FULLSCREEN: Bool;
    public var LEVEL: Int;
    public var HIGHSCORES: Array<Float>;
    public var TOTALLEVELS: Int; //Anzahl aller Level (Zählung startet bei 1)


    public function new() {
        load();
        this.TOTALLEVELS = 9;
    }

    public function load() : Void {

        //Datei auslesen
        var io: SharedObject = SharedObject.getLocal(id);

        //Werte herauslesen, falls sie gesetzt sind
        DEBUG = (io.data.DEBUG == null) ? false : io.data.DEBUG;
        FULLSCREEN = (io.data.FULLSCREEN == null) ? false : io.data.FULLSCREEN;
        VOLUME = (io.data.VOLUME == null) ? true : io.data.VOLUME;
        LEVEL = (io.data.LEVEL == null) ? 0 : io.data.LEVEL;
        HIGHSCORES = (io.data.HIGHSCORES == null) ? [0] : io.data.HIGHSCORES;


    }

    public function save() : Void {

        //Datei auslesen
        var io: SharedObject = SharedObject.getLocal(id);

        //Werte in Datei schreiben
        io.data.DEBUG = DEBUG;          
        io.data.FULLSCREEN = FULLSCREEN;    
        io.data.VOLUME = VOLUME;
        io.data.LEVEL = LEVEL;       
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