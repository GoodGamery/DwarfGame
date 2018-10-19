package
{
	import flash.geom.Point;
	import org.flixel.*;
	import Hud.Grunt;
	import org.flixel.plugin.photonstorm.FlxColor;

	public class Collectible extends FlxSprite
	{
		public var parent:PlayState = null;
		public var name:String = "";
		public var col:uint;
		
		public function Collectible(p:PlayState, gem:int, X:Number, Y:Number)
		{
			
				
			if (gem == 0)
			{
				name = "+1 Pip";
				col = 0xFFFF82C0;
			}
			else if (gem == 1)
			{
				name = "+3 Pips";
				col = 0xFFFF82C0;
			}
			else if (gem == 2)
			{
				name = "+1 Reod";
				col = 0xFF8080FF;
			}
			else if (gem == 3)
			{
				name = "+3 Reods";
				col = 0xFF8080FF;
			}
			else if (gem == 4)
			{
				name = "+1 Lytrat";
				col = 0xFFFFCB1B;
			}
			else if (gem == 5)
			{
				name = "+3 Lytrats";
				col = 0xFFFFCB1B;
			}
			
			gem *= 3;
			
			super(X, Y);
			
			parent = p;
			
			loadGraphic(Content.cGems, true, true, 30, 30);
			
			width = 10;
			height = 10;
			offset.x = 10;
			offset.y = 10;
			
			addAnimation("d", [0 + gem, 0 + gem, 0 + gem, 0 + gem, 0 + gem, 0 + gem, 0 + gem,0  + gem,0  + gem,0  + gem,0 + gem, 1 + gem, 2 + gem], 16, true);
			
			play("d");
		}
		
		override public function update():void
		{
			if (Util.Distance(parent.hero.x + (parent.hero.width / 2), parent.hero.y + (parent.hero.height / 2),
								this.x + 5, this.y + 5) < Content.nCollectDistance)
			{
				//trace("Collected!");
				this.doomed = true;
			
				parent.arrayGrunts.push(new Grunt(this.x + (this.width / 2), this.y + (this.height / 2) - 20, name, col, 60));
				parent.groupGrunts.add(parent.arrayGrunts[parent.arrayGrunts.length - 1] as Grunt);
			}
		}
	}
}