package Mon 
{
	import flash.geom.ColorTransform;
	import org.flixel.*;
	
	public class Beetle extends Monster 
	{
		public var bEnraged:Boolean = false;
		public var iBaseSpeed:int = 0;
		
		public function Beetle(p:PlayState, X:Number, Y:Number, colTrans:ColorTransform = null, speedmod:Number = 1) 
		{
			
			
			super(p, "Beetle", X, Y, colTrans, speedmod);
			
			addAnimation("run", [40 + 0, 40 + 1, 40 + 2, 40 + 3], 6, true);
			

			
			play("run");
			
			bAcrophobic = true;
			
			//remVelocity.x = -30;
			
			width = 12;
			height = 28;
			offset.x = 39;
			offset.y = 32;
			
			rectVulnerable.x = -5;
			rectVulnerable.width = 22;
			rectVulnerable.height = 28;
			
			bForceHit = false;
			
			//boundGraphic(90, 90, 8, 8);
			
			iBaseSpeed = iRunSpeed;
			
			this.health = 40;
		}
		
		override public function update():void
		{
			bEnraged = int(parent.hero.y / 30) == int(this.y / 30) &&
				((this.facing == LEFT && parent.hero.x < this.x) ||
				(this.facing == RIGHT && parent.hero.x > this.x));
		
			
			if (bEnraged == false)
			{
				iRunSpeed = iBaseSpeed / 3;
			}
			else
			{
				iRunSpeed = iBaseSpeed * 3;
			}
			
			super.update();
		
		}
		
		override public function DoesThisArrowHurtMe(arrow:Arrow, hhit:int, vhit:int):Boolean
		{
			if (arrow.iBounceLife > -1) // Was spinning
			{
				return false;
			}
			
			if (arrow.velocity.x < 0 && this.facing == RIGHT)
			{
				return false;
			}
				
			if (arrow.velocity.x > 0 && this.facing == LEFT)
			{
				return false;
			}
			
			/*
			if (this.facing == RIGHT)
			{
				this.facing = LEFT;
				velocity.x = 0;
			}
			else
			{
				this.facing = RIGHT;
				velocity.x = 0;
			}
			*/
			velocity.x = 0;
				
			return true;
		}
	}

}