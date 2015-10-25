package app.math;

class Range {

    public var min: Float;
    public var max: Float;
    private var notset: Bool;

    public function new(min: Float = 0, max: Float = 0) {
        this.min = min;
        this.max = max;
        this.notset = false;
        if (min == 0 && max == 0) notset = true;
    }

    //Neuen Wert hinzufügen, der die Grenzen neu setzt
    public function add(x: Float) : Void {

        if (notset) {
            min = x;
            max = x;
            notset = false;
            return;
        }

        if (x < min) min = x;
        if (x > max) max = x;
    }

    //Berechnet den Abstand zweier Intervalle/Range
    public function distanceTo(range2: Range) : Float {

        if (min < range2.min) {
            return range2.min - max;
        } else {
            return min - range2.max;
        }
        
    }

}
