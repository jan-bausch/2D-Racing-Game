package app.components;

/*
    Checkpoint-Komponente:
    Diese Komponente markiert Checkpoints. Wenn das Auto mit der Entität kollidiert, wird "activated" auf wahr gesetzt.
*/
class CheckpointComponent {



    public var activated: Bool;
    
    public function new() {
        this.activated = false;
    }

}