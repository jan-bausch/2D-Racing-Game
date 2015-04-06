package app.ui;

import openfl.events.Event;
import openfl.display.Sprite;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFieldAutoSize;

class Button extends Sprite {

	private var Text: String;
	private var TextField: TextField;
	private var TextFormat: TextFormat;

	public function new(Text: String, TextFormat: TextFormat) {
		super();

		this.Text = Text;
		this.TextFormat = TextFormat;

		//Textfeld initialisieren
		this.TextField = new TextField();
		this.TextField.defaultTextFormat = this.TextFormat;
		this.TextField.selectable = false;
		this.TextField.autoSize = TextFieldAutoSize.CENTER;
		this.TextField.text = this.Text;

		this.addChild(this.TextField);

		//onResize-Event registrieren
		this.addEventListener(Event.RESIZE, this.onResize);

		//Event auslösen, damit Textfeld zentriert wird.
		this.onResize(new Event("RESIZE"));
	}

	//Textfeld anpassen, wenn Button sich verändert
	private function onResize(event: Event) {

		this.TextField.width = this.TextField.textWidth;
		this.TextField.height = this.TextField.textHeight;

	}

}