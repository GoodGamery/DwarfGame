package Hud 
{
	import flash.geom.Point;
	import org.flixel.FlxSprite;
    import org.flixel.FlxG;
	import org.flixel.FlxGroupXY;
	import org.flixel.FlxTextPlus;
	
	public class Meter extends FlxGroupXY
	{
		public var shadow:FlxSprite;	
		public var bg:FlxSprite;	
		public var fill:FlxSprite;	
		public var text:FlxTextPlus;
		public var meterwidth:int = 0;
		public var meterheight:int = 0;
		public var metercolor:uint = 0xFFFFFFFF;
		public var meterbackcolor:uint = 0xFFFFFFFF;
		
		public function Meter(x:int, y:int, width:int, height:int, col:uint, bcol:uint) 
		{
			super();
			
			meterwidth = width;
			meterheight = height;
			metercolor = col;
			meterbackcolor = bcol;
			
			shadow = new FlxSprite(x - 1, y - 1);
			shadow.makeGraphic(width + 2, height + 2, 0xFF000000, false);
			shadow.scrollFactor.x = 0;
			shadow.scrollFactor.y = 0;
			add(shadow);
			
			bg = new FlxSprite(x, y);
			bg.makeGraphic(width, height, bcol, false);
			bg.scrollFactor.x = 0;
			bg.scrollFactor.y = 0;
			add(bg);
			
			fill = new FlxSprite(x, y);
			fill.makeGraphic(width, height, col, false);
			fill.scrollFactor.x = 0;
			fill.scrollFactor.y = 0;
			add(fill);
			
			text = add(new FlxTextPlus(x - 1, y + (height / 2) - 7, width, "")) as FlxTextPlus;
			text.scrollFactor.x = 0;
			text.scrollFactor.y = 0;
			text.shadow = 0xFF000000;
			text.alignment = "center";
			add(text);
		}
		
		public function SetValue(amount:int, max:int):void
		{
			text.text = amount.toString() + "/" + max.toString();
			
			if (amount <= 0)
			{
				fill.visible = false;
			}
			else
			{
				fill.visible = true;
				fill.makeGraphic(Math.ceil(meterwidth * (amount / max)), meterheight, metercolor, false);
			}
		}
	}

}