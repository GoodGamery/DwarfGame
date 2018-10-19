package
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	
	import org.flixel.*; //Allows you to refer to flixel objects in your code
	                        //600 or 672
	[SWF(width="1640", height="712", backgroundColor="#000000")] //Set the size and color of the Flash file
 
	public class HelloWorld extends FlxGame
	{
		public function HelloWorld()
		{
			super(Content.screenwidth + 400,Content.screenheight + 36,PlayState,2,60,60,true); //Create a new FlxGame object at 320x240 with 2x pixels, then load PlayState

			this.addEventListener(MouseEvent.MOUSE_DOWN, onMouseBegin);

		}

		public static var bPressed:Boolean = false;
		
		public function onMouseBegin(evt:MouseEvent):void
		{ 
			Util.bPressed = true;
			
			Util.startx = evt.localX; 
			Util.starty = evt.localY;
			
			Util.currentx = Util.startx;
			Util.currenty = Util.starty;

			this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			this.addEventListener(MouseEvent.MOUSE_UP, onMouseEnd);
		}
		
		public function onMouseMove(evt:MouseEvent):void
		{  
			Util.currentx = evt.localX;
			Util.currenty = evt.localY;
			
			(FlxG.state as PlayState).Move();
		}
		
		public function onMouseEnd(evt:MouseEvent):void
		{ 			
			Util.bPressed = false;
			
			Util.currentx = evt.localX;
			Util.currenty = evt.localY;
			
			if(Util.Distance(Util.startx, Util.starty, Util.currentx, Util.currenty) < Util.nFailThreshold)
			{
				(FlxG.state as PlayState).Tap(Util.startx, Util.starty);
			}
			
			(FlxG.state as PlayState).Up();
							
			this.removeEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			this.removeEventListener(MouseEvent.MOUSE_UP, onMouseEnd);
		}

	}
}
