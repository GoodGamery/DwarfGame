package Tasks
{
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import org.flixel.*;
 
	public class Task
	{
		public var nSpeed:Number = 1 / Content.iGameFramerate;
		public var nProgress:Number = 0;
		public var strName:String = "";
		public var data:Object = null;
		public var fCallback:Function = null;

		public function Task(name:String, dataobject:Object, seconds:Number, callback:Function = null)
		{
			strName = name;
			nSpeed = (1 / (Content.iGameFramerate * seconds));
			data = dataobject;
			fCallback = callback;
		}

		public function Progress():Boolean
		{
			nProgress += nSpeed;
			
			if (nProgress > 1)
			{
				nProgress = 1;
				
				if (fCallback != null)
					fCallback();
					
				return true;
			}
			
			return false;
		}
		
	}
}