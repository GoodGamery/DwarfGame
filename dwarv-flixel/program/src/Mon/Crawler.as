package Mon 
{
	import flash.geom.ColorTransform;
	import org.flixel.*;
	
	public class Crawler extends Monster 
	{
		public var iDir:int = Content.RIGHT;
		public var nPredict:Number = 4;
		public var iMagnet:int = 16;
		public var iWidth:int = 14;
		
		public function Crawler(p:PlayState, X:Number, Y:Number, colTrans:ColorTransform = null, speedmod:Number = 1) 
		{
			
			
			super(p, "Crawler", X, Y, colTrans, speedmod);
			
			for (var dir:int = 0; dir < 4; dir++)
			{
				addAnimation(dir.toString(), [24 + 0, 24 + 1, 24 + 2, 24 + 3], 6, true);
			}
			
			play("1");
			
			bAcrophobic = false;
			bWallBonk = false;
			bDiesInWater = false;
			bForceHit = false;
			bLevelCollision = false;
			bMonsterCollision = false;
			bOriginalLevelCollision = false;
			bOriginalMonsterCollision = false;
			
			width = iWidth;
			height = iWidth;
			offset.x = 30 + 8;
			offset.y = 30 + 8;
			
			rectVulnerable.x = 0;
			rectVulnerable.width = 14;
			rectVulnerable.y = 0;
			rectVulnerable.height = 14;
			
			acceleration.y = 0;
			
			iRunSpeed = 50;
			
			iDir = Content.RIGHT;
			
			facing = RIGHT; // so that it doesn't mirror
			
			bDiesInSpikes = false;
		}
		
		override public function update():void
		{
			super.update();
			
		}

		override public function HitDeadArrow(arrow:Arrow):Boolean
		{
			return false;
			//return true;
		}

		override public function DoesThisArrowHurtMe(arrow:Arrow, hhit:int, vhit:int):Boolean
		{
			return false;
		}

		override public function UpdateMovement():void
		{
			var curx:int = x / 30;
			var cury:int = y / 30;
			var newx:int = 0;
			var newy:int = 0;
				
			if (bLevelCollision == true)
			{
				if (Util.IsBarrier(parent.level.getTile(curx + 1, cury + 1)) == true ||
					Util.IsBarrier(parent.level.getTile(curx - 1, cury + 1)) == true ||
					Util.IsBarrier(parent.level.getTile(curx + 1, cury - 1)) == true ||
					Util.IsBarrier(parent.level.getTile(curx - 1, cury - 1)) == true)
				{
					x = int(x / 30) * 30;
					y = int(y / 30) * 30;
					
					bLevelCollision = false;
				}
				else
				{
					acceleration.y = 420;
				}
			}
			else
			{
				if (false &&
					Util.IsBarrier(parent.level.getTile(curx + 1, cury + 1)) == false &&
					Util.IsBarrier(parent.level.getTile(curx - 1, cury + 1)) == false &&
					Util.IsBarrier(parent.level.getTile(curx + 1, cury - 1)) == false &&
					Util.IsBarrier(parent.level.getTile(curx - 1, cury - 1)) == false)
				{
					bLevelCollision = true;
				}
				else
				{
				
					acceleration.y = 0;
					
					var iOldDir:int = iDir;
					
					if (iDir == Content.RIGHT)
					{
						// Test front edge
						curx = (x + iWidth) / 30;
						cury = y / 30;
						newx = (x + iWidth + ((this.velocity.x * nPredict) / 60)) / 30;
						newy = y / 30;

						y = (cury * 30) + iMagnet; // Make sure we're attached to surface
						
						if (newx != curx)
						{
							if (Util.IsBarrier(parent.level.getTile(newx, newy)) == true) // +0degrees blocked
							{
								iDir = Content.UP;
								x = (curx * 30) + iMagnet;
								y = (cury * 30) + iMagnet;				
							}
						}
						else
						{
							// Test back edge
							curx = (x) / 30;
							newx = (x + ((this.velocity.x * nPredict) / 60)) / 30;
						
							if (newx != curx)
							{
								if (Util.IsBarrier(parent.level.getTile(newx, newy + 1)) == false) // +90degrees open
								{
									iDir = Content.DOWN;
									x = (newx * 30) - 0;
									y = (newy * 30) + iMagnet;
								}
							}
						}
					}
					else if (iDir == Content.LEFT)
					{
						// Test front edge
						curx = (x) / 30;
						cury = y / 30;
						newx = (x + ((this.velocity.x * nPredict) / 60)) / 30;
						newy = y / 30;

						y = (cury * 30) + 0; // Make sure we're attached to surface
						
						if (newx != curx)
						{
							if (Util.IsBarrier(parent.level.getTile(newx, newy)) == true) // +0degrees blocked
							{
								iDir = Content.DOWN;
								x = (curx * 30) + 0;
								y = (cury * 30) + 0;				
							}
						}
						else
						{
							// Test back edge
							curx = (x + iWidth) / 30;
							newx = (x + iWidth + ((this.velocity.x * nPredict) / 60)) / 30;
						
							if (newx != curx)
							{
								if (Util.IsBarrier(parent.level.getTile(newx, newy - 1)) == false) // +90degrees open
								{
									iDir = Content.UP;
									x = (newx * 30) + iMagnet;
									y = (newy * 30) + 0;
								}
							}
						}
					}
					else if (iDir == Content.DOWN)
					{
						// Test front edge
						curx = x / 30;
						cury = (y + iWidth) / 30;
						newx = x / 30;
						newy = (y + iWidth + ((this.velocity.y * nPredict) / 60)) / 30;

						x = (curx * 30) + 0; // Make sure we're attached to surface
						
						if (newy != cury)
						{
							if (Util.IsBarrier(parent.level.getTile(newx, newy)) == true) // +0degrees blocked
							{
								iDir = Content.RIGHT;
								x = (curx * 30) + 0;
								y = (cury * 30) + iMagnet;				
							}
						}
						else
						{
							// Test back edge
							cury = (y) / 30;
							newy = (y + ((this.velocity.y * nPredict) / 60)) / 30;
						
							if (newy != cury)
							{
								if (Util.IsBarrier(parent.level.getTile(newx - 1, newy)) == false) // +90degrees open
								{
									iDir = Content.LEFT;
									x = (newx * 30) - 0;
									y = (newy * 30) - 0;
								}
							}
						}
					}
					else if (iDir == Content.UP)
					{
						// Test front edge
						curx = x / 30;
						cury = (y) / 30;
						newx = x / 30;
						newy = (y + ((this.velocity.y * nPredict) / 60)) / 30;

						x = (curx * 30) + iMagnet; // Make sure we're attached to surface
						
						if (newy != cury)
						{
							if (Util.IsBarrier(parent.level.getTile(newx, newy)) == true) // +0degrees blocked
							{
								iDir = Content.LEFT;
								x = (curx * 30) + iMagnet;
								y = (cury * 30) + 0;			
							}
						}
						else
						{
							// Test back edge
							cury = (y + iWidth) / 30;
							newy = (y + iWidth + ((this.velocity.y * nPredict) / 60)) / 30;
						
							if (newy != cury)
							{
								if (Util.IsBarrier(parent.level.getTile(newx + 1, newy)) == false) // +90degrees open
								{
									iDir = Content.RIGHT;
									x = (newx * 30) + iMagnet;
									y = (newy * 30) + iMagnet;
								}
							}
						}
					}
					
				
					if (iDir == Content.RIGHT)
					{
						
						this.velocity.y = 0;
						this.velocity.x = iRunSpeed;
					}
					else if (iDir == Content.DOWN)
					{
						this.velocity.y = iRunSpeed;
						this.velocity.x = 0;
					}
					else if (iDir == Content.LEFT)
					{
						this.velocity.y = 0;
						this.velocity.x = -iRunSpeed;
					}
					else if (iDir == Content.UP)
					{
						this.velocity.y = -iRunSpeed;
						this.velocity.x = 0;
					}
					
					if (iDir != iOldDir)
					{
						this.play(iDir.toString());
					}
				}
			}
		}
	}

}