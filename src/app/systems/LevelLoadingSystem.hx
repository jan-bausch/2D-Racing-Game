package app.systems;

import haxe.Json;

import ash.core.System;
import ash.core.NodeList;
import ash.core.Engine;
import ash.core.Entity;
import ash.signals.Signal1;
import openfl.Assets;
import hxmath.math.Vector2;

import app.nodes.RenderNode;

class LevelLoadingSystem extends System {

	private var renderNodes: NodeList<RenderNode>;
	private var LOAD_LEVEL: Signal1<Int>;
	private var engine: Engine;

	public function new(LOAD_LEVEL: Signal1<Int>) {
		super();

		this.LOAD_LEVEL = LOAD_LEVEL;

		//Events registrieren
		LOAD_LEVEL.add(onLoadLevel);
	}




	//Wird aufgerufen, wenn ein neues Level geladen werden soll.
	private function onLoadLevel(id: Int) : Void {

		clearLevel();
		//Level parsen
		parseLevel(Json.parse( Assets.getText("res/levels/" + id + ".json") ));
	}

	//Level-Datei lesen und Entities erstellen
	private function parseLevel(json: Dynamic) : Void {

		var entities: Array<Dynamic> = json.entities;

		for (entity in entities) {

			switch entity.type {
			    case "Car": 	engine.addEntity( new app.entities.Car(entity.x, entity.y) );
			    case "Road": 	parseRoad(entity.waypoints, entity.width);
			    case "Grass": 	engine.addEntity( new app.entities.Grass(entity.x, entity.y, entity.width, entity.height) );
			}

		}

	}

	//Alle alten Entities löschen
	private function clearLevel() : Void {

		var entitiesToBeRemoved: Array<Entity> = new Array<Entity>();

		for (renderNode in renderNodes) {
			entitiesToBeRemoved.push(renderNode.entity);
		}

		for (entity in entitiesToBeRemoved) {
			engine.removeEntity(entity);
		}

	}

	private function parseRoad(waypoints: Array<{x: Float, y: Float}>, width: Float) : Void {
		
		//Error werfen, wenn Strecke nur einen Wegpunkt hat.
		if (waypoints.length < 2) throw "Level-Loading failed: Road only has one waypoint.";

		for( i in 0...waypoints.length-1 ) {
	
			var start: Vector2 = new Vector2(waypoints[i].x, waypoints[i].y),
				end: Vector2 = new Vector2(waypoints[i+1].x, waypoints[i+1].y),
				endAngle: Float = (end-start).angle + Math.PI / 2;


				trace(endAngle * (180 / Math.PI));

			engine.addEntity( new app.entities.Road(start,  end, Math.PI / 2, Math.PI / 2, width) );

		}


	}

	//Wird aufgerufen, wenn System der Engine hinzugefügt wird
	public override function addToEngine(engine: Engine):Void {
		renderNodes = engine.getNodeList(RenderNode);
		this.engine = engine;
   	}

   	//Wird aufgerufen, wenn System von der Engine entfernt wird
    public override function removeFromEngine(engine: Engine):Void {
    	renderNodes = null;
    }


}