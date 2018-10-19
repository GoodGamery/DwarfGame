package Particles
{
	import org.flixel.*;
	
	public class Twinkle extends FlxSprite
	{

		public function Twinkle(p:PlayState, X:int, Y:int)
		{
			super(1, 1);
			loadGraphic(Content.cTwinkle, true, true, 1, 1);
			
			strName = "Twinkle";
			
			this.x = X;
			this.y = Y;
			
			addAnimation("twinkling", [0, 1, 2, 3, 4, 4, 5, 5, 6, 7, 8, 9], 10, false);
			play("twinkling");
		}
		
		public function Reuse(X:int, Y:int):void
		{
			visible = true;
			
			this.x = X;
			this.y = Y;
			
			play("twinkling", true);
		}
		
		override public function update():void
		{
			if (_curFrame == 11)
			{
				this.visible = false;
				//this.condemned = true;
			}
		}
		
	}

}
