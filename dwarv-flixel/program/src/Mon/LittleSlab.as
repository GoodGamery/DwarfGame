package Mon 
{
	import flash.geom.ColorTransform;
	import org.flixel.*;
	
	
	
	public class LittleSlab extends Monster 
	{
		public var nBopHeight:Number = 0;
		
		public function LittleSlab(p:PlayState, X:Number, Y:Number, colTrans:ColorTransform = null, speedmod:Number = 1) 
		{
			
			
			super(p, "LittleSlab", X, Y, colTrans, speedmod);
			
			addAnimation("d", [14, 15], 4, true);
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
			
			this.health = 50;
		}
		
		override public function update():void
		{
			super.update();
		
		}
		
		override public function Struck(hhit:int, vhit:int, damage:int):void
		{
			super.Struck(hhit, vhit, Content.stats.nDamageDealt);
			
		}
	}

}