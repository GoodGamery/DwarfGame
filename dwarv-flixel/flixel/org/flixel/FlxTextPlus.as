package org.flixel
{
	import org.flixel.FlxText;
	import flash.text.TextField;
	import flash.display.BitmapData;
	import flash.text.TextFormat;
	/**
	 * An extended version of the FlxText class.
	 * Adds a resize function for adjusting the width,
	 * and also handles pixel text properly, even on centered text.
	 * 
	 * Unfortunately, it's not all that efficient.
	 * 
	 * @author Truefire
	 */
	public class FlxTextPlus extends FlxText
	{
		/**
		 * Internal reference to a bunch of Flash <code>TextField</code> objects.
		 * We use these to position each line of the text to avoid anti-aliasing.
		 * Hacks FTW!
		 */
		protected var _textFields:Vector.<TextField>
		
		/**
		 * Creates a new <code>FlxTextPlus</code> object at the specified position.
		 * 
		 * @param	X				The X position of the text.
		 * @param	Y				The Y position of the text.
		 * @param	Width			The width of the text object (height is determined automatically).
		 * @param	Text			The actual text you would like to display initially.
		 * @param	EmbeddedFont	Whether this text field uses embedded fonts or nto
		 */
		public function FlxTextPlus(X:Number,Y:Number,Width:uint,Text:String = null,EmbeddedFont:Boolean = true) 
		{
			super(X, Y, Width, Text, EmbeddedFont);
		}
		
		/**
		 * Resizes the text field, updating the pixels and everything.
		 * 
		 * @param  W                The new width of the text.
		 */
		public function resize(W:uint):void
		{
			_textField.width = width = W;
			_regen = true;
			calcFrame();
		}
		
		public function SilentColor(Color:uint):void
		{
			var format:TextFormat = dtfCopy();
			format.color = Color;
			_textField.defaultTextFormat = format;
			_textField.setTextFormat(format);
			_regen = true;
			//calcFrame();
		}
		
		/**
		 * Internal function to update the current animation frame.
		 */
		public var iKerning:int = 1;
		override protected function calcFrame():void 
		{
			if(_regen)
			{
			
				//Need to generate a new buffer to store the text graphic
				var i:uint = 0;
				var nl:uint = _textField.numLines;
				height = 0;
				while (i < nl)
				{
					height += _textField.getLineMetrics(i++).height;
				}
				height += 4 + iKerning; //account for 2px gutter on top and bottom
				_pixels = new BitmapData(width,height,true,0);
				frameHeight = height;
				_textField.height = height*1.2;
				_flashRect.x = 0;
				_flashRect.y = 0;
				_flashRect.width = width;
				_flashRect.height = height;
				_regen = false;
				
				//generate our single line text fields;
				var heightCounter:int;
				_textFields = new Vector.<TextField>();
				i = 0;
				while (i < nl)
				{
					var tf:TextField = new TextField();
					tf.y = heightCounter;
					tf.width = _textField.width;
					tf.embedFonts = _textField.embedFonts;
					tf.selectable = false;
					tf.sharpness = 100;
					tf.multiline = false;
					tf.wordWrap = false;
					tf.text = _textField.getLineText(i);
					tf.defaultTextFormat = _textField.defaultTextFormat;
					tf.setTextFormat(_textField.defaultTextFormat);
					if(tf.text .length <= 0)
						tf.height = 1;
					else
						tf.height = 30;
					var lPos:Number = _textField.getLineMetrics(i).x;
					if ( lPos != Math.round(lPos)) { tf.x = Math.round(lPos)-lPos; }
					heightCounter += _textField.getLineMetrics(i++).height + iKerning;
					_textFields.push(tf);
				}
			}
			else	//Else just clear the old buffer before redrawing the text
				_pixels.fillRect(_flashRect,0);
			
			if((_textField != null) && (_textField.text != null) && (_textField.text.length > 0))
			{
				//Now that we've cleared a buffer, we need to actually render the text to it
				var format:TextFormat = _textField.defaultTextFormat;
				var formatAdjusted:TextFormat = format;
				_matrix.identity();
				//If it's a single, centered line of text, we center it ourselves so it doesn't blur
				if((format.align == "center") && (_textField.numLines == 1))
				{
					formatAdjusted = new TextFormat(format.font,format.size,format.color,null,null,null,null,null,"left");
					_textField.setTextFormat(formatAdjusted);				
					//var trans:Number = Math.floor((width - _textField.getLineMetrics(0).width) / 2);
					
					var trans:Number = Math.floor((width - _textField.getLineMetrics(0).width) / 2);
					
					trace(text + ": " + width.toString() + " | " + _textField.getLineMetrics(0).width.toString() );
					
					
					if(width % 2 == 1)
						trans -= 0.5;
						
					_matrix.translate(trans,0);
				}
				//Render a single pixel shadow beneath the text
				if(_shadow > 0)
				{
					i = 0;
					while (i < _textFields.length)
					{
						_textFields[i].setTextFormat(new TextFormat(formatAdjusted.font,formatAdjusted.size,_shadow,null,null,null,null,null,formatAdjusted.align));				
						_matrix.translate(1+_textFields[i].x,1+_textFields[i].y);
						_pixels.draw(_textFields[i],_matrix,_colorTransform);
						_matrix.translate(-1-_textFields[i].x,-1-_textFields[i].y);
						_textFields[i].setTextFormat(new TextFormat(formatAdjusted.font, formatAdjusted.size, formatAdjusted.color, null, null, null, null, null, formatAdjusted.align));
						i++;
					}
				}
				//Actually draw the text onto the buffer
				i = 0;
				while (i < _textFields.length)
				{
					_matrix.translate(_textFields[i].x, _textFields[i].y);
					_pixels.draw(_textFields[i],_matrix,_colorTransform);
					_textFields[i].setTextFormat(new TextFormat(format.font, format.size, format.color, null, null, null, null, null, format.align));
					_matrix.translate(-_textFields[i].x,-_textFields[i].y);
					i++;
				}
			}
			
			//Finally, update the visible pixels
			if((framePixels == null) || (framePixels.width != _pixels.width) || (framePixels.height != _pixels.height))
				framePixels = new BitmapData(_pixels.width,_pixels.height,true,0);
			framePixels.copyPixels(_pixels,_flashRect,_flashPointZero);
		}
		
	}

}