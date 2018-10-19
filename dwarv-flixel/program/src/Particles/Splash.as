package Particles
{
	import org.flixel.*;
	
	public class Splash extends FlxSprite
	{

		public function Splash(p:PlayState, X:int, Y:int)
		{
			super(30, 60);
			loadGraphic(Content.cSplash, true, true, 30, 60);
			
			strName = "Splash";
			
			this.x = X;
			this.y = Y;
			
			addAnimation("s", [0, 1, 2, 3, 4, 5], 15, false);
			play("s");
		}
		
		public function Reuse(X:int, Y:int):void
		{
			x = X;
			y = Y;
			play("s", true);
			visible = true;
		}
		
		override public function update():void
		{
			if (_curFrame == 5)
				this.visible = false;
		}
		
	}

}
