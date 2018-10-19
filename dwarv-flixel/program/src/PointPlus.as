package  
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ...
	 */
	public class PointPlus extends Point 
	{
		public var obj:Object = null;
		
		public function PointPlus(x:Number, y:Number, o:Object) 
		{
			super(x, y);
			obj = o;
		}
		
	}

}