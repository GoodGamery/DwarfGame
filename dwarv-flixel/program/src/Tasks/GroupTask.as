package Tasks
{
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import org.flixel.*;
 
	public class GroupTask extends Task
	{
		public var group:FlxGroupXY = null;
		public var sx:int = 0;
		public var sy:int = 0;
		public var tx:int = 0;
		public var ty:int = 0;
		public var fTypeX:Function;
		public var fTypeY:Function;
		public var bKill:Boolean;
		public function GroupTask(name:String, dataobject:Object, seconds:Number, grp:FlxGroupXY, startx:int, starty:int, targetx:int, targety:int, xtype:Function, ytype:Function, kill:Boolean, callback:Function = null)
		{
			super(name, dataobject, seconds);
			
			group = grp;

			sx = startx;
			sy = starty;
			tx = targetx;
			ty = targety;
			fTypeX = xtype;
			fTypeY = ytype;
			
			group.x = sx;
			group.y = sy;
		}

		override public function Progress():Boolean
		{
			var done:Boolean = false;
			
			if (super.Progress())
			{
				group.x = tx;
				group.y = ty;
				done = true;
				
				if (bKill)
				{
					group.doomed = true;
				}
				
				if (fCallback != null)
					fCallback();
			}
			else
			{			
				if(sx != tx)
					group.x = fTypeX(sx, tx, nProgress);
					
				if(sy != ty)
					group.y = fTypeY(sy, ty, nProgress);
					
				if (fTypeY == Util.ArcCurrent)
				{
					group.y = fTypeY(sy, sy - 24, nProgress);
				}
			}
			
			return done;
		}
		
	}
}