package Mon 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flixel.*;
	
	public class Signpost extends Talker 
	{
		
		public function Signpost(p:PlayState, name:String, X:Number, Y:Number) 
		{
			super(p, name, X, Y);

			sprFace = new FlxSprite();
			sprFace.loadGraphic(Content.cNPCOther, true, true, 60, 60, true);
			sprFace.addAnimation("s", [0], 16, true);
		    sprFace.scrollFactor.x = 0;
			sprFace.scrollFactor.y = 0;
			sprFace.play("s");
			
			bAcrophobic = false;
			bFriendly = true;
			bLevelCollision = false;
			bMonsterCollision = false;
			bOriginalLevelCollision = false;
			bOriginalMonsterCollision = false;
			
			loadGraphic(Content.cNPCStatic, true, true, 30, 30, true);
			addAnimation("s", [1], 16, true);
			play("s");
			
			//remVelocity.x = -30;
			
			width = 24;
			height = 30;
			offset.x = 3;
			offset.y = 0;
			
			facing = RIGHT;
		}
		
		
		override public function update():void
		{
			acceleration.y = 0;
			velocity.x = 0;
			velocity.y = 0;
			
			//super.update()
			return;
		
		}
	}

}