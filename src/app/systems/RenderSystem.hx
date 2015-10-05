package app.systems;

import ash.core.Entity;
import ash.core.System;
import ash.core.NodeList;
import ash.core.Engine;
import openfl.Lib;
import openfl.display.Sprite;
import openfl.geom.Matrix;
import openfl.filters.BlurFilter;
import openfl.filters.BitmapFilterQuality;


import app.math.Vector2;
import app.Configuration;
import app.components.Collision;
import app.components.Vehicle;
import app.components.Input;
import app.entities.sprites.CollisionSprite;
import app.nodes.RenderNode;
import app.nodes.CameraVehicleNode;
import app.nodes.CameraNode;

class RenderSystem extends System {

	private var renderNodes: NodeList<RenderNode>;
    private var cameraNodes: NodeList<CameraNode>;
    private var cameraVehicleNodes: NodeList<CameraVehicleNode>;
	private var sprite: Sprite;	//Verweis auf Sprite des Spiels
    private var configuration: Configuration;
    private var blurFilter: BlurFilter;

    private static inline var SPEED_ZOOM: Float = .5/40; //Wie schnell zoomt die Kamera bei höheren Geschwindigkeiten heraus?

    private var events: SystemEvents;

    public function new(events: SystemEvents, sprite: Sprite) {
        super();

        this.events = events;
		this.sprite = sprite;
        this.configuration = new Configuration();
        this.blurFilter = new BlurFilter();
        blurFilter.quality = BitmapFilterQuality.LOW;
	}


	public override function update(elapsed: Float) : Void {

        var cameraPosition: Vector2 = new Vector2(0, 0),
            focusedEntities: Int = 0,
            blur: Float = 0,
            zoom: Float = 0;

        //Position der Kamera ergibt sich aus der Durchschnittsposition der fokussierten Entities (d.h. mit "Camera"-Komponente)
        for (cameraNode in cameraNodes) {


            /*
                Den Fokuspunkt finden:
                Bei den meisten Entities ist der Fokuspunkt der Kamera die Position des Entities selbst.
                Beim Auto aber fokusiert die Kamera immer einige Meter vor dem Auto - sprich in die 
                Richtung der Fahrt. Dieser Punkt wird nun berechnet.
            */
            if (cameraNode.entity.has(Vehicle)) {
                //Wenn das fokussierte Entity ein Auto ist

                var angle: Float = cameraNode.position.rotation,
                    velocity: Float = cameraNode.entity.get(Vehicle).velocity;

                //Wenn das fokussierte Entity ein Auto ist
                cameraNode.camera.target = Vector2.fromPolar(angle, velocity * 10);
                cameraPosition += cameraNode.position.vector + cameraNode.camera.focus;

            }else{
                cameraPosition += cameraNode.position.vector;
            }

            //Zoom und Blur festlegen
            zoom += cameraNode.camera.zoom;
            blur = cameraNode.camera.blur;
            focusedEntities++;
        }

        cameraPosition /= focusedEntities;




        //Matrix der Hauptszene
        var matrix: Matrix = new Matrix();

        //Position transformieren, sodass das Auto im Mittelpunkt steht.
        matrix.tx = - cameraPosition.x * zoom + Lib.current.stage.stageWidth/2;
        matrix.ty = - cameraPosition.y * zoom + Lib.current.stage.stageHeight/2;
        //Kamerazoom anwenden
        matrix.a = matrix.d = zoom;
        //Kamerablur anwenden
        blurFilter.blurX = blurFilter.blurY = blur;
        sprite.filters = (blur == 0) ? [] : [blurFilter];

        //Transformationen anwenden
        sprite.transform.matrix = matrix;



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


            var zoom: Float = 1 - SPEED_ZOOM * Math.abs(cameraVehicleNode.vehicle.velocity);
            cameraVehicleNode.camera.zoom = zoom;
        }

	}



	//Wird aufgerufen, wenn System der Engine hinzugefügt wird
	public override function addToEngine(engine: Engine):Void {

        renderNodes = engine.getNodeList(RenderNode);
        cameraNodes = engine.getNodeList(CameraNode);
        cameraVehicleNodes = engine.getNodeList(CameraVehicleNode);


        //Den Sprite eines jedes vorhanden Entitys schon dem Gamesprite-Sprite hinzufügen
        for (renderNode in renderNodes)
            addRenderChild(renderNode.display.sprite, renderNode.entity);

        //Events registrieren
        renderNodes.nodeAdded.add(onRenderNodeAdded);
        renderNodes.nodeRemoved.add(onRenderNodeRemoved);

   	}

   	//Wird aufgerufen, wenn ein neues Entity der RenderNode-Liste hinzugefügt wird
    private function onRenderNodeAdded(node: RenderNode) : Void {
    	//Neues Entity zum "Gamesprite"-Objekt hinzufügen
        addRenderChild(node.display.sprite, node.entity);
    }   

    private function addRenderChild(child: Sprite, entity: Entity) : Void {

        //Im Debugmodus Kollisionsvieleck darstellen
        if (configuration.SHOW_COLLISION) {
            if (entity.has(Collision)) child.addChild(new CollisionSprite(entity.get(Collision)));
        }

        
        sprite.addChild(child);
    }

    //Wird aufgerufen, wenn ein Entity aus der RenderNode-Liste entfernt wird
    private function onRenderNodeRemoved(node: RenderNode) : Void {
    	//Entferntes Entity aus dem "Gamesprite"-Objekt löschen
        sprite.removeChild(node.display.sprite);
    }

   	//Wird aufgerufen, wenn System von der Engine entfernt wird
    public override function removeFromEngine(engine: Engine):Void {
        this.renderNodes = null;
        this.cameraNodes = null;
        this.cameraVehicleNodes = null;
    }


}