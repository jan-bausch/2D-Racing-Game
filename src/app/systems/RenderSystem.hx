package app.systems;

import ash.core.System;
import ash.core.NodeList;
import ash.core.Engine;
import openfl.Lib;
import openfl.display.Sprite;
import hxmath.math.Vector2;

import app.nodes.RenderNode;
import app.nodes.CameraNode;

class RenderSystem extends System {

	private var RenderNodes: NodeList<RenderNode>;
    private var CameraNodes: NodeList<CameraNode>;
	private var Scene: Sprite;	//Verweis auf Sprite des "GameScene"-Objekts


	public function new(Scene: Sprite) {
		super();
		this.Scene = Scene;
	}


	public override function update(elapsed: Float) : Void {

        var CameraPosition: Vector2 = new Vector2(0, 0),
            FocusedEntities: Int = 0;

        //Position der Kamera ergibt sich aus der Durchschnittsposition der fokussierten Entities (d.h. mit "Camera"-Komponente)
        for (CameraNode in this.CameraNodes) {
            CameraPosition += CameraNode.Position.Vector;
            FocusedEntities++;
        }

        CameraPosition /= FocusedEntities;


		//Position jedes Sprites aktualisieren 
		for (RenderNode in this.RenderNodes) {

            //Sprites positionieren (Kamera und Fenstermitte mitberücksichtigen)
			RenderNode.Display.Sprite.x = RenderNode.Position.Vector.x - CameraPosition.x + Lib.current.stage.stageWidth/2;
			RenderNode.Display.Sprite.y = RenderNode.Position.Vector.y - CameraPosition.y + Lib.current.stage.stageHeight/2;

            //OpenFl misst Rotation in Grad, daher müssen wir vom Bogenmaß umrechnen
            RenderNode.Display.Sprite.rotation = RenderNode.Position.Rotation * (180 / Math.PI);
		}
        
	}

	//Wird aufgerufen, wenn System der Engine hinzugefügt wird
	public override function addToEngine(Engine:Engine):Void {

        this.RenderNodes = Engine.getNodeList(RenderNode);
        this.CameraNodes = Engine.getNodeList(CameraNode);

        //Den Sprite jedes vorhanden Entitys schon dem GameScene-Sprite hinzufügen
        for (RenderNode in this.RenderNodes)
        	this.Scene.addChild(RenderNode.Display.Sprite);

        //Events registrieren
        this.RenderNodes.nodeAdded.add(onRenderNodeAdded);
        this.RenderNodes.nodeRemoved.add(onRenderNodeRemoved);

   	}

   	//Wird aufgerufen, wenn ein neues Entity der RenderNode-Liste hinzugefügt wird
    private function onRenderNodeAdded(node: RenderNode) : Void {
    	//Neues Entity zum "GameScene"-Objekt hinzufügen
    	this.Scene.addChild(node.Display.Sprite);
    }

    //Wird aufgerufen, wenn ein Entity aus der RenderNode-Liste entfernt wird
    private function onRenderNodeRemoved(node: RenderNode) : Void {
    	//Entferntes Entity aus dem "GameScene"-Objekt löschen
        this.Scene.removeChild(node.Display.Sprite);
    }

   	//Wird aufgerufen, wenn System von der Engine entfernt wird
    public override function removeFromEngine(Engine:Engine):Void {
        this.RenderNodes = null;
        this.CameraNodes = null;
    }


}