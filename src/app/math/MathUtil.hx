package app.math;

class MathUtil {

	//Gibt das Vorzeichen (-1,0,+1) einer beliebigen Nummer zurück
	public static function sign(number: Float) : Float {
		if (number > 0) return 1;
		if (number < 0) return -1;
		return 0;
	}


	//Grenzt Wert n zwischen  den Grenzen min und max ein
	public static function clamp(n: Float, min: Float, max: Float) : Float {
		return Math.min(Math.max(n, min), max);
	}
}
