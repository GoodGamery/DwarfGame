package  
{
	import org.flixel.*;
	
	public class Pellet extends FlxSprite
	{
		public var parent:PlayState = null;
		public var iSpeed:int = 50;
		public var bAlive:Boolean = true;
		public var grav:int = 420;
		public function Pellet(p:PlayState, X:int, Y:int, bRight:Boolean) 
		{
			super(30, 30);
			
			loadGraphic(Content.cPellet, true, true, 7, 7);

			addAnimation("d", [8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
				8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
				8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
				8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
				8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
				8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
				8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
				8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
				8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
				8, 8, 8, 8, 8, 8, 8, 8, 8, 8,
				8, 8, 8, 8, 8, 8, 8, 8, 8, 8], 20, false);
	
			this.x = X;
			this.y = Y;
			
			play("d");
			
			if (bRight)
			{
				facing = RIGHT;
				velocity.x = iSpeed;
			}
			else
			{
				facing = LEFT;
				velocity.x = -iSpeed;
			}
			
			acceleration.y = grav;			//gravity
			maxVelocity.y = 800;
			
			velocity.y = grav * -0.4;
		}
		
		public var wasfalling:Number = 0;
		public var wastraveling:Number = 0;
		override public function update():void
		{
			if (isTouching(FLOOR))
			{
				if (wasfalling > 3)
				{
					velocity.y = wasfalling * -0.4;
					
					if (velocity.y < grav * -0.6)
						velocity.y = grav * -0.6;
				}
				
				velocity.x *= 0.85;
			}
			
			if (isTouching(LEFT))
			{
				if (wastraveling < 0)
				{
					velocity.x = wastraveling * -1;
				}
					
				velocity.x *= 0.99;
			}
			else if (isTouching(RIGHT))
			{
				if (wastraveling > 0)
				{
					velocity.x = wastraveling * -1;
				}
					
				velocity.x *= 0.99;
			}
			
			velocity.x *= 0.995;
			
			if (Math.abs(velocity.x) < 12)
				velocity.x = 0;
			
			if (velocity.x < 0)
				facing = LEFT;
			
			if (velocity.x > 0)
				facing = RIGHT;
				
			if (velocity.y == 0)
				bAlive = false;
			else
				bAlive = true;
				
			wastraveling = velocity.x;
			wasfalling = velocity.y;
		}
		
	}

}