package org.flixel  
{
	import org.flixel.FlxGroup;
	import org.flixel.FlxSprite;
	
	public class FlxGroupXY extends FlxGroup 
	{
		private var _x:int = 0
		private var _y:int = 0
		
		public function set x(nx:int):void
		{
			var offset:int = nx - _x
			
			for each (var object:* in members) {
				object.x += offset
			}
			
			_x = nx
		}
		
		public function get x():int {return _x}
		
		public function set y(ny:int):void
		{
			var offset:int = ny - _y
			
			for each (var object:* in members) {
				object.y += offset
			}
			
			_y = ny
		}
		
		public function get y():int {return _y}
	}

}