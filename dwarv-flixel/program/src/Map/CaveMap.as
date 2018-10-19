package Map 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import Hud.HUD;
	import org.flixel.FlxSprite;
	
	public class CaveMap 
	{
		public var arrayCaveMap:Array;
		
		public var upperleft:Point = new Point(0, 0);
		public var size:Point = new Point(0, 0);
		public var circlemask:FlxSprite;
		public var youarehere:FlxSprite;
		public var cavenew:FlxSprite;
		
		public function CaveMap(cx:int, cy:int, radius:int) 
		{
			circlemask = new FlxSprite(0, 0);	
			circlemask.loadGraphic(Content.cCircleMask, false, false, 268, 268, true);
			
			youarehere = new FlxSprite(0, 0);	
			youarehere.loadGraphic(Content.cYouAreHere, false, false, 12, 12, true);
			
			cavenew = new FlxSprite(0, 0);	
			cavenew.loadGraphic(Content.cCaveNew, false, false, 4, 4, true);
			
			upperleft.x = cx - radius;
			upperleft.y = cy - radius;
			size.x = (radius * 2) + 1;
			size.y = (radius * 2) + 1;
			
			arrayCaveMap = new Array();
			
			for (var x:int = cx - radius; x <= cx + radius; x++)
			{
				arrayCaveMap.push(new Array());
				
				for (var y:int = cy - radius; y <= cy + radius; y++)
				{
					(arrayCaveMap[arrayCaveMap.length - 1] as Array).push(new Cave(x, y));
				}
			}
			
			
		}
		
		public function UpdateSprites(centerpixelx:int, centerpixely:int, centercavex:int, centercavey:int, radius:int):void
		{
			for (var x:int = 0; x < size.x; x++)
			{
				for (var y:int = 0; y < size.y; y++)
				{
					if (arrayCaveMap[x][y] != null)
					{
						(arrayCaveMap[x][y] as Cave).CreateSprite(centerpixelx, centerpixely, centercavex, centercavey);
						
						if ((arrayCaveMap[x][y] as Cave).sprite != null)
						{
							if (x + upperleft.x < centercavex - radius ||
								x + upperleft.x > centercavex + radius ||
								y + upperleft.y < centercavey - radius ||
								y + upperleft.y > centercavey + radius)
								{
									(arrayCaveMap[x][y] as Cave).sprite.visible = false;
								}
								else
									(arrayCaveMap[x][y] as Cave).sprite.visible = true;
						}
					}
				}
			}
		}
		
		public function AddSpritesToHUD(canvas:FlxSprite, centerx:int, centery:int, offsetx:int, offsety:int, positionx:int, positiony:int, cropx:int, cropy:int, mask:Boolean):void
		{
			canvas._pixels.fillRect(new Rectangle(0, 0, canvas._pixels.width, canvas._pixels.height), 0xFF5D5D5D);
			
			for (var xx:int = upperleft.x; xx < upperleft.x + size.x; xx++)
			{
				for (var yy:int = upperleft.y; yy < upperleft.y + size.y; yy++)
				{
					//hud.cavepieces.add(Content.stats.cavemap.GetCave(xx, yy).sprite);
					
					var cavesprite:FlxSprite = Content.stats.cavemap.GetCave(xx, yy).sprite;
					
					if (cavesprite != null)
					{
						canvas._pixels.copyPixels(cavesprite._pixels, 
							new Rectangle(0, 0,
								cavesprite._pixels.width, cavesprite._pixels.height),
								new Point(((xx - centerx) * 12) + offsetx, ((yy - centery) * 12) + offsety),
								null,
								null,
								true);
								
						if (xx == centerx && yy == centery)
						{
							canvas._pixels.copyPixels(youarehere._pixels, 
								new Rectangle(0, 0,
									12, 12),
									new Point(((xx - centerx) * 12) + offsetx, ((yy - centery) * 12) + offsety),
									null,
									null,
									true);
						}
					}
				}
			}
			
			for (xx = upperleft.x; xx < upperleft.x + size.x; xx++)
			{
				for (yy = upperleft.y; yy < upperleft.y + size.y; yy++)
				{
					if (Content.stats.cavemap.GetCave(xx, yy).visited)
					{
					
						if (yy == upperleft.y ||
							(Content.stats.cavemap.GetCave(xx, yy).exits.north == true && Content.stats.cavemap.GetCave(xx, yy - 1).visited == false)
							)
							{
								canvas._pixels.copyPixels(cavenew._pixels, 
								new Rectangle(0, 0,
									4, 4),
									new Point(((xx - centerx) * 12) + 6 - 2 + offsetx, ((yy - centery) * 12) + 0 - 3 + offsety),
									null,
									null,
									true);
							}
						
						if (xx == upperleft.x ||
							(Content.stats.cavemap.GetCave(xx, yy).exits.west == true && Content.stats.cavemap.GetCave(xx - 1, yy).visited == false)
							)
							{
								canvas._pixels.copyPixels(cavenew._pixels, 
								new Rectangle(0, 0,
									4, 4),
									new Point(((xx - centerx) * 12) + 0 - 3 + offsetx, ((yy - centery) * 12) + 6 - 2 + offsety),
									null,
									null,
									true);
								
							}
							
						if (yy == upperleft.y + size.y - 1 ||
							(Content.stats.cavemap.GetCave(xx, yy).exits.south == true && Content.stats.cavemap.GetCave(xx, yy + 1).visited == false)
							)
							{
								canvas._pixels.copyPixels(cavenew._pixels, 
								new Rectangle(0, 0,
									4, 4),
									new Point(((xx - centerx) * 12) + 6 - 2 + offsetx, ((yy - centery) * 12) + 12 - 1 + offsety),
									null,
									null,
									true);
							}
							
						if (xx == upperleft.x + size.x - 1 ||
							(Content.stats.cavemap.GetCave(xx, yy).exits.east == true && Content.stats.cavemap.GetCave(xx + 1, yy).visited == false)
							)
							{
								canvas._pixels.copyPixels(cavenew._pixels, 
								new Rectangle(0, 0,
									4, 4),
									new Point(((xx - centerx) * 12) + 12 - 1 + offsetx, ((yy - centery) * 12) + 6 - 2 + offsety),
									null,
									null,
									true);
							}
					}
				}
			}
			
			
			
			canvas.dirty = true;
			
			canvas.x = positionx - ((268 - cropx) / 2),
			canvas.y = positiony - ((268 - cropy) / 2)
			
			if (!mask)
			{
				for (xx = 0; xx < 268; xx++)
				{
					for (yy = 0; yy < 268; yy++)
					{
						if (xx <= ((268 - cropx) / 2) ||
							xx >= 268 - ((268 - cropx) / 2) ||
							yy <= ((268 - cropy) / 2) ||
							yy >= 268 - ((268 - cropy) / 2))
							{
								canvas._pixels.setPixel32(xx, yy, 0x00000000);
							}
					}
				}
			}
			else
			{
				canvas._pixels.copyPixels(circlemask._pixels, 
								new Rectangle(0, 0,
								268, 268),
								new Point(0, 0),
								null,
								null,
								true);
								
				for (xx = 0; xx < 268; xx++)
				{
					for (yy = 0; yy < 268; yy++)
					{
						if (canvas._pixels.getPixel32(xx, yy) == 0xFFFF00FF)
						{
							canvas._pixels.setPixel32(xx, yy, 0x00000000);
						}
					}
				}
			}
		}
		
		public function RefreshBorders():void
		{
			for (var x:int = 0; x < size.x; x++)
			{
				for (var y:int = 0; y < size.y; y++)
				{
					
					var xworld:int = x + upperleft.x;
					var yworld:int = y + upperleft.y;
					
					
					
					if (xworld == 0 && yworld == 4)
					{
						var i:int = 2;
					}
					
					var n:String = GetCaveRegion(xworld, yworld - 1);
					var e:String = GetCaveRegion(xworld + 1, yworld);
					var s:String = GetCaveRegion(xworld, yworld + 1);
					var w:String = GetCaveRegion(xworld - 1, yworld);
					
					var c:String = GetCaveRegion(xworld, yworld);
					
					if (c != n) 
						(arrayCaveMap[x][y] as Cave).border.north = true;
					else
						(arrayCaveMap[x][y] as Cave).border.north = false;
						
					if (c != e) 
						(arrayCaveMap[x][y] as Cave).border.east = true;
					else
						(arrayCaveMap[x][y] as Cave).border.east = false;
						
					if (c != s) 
						(arrayCaveMap[x][y] as Cave).border.south = true;
					else
						(arrayCaveMap[x][y] as Cave).border.south = false;
						
					if (c != w) 
						(arrayCaveMap[x][y] as Cave).border.west = true;
					else
						(arrayCaveMap[x][y] as Cave).border.west = false;
				}
			}
		}
		
		public function FillRegionSense(x:int, y:int):void
		{
			var orig:String = GetCaveRegion(x, y);
			
			var checkers:Array = new Array();
            checkers.push(new Point(x, y));

            while (checkers.length > 0)
            {
				var oldcheckers:Array = new Array();

				for each (var pt:Point in checkers)
				{
					GetCave(pt.x, pt.y).sensed = true;
					
					oldcheckers.push(new Point());
					oldcheckers[oldcheckers.length - 1] = pt;
				}
				
				var i:int = 0;
				
                for (i = 0; i < oldcheckers.length; i++)
                {
                    var tocheck:Point = oldcheckers[i] as Point;
							
                    //if (tocheck.y > upperleft.y + 1)
                    //{
                        //if (GetCave(tocheck.x, tocheck.y).exits.north)
						//{
							AddCave(tocheck.x, tocheck.y - 1);
							
							if (GetCave(tocheck.x, tocheck.y - 1).strRegionName == orig &&
								GetCave(tocheck.x, tocheck.y - 1).sensed == false)
							{
								checkers.push(new Point(tocheck.x, tocheck.y - 1));
							}                            
                        //}
                    //}

                    //if (tocheck.y < upperleft.y + size.y - 1)
                    //{
                        //if (GetCave(tocheck.x, tocheck.y).exits.south)
						//{
							AddCave(tocheck.x, tocheck.y + 1);
							
							if (GetCave(tocheck.x, tocheck.y + 1).strRegionName == orig &&
								GetCave(tocheck.x, tocheck.y + 1).sensed == false)
							{
								checkers.push(new Point(tocheck.x, tocheck.y + 1));
							}                            
                        //}
                    //}

                    //if (tocheck.x > upperleft.x + 1)
                    //{
                        //if (GetCave(tocheck.x, tocheck.y).exits.west)
						//{
							AddCave(tocheck.x - 1, tocheck.y);
							
							if (GetCave(tocheck.x - 1, tocheck.y).strRegionName == orig &&
								GetCave(tocheck.x - 1, tocheck.y).sensed == false)
							{
								checkers.push(new Point(tocheck.x - 1, tocheck.y));
							}                            
                        //}
                    //}

                    //if (tocheck.x < upperleft.x + size.x - 1)
                    //{
                        //if (GetCave(tocheck.x, tocheck.y).exits.east)
						//{
							AddCave(tocheck.x + 1, tocheck.y);
							
							if (GetCave(tocheck.x + 1, tocheck.y).strRegionName == orig &&
								GetCave(tocheck.x + 1, tocheck.y).sensed == false)
							{
								checkers.push(new Point(tocheck.x + 1, tocheck.y));
							}                            
                        //}
                    //}
                }

                for (i = 0; i < oldcheckers.length; i++)
                {
                    checkers.splice(0, 1);
                }
            }

			return;
		}
		
		public function GetCave(xget:int, yget:int):Cave
		{
			xget -= upperleft.x;
			yget -= upperleft.y;
			
			if (xget < 0 || xget >= size.x || yget < 0 || yget >= size.y)
			{
				return null;
			}
			
			return arrayCaveMap[xget][yget] as Cave;
		}
		
		public function GetCaveRegion(xget:int, yget:int):String
		{
			xget -= upperleft.x;
			yget -= upperleft.y;
			
			if (xget < 0 || xget >= size.x || yget < 0 || yget >= size.y)
			{
				return "";
			}
			
			return (arrayCaveMap[xget][yget] as Cave).strRegionName;
		}
		
		public function ExploreCave(xadd:int, yadd:int):void
		{
			AddCave(xadd, yadd);
			GetCave(xadd, yadd).visited = true;
			GetCave(xadd, yadd).sensed = true;
			FillRegionSense(xadd, yadd);
		}
		
		public function AddCave(xadd:int, yadd:int):void
		{
			var xx:int = 0;
			var yy:int = 0;
			
			if (xadd < upperleft.x)
			{
				arrayCaveMap.unshift(new Array());
				
				for (yy = 0; yy < size.y; yy++)
				{
					if (yy == yadd - upperleft.y || true) // just do it
					{
						(arrayCaveMap[0] as Array).push(new Cave(xadd, yy + upperleft.y));
					}
					else
					{
						(arrayCaveMap[0] as Array).push(null);
					}
				}
				
				upperleft.x--;
				size.x++;
			}
			else if (xadd >= upperleft.x + size.x)
			{
				arrayCaveMap.push(new Array());
				
				for (yy = 0; yy < size.y; yy++)
				{
					if (yy == yadd - upperleft.y || true) // just do it
					{
						(arrayCaveMap[arrayCaveMap.length - 1] as Array).push(new Cave(xadd, yy + upperleft.y));
					}
					else
					{
						(arrayCaveMap[arrayCaveMap.length - 1] as Array).push(null);
					}
				}
				
				size.x++;
			}
			else if (yadd < upperleft.y)
			{				
				for (xx = 0; xx < size.x; xx++)
				{
					if (xx == xadd - upperleft.x || true) // just do it
					{
						(arrayCaveMap[xx] as Array).unshift(new Cave(xx + upperleft.x, yadd));
					}
					else
					{
						(arrayCaveMap[xx] as Array).unshift(null);
					}
				}
				
				upperleft.y--;
				size.y++;
			}
			else if (yadd >= upperleft.y + size.y)
			{				
				for (xx = 0; xx < size.x; xx++)
				{
					if (xx == xadd - upperleft.x || true) // just do it
					{
						(arrayCaveMap[xx] as Array).push(new Cave(xx + upperleft.x, yadd));
					}
					else
					{
						(arrayCaveMap[xx] as Array).push(null);
					}
				}
				
				size.y++;
			}
		}
	}
}