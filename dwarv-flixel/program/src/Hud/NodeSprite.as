package Hud 
{
	import org.flixel.*;
	
	public class NodeSprite extends FlxSprite 
	{
		
		public function NodeSprite(X:Number, Y:Number) 
		{
			
			
			super(X, Y);
						
			loadGraphic(Content.cMapNodes, true, false, 12, 12);
			
			addAnimation("blank", [0], 1, true);
			addAnimation("face", [1], 1, true);
			addAnimation("h", [2], 1, true);
			addAnimation("v", [3], 1, true);
			
			for (var i:int = 4; i < Content.numbiomes + 4; i++)
			{
				addAnimation((i - 4).toString(), [i], 1, true);
			}
			
		}
		
		public function SetBiome(biome:int ):void
		{
			play(biome.toString());
		
		}
	}

}