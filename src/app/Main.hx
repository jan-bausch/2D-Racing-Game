package app;


import openfl.display.Sprite;
import openfl.display.StageDisplayState;
import openfl.Lib;

import haxe.ui.toolkit.core.Toolkit;
import haxe.ui.toolkit.core.Macros;

import app.scenes.MainMenuScene;
import app.scenes.GameScene;
import app.Configuration;

import haxe.ui.toolkit.core.PopupManager;

import lime.ui.Gamepad;
import lime.ui.GamepadAxis;
import lime.ui.GamepadButton;

class Main extends Sprite {
    
    
    public function new () {        
        super();

        //HaxeUI-Bibliothek initialisieren
        Toolkit.theme = new  haxe.ui.toolkit.themes.GradientTheme();
        Toolkit.init();
        Macros.addStyleSheet("assets/ui/layout/style.css"); //Stylesheet laden
        
        //Wenn man die Option "Vollbild" gewählt hat, muss Fenster in Vollbildmodus gebracht werden
        Lib.current.stage.displayState = new Configuration().FULLSCREEN ? StageDisplayState.FULL_SCREEN_INTERACTIVE : StageDisplayState.NORMAL;


        //Startmenü anzeigen
        //new MainMenuScene().show();
        new GameScene(0).show();




    }
    
    
}