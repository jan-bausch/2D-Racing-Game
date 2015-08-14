package app.entities;


class Level {

	public var name: String;
	public var id: Int;
	public var description: String;
	public var time: Float; //Zeit in ms, um das Level zu bestehen

	public function new(id: Int) {

		this.id = id;
		load();

	}
	
	//Informationen des Levels aus der Leveldatei auslesen
	private function load() : Void {
		name = "Tutorial";
		description = "Lerne die Grundlagen und mache dich mit dem Auto vertraut.";
		time = 22 * 1000; //22 Sekunden
	}

}