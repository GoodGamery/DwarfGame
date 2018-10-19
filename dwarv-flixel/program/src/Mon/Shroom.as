package Mon 
{
	import flash.geom.ColorTransform;
	import org.flixel.*;
	
	
	
	public class Shroom extends Monster 
	{
		public var nBopHeight:Number = 0;
		
		public function Shroom(p:PlayState, X:Number, Y:Number, colTrans:ColorTransform = null, speedmod:Number = 1) 
		{
			
			
			super(p, "Shroom", X, Y, colTrans, speedmod);
			
			addAnimation("d", [8, 9, 10, 11], 6, true);
			play("d");
			
			bAcrophobic = true;
			
			//remVelocity.x = -30;
			
			width = 12;
			height = 22;
			offset.x = 39;
			offset.y = 38;
			
			rectVulnerable.x = -5;
			rectVulnerable.width = 22;
			
			//boundGraphic(90, 90, 8, 8);
			
			nBopHeight = 0.4;
		}
		
		override public function update():void
		{
			super.update();
		
		}
		
		override public function Struck(hhit:int, vhit:int, damage:int):void
		{
			super.Struck(hhit, vhit, Content.stats.nDamageDealt);
			
			velocity.y = -Content.nGrav * nBopHeight;
		}
	}

}