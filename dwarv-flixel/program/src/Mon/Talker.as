package Mon 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flixel.*;
	
	public class Talker extends Monster 
	{
		public var sprFace:FlxSprite = null;
		
		public var strDialogue:String = "This is some sample dialogue.";
		public var arrayScript:Array = new Array();
		
		
		
		public function Talker(p:PlayState, name:String, X:Number, Y:Number) 
		{
			super(p, name, X, Y);
			
		}
		
		override public function update():void
		{
			super.update();
		
		}
	}

}