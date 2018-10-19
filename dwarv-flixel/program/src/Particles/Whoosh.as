package Particles
{
	import org.flixel.*;
	
	public class Whoosh extends FlxSprite
	{
		public var nDirection:Number = 0;
		public var nSpeed:Number = 0;
		public function Whoosh(p:PlayState, X:int, Y:int, dir:Number, sp:Number)
		{
			super(30, 30);
			loadGraphic(Content.cParticle, true, true, 30, 30);
			
			this.x = X;
			this.y = Y;
			
			addAnimation("w", [16, 17, 18, 19, 20], 13, false);
			play("w");
			
			nDirection = dir;
			nSpeed = sp;
			
			AngleToCartSpeed();
		}
		
		public function AngleToCartSpeed():void
		{
			var rads:Number = nDirection * (Math.PI / 180);
			velocity.x = nSpeed * Math.cos(rads);
			velocity.y = nSpeed * Math.sin(rads);
		}
		
		override public function update():void
		{
			if (_curFrame == 3)
				this.condemned = true;
		}
		
	}

}
