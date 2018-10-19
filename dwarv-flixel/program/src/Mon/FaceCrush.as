package Mon 
{
	import flash.geom.ColorTransform;
	import org.flixel.*;
	
	public class FaceCrush extends Monster 
	{
		public var nSpitTime:Number = 2;
		public var nSpitTimer:Number = nSpitTime;
		
		public const xCEILING:uint = 0;
		public const xFALLING:uint = 1;
		public const xGROUND:uint = 2;
		public const xRISING:uint = 3;
		public var iState:int = xCEILING;
		
		public function FaceShoot(p:PlayState, X:Number, Y:Number, colTrans:ColorTransform = null, speedmod:Number = 1) 
		{
			
			
			super(p, "FaceShoot", X, Y, colTrans, speedmod);
			
			bAcrophobic = false;
			bWallBonk = false;
			bDiesInWater = false;
			bForceHit = false;
			
			bLevelCollision = true;
			bMonsterCollision = false;
			bOriginalLevelCollision = true;
			bOriginalMonsterCollision = false;

			addAnimation("d", [36], 6, true);
			
			play("d");
			
			
			//remVelocity.x = -30;
			
			width = 20;
			height = 30;
			offset.x = 35;
			offset.y = 30;
			
			
			//boundGraphic(90, 90, 8, 8);
			
			acceleration.y = 0;
			
	
			
			facing = RIGHT;
			

		}
		
		override public function update():void
		{
			
			if (bPaused || visible == false)
			{
				this.velocity.x = 0;
				this.velocity.y = 0;
				this.acceleration.x = 0;
				this.acceleration.y = 0;
				
				return;
			}
			
			if (iState == xCEILING)
			{
				acceleration.y = 0;
			}
			else if (iState == xFLOOR)
			{
				acceleration.y = 300;
			}
			
			if (this.GetCurrentAnim() == "d")
			{
				nSpitTimer -= FlxG.elapsed;
				
				if (nSpitTimer < 0)
					this.play("spit");
			}
			
			if (this.GetCurrentAnim() == "spit" && this.GetCurrentFrame() == 3 && nSpitTimer < 0)
			{
				nSpitTimer = nSpitTime;
				
				var toadd:Monster = null;
				
				for (var m:int = 0; m < parent.arrayAllMonsters.length; m++)
				{
					if ((parent.arrayAllMonsters[m] as Monster).visible == false &&
						(parent.arrayAllMonsters[m] as Monster).strName == "FaceFire")
					{
						toadd = parent.arrayAllMonsters[m] as FaceFire;
						toadd.visible = true;
						break;
					}
				}
				
				if(toadd == null)
				{
					toadd = new FaceFire(this.parent, 0, 0, null, 
							3);
							
					parent.arrayAllMonsters.push(toadd);
				}
				
				
				
				parent.arrayNearMonsters.push(toadd);
				parent.groupFrontMonsters.add(toadd);
				
				if (this.facing == RIGHT)
				{
					toadd.facing = RIGHT;
					toadd.x = this.x + 15;
					toadd.y = this.y + 8;
				}
				else if (this.facing == LEFT)
				{
					toadd.facing = LEFT;
					toadd.x = this.x - 5;
					toadd.y = this.y + 8;
				}
				
				
				toadd.Reuse();
				
				
				var nCloseness:Number = Util.Distance(this.x, this.y, parent.hero.x, parent.hero.y);
				nCloseness /= 30;
				nCloseness = 20 - nCloseness;
				
				if (nCloseness > 0)
				{
					nCloseness /= 10;
					FlxG.play(Content.soundSpit, Content.volumeSpit * nCloseness, false, false);
				}
			}
			else if (this.GetCurrentAnim() == "spit" && this.GetCurrentFrame() == 6)
			{
				this.play("d");
			}
		}
		
		override public function DoesThisArrowHurtMe(arrow:Arrow, hit:int):Boolean
		{
			return false;
		}
		
	}

}