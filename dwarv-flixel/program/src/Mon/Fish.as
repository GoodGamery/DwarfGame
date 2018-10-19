package Mon 
{
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import org.flixel.*;
	
	public class Fish extends Monster 
	{
		public var nAngle:Number = 0;
		public var ptTargetVelocity:Point = new Point(0, 0);
		public var nSyncVelocitySpeed:Number = 200;
		
		
		public function Fish(p:PlayState, X:Number, Y:Number, colTrans:ColorTransform = null, speedmod:Number = 1) 
		{
			
			
			super(p, "Fish", X, Y, colTrans, speedmod);
			
			bDiesInWater = false;
			
			//addAnimation("run", [8, 9, 10, 11], 6, true);
			addAnimation("d", [16, 17, 18, 19], 6, true);
			
			play("d");
			
			bAcrophobic = false;
			
			//remVelocity.x = -30;
			
			width = 12;
			height = 22;
			offset.x = 39;
			offset.y = 38;
			
			rectVulnerable.x = -5;
			rectVulnerable.width = 22;
			
			//boundGraphic(90, 90, 8, 8);
			
			acceleration.y = 0;
			
			//bForceHit = false;
			
			var r:Rndm = new Rndm(x + (y * 2000));			
			nAngle = r.integer(0, Math.PI * 200) / 100;
			
			this.health = 20;
		}
		
		override public function update():void
		{
			super.update();
			acceleration.y = 0;
		}
		
		public var nChange:Number = Math.PI / 100;
		public var nChangeTimer:Number = 1;
		
		override public function UpdateMovement():void
		{
			nChangeTimer -= FlxG.elapsed;
			if (nChangeTimer < 0)
			{
				nChangeTimer += Util.Random(0, 500) / 100;
				nChange = ((Util.Random(0, 1) * 2) - 1) * Math.PI / 5;
			}
			
			nAngle += nChange * FlxG.elapsed;
			
			var bAirAbove:Boolean = false;
			
			var thistile:int = parent.level.getTile(int(this.x / 30), int((this.y) / 30)) % Content.iFrontSheetWidth;
			var bHereShallow:Boolean = (thistile == Content.iShallow || thistile == Content.iShallowGrass || thistile == Content.iShallowSpikes);
		
			var abovetile:int = parent.level.getTile(int(this.x / 30), int((this.y - 8) / 30)) % Content.iFrontSheetWidth;
			var bAboveNotShallow:Boolean = !(abovetile == Content.iShallow || abovetile == Content.iShallowGrass || abovetile == Content.iShallowSpikes);
								
			
			
			
			if ((bHereShallow && bAboveNotShallow) ||
				isTouching(FLOOR) ||
				isTouching(CEILING) ||
				isTouching(LEFT) ||
				isTouching(RIGHT))
			{
				nAngle += nChange * FlxG.elapsed;
			}
			
			if (velocity.x < 0)
				facing = LEFT;
			else if (velocity.x > 0)
				facing = RIGHT;
			
			if (isTouching(RIGHT))
				facing = LEFT;
			else if (isTouching(LEFT))
				facing = RIGHT;
			
			var opp:Number = Math.sin(nAngle) * iRunSpeed;
			var adj:Number = Math.cos(nAngle) * iRunSpeed;

			this.ptTargetVelocity.x = adj;
			this.ptTargetVelocity.y = opp;
			
			if (velocity.x < ptTargetVelocity.x)
			{
				velocity.x += nSyncVelocitySpeed * FlxG.elapsed;
				
				if (velocity.x > ptTargetVelocity.x)
					velocity.x = ptTargetVelocity.x;
			}
			else if (velocity.x > ptTargetVelocity.x)
			{
				velocity.x -= nSyncVelocitySpeed * FlxG.elapsed;
				
				if (velocity.x < ptTargetVelocity.x)
					velocity.x = ptTargetVelocity.x;
			}
			
			if (velocity.y < ptTargetVelocity.y)
			{
				velocity.y += nSyncVelocitySpeed * FlxG.elapsed;
				
				if (velocity.y > ptTargetVelocity.y)
					velocity.y = ptTargetVelocity.y;
			}
			else if (velocity.y > ptTargetVelocity.y)
			{
				velocity.y -= nSyncVelocitySpeed * FlxG.elapsed;
				
				if (velocity.y < ptTargetVelocity.y)
					velocity.y = ptTargetVelocity.y;
			}
			
			
			if (bHereShallow && bAboveNotShallow && velocity.y < 0)
			{
				velocity.y = 1;
			}
		}
	}

}