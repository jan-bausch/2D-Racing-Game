package app.components;


import app.math.Vector2;
import ash.core.Entity;

/*
    Kollisions-Komponente:
    Entities, die diese Komponente besitzen, können Kollisions-Ereignisse auslösen. Sie können sowohl durchlässig (Ziel, Checkpoints)
    als auch solide (Mauern, Holzboxen) sein.
*/
class Collision {

    public var solid: Bool; //Kann ein Auto mit der Entität zusammenstoßen?
    public var width: Float;
    public var height: Float;
    public var radius: Float; //Der Abstand zum entferntesten Punkt des Rechtecks. Er wird benutzt, um grob auf Kollision zu prüfen.

    //Damit festgestellt werden kann, wann eine Kollision beginnt und endet, werden Referenzen auf kollidierende Entitäten gespeichert.
    public var collidingEntities: Array<Entity>; 

    public function new(width: Float, height: Float, solid: Bool = true) {
        
        this.width = width;
        this.height = height;
        this.solid = solid;
        this.radius = new Vector2(width/2, height/2).length;
        this.collidingEntities = [];

    }

}