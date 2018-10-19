package
{
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flixel.*;
	

	public class Monster extends FlxSprite
	{
		public var parent:PlayState = null;
		public var bPaused:Boolean = false;
		public var bAcrophobic:Boolean = false;
		public var bWallBonk:Boolean = true;
		public var bForceHit:Boolean = true;
		public var bKillIfFar:Boolean = false;
		public var bOriginalLevelCollision:Boolean = true;
		public var bOriginalMonsterCollision:Boolean = true;
		public var bLevelCollision:Boolean = true;
		public var bHeroCollision:Boolean = false;
		public var bMonsterCollision:Boolean = true;
		public var bKeepRebouncing:Boolean = false;
		public var bBlockade:Boolean = false;
		public var bForceImmovable:Boolean = false;
		public var bEatUpwardArrows:Boolean = false;
		public var nLastX:Number = -9999999;
		public var nLastY:Number = -9999999;;
		public var bFrontMonster:Boolean = false;
		public var sBroom:FlxSprite = null;
		public var sBump:FlxSprite = null;
		public var iRunSpeed:int = 30;
		public var bFriendly:Boolean = false;
		public var nDamageDealt:Number = 20;
		public var groupStuck:FlxGroupXY = new FlxGroupXY();
		public var rectVulnerable:FlxRect;
		public var bDiesInWater:Boolean = true;
		public var bDiesInSpikes:Boolean = true;
		public var nRecoverySeconds:Number = 0.25;
		public var bOnMonster:Boolean = false;
		public var nStruckPower:Number = 100;
		public var strID:String = "";
		public var bQuashed:Boolean = false;
		public var strPrequashAnim:String = "";
		
		public function Quash(quash:Boolean):void
		{
			bQuashed = quash;
			
			if (quash)
			{
				bLevelCollision = false;
				bMonsterCollision = false;
				strPrequashAnim = this.GetCurrentAnim();
				this.play("q");
			}
			else
			{
				bLevelCollision = bOriginalLevelCollision;
				bMonsterCollision = bOriginalMonsterCollision;
				this.play(strPrequashAnim);
			}
		}
		
		public function Monster(p:PlayState, name:String, X:Number, Y:Number, colTrans:ColorTransform = null, speedmod:Number = 1)
		{
			super(X, Y);
			
			strName = name;
			
			strID = strName + "|" + x.toString() + "|" + y.toString();
			
			_bPixelFix = false;
			parent = p;
			
			loadGraphic(Content.cMonsters, true, true, 90, 90, true);
			addAnimation("q", [2], 16, true);
			
			if (colTrans != null)
			{
				this._colorTransform = colTrans;
				this._defaultColorTransform = colTrans;
			}
			
			facing = LEFT;
			
			iRunSpeed *= speedmod;
			maxVelocity.x = 200;			//walking speed
			maxVelocity.y = 800;
			//velocity.x = 300;
			//acceleration.x = 200;
			acceleration.y = 420;			//gravity
			//drag.x = maxVelocity.x * 300;		//deceleration (sliding to a stop)
			

			//tweak the bounding box for better feel
			width = 30;
			height = 30;
			offset.x = 30;
			offset.y = 30;
			
			rectVulnerable = new FlxRect(0, 0, width, height);
			
			addAnimation("ph", [0], 1, false);
			addAnimation("ph2", [1], 1, false);
			
			sBroom = new FlxSprite(X + (width / 2), Y + (height / 2));
			sBroom.width = 1;
			sBroom.height = 1;
			
			sBump = new FlxSprite(X + (width / 2), Y + (height / 2));
			sBump.width = 1;
			sBump.height = 1;
			
			Pause(true);
			
			this._cFlickerColor = 0xFFFFFFFF;
			this.health = 20;
		}
		
		public var remVelocity:FlxPoint = new FlxPoint(0, 0);
		public var remAcceleration:FlxPoint = new FlxPoint(0, 0);
		public var bOncePaused:Boolean = false;
		public function Pause(pause:Boolean):void 
		{
			bPaused = pause;

			if (pause)
			{
				//play("ph");
				
				remVelocity.x = this.velocity.x;
				remVelocity.y = this.velocity.y;
				remAcceleration.x = this.acceleration.x;
				remAcceleration.y = this.acceleration.y;
				
				this.velocity.x = 0;
				this.velocity.y = 0;
				this.acceleration.x = 0;
				this.acceleration.y = 0;
				
				bOncePaused = true;
			}
			else 
			{
				//play("ph2");
				
				if (bOncePaused)
				{
					this.velocity.x = remVelocity.x;
					this.velocity.y = remVelocity.y;
					this.acceleration.x = remAcceleration.x;
					this.acceleration.y = remAcceleration.y;
				}
			}
		}
		
		public function Reuse():void
		{
			
		}

		override public function update():void
		{
			if (bPaused || visible == false || doomed == true || bQuashed == true)
			{
				this.velocity.x = 0;
				this.velocity.y = 0;
				this.acceleration.x = 0;
				this.acceleration.y = 0;
				
				if (nLastX != -9999999 && nLastY != -9999999)
				{
					x = nLastX;
					y = nLastY;
				}
			}
			else
			{
				if (this.flickering == false)
					UpdateMovement();
				
				if(bWallBonk)
					UpdateWallBonk();
					
				if (bAcrophobic && this.flickering == false)
				{
					UpdateAcrophobia();
				}
				
				if (bFriendly == false)
				{
					UpdateArrowHits();
					UpdatePlayerHits();
				}
				
				if (bDiesInWater)
				{
					if (IsInWater())
					{
						Slay();
					}
				}
				
				if (bDiesInSpikes)
				{
					if (IsInSpikes())
					{
						Slay();
					}
				}
				
				if (bForceImmovable)
				{
					if (nLastX != -9999999 && nLastY != -9999999)
					{
						x = nLastX;
						y = nLastY;
					}
				}
			}
			
			nLastX = x;
			nLastY = y;
		}
		
		public function Slay():void
		{
			this.doomed = true;
			parent.CauseExplosion(5, this.x, this.y, 0);
			
			if (parent.nElapsedInZone > 1)
			{
				var nCloseness:Number = Util.Distance(this.x, this.y, parent.hero.x, parent.hero.y);
				nCloseness /= 30;
				nCloseness = 20 - nCloseness;
				
				if (nCloseness > 0)
				{
					nCloseness /= 10;
					FlxG.play(Content.soundDefeated, Content.volumeDefeated * nCloseness, false, false, Content.nDefaultSkip);
				}				
			}
		}
		
		public function IsInWater():Boolean
		{
			var bReallyInWater:Boolean = false;

			if (parent != null && parent.level != null)
			{ /*
				var xcheck:int = int(this.x + (this.width / 2)) / 30;
				var ycheck:int = int(this.y + (this.height / 2)) / 30;
				
				var overtile:int = parent.level.getTile(xcheck, ycheck) % Content.iFrontSheetWidth;
				var below:int = parent.level.getTile(xcheck, ycheck + 1) % Content.iFrontSheetWidth;
				var fluid:int = 0;
	
				if (overtile == Content.iWater || overtile == Content.iWaterGrass || overtile == Content.iWaterSpikes)
					fluid = 2;
				else if (overtile == Content.iShallow || overtile == Content.iShallowGrass || overtile == Content.iShallowSpikes)
					fluid = 1;
				else
					fluid = 0;*/
	
				var really:int = parent.level.getTile(int(this.x / 30), int(this.y / 30)) % Content.iFrontSheetWidth;
				bReallyInWater = (really == Content.iWater || really == Content.iWaterGrass || really == Content.iWaterSpikes ||
									really == Content.iShallow || really == Content.iShallowGrass || really == Content.iShallowSpikes);
			}
			
			return bReallyInWater;
		}
		
		public function IsInSpikes():Boolean
		{
			var bReallyInSpikes:Boolean = false;

			if (parent != null && parent.level != null)
			{
	
				var really:int = parent.level.getTile(int(this.x / 30), int(this.y / 30)) % Content.iFrontSheetWidth;
				bReallyInSpikes = (really == Content.iSpikes || really == Content.iWaterSpikes || really == Content.iShallowSpikes);
			}
			
			return bReallyInSpikes;
		}
		
		
		
		public function UpdateArrowHits():void
		{
			if (bPaused == false && bQuashed == false)
			{
				var vhit:int = -1;
				var hhit:int = -1;
				
				for (var a:int = 0; a < parent.arrayArrows.length; a++)
				{
					var thisarrow:Arrow = (parent.arrayArrows[a] as Arrow);
					
					if (rectVulnerable.offsetOverlaps(this.x, this.y, 
											(parent.arrayArrows[a] as Arrow).rectEffective,
											(parent.arrayArrows[a] as Arrow).x,
											(parent.arrayArrows[a] as Arrow).y)
						)
					{
						// ((parent.arrayArrows[a] as Arrow).iBounceLife < Content.iArrowRebounce ||  // Not spinning (or spinning and allowed to rebounce)
						//	(bKeepRebouncing && (parent.arrayArrows[a] as Arrow).iBounceLife < Content.iQuickRebounce)))
							
						if ((parent.arrayArrows[a] as Arrow).iAlive > 0 && // Not in twang/dead state, AND
							(parent.arrayArrows[a] as Arrow).iBounceLife == -1) // never bounced
						{
							if ((parent.arrayArrows[a] as Arrow).velocity.y > 0)
							{
								vhit = Content.DOWN;
							}
							else if ((parent.arrayArrows[a] as Arrow).velocity.y < 0)
							{
								vhit = Content.UP;
							}
						
							if ((parent.arrayArrows[a] as Arrow).velocity.x > 0)
							{
								hhit = Content.RIGHT;
							}
							else if ((parent.arrayArrows[a] as Arrow).velocity.x < 0)
							{
								hhit = Content.LEFT;
							}
				
								
							if (DoesThisArrowHurtMe(parent.arrayArrows[a] as Arrow, vhit, hhit))
							{
								parent.groupArrows.remove(parent.arrayArrows[a]);
								parent.arrayArrows.splice(a, 1);
								a--;
							}
							else
							{
								
								(parent.arrayArrows[a] as Arrow).Bounce(hhit, vhit);
							
								// Make it so it doesn't call 'struck'
								vhit = -1;
								hhit = -1;
							}
						}
						else if ((parent.arrayArrows[a] as Arrow).iAlive > 0 && 
							(parent.arrayArrows[a] as Arrow).iBounceLife < Content.iQuickRebounce)
						{
							if ((parent.arrayArrows[a] as Arrow).velocity.x > 0)// right
							{
								if(thisarrow.x + 7 < this.x + rectVulnerable.x + 5) // Hitting left face
									hhit = Content.RIGHT; // bonk!
								else
									hhit = Content.LEFT; // keepgoing
							}
							else if ((parent.arrayArrows[a] as Arrow).velocity.x < 0)// left
							{
								if (thisarrow.x + 7 > this.x + rectVulnerable.x + rectVulnerable.width - 5) // Hitting right face
									hhit = Content.LEFT; // bonk!
								else
									hhit = Content.RIGHT; // keepgoing
							}
							
							if ((parent.arrayArrows[a] as Arrow).velocity.y > 0)// down
							{
								if(thisarrow.y + 7 < this.y + rectVulnerable.y + 5) // Hitting top face
									vhit = Content.DOWN; // bonk!
								else
									vhit = Content.UP; // keepgoing
							}
							else if ((parent.arrayArrows[a] as Arrow).velocity.y < 0) // up
							{
								if (thisarrow.y + 7 > this.y + rectVulnerable.y + rectVulnerable.height - 5) // Hitting bottom face
									vhit = Content.UP; // bonk!
								else
									vhit = Content.DOWN; // keepgoing
							}
							
							var str_hhit:String = "hhit = -1";
							
							if (hhit == Content.LEFT)
								str_hhit = "hhit = LEFT";
							else if (hhit == Content.RIGHT)
								str_hhit = "hhit = RIGHT";
								
							var str_vhit:String = "vhit = -1";
							
							if (vhit == Content.UP)
								str_vhit = "vhit = UP";
							else if (vhit == Content.DOWN)
								str_vhit = "vhit = DOWN";
								
							trace("Bounce! " + str_hhit + " " + str_vhit);
							
							(parent.arrayArrows[a] as Arrow).Bounce(hhit, vhit);
							
								// Make it so it doesn't call 'struck'
								vhit = -1;
								hhit = -1;
		
						}
						/*
						else if ((parent.arrayArrows[a] as Arrow).iAlive < Content.iArrowLife)
						{
							if (HitDeadArrow(parent.arrayArrows[a] as Arrow))
							{
								parent.groupArrows.remove(parent.arrayArrows[a]);
								parent.arrayArrows.splice(a, 1);
								a--;
							}
						}*/
					}					
				}
				
				if (vhit != -1 || hhit != -1)
				{
					Struck(hhit, vhit, Content.stats.nDamageDealt);
					
					if (this.doomed == false)
						FlxG.play(Content.soundOffended, Content.volumeOffended, false, false, Content.nDefaultSkip);
				}	
			}
		}
		
		public function DoesThisArrowHurtMe(arrow:Arrow, hhit:int, vhit:int):Boolean
		{
			return true;
		}
		
		public function HitDeadArrow(arrow:Arrow):Boolean
		{
			return false;
		}
		
		public function ForceStruck(hhit:int, vhit:int):void
		{
			if (bForceHit)
			{
				if (vhit == Content.UP)
				{
					velocity.y -= nStruckPower;
				}
				else if (vhit == Content.DOWN)
				{
					velocity.y += nStruckPower;
				}
			}
			
			if (bForceHit)
			{
				if (hhit == Content.LEFT)
				{
					velocity.x -= nStruckPower;
				}
				else if (hhit == Content.RIGHT)
				{
					velocity.x += nStruckPower;
				}
			}
		}
		
		public function Struck(hhit:int, vhit:int, damage:int):void
		{		
			ForceStruck(hhit, vhit);
			
			this.flicker(nRecoverySeconds);
			
			this.health -= Content.stats.nDamageDealt;
			
			//trace(this.health.toString() + " health left");

				
			if (this.health <= 0)
			{
				Slay();
			}
		}
		
		public function UpdatePlayerHits():void
		{
			this.y += 2;
			this.height -= 2; // haircut to avoid diagonal through-block hits
			
			
			if (this.visible &&
				this.overlaps(parent.hero) &&
				parent.hero.flickering == false &&
				parent.state != Content.LEAVING &&
				parent.state != Content.DEAD &&
				parent.hero.GetCurrentAnim() != "leaving" &&
				parent.hero.GetCurrentAnim() != "arriving")
			{
				
				parent.hero.Hit(nDamageDealt, this.x + (this.width / 2));
			}
			
			this.y -= 2;
			this.height += 2;
		}
		
		
		
		public var speedrecover:int = 5;
		public function UpdateMovement():void
		{
			if (isTouching(FLOOR))
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
		
		public function UpdateWallBonk():void
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
		
		public function UpdateAcrophobia():void
		{
			if (isTouching(FLOOR))
			{
				if(facing == LEFT)
					sBroom.x = this.x - 4;
				else if(facing == RIGHT)
					sBroom.x = this.x + this.width - 1 + 4;
					
				sBroom.y = this.y + height + 2;
				
				if (sBroom.overlaps(parent.level))
				{
					
				}
				else
				{
					if (facing == LEFT)
						facing = RIGHT;
					else if (facing == RIGHT)
						facing = LEFT;
					
				}
			}
		}
	}
}