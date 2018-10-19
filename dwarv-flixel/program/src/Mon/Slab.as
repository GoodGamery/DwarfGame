package Mon 
{
	import flash.geom.ColorTransform;
	import org.flixel.*;
	
	
	
	public class Slab extends Monster 
	{
		public var nBopHeight:Number = 0;
		
		public function Slab(p:PlayState, X:Number, Y:Number, colTrans:ColorTransform = null, speedmod:Number = 1) 
		{
			
			
			super(p, "Slab", X, Y, colTrans, speedmod);
			
			addAnimation("d", [12, 13], 4, true);
			play("d");
			
			bAcrophobic = true;
			
			//remVelocity.x = -30;
			
			width = 12;
			height = 52;
			offset.x = 39;
			offset.y = 8;
			
			rectVulnerable.x = -5;
			rectVulnerable.width = 22;
			rectVulnerable.height = 60;
			
			//boundGraphic(90, 90, 8, 8);
			
			this.health = 100;
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