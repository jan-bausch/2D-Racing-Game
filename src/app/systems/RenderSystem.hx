package app.systems;

import ash.core.Entity;
import ash.core.System;
import ash.core.NodeList;
import ash.core.Engine;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.geom.Matrix;
import app.math.Vector2;

import app.Configuration;
import app.components.Collision;
import app.entities.sprites.CollisionSprite;
import app.nodes.RenderNode;
import app.nodes.CameraVehicleNode;
import app.nodes.CameraNode;

class RenderSystem extends System {

	private var renderNodes: NodeList<RenderNode>;
    private var cameraNodes: NodeList<CameraNode>;
    private var cameraVehicleNodes: NodeList<CameraVehicleNode>;
	private var scene: Sprite;	//Verweis auf Sprite des "GameScene"-Objekts
    private var configuration: Configuration;

    private static inline var SPEED_ZOOM: Float = 5/10000;

    private var events: SystemEvents;

    public function new(events: SystemEvents, scene: Sprite) {
        super();

        this.events = events;
		this.scene = scene;
        this.configuration = new Configuration();
	}


	public override function update(elapsed: Float) : Void {

        var cameraPosition: Vector2 = new Vector2(0, 0),
            focusedEntities: Int = 0,
            zoom: Float = 0;

        //Position der Kamera ergibt sich aus der Durchschnittsposition der fokussierten Entities (d.h. mit "Camera"-Komponente)
        for (cameraNode in cameraNodes) {
            cameraPosition += cameraNode.position.vector;
            focusedEntities++;
            zoom += cameraNode.camera.zoom;
        }

        cameraPosition /= focusedEntities;




        //Matrix der Hauptszene
        var matrix: Matrix = scene.transform.matrix;

        //Position transformieren, sodass das Auto im Mittelpunkt steht.
        matrix.tx = - cameraPosition.x * zoom + Lib.current.stage.stageWidth/2;
        matrix.ty = - cameraPosition.y * zoom + Lib.current.stage.stageHeight/2;

        //Kamerazoom anwenden
        matrix.a = matrix.d = zoom;



        //Transformationen anwenden
        scene.transform.matrix = matrix;



		//Position jedes Sprites aktualisieren 
		for (renderNode in renderNodes) {

            //Sprites positionieren (Kamera und Fenstermitte mitberücksichtigen)
			renderNode.display.sprite.x = renderNode.position.vector.x;
			renderNode.display.sprite.y = renderNode.position.vector.y;

            //OpenFl misst Rotation in Grad, daher müssen wir vom Bogenmaß umrechnen
            renderNode.display.sprite.rotation = renderNode.position.rotation;
		}
        

        //Zoom an Geschwindigkeit anpassen
        for (cameraVehicleNode in cameraVehicleNodes) {

            var zoom: Float = 1 - SPEED_ZOOM * Math.abs(cameraVehicleNode.vehicle.speed);
            cameraVehicleNode.camera.zoom = zoom;
        }

	}

	//Wird aufgerufen, wenn System der Engine hinzugefügt wird
	public override function addToEngine(engine: Engine):Void {

        renderNodes = engine.getNodeList(RenderNode);
        cameraNodes = engine.getNodeList(CameraNode);
        cameraVehicleNodes = engine.getNodeList(CameraVehicleNode);


        //Den Sprite eines jedes vorhanden Entitys schon dem GameScene-Sprite hinzufügen
        for (renderNode in renderNodes)
            addRenderChild(renderNode.display.sprite, renderNode.entity);

        //Events registrieren
        renderNodes.nodeAdded.add(onRenderNodeAdded);
        renderNodes.nodeRemoved.add(onRenderNodeRemoved);

   	}

   	//Wird aufgerufen, wenn ein neues Entity der RenderNode-Liste hinzugefügt wird
    private function onRenderNodeAdded(node: RenderNode) : Void {
    	//Neues Entity zum "GameScene"-Objekt hinzufügen
        addRenderChild(node.display.sprite, node.entity);
    }   

    private function addRenderChild(child: Sprite, entity: Entity) : Void {

        //Im Debugmodus Kollisionsvieleck darstellen
        if (configuration.SHOW_COLLISION) {
            if (entity.has(Collision)) child.addChild(new CollisionSprite(entity.get(Collision)));
        }

        
        scene.addChild(child);
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
        this.cameraVehicleNodes = null;
    }


}