package Mon 
{
	import flash.geom.ColorTransform;
	import org.flixel.*;
	
	public class FaceShoot extends Monster 
	{
		public var nSpitTime:Number = 2;
		public var nSpitTimer:Number = nSpitTime;
		
		public function FaceShoot(p:PlayState, X:Number, Y:Number, colTrans:ColorTransform = null, speedmod:Number = 1) 
		{
			
			
			super(p, "FaceShoot", X, Y, colTrans, speedmod);
			
			bAcrophobic = false;
			bWallBonk = false;
			bDiesInWater = false;
			bForceHit = false;
			
			bLevelCollision = false;
			bMonsterCollision = false;
			bOriginalLevelCollision = false;
			bOriginalMonsterCollision = false;
			
			
			addAnimation("spit", [32, 33, 34, 35, 34, 33, 32], int(6 * speedmod), false);
			addAnimation("d", [32], 6, true);
			
			play("d");
			
			
			//remVelocity.x = -30;
			
			width = 12;
			height = 22;
			offset.x = 39;
			offset.y = 38;
			
			rectVulnerable.x = -5;
			rectVulnerable.width = 22;
			rectVulnerable.y = -5;
			
			//boundGraphic(90, 90, 8, 8);
			
			acceleration.y = 0;
			
	
			
			facing = RIGHT;
			
			bFrontMonster = true;
			
			var r:Rndm = new Rndm(x + (y * 2000));			
			nSpitTimer += r.integer(0, 200) / 100;
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
			
			//super.update();
			UpdateArrowHits();
			acceleration.y = 0;
			
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
		
		override public function DoesThisArrowHurtMe(arrow:Arrow, hhit:int, vhit:int):Boolean
		{
			return false;
		}
		
	}

}