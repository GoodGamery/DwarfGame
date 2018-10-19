package Tasks
{
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import org.flixel.*;
 
	public class SpriteTask extends Task
	{
		public var sprite:FlxSprite = null;
		public var sx:int = 0;
		public var sy:int = 0;
		public var tx:int = 0;
		public var ty:int = 0;
		public var fTypeX:Function;
		public var fTypeY:Function;
		public var bKill:Boolean;
		
		public function SpriteTask(name:String, dataobject:Object, seconds:Number, spr:FlxSprite, startx:int, starty:int, targetx:int, targety:int, xtype:Function, ytype:Function, kill:Boolean, callback:Function = null)
		{
			super(name, dataobject, seconds, callback);
			
			
			sprite = spr;
			
			sx = startx;
			sy = starty;
			tx = targetx;
			ty = targety;
			fTypeX = xtype;
			fTypeY = ytype;
			bKill = kill;
			
			sprite.x = sx;
			sprite.y = sy;
		}

		override public function Progress():Boolean
		{
			var done:Boolean = false;
			
			if (super.Progress())
			{
				sprite.x = tx;
				sprite.y = ty;
				done = true;
				
				if (bKill)
				{
					sprite.doomed = true;
				}
			}
			else
			{
				if(sx != tx)
					sprite.x = fTypeX(sx, tx, nProgress);
					
				if(sy != ty)
					sprite.y = fTypeY(sy, ty, nProgress);
					
				if (fTypeY == Util.ArcCurrent)
				{
					sprite.y = fTypeY(sy, sy - 24, nProgress);
				}
			}
			
			return done;
		}
		
	}
}