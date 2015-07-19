package app.ui;

import openfl.display.SimpleButton;
import openfl.display.Sprite;
import openfl.display.Bitmap;
import openfl.text.TextField;
import openfl.text.TextFormat;
import openfl.text.TextFormatAlign;
import openfl.Assets;
import openfl.events.Event;
import openfl.Lib;

class LevelButton extends SimpleButton {

	public var id: Int;
	private var textNormal: TextField;
	private var textHover: TextField;

	public function new(id: Int) {
		super();

		this.id = id;
	
		textNormal = new TextField();
		textHover = new TextField();
		textNormal.embedFonts = textHover.embedFonts = true;
		textNormal.text = textHover.text = "" + id;
		textNormal.background = textHover.background = true;
		textNormal.backgroundColor = 0xFFFFFF;
		textHover.backgroundColor = 0xF2F2F2;

		upState = textNormal;
		overState = textHover;



		//Layout
		addEventListener(Event.RESIZE, layout);
		layout(new Event("RESIZE"));	

	}

	private function layout(event: Event) : Void {

		trace(width);



		var fontSize: Float = height * 0.8;
		textNormal.width = textHover.width = width;
		textNormal.height = textHover.height = height;
		textNormal.x = textHover.x = 0;
		textNormal.y = textHover.y = height - fontSize;

		var textFormatNormal: TextFormat = new TextFormat ("Katamotz Ikasi", fontSize, 0x7A0026);
		var textFormatHover: TextFormat = new TextFormat ("Katamotz Ikasi", fontSize, 0x7A0026);
		textFormatHover.bold = true;
		textFormatNormal.align = textFormatHover.align = TextFormatAlign.RIGHT;

		textNormal.setTextFormat(textFormatNormal);
		textHover.setTextFormat(textFormatHover);
		

	}



}