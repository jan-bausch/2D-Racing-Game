package app.systems;

import ash.core.Entity;
import ash.core.System;
import ash.core.NodeList;
import ash.core.Engine;

import haxe.ui.toolkit.controls.Text;
import haxe.ui.toolkit.containers.Box;

import motion.Actuate;
import motion.easing.Linear;

import openfl.utils.Timer;
import openfl.events.TimerEvent;

import app.scenes.Scene;
import app.systems.SystemEvents;
import app.nodes.GameNode;
import app.math.Time;

class UISystem extends System {

	private var scene: Scene;	//Verweis auf Sprite des "GameScene"-Objekts
    private var events: SystemEvents;
    private var gameNodes: NodeList<GameNode>;
    private var counter: Float;

    public function new(events: SystemEvents, scene: Scene) {
        super();

        this.events = events;
		this.scene = scene;
        this.counter = 0;

        //Events registrieren
        events.GAME_COUNTDOWN.add(onCountdown);
        events.GAME_START.add(onGameStart);
	}


	public override function update(elapsed: Float) : Void {

        //Es reicht, wenn wir die Zeitanzeige nur alle 50ms aktualisieren.
        //Deswegen überspringen wir einige Durchgänge

        counter += elapsed;

        if (counter > 0.05) {
            for (gameNode in gameNodes) {

                //Milisekunden in Stunde:Minute:Sekunde:Milisekunde umwandeln
                var time: Time = Time.fromMiliseconds(gameNode.gameState.time);


                //Aktuelle Zeit anzeigen
                scene.view.findChild("minutes", Text, true).text = time.minutesString + ":" + time.secondsString;
                scene.view.findChild("miliseconds", Text, true).text = time.milisecondsString;
            }

            counter = 0;
        }

	}

    //Wird aufgerufen, wenn Countdown abgelaufen ist - bzw. wenn das Spiel gestartet ist
    private function onGameStart() : Void {

        //HUD (sprich Geschwindigkeitsanzeige, Zeit) beim Spielstart anzeigen
        scene.view.findChild("hud", Box, true).visible = true;

    }

    //Countdown beim Start eines Levels anzeigen
    private function onCountdown(callback: Void->Void) : Void {

        var countdownTimer: Timer = new Timer(1000, 4),
            counts: Int = 3;


        //Textfeld in der Mitte des Bildschirms anzeigen
        countdownTimer.start();
        countdownTimer.addEventListener(TimerEvent.TIMER, function(e: TimerEvent) {

            switch (counts) {
                case 3: showCountdownText("3");
                case 2: showCountdownText("2");
                case 1: showCountdownText("1");
                case 0: showCountdownText("Los!"); callback();
            }

            counts--;
        });

    }

    //Countdown in der Mitte des Bildschirms anzeigen
    private function showCountdownText(text: String) : Void {

        //countdown-Element finden
        var countdown: Text = scene.view.findChild("countdown", Text, true);

        //Schriftgröße setzen und anzeigen
        countdown.visible = true;
        countdown.text = text;
        countdown.style.fontSize = 300;
        countdown.style.alpha = 1;

        //Schrift animieren (kleiner werdend und transparenter)
        Actuate.tween(countdown.style, 1, {fontSize: 150, alpha: 0}).onComplete(function () {
            //Wenn Animation fertig ist, soll Text versteckt werden
            countdown.visible = false;
        });

    }

	//Wird aufgerufen, wenn System der Engine hinzugefügt wird
	public override function addToEngine(engine: Engine):Void {
        gameNodes = engine.getNodeList(GameNode);
   	}


   	//Wird aufgerufen, wenn System von der Engine entfernt wird
    public override function removeFromEngine(engine: Engine):Void {
        gameNodes = null;
    }


}