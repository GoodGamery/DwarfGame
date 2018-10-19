package Hud 
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author ...
	 */
	public class MapNode 
	{
		public var north:Boolean = false;
		public var south:Boolean = false;
		public var west:Boolean = false;
		public var east:Boolean = false;
		public var biome:int = 0;
		public var where:Point = new Point(0, 0);
		
		public function MapNode(place:Point, b:int, n:Boolean, s:Boolean, w:Boolean, e:Boolean) 
		{
			where = place;
			biome = b;
			north = n;
			south = s;
			west = w;
			east = e;
		}
		
	}

}