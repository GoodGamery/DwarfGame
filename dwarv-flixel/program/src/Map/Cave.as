package Map 
{
	import flash.geom.ColorTransform;
	import flash.geom.Rectangle;
	import org.flixel.*;
	import flash.geom.Point;
	
	public class Cave 
	{
		public var exits:DirectionSet = new DirectionSet();
		public var border:DirectionSet = new DirectionSet();
		public var strRegionName:String;
		public var mynexus:Point = new Point(0, 0);
		public var style:int = -1;
		public var coords:Point = new Point(0, 0);
		public var visited:Boolean = false;
		public var sensed:Boolean = false;
		public var levelColor:ColorTransform;
		public var colorpieces:FlxSprite;
		public var purepieces:FlxSprite;
		public var sprite:FlxSprite;
		public var flag:int = Content.BLANK;
		
		public function Cave(x:int = 0, y:int = 0)
		{
			coords.x = x;
			coords.y = y;
			SetMetaRole();
			CalculateColor();
			
			colorpieces = new FlxSprite(100 + (x * 12), 100 + (y * 12));
			colorpieces.loadGraphic(Content.cMapCaves, false, false, 96, 48, true);
			colorpieces._pixels.colorTransform(new Rectangle(0, 0, 96, 48), levelColor);
			colorpieces.dirty = true;
			
			purepieces = new FlxSprite(100 + (x * 12), 100 + (y * 12));
			purepieces.loadGraphic(Content.cMapCaves, false, false, 96, 48, true);
			purepieces.dirty = true;
			
		}
		
		public function CreateSprite(centerpixelx:int, centerpixely:int, centercavex:int, centercavey:int):void
		{
			if (sensed == false)
			{
				if (sprite != null)
					sprite.visible = false;
			}
			else
			{			
				sprite = new FlxSprite(centerpixelx + ((coords.x - centercavex) * 12), centerpixely + ((coords.y - centercavey) * 12));
				sprite.makeGraphic(12, 12, 0x00000000, true);
				sprite.scrollFactor.x = 0;
				sprite.scrollFactor.y = 0;
			
				sprite.visible = true;
				
				// Upper-left corner
				if (!border.north)
				{
					if(!border.west)
						sprite._pixels.copyPixels(colorpieces._pixels, new Rectangle(0 + (0 * 12), 0, 12, 12), new Point(0, 0), null, null, true);
					else
						sprite._pixels.copyPixels(colorpieces._pixels, new Rectangle(0 + (1 * 12), 0, 12, 12), new Point(0, 0), null, null, true);
				}
				else
				{
					if(border.west)
						sprite._pixels.copyPixels(colorpieces._pixels, new Rectangle(0 + (0 * 12), 12, 12, 12), new Point(0, 0), null, null, true);
					else
						sprite._pixels.copyPixels(colorpieces._pixels, new Rectangle(0 + (1 * 12), 12, 12, 12), new Point(0, 0), null, null, true);
				}
				
				// Upper-right corner
				if (!border.east)
				{
					if(!border.north)
						sprite._pixels.copyPixels(colorpieces._pixels, new Rectangle(0 + (2 * 12), 0, 12, 12), new Point(0, 0), null, null, true);
					else
						sprite._pixels.copyPixels(colorpieces._pixels, new Rectangle(0 + (3 * 12), 0, 12, 12), new Point(0, 0), null, null, true);
				}
				else
				{
					if(border.north)
						sprite._pixels.copyPixels(colorpieces._pixels, new Rectangle(0 + (2 * 12), 12, 12, 12), new Point(0, 0), null, null, true);
					else
						sprite._pixels.copyPixels(colorpieces._pixels, new Rectangle(0 + (3 * 12), 12, 12, 12), new Point(0, 0), null, null, true);
				}
				
				// Lower-right corner
				if (!border.south)
				{
					if(!border.east)
						sprite._pixels.copyPixels(colorpieces._pixels, new Rectangle(0 + (4 * 12), 0, 12, 12), new Point(0, 0), null, null, true);
					else
						sprite._pixels.copyPixels(colorpieces._pixels, new Rectangle(0 + (5 * 12), 0, 12, 12), new Point(0, 0), null, null, true);
				}
				else
				{
					if(border.east)
						sprite._pixels.copyPixels(colorpieces._pixels, new Rectangle(0 + (4 * 12), 12, 12, 12), new Point(0, 0), null, null, true);
					else
						sprite._pixels.copyPixels(colorpieces._pixels, new Rectangle(0 + (5 * 12), 12, 12, 12), new Point(0, 0), null, null, true);
				}
				
				// Lower-left corner
				if (!border.west)
				{
					if(!border.south)
						sprite._pixels.copyPixels(colorpieces._pixels, new Rectangle(0 + (6 * 12), 0, 12, 12), new Point(0, 0), null, null, true);
					else
						sprite._pixels.copyPixels(colorpieces._pixels, new Rectangle(0 + (7 * 12), 0, 12, 12), new Point(0, 0), null, null, true);
				}
				else
				{
					if(border.south)
						sprite._pixels.copyPixels(colorpieces._pixels, new Rectangle(0 + (6 * 12), 12, 12, 12), new Point(0, 0), null, null, true);
					else
						sprite._pixels.copyPixels(colorpieces._pixels, new Rectangle(0 + (7 * 12), 12, 12, 12), new Point(0, 0), null, null, true);
				}

				if (visited)
				{
					if (exits.north)
						sprite._pixels.copyPixels(colorpieces._pixels, new Rectangle(0 + (1 * 12), 24, 12, 12), new Point(0, 0), null, null, true);
						
					if (exits.east)
						sprite._pixels.copyPixels(colorpieces._pixels, new Rectangle(0 + (2 * 12), 24, 12, 12), new Point(0, 0), null, null, true);
						
					if (exits.south)
						sprite._pixels.copyPixels(colorpieces._pixels, new Rectangle(0 + (3 * 12), 24, 12, 12), new Point(0, 0), null, null, true);
						
					if (exits.west)
						sprite._pixels.copyPixels(colorpieces._pixels, new Rectangle(0 + (4 * 12), 24, 12, 12), new Point(0, 0), null, null, true);
						
					if (exits.north)
						sprite._pixels.copyPixels(purepieces._pixels, new Rectangle(0 + (1 * 12), 36, 12, 12), new Point(0, 0), null, null, true);
						
					if (exits.east)
						sprite._pixels.copyPixels(purepieces._pixels, new Rectangle(0 + (2 * 12), 36, 12, 12), new Point(0, 0), null, null, true);
						
					if (exits.south)
						sprite._pixels.copyPixels(purepieces._pixels, new Rectangle(0 + (3 * 12), 36, 12, 12), new Point(0, 0), null, null, true);
						
					if (exits.west)
						sprite._pixels.copyPixels(purepieces._pixels, new Rectangle(0 + (4 * 12), 36, 12, 12), new Point(0, 0), null, null, true);
						
					if (flag == Content.INTEREST)
					{
						sprite._pixels.copyPixels(purepieces._pixels, new Rectangle(0 + (5 * 12), 24, 12, 12), new Point(0, 0), null, null, true);
					}
					else if (flag == Content.CITY)
					{
						sprite._pixels.copyPixels(purepieces._pixels, new Rectangle(0 + (6 * 12), 24, 12, 12), new Point(0, 0), null, null, true);
					}
				}
				
				sprite.dirty = true;
			}
		}
		
		public function BecomeCopyOf(source:Cave):void
		{
			this.exits.north = source.exits.north;
			this.exits.south = source.exits.south;
			this.exits.east = source.exits.east;
			this.exits.west = source.exits.west;
			
			this.border.north = source.border.north;
			this.border.south = source.border.south;
			this.border.east = source.border.east;
			this.border.west = source.border.west;
			
			this.strRegionName = source.strRegionName;
			this.mynexus = source.mynexus;
			this.style = source.style;
			this.coords = source.coords;
			
			this.visited = source.visited;
			this.sensed = source.sensed;
			this.levelColor = source.levelColor;
		}
		
		public function GetDirectionsForCoords(x:int, y:int):DirectionSet
        {
            var r:Rndm = new Rndm(Util.Seed(x, y));
			var dirs:DirectionSet = new DirectionSet();
			
			while (
				(dirs.north == false && dirs.south == false && dirs.west == false && dirs.east == false)
				||
				(dirs.north == true && dirs.south == true && dirs.west == true && dirs.east == true)
				)
			{
				dirs.north = false;
				dirs.south = false;
				dirs.west = false;
				dirs.east = false;
				
				if (r.integer(0, 100) < Content.nVChance * 100)
					dirs.north = true;

				if (r.integer(0, 100) < Content.nVChance * 100)
					dirs.south = true;
				
				if (r.integer(0, 100) < Content.nHChance * 100)
					dirs.west = true;
				
				if (r.integer(0, 100) < Content.nHChance * 100)
					dirs.east = true;
			}

            return dirs;
        }
		
		public function NeighborlyDirections(x:int, y:int):DirectionSet
		{
			var dirs:DirectionSet = GetDirectionsForCoords(x, y);
			
			if (GetDirectionsForCoords(x, y - 1).south == true)
				dirs.north = true;
			
			if (GetDirectionsForCoords(x, y + 1).north == true)
				dirs.south = true;
			
			if (GetDirectionsForCoords(x - 1, y).east == true)
				dirs.west = true;
			
			if (GetDirectionsForCoords(x + 1, y).west == true)
				dirs.east = true;
				
			
			
			return dirs;
		}
		
		public function SetMetaRole():void
		{
			
			var x:int = coords.x;
			var y:int = coords.y;
			
			if (
				//(x == -5 && y == -6) ||
				(x == -4 && y == -6) ||
				(x == -4 && y == -5) ||
				(x == -5 && y == -5))
			{
				var g:int = 2;
			}
			
			var vacinity:Array = new Array();
			
			for (var cx:int = x - 1; cx <= x + 1; cx++)
			{
				vacinity.push(new Array());
				
				for (var cy:int = y - 1; cy <= y + 1; cy++)
				{
					(vacinity[vacinity.length - 1] as Array).push(NeighborlyDirections(cx, cy));
				}
			}
			
			exits.north = (vacinity[1][1] as DirectionSet).north;
			exits.east = (vacinity[1][1] as DirectionSet).east;
			exits.south = (vacinity[1][1] as DirectionSet).south;
			exits.west = (vacinity[1][1] as DirectionSet).west;
			
			/* _ _ _ _ _
			  |    0    |
			  |         |
			  |3       1|   <- straws
			  |         |
			  |_ _ 2 _ _|
			*/
			
			var straws:Rndm;
			var straw:int;
			var seed:int;
			
			if ( // Loop in upper-left
				(vacinity[0][0] as DirectionSet).east &&
				(vacinity[1][0] as DirectionSet).south &&
				(vacinity[1][1] as DirectionSet).west &&
				(vacinity[0][1] as DirectionSet).north)
				{
					// Draw straws
					
					seed = Util.QuadSeed(
						x - 1, y - 1,
						x - 0, y - 1,
						x - 0, y - 0,
						x - 1, y - 0); 
					straws = new Rndm(seed);

					straw = straws.integer(0, 3);
					
					if (straw == 1)
					{
						exits.north = false;
					}
					else if (straw == 2)
					{
						exits.west = false;
					}
				}
				
			if ( // Loop in upper-right
				(vacinity[1][0] as DirectionSet).east &&
				(vacinity[2][0] as DirectionSet).south &&
				(vacinity[2][1] as DirectionSet).west &&
				(vacinity[1][1] as DirectionSet).north)
				{
					// Draw straws
					
					seed = Util.QuadSeed(
						x - 0, y - 1,
						x + 1, y - 1,
						x + 1, y - 0,
						x - 0, y - 0);
					straws = new Rndm(seed);

					straw = straws.integer(0, 3);
					
					if (straw == 3)
					{
						exits.north = false;
					}
					else if (straw == 2)
					{
						exits.east = false;
					}
				}
				
			if ( // Loop in lower-right
				(vacinity[1][1] as DirectionSet).east &&
				(vacinity[2][1] as DirectionSet).south &&
				(vacinity[2][2] as DirectionSet).west &&
				(vacinity[1][2] as DirectionSet).north)
				{
					// Draw straws
					
					seed = Util.QuadSeed(
						x - 0, y - 0,
						x + 1, y - 0,
						x + 1, y + 1,
						x - 0, y + 1);
					straws = new Rndm(seed);

					straw = straws.integer(0, 3);
					
					if (straw == 0)
					{
						exits.east = false;
					}
					else if (straw == 3)
					{
						exits.south = false;
					}
				}
				
			if ( // Loop in lower-left
				(vacinity[0][1] as DirectionSet).east &&
				(vacinity[1][1] as DirectionSet).south &&
				(vacinity[1][2] as DirectionSet).west &&
				(vacinity[0][2] as DirectionSet).north)
				{
					// Draw straws
					
					seed = Util.QuadSeed(
						x - 1, y - 0,
						x - 0, y - 0,
						x - 0, y + 1,
						x - 1, y + 1)
					straws = new Rndm(seed);

					straw = straws.integer(0, 3);
					
					if (straw == 0)
					{
						exits.west = false;
					}
					else if (straw == 1)
					{
						exits.south = false;
					}
				}
			
			var totalexits:int = 0;
			
			if (exits.north) totalexits++;
			
			if (exits.east) totalexits++;
			
			if (exits.south) totalexits++;
			
			if (exits.west) totalexits++;
			
			if (totalexits == 1)
				flag = Content.CITY;
			
			style = -1;
			
			var r:Rndm = new Rndm(Util.Seed(x, y));
			var nexustest:int = r.integer(0, 100);
						
			//trace("nexus threshold = " + (Content.nNexusChance * 100).toString() + " Roll = " + nexustest.toString());
			
			if (nexustest < Content.nNexusChance * 100)
			{
				do // limit deadwater to Shar Surface and below
				{
					style = r.integer(0, Content.numbiomes);
				} while (style == 4 && y < 10);
					
				mynexus.x = x;
				mynexus.y = y;
			}
				
			//trace("Am I a nexus? " + nexustest.toString());

			if (style == -1)
			{
				var nexi:Array = new Array();
				
				for (var yy:int = y - 10; yy < y + 10; yy++)
				{
					for (var xx:int = x - 10; xx < x + 10; xx++)
					{
						var rr:Rndm = new Rndm(Util.Seed(xx, yy));
						nexustest = rr.integer(0, 100);
						
						if (nexustest < Content.nNexusChance * 100)
						{
							var biomestyle:int = 0;
							
							do // limit deadwater to Shar Surface and below
							{
								biomestyle = rr.integer(0, Content.numbiomes);
							} while (biomestyle == 4 && yy < 10);
							
							//biomestyle = 6; //hack
							
							nexi.push(new Nexus(xx, yy, biomestyle, Util.Distance(x, y, xx, yy)));
						}

					}
				}

				var c:int = -1;
				var dist:Number = 9999;

				for each(var n:Nexus in nexi)
				{						
					if (n.distance < dist)
					{
						style = n.style;
						dist = n.distance;
						mynexus.x = n.x;
						mynexus.y = n.y;
					}
				}
			}
			
			strRegionName = Util.MakeRegionName(Util.Seed(mynexus.x, mynexus.y), style);
			//trace("This is part of region: " + strRegionName);
		}
		
		public function CalculateColor():void
		{
			var ran:Rndm = new Rndm(Util.Seed(mynexus.x, mynexus.y));

			var testing:int = ran.integer(0, 10);
			testing = ran.integer(0, 10);
			testing = ran.integer(0, 10);
			testing = ran.integer(0, 10);
			testing = ran.integer(0, 10);
			testing = ran.integer(0, 10);
			testing = ran.integer(0, 10);
			testing = ran.integer(0, 10);
			testing = ran.integer(0, 10);
			testing = ran.integer(0, 10);
			
			var maxex:int = 10;
			
			for (var o:int = 0; o < (Content.biomes[style] as Biome).overlays.length; o++)
			{
				if (((Content.biomes[style] as Biome).overlays[o] as String) == "")
				{
					maxex = o;
				}
			}
			
			var whichone:int = ran.integertrace(0, maxex);

			var which:String = (Content.biomes[style] as Biome).overlays[whichone] as String;
			var mods:Array = which.split("|");
			
			var r:Number = Number(mods[0]);
			var g:Number = Number(mods[1]);
			var b:Number = Number(mods[2]);
			
			r = 1 + (r / 10);
			g = 1 + (g / 10);
			b = 1 + (b / 10);
			
			r *= (ran.integer(80, 120) / 100);
			g *= (ran.integer(80, 120) / 100);
			b *= (ran.integer(80, 120) / 100);

			levelColor = new ColorTransform(r, g, b, 1, 0, 0, 0);
			
		}
	}

}