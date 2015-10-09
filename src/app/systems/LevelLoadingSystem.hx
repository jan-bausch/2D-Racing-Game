package app.systems;

import haxe.xml.Fast;

import ash.core.System;
import ash.core.NodeList;
import ash.core.Engine;
import ash.core.Entity;
import ash.signals.Signal1;
import openfl.Assets;

import app.math.Vector2;
import app.entities.Level;
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
	private function onLoadLevel(level: Level) : Void {

		clearLevel();
		//Level parsen
		parseLevel(Xml.parse( Assets.getText("assets/levels/level" + level.id + ".xml") ));
	}

	//Level-Datei lesen und Entities erstellen
	private function parseLevel(xml: Xml) : Void {

		var data: Fast = new Fast(xml.firstElement()),
			levelName: String = data.att.Name;



		for (layer in data.node.Layers.nodes.Layer) {
			for (item in layer.node.Items.nodes.Item) {
				parseItem(item);
			}
		}

	}


	private function parseItem(item: Fast) : Void {

		var type: String = "";

		//Typ des Entities herausfinden
		for (property in item.node.CustomProperties.nodes.Property) {
			if (property.att.Name == "type") type = property.node.string.innerData;
		}

		switch type {
			case "grass-ground": engine.addEntity( new app.entities.Grass(parsePolygon(item, true)) );
			case "stone-wall": engine.addEntity( new app.entities.StoneWall(parsePolygon(item, true)) );
			case "car": engine.addEntity( new app.entities.Car(parsePosition(item), parseRotation(item)) );
			case "road": parseRoad(item);
			case "finish": engine.addEntity( new app.entities.Finish(parsePosition(item), parseScale(item), parseRotation(item)) );
			case "barrier": engine.addEntity( new app.entities.Barrier(parsePosition(item), parseScale(item), parseRotation(item)) );
			//default: throw "Unknow Entity of type '" + type + "' in level.";
		}


	}


	private function parseScale(item: Fast) : Vector2 {

		var x: Float = Std.parseFloat(item.node.Scale.node.X.innerData),
			y: Float = Std.parseFloat(item.node.Scale.node.Y.innerData);

		return new Vector2(x,y);
	}

	private function parseRotation(item: Fast) : Float {
		return Std.parseFloat(item.node.Rotation.innerData) *(180/Math.PI);
	}

	private function parsePosition(item: Fast) : Vector2 {

		var x: Float = Std.parseFloat(item.node.Position.node.X.innerData),
			y: Float = Std.parseFloat(item.node.Position.node.Y.innerData);

		return new Vector2(x,y);
	}


	private function parsePolygon(item: Fast, absolute: Bool = false) : Array<Vector2> {

		var polygon: Array<Vector2> = new Array<Vector2>();

		//Sollen die Punkte absolut oder relativ zum Mittelpunkt des Entities ausgelesen werden?
		if (absolute) {
			for (point in item.node.WorldPoints.nodes.Vector2)
				polygon.push(new Vector2(Std.parseFloat(point.node.X.innerData), Std.parseFloat(point.node.Y.innerData)));
		
		} else {
			for (point in item.node.LocalPoints.nodes.Vector2)
				polygon.push(new Vector2(Std.parseFloat(point.node.X.innerData), Std.parseFloat(point.node.Y.innerData)));

		}

		return polygon;
	}

	private function parseRoad(item: Fast) : Void {
		

		var width: Float = Std.parseFloat(item.node.LineWidth.innerData) / 2,
			waypoints: Array<Vector2> = parsePolygon(item, true);

		//Error werfen, wenn Strecke nur einen Wegpunkt hat.
		if (waypoints.length < 2) throw "Level-Loading failed: Road only has one waypoint.";

		for ( i in 0...waypoints.length-1 ) {
	
			var start: Vector2 = waypoints[i],
				end: Vector2 = waypoints[i+1];

			var startAngle: Float = (i==0) ? start.angleTo(end) : (start.angleTo(end) + new Vector2(waypoints[i-1].x, waypoints[i-1].y).angleTo(start)) / 2,
				endAngle: Float = (i==waypoints.length-2) ? start.angleTo(end) : (start.angleTo(end) + end.angleTo(new Vector2(waypoints[i+2].x, waypoints[i+2].y))) / 2;


			engine.addEntity( new app.entities.Road(start,  end, startAngle, endAngle, width) );

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