package app.entities;

enum Result {
  Fail;
  Bronze;
  Silver;
  Gold;
}

/*
    Diese Klasse ist keine Entität, sondern repräsentiert Levelinformationen.
*/
class Level {

    public var name: String;
    public var id: Int;
    public var description: String;
    public var time: Int; //Zeit in ms, um das Level zu bestehen

    public function new(id: Int) {

        this.id = id;

        this.name = "<Unknown>";
        this.time = 0;
        this.description = "-";

    }
    

    //Ergebnisszeit bewerten (fehlgeschlagen, Bronze-Medaille, Silber-Medaille, Gold-Medaille)
    public function rate(result: Float) : Result {

        if (result <= time * 0.9) return Result.Gold;
        if (result <= time * 0.95) return Result.Silver;
        if (result <= time * 1) return Result.Bronze;

        return Result.Fail;
    }

}