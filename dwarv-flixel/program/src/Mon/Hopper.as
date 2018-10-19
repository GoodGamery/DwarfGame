package Mon 
{
	import flash.geom.ColorTransform;
	import org.flixel.*;
	
	public class Hopper extends Monster 
	{
		public var nHopForce:Number = Content.nForceTwo //0.4;
		public var bMoveOnlyWhenJumping:Boolean = false;
		public var bTurnWhenWalking:Boolean = false;
		public var bTurnWhenFalling:Boolean = false;
		public var bTurnToPlayerOnJump:Boolean = true;
		public var nJumpSeconds:Number = 0.05;
		public var nNextJumpSeconds:Number = 0.05;
		public var nJumpVariance:Number = 1;
		public var nDetectHero:Number = 8 * 30;
		public var bFloorRecovered:Boolean = true;
		
		public function Hopper(p:PlayState, X:Number, Y:Number, colTrans:ColorTransform = null, speedmod:Number = 1) 
		{
			
			
			super(p, "Hopper", X, Y, colTrans, speedmod);
			
			addAnimation("d", [48 + 0], 1, true);
			addAnimation("jump", [48 + 1], 1, true);

			
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
		
			iRunSpeed = 50;
			this.health = 40;
		}
		
		override public function update():void
		{
			super.update();	
		}
		
		override public function Struck(hhit:int, vhit:int, damage:int):void
		{
			bFloorRecovered = false;
			
			super.Struck(hhit, vhit, damage);
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
			
			if (isTouching(FLOOR) || bOnMonster)
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
					velocity.y = -Content.nGrav * nHopForce;
					
					var nCloseness:Number = Util.Distance(this.x, this.y, parent.hero.x, parent.hero.y);
					nCloseness /= 30;
					nCloseness = 10 - nCloseness;
					
					if (nCloseness > 0)
					{
						nCloseness /= 10;
						FlxG.play(Content.soundCricket, Content.volumeCricket * nCloseness, false, false);
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
			
			if (bJumping && bTurnToPlayerOnJump)
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
			
			if (bMoveOnlyWhenJumping == true && isTouching(FLOOR))
			{
				this.velocity.x = 0;
			}
		}
	}

}