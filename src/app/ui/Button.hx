package app.ui;

import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFieldAutoSize;

class Button extends Sprite {

	public var Text: String;
	public var Pressed: Bool;
	private var TextField: TextField;
	public var TextFormat: TextFormat;

	public function new(Text: String, TextFormat: TextFormat) {
		super();

		this.Text = Text;
		this.TextFormat = TextFormat;
		this.Pressed = false;

		//Textfeld initialisieren
		this.TextField = new TextField();
		this.TextField.defaultTextFormat = this.TextFormat;
		this.TextField.selectable = false;
		this.TextField.autoSize = TextFieldAutoSize.CENTER;
		this.TextField.text = this.Text;

		this.addChild(this.TextField);

		//Events registrieren
		this.addEventListener(Event.RESIZE, this.onResize);
		this.addEventListener(MouseEvent.MOUSE_UP, this.onUnpressed);
		this.addEventListener(MouseEvent.MOUSE_DOWN, this.onPressed);

		//Event auslösen, damit Textfeld anfangs zentriert wird.
		this.onResize(new Event("RESIZE"));
	}


	private function onPressed(event: Event) : Void {
		this.Pressed = true;
	}

	private function onUnpressed(event: Event) : Void {
		this.Pressed = false;
	}

	//Textfeld anpassen, wenn Button sich verändert
	private function onResize(event: Event) : Void {

		this.TextField.width = this.TextField.textWidth;
		this.TextField.height = this.TextField.textHeight;

	}

}