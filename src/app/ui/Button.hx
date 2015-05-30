package app.ui;

import openfl.events.Event;
import openfl.events.MouseEvent;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFieldAutoSize;

class Button extends Sprite {

	public var text: String;
	public var pressed: Bool;
	private var textField: TextField;
	public var textFormat: TextFormat;

	public function new(text: String, textFormat: TextFormat) {
		super();

		this.text = text;
		this.textFormat = textFormat;
		this.pressed = false;

		//Textfeld initialisieren
		textField = new TextField();
		textField.defaultTextFormat = textFormat;
		textField.selectable = false;
		textField.autoSize = TextFieldAutoSize.CENTER;
		textField.text = text;

		addChild(textField);

		//Events registrieren
		addEventListener(Event.RESIZE, onResize);
		addEventListener(MouseEvent.MOUSE_UP, onUnpressed);
		addEventListener(MouseEvent.MOUSE_DOWN, onPressed);

		//Event auslösen, damit Textfeld anfangs zentriert wird.
		onResize(new Event("RESIZE"));
	}


	private function onPressed(event: Event) : Void {
		pressed = true;
	}

	private function onUnpressed(event: Event) : Void {
		pressed = false;
	}

	//Textfeld anpassen, wenn Button sich verändert
	private function onResize(event: Event) : Void {

		textField.width = textField.textWidth;
		textField.height = textField.textHeight;

	}

}