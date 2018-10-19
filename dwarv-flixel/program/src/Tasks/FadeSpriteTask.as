package Tasks
{
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;
	import flash.display.StageQuality;
	import org.flixel.*;
	import org.flixel.FlxGroupXY;
	import spark.layouts.BasicLayout;
	
	public class FadeSpriteTask extends SpriteTask 
	{
		public function FadeSpriteTask(name:String, dataobject:Object, seconds:Number, spr:FlxSprite, startx:int, starty:int, targetx:int, targety:int, xtype:Function, ytype:Function, kill:Boolean, callback:Function = null)
		{
			super(name, dataobject, seconds, spr, startx, starty, targetx, targety, xtype, ytype, kill, callback);
		}
		
		override public function Progress():Boolean
		{
			sprite.alpha -= nSpeed;
			//sprite.dirty = true;
			
			return super.Progress();
		}
	}

}