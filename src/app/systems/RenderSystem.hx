package app.systems;

import ash.core.System;
import ash.core.NodeList;
import ash.core.Engine;
import openfl.Lib;
import openfl.display.Sprite;
import app.math.Vector2;

import app.nodes.RenderNode;
import app.nodes.CameraNode;

class RenderSystem extends System {

	private var renderNodes: NodeList<RenderNode>;
    private var cameraNodes: NodeList<CameraNode>;
	private var scene: Sprite;	//Verweis auf Sprite des "GameScene"-Objekts


	public function new(scene: Sprite) {
		super();
        
		this.scene = scene;
	}


	public override function update(elapsed: Float) : Void {

        var cameraPosition: Vector2 = new Vector2(0, 0),
            focusedEntities: Int = 0;

        //Position der Kamera ergibt sich aus der Durchschnittsposition der fokussierten Entities (d.h. mit "Camera"-Komponente)
        for (cameraNode in cameraNodes) {
            cameraPosition += cameraNode.position.vector;
            focusedEntities++;
        }

        cameraPosition /= focusedEntities;


		//Position jedes Sprites aktualisieren 
		for (renderNode in renderNodes) {

            //Sprites positionieren (Kamera und Fenstermitte mitberücksichtigen)
			renderNode.display.sprite.x = renderNode.position.vector.x - cameraPosition.x + Lib.current.stage.stageWidth/2;
			renderNode.display.sprite.y = renderNode.position.vector.y - cameraPosition.y + Lib.current.stage.stageHeight/2;

            //OpenFl misst Rotation in Grad, daher müssen wir vom Bogenmaß umrechnen
            renderNode.display.sprite.rotation = renderNode.position.rotation;
		}
        
	}

	//Wird aufgerufen, wenn System der Engine hinzugefügt wird
	public override function addToEngine(engine: Engine):Void {

        renderNodes = engine.getNodeList(RenderNode);
        cameraNodes = engine.getNodeList(CameraNode);

        //Den Sprite eines jedes vorhanden Entitys schon dem GameScene-Sprite hinzufügen
        for (renderNode in renderNodes)
        	scene.addChild(renderNode.display.sprite);

        //Events registrieren
        renderNodes.nodeAdded.add(onRenderNodeAdded);
        renderNodes.nodeRemoved.add(onRenderNodeRemoved);

   	}

   	//Wird aufgerufen, wenn ein neues Entity der RenderNode-Liste hinzugefügt wird
    private function onRenderNodeAdded(node: RenderNode) : Void {
    	//Neues Entity zum "GameScene"-Objekt hinzufügen
    	scene.addChild(node.display.sprite);
    }

    //Wird aufgerufen, wenn ein Entity aus der RenderNode-Liste entfernt wird
    private function onRenderNodeRemoved(node: RenderNode) : Void {
    	//Entferntes Entity aus dem "GameScene"-Objekt löschen
        scene.removeChild(node.display.sprite);
    }

   	//Wird aufgerufen, wenn System von der Engine entfernt wird
    public override function removeFromEngine(engine: Engine):Void {
        this.renderNodes = null;
        this.cameraNodes = null;
    }


}