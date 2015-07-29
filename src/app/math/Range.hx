package app.math;

class Range {

	public var min: Float;
	public var max: Float;

	public function new(min: Float = 0, max: Float = 0) {
		this.min = min;
		this.max = max;
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
