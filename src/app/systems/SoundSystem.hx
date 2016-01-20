package app.systems;


import ash.core.System;
import ash.core.Entity;
import ash.core.NodeList;
import ash.core.Engine;

import openfl.Assets;
import openfl.media.Sound;
import openfl.media.SoundTransform;
import openfl.media.SoundChannel;
import openfl.utils.Timer;
import openfl.events.TimerEvent;


import app.entities.Level;
import app.components.Vehicle;
import app.nodes.VehicleNode;
import app.systems.SystemEvents;
import app.math.CollisionResponse;

class SoundSystem extends System {


    private var events: SystemEvents;
    private var volume: Float;
    private var vehicleNodes: NodeList<VehicleNode>;

    private var SOUND_COUNTDOWN: Sound;
    private var SOUND_SUCCESS: Sound;
    private var SOUND_CHECKPOINT: Sound;

    private var SOUND_CRASH: Sound;
    private var SOUND_IDLE: Sound;
    private var CHANNEL_IDLE: SoundChannel;
    private var SOUND_SLOW: Sound;
    private var CHANNEL_SLOW: SoundChannel;
    private var SOUND_MEDIUM: Sound;
    private var CHANNEL_MEDIUM: SoundChannel;
    private var SOUND_FAST: Sound;
    private var CHANNEL_FAST: SoundChannel;
    private var running: Bool;

    public function new(events: SystemEvents) {
        super();

        this.events = events;
        this.volume = 1;
        this.running = false;

        events.GAME_COUNTDOWN.add(onCountdown);
        events.GAME_END.add(onGameEnd);
        events.GAME_QUIT.add(onGameQuit);
        events.LOADED_LEVEL.add(onLoadedLevel);
        events.CHECKPOINT_ACTIVATED.add(onCheckpointActivated);
        events.CAR_CRASH.add(onCarCrash);

        SOUND_COUNTDOWN = Assets.getSound("assets/sounds/countdown.ogg");
        SOUND_SUCCESS = Assets.getSound("assets/sounds/success.ogg");
        SOUND_CHECKPOINT = Assets.getSound("assets/sounds/checkpoint.ogg");

        SOUND_CRASH = Assets.getSound("assets/sounds/crash.ogg");
        SOUND_IDLE = Assets.getSound("assets/sounds/idle_long.ogg");
        SOUND_SLOW = Assets.getSound("assets/sounds/slow_long.ogg");
        SOUND_MEDIUM = Assets.getSound("assets/sounds/medium_long.ogg");
        SOUND_FAST = Assets.getSound("assets/sounds/fast_long.ogg");


    }

    private function stop() : Void {
        //Alle laufenden Soundeffekte stoppen
        CHANNEL_IDLE.stop();
        CHANNEL_SLOW.stop();
        CHANNEL_MEDIUM.stop();
        CHANNEL_FAST.stop();
    }

    public override function update(elapsed: Float) : Void {

        if (running) {
            for (vehicleNode in vehicleNodes) {
                var velocity: Float = vehicleNode.vehicle.velocity;


                CHANNEL_IDLE.soundTransform = new SoundTransform(Math.max(1 - Math.abs((velocity-0)/10), 0));
                CHANNEL_SLOW.soundTransform = new SoundTransform(Math.max(1 - Math.abs((velocity-10)/10), 0));
                CHANNEL_MEDIUM.soundTransform = new SoundTransform(Math.max(1 - Math.abs((velocity-25)/20), 0));
                CHANNEL_FAST.soundTransform = new SoundTransform(Math.max(1 - Math.abs((velocity-40)/15), 0));
            }
        }

    }


    //Countdown beim Start eines Levels anzeigen
    private function onCountdown(callback: Void->Void) : Void {

        this.running = true;

        //Countdown Soundeffekt abspielen
        var countdownTimer: Timer = new Timer(1000, 1);

        countdownTimer.start();
        countdownTimer.addEventListener(TimerEvent.TIMER, function(e: TimerEvent) {
            SOUND_COUNTDOWN.play();
        });
    }

    private function onLoadedLevel(level: Level) : Void {

        //Motorgeräusche starten
        CHANNEL_IDLE = SOUND_IDLE.play(0,99);
        CHANNEL_SLOW = SOUND_SLOW.play(0,99);
        CHANNEL_MEDIUM = SOUND_MEDIUM.play(0,99);
        CHANNEL_FAST = SOUND_FAST.play(0,99);

        CHANNEL_IDLE.soundTransform = new SoundTransform(0, 0);
        CHANNEL_SLOW.soundTransform = new SoundTransform(0, 0);
        CHANNEL_MEDIUM.soundTransform = new SoundTransform(0, 0);
        CHANNEL_FAST.soundTransform = new SoundTransform(0, 0);
        
    }

    private function onGameEnd(time: Float, result: Result) : Void {

        //Erfolgstrompete abspielen, wenn Level bestanden
        if (result != Result.Fail) {
            SOUND_SUCCESS.play();
        }

        //Motorgeräusche stoppen
        stop();

    }

    private function onGameQuit() : Void {
        //Motorgeräusche stoppen
        stop();
    }

    private function onCheckpointActivated(count: Int) : Void {
        SOUND_CHECKPOINT.play();
    }

    private function onCarCrash() : Void {
        SOUND_CRASH.play();
    }

    //Wird aufgerufen, wenn System der Engine hinzugefügt wird
    public override function addToEngine(engine: Engine):Void {
        vehicleNodes = engine.getNodeList(VehicleNode);
    }

    //Wird aufgerufen, wenn System von der Engine entfernt wird
    public override function removeFromEngine(engine: Engine):Void {
        vehicleNodes = null;
    }


}