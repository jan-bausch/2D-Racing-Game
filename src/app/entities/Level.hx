package app.entities;

enum Result {
  Fail;
  Bronze;
  Silver;
  Gold;
}

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

	//Ergebnisszeit bewerten (fehlgeschlagen, Bronze-Medaille, Silber-Medaille, Gold-Medaille)
	public function rate(result: Float) : Result {

		if (result <= time * 0.9) return Result.Gold;
		if (result <= time * 0.95) return Result.Silver;
		if (result <= time * 1) return Result.Bronze;

		return Result.Fail;
	}

}