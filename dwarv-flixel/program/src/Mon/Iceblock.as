package Mon 
{
	import flash.geom.ColorTransform;
	import org.flixel.*;
	
	
	
	public class Iceblock extends Monster 
	{
		
		public function Iceblock(p:PlayState, X:Number, Y:Number, colTrans:ColorTransform = null) 
		{
			
			
			super(p, "Iceblock", X, Y, colTrans, 1);
			
			addAnimation("d", [3], 1, true);
			play("d");
			
			bAcrophobic = true;
			
			this.immovable = true;
			bForceImmovable = true;
			bBlockade = true;
			bKeepRebouncing = true;
			bEatUpwardArrows = false;
			
			bAcrophobic = false;
			bWallBonk = false;
			bDiesInWater = false;
			bForceHit = false;
			
			
			
			bLevelCollision = false;
			bMonsterCollision = true;
			bOriginalLevelCollision = false;
			bOriginalMonsterCollision = true;
			bHeroCollision = true;
			
			width = 30;
			height = 30;
			offset.x = 30;
			offset.y = 30;
			
			facing = RIGHT;
		}
		
		override public function update():void
		{
			acceleration.y = 0;
			velocity.x = 0;
			velocity.y = 0;
			
			super.update();
		
		}
		
		override public function UpdatePlayerHits():void
		{
			
		}
		
		override public function DoesThisArrowHurtMe(arrow:Arrow, hhit:int, vhit:int):Boolean
		{
			return false;
		}
	}

}