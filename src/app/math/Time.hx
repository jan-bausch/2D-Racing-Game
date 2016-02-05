package app.math;

/*
    Zeit, in der ein Level durchfahren wurde.
    Sie berechnet Milisekunden in Minuten, Sekunden und Milisekunden um und
    speichert sie als String der üblichen Darstellung 01:05.905 (Minuten:Sekunden.Milisekunden)
*/
class Time {

    public var miliseconds: Int;
    public var seconds: Int;
    public var minutes: Int;

    //Die gleiche Zahl mit anführenden Nullen
    public var milisecondsString: String;
    public var secondsString: String;
    public var minutesString: String;
    public var string: String;

    public function new() {

        miliseconds = 0;
        seconds = 0;
        minutes = 0;

    }

    //Konvertiert Milisekunden in besseres Zeitformat
    public static function fromMiliseconds(x: Float) : Time {

        var result: Time = new Time();

        result.miliseconds = Math.floor(x % 1000);
        result.seconds = Math.floor((x / 1000) % 60) ;
        result.minutes = Math.floor((x / (1000*60)) % 60);

        //Anführende Nullen ergänzen (1 Minute -> 01 Minuten, 2 Sekunden -> 02 Sekunden, usw.)
        result.milisecondsString = (result.miliseconds < 100) ? "0" + result.miliseconds : "" + result.miliseconds;
        if (result.miliseconds < 10) result.milisecondsString = "0" + result.milisecondsString;

        result.secondsString = (result.seconds < 10) ? "0" + result.seconds : "" + result.seconds; 
        result.minutesString = (result.minutes < 10) ? "0" + result.minutes : "" + result.minutes; 

        result.string = result.minutesString + ":" + result.secondsString + "." + result.milisecondsString;
        

        return result;
    }

}