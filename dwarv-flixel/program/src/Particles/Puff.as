package Particles
{
	import org.flixel.*;
	import org.flixel.system.FlxAnim;
	
	public class Puff extends FlxSprite
	{
		public var nDirection:Number = 0;
		public var nSpeed:Number = 0;
		public function Puff(p:PlayState, X:int, Y:int, dir:Number, sp:Number, row:int)
		{
			super(30, 30);
			loadGraphic(Content.cParticle, true, true, 30, 30);
			
			strName = "Puff";
			
			this.x = X;
			this.y = Y;
			
			addAnimation("exploding", [0 + (row * 8), 1 + (row * 8), 2 + (row * 8), 3 + (row * 8), 4 + (row * 8), 5 + (row * 8), 6 + (row * 8), 7 + (row * 8)], 15, false);
			play("exploding");
			
			nDirection = dir;
			nSpeed = sp;
			
			AngleToCartSpeed();
		}
		
		public function Reuse(X:int, Y:int, dir:Number, sp:Number, row:int):void
		{
			visible = true;
			
			
			play("exploding", true);
			
			this.x = X;
			this.y = Y;
			
			nDirection = dir;
			nSpeed = sp;
			
			(this._animations[0] as FlxAnim).frames = [0 + (row * 8), 1 + (row * 8), 2 + (row * 8), 3 + (row * 8), 4 + (row * 8), 5 + (row * 8), 6 + (row * 8), 7 + (row * 8)];
			
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
			if (_curFrame == 7)
			{
				this.visible = false;
				//this.condemned = true;
			}
		}
		
	}

}
