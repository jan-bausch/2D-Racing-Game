package app.systems;

import ash.core.System;
import ash.core.NodeList;
import ash.core.Engine;
import openfl.display.Sprite;

import app.nodes.RenderNode;

class RenderSystem extends System {

	private var RenderNodes: NodeList<RenderNode>;
	private var Scene: Sprite;	//Verweis auf Sprite des "GameScene"-Objekts


	public function new(Scene: Sprite) {
		super();
		this.Scene = Scene;
	}


	public override function update(elapsed: Float) : Void {

		//Position jedes Sprites aktualisieren 
		for (RenderNode in this.RenderNodes) {
			RenderNode.Display.Sprite.x = RenderNode.Position.X;
			RenderNode.Display.Sprite.y = RenderNode.Position.Y;
		}

	}

	//Wird aufgerufen, wenn System der Engine hinzugefügt wird
	public override function addToEngine(Engine:Engine):Void {

        this.RenderNodes = Engine.getNodeList(RenderNode); //Alle RenderNodes bekommen

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

    }


}