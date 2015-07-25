package app.systems;

import haxe.Json;

import ash.core.System;
import ash.core.NodeList;
import ash.core.Engine;
import ash.core.Entity;
import ash.signals.Signal1;
import openfl.Assets;
import app.math.Vector2;

import app.nodes.RenderNode;

class LevelLoadingSystem extends System {

	private var renderNodes: NodeList<RenderNode>;
	private var engine: Engine;

    private var events: SystemEvents;

    public function new(events: SystemEvents) {
		super();

        this.events = events;


		//Events registrieren
		events.LOAD_LEVEL.add(onLoadLevel);
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
			    case "Car": 		engine.addEntity( new app.entities.Car(entity.x, entity.y) );
			    case "Road": 		parseRoad(entity.waypoints, entity.width);
			    case "Grass": 		engine.addEntity( new app.entities.Grass(entity.x, entity.y, entity.width, entity.height) );
			    case "StoneWall":	engine.addEntity( new app.entities.StoneWall(parseWaypoints(entity.waypoints)) );
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

	private function parseWaypoints(waypoints: Array<{x: Float, y: Float}>) : Array<Vector2> {

		var polygon: Array<Vector2> = new Array<Vector2>();

		for (point in waypoints) {
			polygon.push(new Vector2(point.x, point.y));
		}

		return polygon;
	}

	private function parseRoad(waypoints: Array<{x: Float, y: Float}>, width: Float) : Void {
		
		//Error werfen, wenn Strecke nur einen Wegpunkt hat.
		if (waypoints.length < 2) throw "Level-Loading failed: Road only has one waypoint.";

		for( i in 0...waypoints.length-1 ) {
	
			var start: Vector2 = new Vector2(waypoints[i].x, waypoints[i].y),
				end: Vector2 = new Vector2(waypoints[i+1].x, waypoints[i+1].y);

			var startAngle: Float = (i==0) ? start.angleTo(end) : (start.angleTo(end) + new Vector2(waypoints[i-1].x, waypoints[i-1].y).angleTo(start)) / 2,
				endAngle: Float = (i==waypoints.length-2) ? start.angleTo(end) : (start.angleTo(end) + end.angleTo(new Vector2(waypoints[i+2].x, waypoints[i+2].y))) / 2;


			engine.addEntity( new app.entities.Road(start,  end, startAngle, endAngle, width) );

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