package  
{
	import flash.geom.Rectangle;
	import org.flixel.*;
	import Particles.*;
	
	public class Arrow extends FlxSprite
	{
		public var parent:PlayState = null;
		public var iSpeed:int = 1000;
		public var iAlive:int = Content.iArrowLife;
		public var iBounceLife:int = -1;
		public var bBouncing:Boolean = false;
		public var iDir:int = 0;
		public var rectEffective:FlxRect;
		
		public function Arrow(p:PlayState, X:int, Y:int, bRight:Boolean, direction:int) 
		{
			
			super(30, 30);
			
			parent = p;
			
			loadGraphic(Content.cArrow, true, true, 30, 30);

			
	
			this.x = X;
			this.y = Y;
			
			rectEffective = new FlxRect(0, 0, this.width, this.height);
			
			var iStarting:int = 0;
			
			addAnimation("aliveH", [iStarting], 1, false);
			addAnimation("deadH", [iStarting + 1, iStarting + 2, iStarting + 3, iStarting + 4, iStarting + 5, iStarting + 6, iStarting + 7, iStarting + 8,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9], 20, false);
				
			iStarting = 10;
			
			addAnimation("aliveU", [iStarting], 1, false);
			addAnimation("deadU", [iStarting + 1, iStarting + 2, iStarting + 3, iStarting + 4, iStarting + 5, iStarting + 6, iStarting + 7, iStarting + 8,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9], 20, false);
				
			iStarting = 20;
			
			addAnimation("aliveD", [iStarting], 1, false);
			addAnimation("deadD", [iStarting + 1, iStarting + 2, iStarting + 3, iStarting + 4, iStarting + 5, iStarting + 6, iStarting + 7, iStarting + 8,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9,
				iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9], 20, false);
		
			addAnimation("bounce", [30, 31, 32, 33, 34, 35, 36, 37], 30, true);
			
			SetDirection(direction, bRight);
			
			ArrowPlay("alive");
		}
		
		public function ArrowPlay(anim:String):void
		{
			if (iDir == 0)
			{
				play(anim + "H");
			}
			else if (iDir == -1)
			{
				play(anim + "U");
			}
			else if (iDir == 1)
			{
				play(anim + "D");
			}
		}
		
		public function SetDirection(direction:int, bRight:Boolean):void
		{
			iDir = direction;

			if (iDir == 0)
			{
				width = 16;
				height = 3;
				offset.x = 7;
				offset.y = 19;
			}
			else
			{
				if (iDir == -1)
				{
					width = 3;
					height = 14;
					offset.x = 18;
					offset.y = 9;
				}
				else
				{
					width = 3;
					height = 14;
					offset.x = 18;
					offset.y = 7;
				}
			}
					
			if (iDir == 0)
			{
				if (bRight)
				{
					facing = RIGHT;
					width = 14;
					height = 3;
					offset.x = 7;
					offset.y = 19;
				}
				else
				{
					facing = LEFT;
					width = 14;
					height = 3;
					offset.x = 9;
					offset.y = 19;
				}
			
				if (bRight)
				{
					velocity.x = iSpeed;
				}
				else
				{
					velocity.x = -iSpeed;
				}
			}
			else if (iDir == -1)
			{
				velocity.y = -iSpeed;
			}
			else if (iDir == 1)
			{
				velocity.y = iSpeed;
			}
			
			SetEffective();
		}
		
		public function SetEffective():void
		{
			rectEffective.x = 0;
			rectEffective.y = 0;
			rectEffective.width = this.width;
			rectEffective.height = this.height;
		}
		
		public function Bounce(hhit:int, vhit:int):void
		{
			this.play("bounce");
			
			FlxG.play(Content.soundTing, Content.volumeTing, false, false, Content.nDefaultSkip);
			
			var nUpBounceSpeed:Number = 0.35;
			var nDownBounceSpeed:Number = 0.1;
			var nLateralBounceSpeed:Number = 0.3;
			
			var nUpHeadStart:Number = 4;
			var nDownHeadStart:Number = 2;
			var nLateralHeadStart:Number = 4;
			
			
			
			if (hhit == -1 || Math.abs(this.velocity.x) < iSpeed * nLateralBounceSpeed)
			{
				var r:int = Util.Random(0, 1);
				
				nLateralBounceSpeed = 0.08;
				
				if (r == 0)
				{
					this.velocity.x = iSpeed * nLateralBounceSpeed; // bounce right
				}
				else
				{
					this.facing = LEFT;
					this.velocity.x = -iSpeed * nLateralBounceSpeed; // bounce left
				}
					
				
			}
		
			if (hhit == Content.RIGHT)
			{
				this.x -= nLateralHeadStart;
				this.velocity.x = -iSpeed * nLateralBounceSpeed; // bounce left
				
				if (vhit == -1 || vhit == Content.DOWN)
				{
					this.y -= nUpHeadStart;
					this.velocity.y = -iSpeed * nUpBounceSpeed;
				}
				else
				{
					this.y += nDownHeadStart;
					this.velocity.y = iSpeed * nDownBounceSpeed;
				}
			}
			else if(hhit == Content.LEFT)
			{
				this.x += nLateralHeadStart;
				this.velocity.x = iSpeed * nLateralBounceSpeed; // bounce right
				
				if (vhit == -1 || vhit == Content.DOWN)
				{
					this.y -= nUpHeadStart;
					this.velocity.y = -iSpeed * nUpBounceSpeed;
				}
				else
				{
					this.y += nDownHeadStart;
					this.velocity.y = iSpeed * nDownBounceSpeed;
				}
			}
			else if (vhit == Content.UP)
			{
				this.y += nDownHeadStart;
				this.velocity.y = iSpeed * nDownBounceSpeed;
			}
			else if (vhit == Content.DOWN)
			{
				this.y -= nUpHeadStart;
				this.velocity.y = -iSpeed * nUpBounceSpeed;
			}
			
			if (velocity.x > 0)
				this.facing = LEFT;
			else if (velocity.x < 0)
				this.facing = RIGHT;
			
			trace("vel = " + velocity.x.toString() + " , " + velocity.y.toString());
			
			iBounceLife = Content.iArrowBounceLife;
			bBouncing = true;
			
			acceleration.y = Content.nGrav * 3;			//gravity

			// Boxy thickness
			
			width = 14;
			height = 14;
			offset.x = 8;
			offset.y = 8;
			
			if (Math.abs(this.velocity.x) > Math.abs(this.velocity.y))
			{
				iDir = 0;
			}
			else
			{
				if (this.velocity.y > 0)
					iDir = 1;
				else
					iDir = -1;
			}
			

			
			SetEffective();
		}
		
		override public function update():void
		{
			var overtile:int = -1;
			var fluid:int = -1;
			
			if (parent != null && parent.level != null)
			{
				var xcheck:int = int(this.x) / 30;
				var ycheck:int = int(this.y) / 30;
				
				overtile = parent.level.getTile(xcheck, ycheck) % Content.iFrontSheetWidth;			
	
				if (overtile == 4 || overtile == 5)
					fluid = 2;
				else if (overtile == 6 || overtile == 7)
					fluid = 1;
				else
					fluid = 0;
	
			}
			
			if (Util.Random(0, 3) == 0 && (velocity.x != 0 || velocity.y != 0)) // spawn a whoosh
			{
				if (fluid == 0)
				{/*
					if(velocity.x < 0)
						parent.groupParticles.add(new Whoosh(parent, this.x - offset.x, this.y - offset.y, 180, 150));
					else if(velocity.x > 0)
						parent.groupParticles.add(new Whoosh(parent, this.x - offset.x, this.y - offset.y, 0, 150));*/
				}
				else
				{
					var xx:Number = this.x + Util.Random( -3, 3);
					var yy:Number = this.y - 3;
					var nDir:Number = 270;
					var nSpeed:Number = 10;
					
					if (velocity.x < 0)
					{
						nDir = 250;
					}
					else if (velocity.x > 0)
					{
						nDir = 310;
					}
					else
					{
						yy = this.y + Util.Random( -3, 3);
					}
					
					var toadd:Bub = null;
					
					toadd = Util.GetInvisibleSpriteByName(parent.arrayParticles, "Bub") as Bub;
					
					if (toadd == null)
					{
						toadd = new Bub(this.parent, xx, yy, nDir, nSpeed);
						parent.arrayParticles.push(toadd);
						parent.groupParticles.add(toadd);
					}
					else
					{
						toadd.Reuse(xx, yy, nDir, nSpeed);
					}
				}
			}
		}
	}
}