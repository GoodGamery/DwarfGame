package Mon 
{
	import flash.geom.ColorTransform;
	import org.flixel.*;
	
	public class Goblin extends Monster 
	{
		public var nHopForce:Number = Content.nForceTwo //0.4;
		public var bMoveOnlyWhenJumping:Boolean = false;
		public var bTurnWhenWalking:Boolean = false;
		public var bTurnWhenFalling:Boolean = false;
		public var bTurnToPlayerOnJump:Boolean = true;
		public var nJumpSeconds:Number = 0.2;
		public var nNextJumpSeconds:Number = 0.05;
		public var nJumpVariance:Number = 1.5;
		public var nDetectHero:Number = 10 * 30;
		public var bFloorRecovered:Boolean = true;
		
		public var nImpatience:Number = 0;
		public var iRetreatStrat:int = 0;
		public var iRetreatDistance:int = 0;
		public var nWander:Number = 0;
		
		public function Goblin(p:PlayState, X:Number, Y:Number, colTrans:ColorTransform = null, speedmod:Number = 1) 
		{
			
			
			super(p, "Goblin", X, Y, colTrans, speedmod);
			
			addAnimation("d", [50 + 0, 50 + 1, 50 + 0, 50 + 2], 16, true);
			addAnimation("jump", [50 + 2], 11, true);
			

			
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
		
			bDiesInWater = false;
			bDiesInSpikes = true;
			iRunSpeed = 80;
			this.health = 100;
			nDamageDealt = 1000;
			
			this._cFlickerColor = 0x00FFFFFF;
		}
		
		override public function update():void
		{
			super.update();	
		}
		
		override public function DoesThisArrowHurtMe(arrow:Arrow, hhit:int, vhit:int):Boolean
		{
			
			ForceStruck(vhit, hhit);
				
			this.flicker(nRecoverySeconds);
			
			return false;
		}
		
		override public function Struck(hhit:int, vhit:int, damage:int):void
		{
		}
		
		override public function UpdateWallBonk():void
		{	
			if ((velocity.y > 0 && bTurnWhenFalling) || 
				(bTurnWhenWalking && isTouching(FLOOR)))
			{
				if (facing == LEFT && isTouching(LEFT))
				{
					velocity.x = iRunSpeed;
					facing = RIGHT;
				}
				else if (facing == RIGHT && isTouching(RIGHT))
				{
					velocity.x = -iRunSpeed;
					facing = LEFT;
				}
			}
		}
		
		
		
		public var nJumpTimer:Number = 0;
		override public function UpdateMovement():void
		{
			var bJumping:Boolean = false;
			
			if (iRetreatStrat == 0)
			{
				if (isTouching(FLOOR))
				{
					if (isTouching(RIGHT))
						nImpatience += FlxG.elapsed;
					
					if (isTouching(LEFT))
						nImpatience -= FlxG.elapsed;
					
					if (nImpatience > 1)
					{
						iRetreatStrat = -1;
						iRetreatDistance = Util.Random(33, 53);
					}
					else if (nImpatience < -1)
					{
						iRetreatStrat = 1;
						iRetreatDistance = 33;
						if (Util.Random(0, 1) == 0)
							iRetreatDistance = 63;
					}
				}
			}
				
			if (Util.Random(0, 1000) == 0)
			{
				iRetreatStrat = (Util.Random(0, 1) * 2) - 1
				iRetreatDistance = Util.Random(63, 200);
			}
			
			if (iRetreatStrat < 0)
			{
				facing = LEFT;
				iRetreatStrat -= (iRunSpeed * FlxG.elapsed);
			}
			else if (iRetreatStrat > 0)
			{
				facing = RIGHT;
				iRetreatStrat += (iRunSpeed * FlxG.elapsed);
			}
			
			if (Math.abs(iRetreatStrat) > iRetreatDistance)
			{

				nJumpTimer = 1000;
				nImpatience = 0;
				iRetreatStrat = 0;
				nWander = Util.Random(1, 6);
			}
			
			nWander -= FlxG.elapsed;
			if (nWander < 0)
				nWander = 0;
			
			if (iRetreatStrat == 0)
			{
				if (isTouching(FLOOR) || 
					(this.y > parent.hero.y && (isTouching(LEFT) || isTouching(RIGHT))))
				{
					bFloorRecovered = true;
					
					nJumpTimer += 1;
					if (nJumpTimer >= nNextJumpSeconds * 60)
					{
						nJumpTimer = 0;
						bJumping = true;

						nNextJumpSeconds = nJumpSeconds * (1 + (((Util.Random(0, 100) / 100) - 0.5) * nJumpVariance))
					}
					
					if (bJumping)
					{
						var force:Number = nHopForce;
						var r:int = Util.Random(0, 2);
						
						if(r == 1)
							force = Content.nForceThree;
						else if (r == 2)
							force = Content.nForceOne;
							
						velocity.y = -Content.nGrav * force;
						
						var nCloseness:Number = Util.Distance(this.x, this.y, parent.hero.x, parent.hero.y);
						nCloseness /= 30;
						nCloseness = 10 - nCloseness;
						
						if (nCloseness > 0)
						{
							nCloseness /= 10;
							FlxG.play(Content.soundGoblin, Content.volumeGoblin * nCloseness, false, false);
						}
						//trace("HOP!");
					}
				}
				
				if (this.velocity.y < 0)
				{
					this.play("jump");
				}
				else
					this.play("d");
				
				if (bJumping && bTurnToPlayerOnJump && nWander <= 0)
				{
					if (Util.Distance(parent.hero.x, parent.hero.y, x, y) <= nDetectHero)
					{
						if (parent.hero.x < x)
						{
							facing = LEFT;
						}
						else
						{
							facing = RIGHT;
						}
					}
				}
					
				if (bMoveOnlyWhenJumping == true && isTouching(FLOOR))
				{
					this.velocity.x = 0;
				}
			}
			else
			{
				if (this.velocity.y < 0)
				{
					this.play("jump");
				}
				else
					this.play("sit");
			}
			
			if (bMoveOnlyWhenJumping == false ||
					(bMoveOnlyWhenJumping == true && !isTouching(FLOOR)))
			{
				if (bFloorRecovered)
				{
					if (facing == LEFT)
					{
						if (this.velocity.x < -iRunSpeed)
						{
							this.velocity.x += speedrecover;
						}
						else
							this.velocity.x = -iRunSpeed;
					}
					else if (facing == RIGHT)
					{
						if (this.velocity.x > iRunSpeed)
						{
							this.velocity.x -= speedrecover;
						}
						else
							this.velocity.x = iRunSpeed;
					}
				}
			}
		}
	}

}