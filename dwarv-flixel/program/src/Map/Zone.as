package Map 
{
	import org.flixel.*;
	import flash.geom.Point;
	
	public class Zone 
	{
		public var width:int = 256;
        public var height:int = 256;
        public var map:Array = null;
		public var wallmap:Array = null;
		public var watermap:Array = null;
		public var waterlist:Array = null;
		public var intangmap:Array = null;
		public var accessiblemap:Array = null;
		public var roommap:Array = null;
		public var gemmap:Array = null;
		public var wallpapermap:Array = null;
		public var facademap:Array = null;
		public var chambermap:Array = null;
		public var spikemap:Array = null;
		public var wallqualmap:Array = null;
		public var exits:Array = null;
		public var rand:Rndm = null;

		public var upperleft:Point = new Point(-1, -1);
		public var lowerright:Point = new Point( -1, -1);
		
		public var description:Cave;
		
		
		
		
		public var backmap:Array = null;
		public var remplats:int = -1;
		public var points:Array = new Array();
		public var secrets:Array = new Array();
		public var intangs:Array = new Array();
		public var floorsecrets:Array = new Array();
		public var momentum:int = 20;
		public var brush:int = 1;
		
		
		
		
		public function CopyZone(z:Zone):void
		{
			map = Util.Clone(z.map);
			wallmap = Util.Clone(z.wallmap);
			watermap = Util.Clone(z.watermap);
			
			
			waterlist = new Array();
			for each(var wpt:PointPlus in z.waterlist)
				waterlist.push(new PointPlus(wpt.x, wpt.y, wpt.obj as String));
			
			
			intangmap = Util.Clone(z.intangmap);
			accessiblemap = Util.Clone(z.accessiblemap);
			roommap = Util.Clone(z.roommap);
			gemmap = Util.Clone(z.gemmap);
			wallpapermap = Util.Clone(z.wallpapermap);
			facademap = Util.Clone(z.facademap);
			chambermap = Util.Clone(z.chambermap);
			spikemap = Util.Clone(z.spikemap);
			wallqualmap = Util.Clone(z.wallqualmap);
			
			exits = new Array();
			for each(var ex:Exit in z.exits)
				exits.push(new Exit(ex.x, ex.y, ex.id));
				
			upperleft = z.upperleft;
			lowerright = z.lowerright;
			
			description = new Cave();
			description.BecomeCopyOf(z.description);
			
			secrets = new Array();
			for each(var pt:Point in z.secrets)
				secrets.push(new Point(pt.x, pt.y));
				
			intangs = new Array();
			for each(var ipt:Point in z.intangs)
				intangs.push(new Point(ipt.x, ipt.y));
				
			floorsecrets = new Array();
			for each(var fpt:Point in z.floorsecrets)
				floorsecrets.push(new Point(fpt.x, fpt.y));
			
			rand = new Rndm(Util.Seed(description.coords.x + 100, description.coords.y + 100));
		}

        public function Zone()
        {
			
		}
		
		public function InitZone(x:int, y:int):void
		{
			
			rand = new Rndm(Util.Seed(x, y));
			
			map = new Array();
			watermap = new Array();
			waterlist = new Array();
			intangmap = new Array();
			accessiblemap = new Array();
			roommap = new Array();
			gemmap = new Array();
			wallpapermap = new Array();
			facademap = new Array();
			chambermap = new Array();
			spikemap = new Array();
			wallqualmap = new Array();
			exits = new Array();
			
			var xx:int = 0;
			var yy:int = 0;
			
			for (xx = 0; xx < width; xx++)
            {
				map.push(new Array());
				intangmap.push(new Array());
				accessiblemap.push(new Array());
				roommap.push(new Array());
				gemmap.push(new Array());
				wallpapermap.push(new Array());
				facademap.push(new Array());
				chambermap.push(new Array());
				spikemap.push(new Array());
				wallqualmap.push(new Array());
				watermap.push(new Array());
				
				
                for (yy = 0; yy < height; yy++)
                {
					map[map.length - 1].push(0);
					intangmap[intangmap.length - 1].push(0);
					accessiblemap[accessiblemap.length - 1].push(0);
					roommap[roommap.length - 1].push(0);
					gemmap[gemmap.length - 1].push(0);
					wallpapermap[wallpapermap.length - 1].push(0);
					facademap[facademap.length - 1].push(0);
					chambermap[chambermap.length - 1].push(0);
					spikemap[spikemap.length - 1].push(0);
					wallqualmap[wallqualmap.length - 1].push(0);
					watermap[watermap.length - 1].push(0);
				}
			}
			
			description = new Cave(x, y);
			
		}
		
		
		
		
		
		

        public function SetMap(x:int, y:int, i:int):void
        {
            if (x >= 0 && x < width && y >= 0 && y < height)
            {
                map[x][y] = i;
            }           
        }

        public function GetMap(x:int, y:int):int
        {
            if (x >= 0 && x < width && y >= 0 && y < height)
            {
                return map[x][y];
            }
            else
                return -1;

        }
		
		public function SetBackmap(x:int, y:int, i:int):void
        {
            if (x >= 0 && x < width && y >= 0 && y < height)
            {
                backmap[x][y] = i;
            }           
        }

        public function GetBackmap(x:int, y:int):int
        {
            if (x >= 0 && x < width && y >= 0 && y < height)
            {
                return backmap[x][y];
            }
            else
                return -1;

        }

		/*
        private void Button_Clear_Click(object sender, EventArgs e)
        {
            secrets.Clear();
            int c = 0;

            do
            {
                Check_N.Checked = false;
                Check_S.Checked = false;
                Check_W.Checked = false;
                Check_E.Checked = false;

                c = 0;

                if (rand.Next(100) < 60)
                {
                    c++;
                    Check_N.Checked = true;
                }

                if (rand.Next(100) < 60)
                {
                    c++;
                    Check_S.Checked = true;
                }

                if (rand.Next(100) < 70)
                {
                    c++;
                    Check_W.Checked = true;
                }

                if (rand.Next(100) < 70)
                {
                    c++;
                    Check_E.Checked = true;
                }


            } while (c < 2);

            Text_LineWidth.Text = (rand.Next(13) + 3).ToString();
            Text_Wildness.Text = (rand.Next(270) + 30).ToString();
            Text_Cinch.Text = (((double)rand.Next(50) / 100) + 0.25).ToString();

            LineCave();

            //panel1.Invalidate();
        }
		*/

        public function Shuffle(array:Array):Array
        {	
			var toret:Array = new Array();
			
			while (array.length > 0)
			{
				var i:int = rand.integer(0, array.length);
				toret.push(array[i]);
				array.splice(i, 1);
			}
			
			return toret;
        }

        public function CheckExits():Boolean
        {
			for each (var ex:Exit in exits)
			{
				if (GetBackmap(ex.x, ex.y) != 0 || GetBackmap(ex.x, ex.y - 1) != 0)
					return false;
			}
			
            for (var i:int = 0; i < exits.length - 1; i++)
            {
                if (CheckPassage(new Point((exits[i] as Exit).x, (exits[i] as Exit).y), new Point((exits[i + 1] as Exit).x, (exits[i + 1] as Exit).y)) == false)
				{
                    return false;
				}
            }

            return true;
        }

        public function CheckPassage(a:Point, b:Point):Boolean
        {
			var checkmap:Array = Util.Clone(backmap);

			var checkers:Array = new Array();
            checkers.push(a);

            while (checkers.length > 0)
            {
				var oldcheckers:Array = new Array();// Util.Clone(checkers);

				for each (var pt:Point in checkers)
				{
					oldcheckers.push(new Point());
					oldcheckers[oldcheckers.length - 1] = pt;
				}
				
				var i:int = 0;
				
                for (i = 0; i < oldcheckers.length; i++)
                {
                    
                    var tocheck:Point = oldcheckers[i] as Point;

					if (tocheck.y == b.y && tocheck.x == b.x)
                            return true;
							
                    if (tocheck.y > 0)
                    {
                        if (checkmap[tocheck.x][tocheck.y - 1] % 2 == 0 || 
							(checkmap[tocheck.x][tocheck.y - 1] == 0 && intangmap[tocheck.x][tocheck.y - 1] == 1))
                        {
                            checkmap[tocheck.x][tocheck.y - 1] = 3;
                            checkers.push(new Point(tocheck.x, tocheck.y - 1));
                        }
                    }

                    if (tocheck.y < height - 1)
                    {
                        if (checkmap[tocheck.x][tocheck.y + 1] % 2 == 0 || 
							(checkmap[tocheck.x][tocheck.y + 1] == 0 && intangmap[tocheck.x][tocheck.y + 1] == 1))
                        {
                            checkmap[tocheck.x][tocheck.y + 1] = 3;
                            checkers.push(new Point(tocheck.x, tocheck.y + 1));
                        }
                    }

                    if (tocheck.x > 0)
                    {
                        if (checkmap[tocheck.x - 1][tocheck.y] % 2 == 0 || 
							(checkmap[tocheck.x - 1][tocheck.y] == 0 && intangmap[tocheck.x - 1][tocheck.y] == 1))
                        {
                            checkmap[tocheck.x - 1][tocheck.y] = 3;
                            checkers.push(new Point(tocheck.x - 1, tocheck.y));
                        }
                    }

                    if (tocheck.x < width - 1)
                    {
                        if (checkmap[tocheck.x + 1][tocheck.y] % 2 == 0 || 
							(checkmap[tocheck.x + 1][tocheck.y] == 0 && intangmap[tocheck.x + 1][tocheck.y] == 1))
                        {
                            checkmap[tocheck.x + 1][tocheck.y] = 3;
                            checkers.push(new Point(tocheck.x + 1, tocheck.y));
                        }
                    }
                }

                for (i = 0; i < oldcheckers.length; i++)
                {
                    checkers.splice(0, 1);
                }
            }

			//map = Util.Clone(checkmap);

            return false;
        }
		
		

        public function LineCave(size:int, cinch:Number, maxwiggle:int):void
        {
			remplats = -1;
            var mult:Number = 0;
			var x:int = 0;
			var y:int = 0 ;
			
            for (x = 0; x < width; x++)
            {
                for (y = 0; y < height; y++)
                {
                    SetMap(x, y, 1);

                }
            }
			

			var hcinch:Number = cinch * Content.nHorizontalCinchCoefficient;
			var vcinch:Number = cinch * Content.nCurrentVerticalCinchCoefficient;

			
			

			exits.splice(0);

            var nodes:Array = new Array();

            if (description.exits.north)
            {

				//trace("a - " + ((1.0 / 3.0) * width).toString());

                x = rand.integer(0, int((1.0 / 3.0) * width)) + int((1.0 / 3.0) * width);
                y = rand.integer(0, int((2.0 / 9.0) * height)) + int((1.0 / 9.0) * height);

				
				//trace("b - " + x.toString());
				
                x = int((width / 2) - (((width / 2) - x) * (hcinch)));
                y = int((height / 2) - (((height / 2) - y) * vcinch));

				
                exits.push(new Exit(x, y, 0));

                
            }

            if (description.exits.south)
            {				
				x = rand.integer(0, int((1.0 / 3.0) * width)) + int((1.0 / 3.0) * width);
                y = rand.integer(0, int((2.0 / 9.0) * height)) + int((2.0 / 3.0) * height);

                x = int((width / 2) - (((width / 2) - x) * hcinch));
                y = int((height / 2) - (((height / 2) - y) * vcinch));

                exits.push(new Exit(x, y, 1));
            }

            if (description.exits.west)        
            {
				
				x = rand.integer(0, int((2.0 / 9.0) * width)) + int((1.0 / 9.0) * width);
                y = rand.integer(0, int((1.0 / 3.0) * height)) + int((1.0 / 3.0) * height);

                x = int((width / 2) - (((width / 2) - x) * hcinch));
                y = int((height / 2) - (((height / 2) - y) * vcinch));

                exits.push(new Exit(x, y, 2));

            }

            if (description.exits.east)
            {								
				x = rand.integer(0, int((2.0 / 9.0) * width)) + int((2.0 / 3.0) * width);
                y = rand.integer(0, int((1.0 / 3.0) * height)) + int((1.0 / 3.0) * height);

                x = int((width / 2) - (((width / 2) - x) * hcinch));
                y = int((height / 2) - (((height / 2) - y) * vcinch));

                exits.push(new Exit(x, y, 3));
            }
			
			if (exits.length == 1)
			{
				x = rand.integer(0, int((1.0 / 3.0) * width)) + int((1.0 / 3.0) * width);
                y = rand.integer(0, int((1.0 / 3.0) * height)) + int((1.0 / 3.0) * height);

                x = int((width / 2) - (((width / 2) - x) * hcinch));
                y = int((height / 2) - (((height / 2) - y) * vcinch));

                exits.push(new Exit(x, y, 99));
			}

            exits = Shuffle(exits);
			var ex:int = 0;
            for (ex = 0; ex < exits.length; ex++)
            {
                if (!(exits[ex] as Exit).handled)
                {
                    var digger:Point = new Point((exits[ex] as Exit).x, (exits[ex] as Exit).y);
                    var target:Point = null;
					var targetexit:int = -1;
					
                    if (ex == 0)
                    {
                        targetexit = rand.integer(0, exits.length - 1) + 1; // <- Do NOT get tricked into thinking the rand is exclusive!

                        (exits[ex] as Exit).handled = true;
                        (exits[targetexit] as Exit).handled = true;

                        target = new Point((exits[targetexit] as Exit).x, (exits[targetexit] as Exit).y);
                    }
                    else if (nodes.length > 0)
                    {
                        targetexit = rand.integer(0, nodes.length);

                        (exits[ex] as Exit).handled = true;

                        target = new Point((nodes[targetexit] as Point).x, (nodes[targetexit] as Point).y);
                    }
                    else
                    {
                        trace("No nodes?!?!?!?!?!!?!?!?!??!?!?!?!?!??!?!?!?!?!??!?!");
                        target = new Point(0, 0);
                    }

                    
                    var toofar:Boolean = true;
                    var stopdistance:Number = size / 2;
                    var hopdistance:Number = size / 2;
                    
                    var wtf:int = 0;
                    var wiggle:Number = 0;
                    var angle:Number = -999;

                    do
                    {
                        nodes.push(new Point(int(digger.x), int(digger.y)));


                        var xdiff:Number = target.x - digger.x;
                        var ydiff:Number = target.y - digger.y;

                        var dist:Number = Math.sqrt(Math.pow(xdiff, 2) + Math.pow(ydiff, 2));

                        if (dist <= stopdistance)
                        {
                            toofar = false;
                        }
                        else
                        {
                            wtf++;

                            if (dist <= stopdistance)
                            {
                                wiggle = 0;
                                angle = Math.asin((target.y - digger.y) / dist);
                            }
                            else if (rand.integer(0, 100) <= 98 && angle != -999)
                            {
                                //Console.WriteLine("Preserving previous: " + (angle * (180 / Math.PI)));
                            }
                            else
                            {
                                wiggle = rand.integer(0, maxwiggle) - (maxwiggle / 2);
                                wiggle *= Math.PI / 180;
                                angle = Math.asin((target.y - digger.y) / dist) + wiggle;
                            }

                            var threshold:Number = Math.PI / 2;

                            if ((angle - (Math.PI / 2) < threshold) ||
                                (angle - (3 * (Math.PI / 2)) < threshold))
                            {
                                var dir:int = 1;

                                while (Math.abs((angle - (Math.PI / 2))) < threshold ||
                                    Math.abs((angle - (3 * (Math.PI / 2)))) < threshold)
                                {
                                    angle += dir * (Math.PI / 16);
                                }
                            }

							var trav:Number = rand.integer(int(hopdistance / 2), hopdistance * 4);
							
                            var xtrav:Number = Math.cos(angle) * trav * -1;
                            var ytrav:Number = Math.sin(angle) * trav * -1;

                            if ((xtrav > 0 && xdiff < 0) || xtrav < 0 && xdiff > 0)
                                xtrav *= -1;

                            if ((ytrav > 0 && ydiff < 0) || ytrav < 0 && ydiff > 0)
                                ytrav *= -1;

                            mult = (rand.integer(0, 100) + 100) / 100;
							//trace("mult a = " + mult.toString());
							//trace("mult b = " + (int(size * mult)).toString());

                            StampLine(int(size * mult), new Point(int(digger.x), int(digger.y)), new Point(int(digger.x + xtrav), int(digger.y + ytrav)));

                            digger.x += xtrav;
                            digger.y += ytrav;

                        }
                    } while (toofar);

                    mult = (rand.integer(0, 100) + 100) / 100;
					//trace("mult c = " + mult.toString());
					//trace("mult d = " + (int(size * mult)).toString());

                    var t:Point = new Point(int(target.x), int(target.y));

                    StampLine(int(size * mult), t,t);
                }
            }

			// Exit Floors
			for (ex = 0; ex < exits.length; ex++)
			{
                if ((exits[ex] as Exit).id == 0)
                {
                    SetMap((exits[ex] as Exit).x - 1, (exits[ex] as Exit).y + 1, 1);
                    SetMap((exits[ex] as Exit).x, (exits[ex] as Exit).y + 1, 1);
                    SetMap((exits[ex] as Exit).x + 1, (exits[ex] as Exit).y + 1, 1);
                }
				else if ((exits[ex] as Exit).id == 99)
				{
					//exits.splice(ex, 1);
					//ex--;
				}
            }
			
			DefineBounds();
			ResetRandom();
        }
		
		public function ResetRandom():void
		{
			rand = new Rndm(Util.Seed(this.description.coords.x + 100, this.description.coords.y + 100));
		}
		
		public function DefineBounds():void
		{
			var x:int = 0;
			var y:int = 0;
			
			var empty:Boolean = true;
			
			for (x = 0; x < width && empty == true; x++)
			{
				for (y = 0; y < height && empty == true; y++)
				{
					if (GetMap(x, y) != 1)
						empty = false;
				}
			}
			
			trace("Empty?? " + empty.toString());
			
			for (y = 0; y < height && upperleft.y == -1; y++)
            {
                for (x = 0; x < width && upperleft.y == -1; x++)
                {
					if(GetMap(x, y) != 1)
						upperleft.y = y;
                }
            }
			
			for (x = 0; x < width && upperleft.x == -1; x++)
            {
                for (y = 0; y < height && upperleft.x == -1; y++)
                {
					if(GetMap(x, y) != 1)
						upperleft.x = x;
                }
            }
			
			for (y = height - 1; y > 0 && lowerright.y == -1; y--)
            {
				for (x = width - 1; x > 0 && lowerright.y == -1; x--)
				{
					if(GetMap(x, y) != 1)
						lowerright.y = y;
                }
            }
			
			for (x = width - 1; x > 0 && lowerright.x == -1; x--)
            {
				for (y = height - 1; y > 0 && lowerright.x == -1; y--)
				{
					if(GetMap(x, y) != 1)
						lowerright.x = x;
                }
            }
			
			upperleft.x -= 4;
			upperleft.y -= 4;
			lowerright.x += 4;
			lowerright.y += 4;
		}
		
		public function CleanUp():void
		{
			for (var y:int = upperleft.y + 2; y < lowerright.y - 2; y++)
            {
				for (var x:int = upperleft.x + 2; x < lowerright.x - 2; x++)
                {
					if (GetMap(x - 1, y) == 1 &&       GetMap(x, y) == 0 &&			GetMap(x + 1, y) == 1 &&
															GetMap(x, y + 1) == 1)
					{
						SetMap(x, y, 1);
					}
					else if (						  GetMap(x, y - 1) == 1 &&
							 GetMap(x - 1, y) == 1 && GetMap(x, y) == 0 && GetMap(x - 1, y) == 1 &&
													  GetMap(x, y + 1) == 1
					)
					{
						SetMap(x, y, 1);
					}

					var bNearExitOrWater:Boolean = false;
					
					for (var xx:int = x - 1; xx <= x + 1 && bNearExitOrWater == false; xx++)
					{
						for (var yy:int = y - 1; yy <= y + 1 && bNearExitOrWater == false; yy++)
						{
							if (watermap[xx][yy] == 1)
							{
								bNearExitOrWater = true;
							}
						}
					}
						
					
					if (bNearExitOrWater == false)
					{
						for each (var exit:Exit in exits)
						{
							if (Math.abs(x - exit.x) <= 2 && 
								Math.abs(y - exit.y) <= 2)
							{
								bNearExitOrWater = true;
							}
						}
					}
					
					if (bNearExitOrWater == false)
					{
						if ((	//							 GetMap(x, y - 1) == 1 &&
								GetMap(x - 1, y) == 0 &&     GetMap(x, y) == 0 &&       GetMap(x + 1, y) == 1 &&
								GetMap(x - 1, y + 1) == 1 && GetMap(x, y + 1) == 0 &&       GetMap(x + 1, y + 1) == 0 &&
															 GetMap(x, y + 2) == 1)
															||
							(	//							 GetMap(x, y - 1) == 1 &&
								GetMap(x - 1, y) == 1 &&     GetMap(x, y) == 0 &&       GetMap(x + 1, y) == 0 &&
								GetMap(x - 1, y + 1) == 0 && GetMap(x, y + 1) == 0 &&       GetMap(x + 1, y + 1) == 1 &&
															 GetMap(x, y + 2) == 1))
						{
							SetMap(x - 1, y, 0);
							SetMap(x + 1, y, 0);
						}
					}
                }
            }
		}
		
		public function MakeSpikes():void
		{
			for (var y:int = upperleft.y + 10; y < lowerright.y; y++)
            {
				for (var x:int = upperleft.x + 1; x < lowerright.x; x++)
                {
					var bValid:Boolean = true;
					
					if (                             
					                                 GetMap(x, y - 1) == 0 &&
					     GetMap(x - 1, y) == 1 &&    GetMap(x, y) == 0 &&
													 GetMap(x, y + 1) == 1)
					{
						var length:int = 0;
						var keepgoing:Boolean = true;
						
						for (var xx:int = x; xx < lowerright.x; xx++)
						{
							for each (var exit:Exit in exits)
							{
								if (xx == exit.x && y == exit.y)
								{
									bValid = false;
									break;
								}
							}
							
							if (
							    //GetMap(xx, y - 1) == 0 &&
							    GetMap(xx, y) == 0 &&
								GetMap(xx, y + 1) == 1)
							{
								if (GetMap(xx + 1, y) == 1)
								{
									length = xx - x + 2;
									break;
								}
							}
							else
							{
								bValid = false;
								break;
							}
						}
						
						var yoff:int = 0;
						
						var pitheight:int = 0;
						var leftentry:int = 0;
						var rightentry:int = 0;
						
						keepgoing = true;
						
						for (yoff = 0; yoff < length + 2 && (leftentry == 0 || rightentry == 0); yoff++)
						{
							if (leftentry == 0 && GetMap(x - 1, y - yoff) == 0)
							{
								leftentry = yoff;
							}
							
							if (rightentry == 0 && GetMap(x + length, y - yoff) == 0)
							{
								rightentry = yoff;
							}
						}
						
						if (rand.integer(0, 100) <= Content.nRequireSpaceForSpikesChance * 100) // Guarantee jump space
						{
							if (bValid)
							{
								for (xx = x; xx < lowerright.x && keepgoing; xx++)
								{
									if (GetMap(xx, y) == 1)
									{
										keepgoing = false;
										break;
									}
									
									for (yoff = 0; (yoff < length || yoff < leftentry + length || yoff < rightentry + length) && keepgoing; yoff++)
									{
										if (GetMap(xx, y - yoff) == 1)
										{
											bValid = false;
											keepgoing = false;
											break;
										}
									}
								}
							}
						}
						
						if (bValid)
						{
							for (xx = x; xx < lowerright.x; xx++)
							{
								if (GetMap(xx, y) == 0 &&
									GetMap(xx, y + 1) == 1 && 
									chambermap[x][y] == 0)
								{
									spikemap[xx][y] = 1;
								}
								else
								{
									break;
								}
							}
						}
					}
					
					
					     
				}
			}
		}
		
		public function DropExits():void
		{
			for each (var exit:Exit in exits)
			{
				while (GetMap(exit.x, exit.y + 1) == 0)
					exit.y++;
            }
		}

        public function StampLine(size:int, a:Point, b:Point):void
        {
			
			var stamp:Array = new Array();
			
			for (var x:int = 0; x < size; x++)
			{
				stamp.push(new Array());
				
				for (var y:int = 0; y < size; y++)
				{
					stamp[stamp.length - 1].push(0);
				}
			}

            stamp = MakeCircleStamp(stamp, size);

			var z:Point = null;
			var xn:Number = -1;
			var yn:Number = -1;
			var perc:Number = -1;
			
            if (Math.abs(a.x - b.x) < Math.abs(a.y - b.y))
            {
                if (a.y > b.y)
                {
                    z = a;
                    a = b;
                    b = z;
                }

                for (yn = a.y; yn <= b.y; yn++)
                {

                    perc = (yn - a.y) / (b.y - a.y);
                    var xchange:Number = perc * (b.x - a.x);
                    xn = xchange + a.x;

                    StampAt(SetMap, stamp, size, int(xn), int(yn));
                }
            }
            else
            {
				if (a.x == b.x)
				{
					StampAt(SetMap, stamp, size, int(a.x), int(a.y));
				}
				else
				{
					if (a.x > b.x)
					{
						z = a;
						a = b;
						b = z;
					}

					for (xn = a.x; xn <= b.x; xn++)
					{

						perc = (xn - a.x) / (b.x - a.x);
						var ychange:Number = perc * (b.y - a.y);
						yn = ychange + a.y;

						StampAt(SetMap, stamp, size, int(xn), int(yn));
					}
				}
            }
        }

        public function MakeCircleStamp(stamp:Array, size:int):Array
        {			
            var halfsize:Number = size / 2;

            for (var y:int = 0; y < size; y++)
            {
                for (var x:int = 0; x < size; x++)
                {
                    var hcorrection:Number = 0;
                    var vcorrection:Number = 0;

                    if (size % 2 == 0)
                    {
                        if (x >= halfsize)
                            hcorrection = 1;

                        if (y >= halfsize)
                            vcorrection = 1;
                    }

                    
                    var xx:Number = x - halfsize + hcorrection;
                    var yy:Number = y - halfsize + vcorrection;

                    if (Math.sqrt((yy * yy) + (xx * xx)) < halfsize + 0.5)
                        stamp[x][y] = 1;
                    else
                        stamp[x][y] = 0;
                }
            }
			
			return stamp;
        }
   

        public function StampAt(SetMapFunction:Function, stamp:Array, size:int, x:int, y:int):void
        {
            var halfsize:Number = size / 2;

            var sx:int = x - int(halfsize);
            var sy:int = y - int(halfsize);

            for (var yy:int = 0; yy < size; yy++)
            {
                for (var xx:int = 0; xx < size; xx++)
                {
                    var cx:int = sx + xx;
                    var cy:int = sy + yy;

 
                        if(stamp[xx][yy] == 1)
                        {
                            SetMapFunction(cx, cy, 0);
                        }
                }
            }
        }
		
		
		public function ApplyFilter(f:Function, items:int, variable:int, deathchance:int):Boolean
        {
			
            //for (var i:int = 0; i < iterations; i++)   // PSH WHO DOES ITERATIONS ANYMORE
            //{
                var failout:int = 0;
                var keepgoing:Boolean = false;

                do
                {
                    backmap = Util.Clone(map);
                    keepgoing = false;
                    failout++;
					
                    f(items, variable, deathchance);

                    if (CheckExits() == false)
                    {
                        keepgoing = true;
                    }
                } while (keepgoing && failout < 4);

                if (failout == 4)
				{
					//trace("FAILED OUT");
					return true;
				}
				else
				{
					map = Util.Clone(backmap);
				
					return false;
				}	
            //}
        }
		
		public function BackmapSafe():Boolean
        {
            var safe1:Boolean = false;
            var safe2:Boolean = false;

            for (var ysafe:int = 0; ysafe < height; ysafe++)
            {
                for (var xsafe:int = 0; xsafe < width; xsafe++)
                {

                    if (GetBackmap(xsafe, ysafe) == 1)
                        safe1 = true;

                    if (GetBackmap(xsafe, ysafe) == 0)
                        safe2 = true;

                    if (safe1 && safe2)
                        return true;
                }
            }

            return false;
        }
		
		public function HowHighUp(x:int, y:int):int
        {
            var howhigh:int = 0;

            while (GetBackmap(x, y) == 0)
            {
                howhigh++;
                y++;
            }

            return howhigh;
        }
		
		public function HowHighUpWater(x:int, y:int):int
        {
            var howhigh:int = 0;

            while (GetMap(x, y) == 0 && watermap[x][y] == 0)
            {
                howhigh++;
                y++;
            }

            return howhigh;
        }
		
		
		public function Plats(items:int, variable:int, notused:int):void
        {
            if (BackmapSafe() == false)
                return;

            for (var i:int = 0; i < items; i++)
            {
				remplats++;
				
				if (remplats % 10 == 0)
				{
					points.splice(0);

					for (var y:int = upperleft.y; y < lowerright.y; y++)
					{
						for (var x:int = upperleft.x; x < lowerright.x; x++)
						{
							if ((GetBackmap(x, y) == 1 && (GetBackmap(x + 1, y) == 0) 
								||
								(GetBackmap(x, y) == 0 && (GetBackmap(x + 1, y) == 1)
								|| 
								(HowHighUp(x, y) > 5 && rand.integer(0, 100) < 40)
								||
								(GetBackmap(x, y) == 0 && rand.integer(0, 100) < 10))))
							{
								points.push(new Point(x, y));
							}
						}
					}
				}

				if (points.length > 0)
				{
					var p:int = rand.integer(0, points.length);
					var pt:Point = points[p] as Point;

					var span:int = rand.integer(0, variable) + (variable / 2) + 1;

					var h:int = -1;
					
					for (h = pt.x - (span / 2); h < pt.x + (span / 2); h++)
					{
						SetBackmap(h, pt.y + 1, 1);
					}

					for (h = pt.x - (span / 2) + 1 + (rand.integer(0, 2)); h < pt.x + (span / 2) - 1 - (rand.integer(0, 2)); h++)
					{
						SetBackmap(h, pt.y, 1);
					}
				}
				else
				{
					trace("No valid plat points??");
				}
				
				//trace("Platform " + i.toString());
            }
        }
		
		public function Pools(items:int, variable:int, notused:int):void
		{
			var points:Array = new Array();
			var success:int = 0;
            var fail:int = 0;

			var x:int = 0;
            var y:int = 0;
			
            while (success < items && fail < 500)
            {
				x = rand.integer(upperleft.x, lowerright.x);
                y = rand.integer(upperleft.y, lowerright.y);
				
				if (GetBackmap(x, y) == 0 && watermap[x][y] == 0)
				{
					var shallow:Boolean = false;
					while (!shallow && GetBackmap(x, y) == 0 && watermap[i][y] == 0)
					{
						if (x == 130 && y == 120)
							var a:int = 2;
							
						var i:int = x;
						
						while (i != 0 && (GetBackmap(i, y) == 0 || watermap[i][y + 1] > 0) && watermap[i][y] == 0)
							i--;
											
						var startx:int = i + 1;
						
						for (i = startx; (GetBackmap(i, y) == 0 || watermap[i][y + 1] > 0) && watermap[i][y] == 0; i++)
						{
							shallow = true;
							
							if (GetBackmap(i, y + 1) > 0 || watermap[i][y + 1] > 0)
							{
								// shallow
							}
							else
							{
								shallow = false;
								x = i;
								y++;
								break;
							}
						}
						
						if (shallow)
						{
							for (i = startx; (GetBackmap(i, y) == 0 || watermap[i][y + 1] > 0) && watermap[i][y] == 0; i++)
							{
								watermap[i][y] = 1;
								success++;
							}
						}
					}
				}
				
				fail++;
			}
			/*
			for (x = upperleft.x; x < lowerright.x; x++)
			{
				for (y = upperleft.y; y < lowerright.y; y++)
				{
					if (GetBackmap(x, y) > 0 && watermap[x][y + 1] > 0 &&
						(watermap[x - 1][y] > 0 || watermap[x + 1][y] > 0))
					{
						watermap[x][y] = 1;
					}
				}
			}
			*/
			
		}
		
		public function Pillars(items:int, variable:int, notused:int):void
		{
            var points:Array = new Array();
            var fail:int = 0;

            while (points.length < variable && fail != -1)
            {
                var x:int = rand.integer(upperleft.x, lowerright.x);
                var y:int = rand.integer(upperleft.y, lowerright.y);

                if (GetBackmap(x, y) == 0 && GetBackmap(x, y + 1) == 1)
                {
                    points.push(new Point(x, y));
                }

                fail++;
            }

            for each (var pt:Point in points)
            {
                var size:Number = variable * (rand.integer(50, 150) / 100);

                for (y = size * -1; y <= 0; y++)
                {
                    SetBackmap(pt.x, pt.y + y, 1);
                }
                
            }
		}
		
		public function Plateaus(items:int, variable:int, deathchance:int):void
        {/*
			for (var yy:int = upperleft.y; yy < lowerright.y; yy++)
            {
				for (var xx:int = upperleft.x; xx < lowerright.x; xx++)
                {
					
				}
			}*/
			
			if (BackmapSafe() == false)
                return;

            var points:Array = new Array();
            var fail:int = 0;

            while (points.length < items && fail < 500)
            {
                var x:int = rand.integer(upperleft.x + 10, lowerright.x - 10);
                var y:int = rand.integer(upperleft.y, lowerright.y);
              

                if (GetBackmap(x, y) == 0 && GetBackmap(x, y + 1) == 1)
                {
                    fail--;

					var dir:int = rand.integer(0, 2);
					
					
					dir *= 2;
					dir--;
					
					if (GetBackmap(x + dir, y) == 0)
					{
						fail++;
					}
					else
					{
						var tosurmount:int = 1;
					
						while (GetBackmap(x + dir, y - tosurmount) == 1)
						{
							tosurmount++;
						}
						
						if (tosurmount > variable)
						{
							fail++;
						}
						else
						{
						
							var bAllDone:Boolean = false;
							

							for (var xx:int = x + dir + dir; xx >= upperleft.x + 10 && xx <= lowerright.x - 10 && !bAllDone; xx += dir)
							{
								for (var yy:int = y; yy > upperleft.y + 10 && !bAllDone; yy--)
								{
									if (rand.integer(1, 100) <= deathchance)
									{
										break;
									}
									else if (GetBackmap(xx, yy) == 0)
									{
										if (yy == y - tosurmount)
											bAllDone = true;
											
										break;
									}
									else
									{
										points.push(new Point(xx, yy));
									}
								}
								
								if (rand.integer(1, 100) <= deathchance)
								{
									y--;
								}
							}
						}
						
						
					}

                }

                fail++;
            }

            for each (var pt:Point in points)
            {
                SetBackmap(pt.x, pt.y, 0);
            }
		}
		

		
		public function Clumps(items:int, variable:int, notused:int):void
        {
			var x:int;
			var y:int;
			var i:int;
			
            if (BackmapSafe() == false)
                return;

            var points:Array = new Array();
            var fail:int = 0;

            while (points.length < items && fail < 500)
            {
                x = rand.integer(upperleft.x, lowerright.x);
                y = rand.integer(upperleft.y, lowerright.y);
              

                if (GetBackmap(x, y) == 0)
                {
                    fail--;

                    var chance:Number = rand.integer(0, 100);

                    if (GetBackmap(x + 1, y) == 1) chance /= 3;
                    if (GetBackmap(x - 1, y) == 1) chance /= 3;
                    if (GetBackmap(x, y + 1) == 1) chance /= 3;
                    if (GetBackmap(x, y - 1) == 1) chance /= 3;

                    if (chance <= variable)
                    {
                        points.push(new Point(x, y));
                    }
                }

                fail++;
            }

            for each (var pt:Point in points)
            {
                SetBackmap(pt.x, pt.y, 1);
            }
        }
		
		public function Rounds(items:int, variable:int, notused:int):void
		{
            var points:Array = new Array();

		
			for (var x:int = 5; x < this.width - 5; x++)
			{
				for (var y:int = 5; y < this.width - 5; y++)
				{
					if (GetBackmap(x - 1, y - 1) == 1 && GetBackmap(x + 0, y - 1) == 0 && GetBackmap(x + 1, y - 1) == 0 &&
						GetBackmap(x - 1, y + 0) == 1 && GetBackmap(x + 0, y + 0) == 0 && GetBackmap(x + 1, y + 0) == 0 &&
						GetBackmap(x - 1, y + 1) == 1 && GetBackmap(x + 0, y + 1) == 1 && GetBackmap(x + 1, y + 1) == 1)
					{
						points.push(new Point(x, y));
					}
					else if (GetBackmap(x - 1, y - 1) == 1 && GetBackmap(x + 0, y - 1) == 1 && GetBackmap(x + 1, y - 1) == 1 &&
							GetBackmap(x - 1, y + 0) == 1 && GetBackmap(x + 0, y + 0) == 0 && GetBackmap(x + 1, y + 0) == 0 &&
							GetBackmap(x - 1, y + 1) == 1 && GetBackmap(x + 0, y + 1) == 0 && GetBackmap(x + 1, y + 1) == 0)
					{
						points.push(new Point(x, y));
					}
					else if (GetBackmap(x - 1, y - 1) == 0 && GetBackmap(x + 0, y - 1) == 0 && GetBackmap(x + 1, y - 1) == 1 &&
							GetBackmap(x - 1, y + 0) == 0 && GetBackmap(x + 0, y + 0) == 0 && GetBackmap(x + 1, y + 0) == 1 &&
							GetBackmap(x - 1, y + 1) == 1 && GetBackmap(x + 0, y + 1) == 1 && GetBackmap(x + 1, y + 1) == 1)
					{
						points.push(new Point(x, y));
					}
					else if (GetBackmap(x - 1, y - 1) == 1 && GetBackmap(x + 0, y - 1) == 1 && GetBackmap(x + 1, y - 1) == 1 &&
							GetBackmap(x - 1, y + 0) == 0 && GetBackmap(x + 0, y + 0) == 0 && GetBackmap(x + 1, y + 0) == 1 &&
							GetBackmap(x - 1, y + 1) == 0 && GetBackmap(x + 0, y + 1) == 0 && GetBackmap(x + 1, y + 1) == 1)
					{
						points.push(new Point(x, y));
					}
				}
			}

		
            for (var i:int = 0; i < variable && points.length > 0; i++)
			{
				var which:int = rand.integer(0, points.length - 1);
			
				var forbidden:Boolean = false;
				
				for each(var ex:Exit in exits)
				{
					if (
						(points[which] as Point).x == ex.x &&
						((points[which] as Point).y == ex.y || (points[which] as Point).y != ex.y - 1)						
						)
					{
						forbidden = true;
						break;
					}
				}
				
				if(forbidden == false)
					SetBackmap((points[which] as Point).x, (points[which] as Point).y, 1);
				
				points.splice(which, 1);
            }
		}
		
		public function Pixels(items:int, variable:int, notused:int):void
		{
            var points:Array = new Array();
            var fail:int = 0;

		
			for (var x:int = 5; x < this.width - 5; x += 2)
			{
				for (var y:int = 5; y < this.width - 5; y += 2)
				{
					var t:int = GetBackmap(x + 0, y + 0) + GetBackmap(x + 1, y + 0) + GetBackmap(x + 0, y + 1) + GetBackmap(x + 1, y + 1);
					
					if (t != 0 && t != 4)
					{
						points.push(new Point(x, y));
					}
				}
			}

            for (var i:int = 0; i < variable && points.length > 0; i++)
			{
				var which:int = rand.integer(0, points.length - 1);
				var onoff:int = rand.integer(0, 2);
				

				
				SetBackmap((points[which] as Point).x, (points[which] as Point).y, onoff);
				SetBackmap((points[which] as Point).x + 1, (points[which] as Point).y, onoff);
				SetBackmap((points[which] as Point).x, (points[which] as Point).y + 1, onoff);
				SetBackmap((points[which] as Point).x + 1, (points[which] as Point).y + 1, onoff);
				
                points.splice(which, 1);
            }
		}
		
		public function ChewCave(items:int, variable:int, notused:int):void
		{
			var points:Array = new Array();
			
			for (var i:int = 0; i < items; i++)
			{
				points.splice(0);
				
				for (var y:int = 20; y < this.height - 20; y++)
				{
					for (var x:int = 20; x < this.width - 20; x++)
					{
						if ((GetBackmap(x, y) == 1 && (GetBackmap(x, y+1) == 0) || GetBackmap(x, y-1) == 0))
                        {
                            points.push(new Point(x, y));
                        }
					}
				}
			}
			
			for (var p:int = 0; p < points.length; p++)
			{
				var which:int = rand.integer(0, points.length - 1);
				
				var stamp:Array = new Array();
			
				for (var xx:int = 0; xx < variable; xx++)
				{
					stamp.push(new Array());
					
					for (var yy:int = 0; yy < variable; yy++)
					{
						stamp[stamp.length - 1].push(0);
					}
				}

				stamp = MakeCircleStamp(stamp, variable);
				
				StampAt(SetBackmap, stamp, variable, int((points[which] as Point).x), int((points[which] as Point).y));
			}
		}
		
		public function PurgeOnes(percentage:int, variable:int, notused:int):void
        {
			
            if (BackmapSafe() == false)
                return;

            var points:Array = new Array();
            var fail:int = 0;
					
			
			
			for (var x:int = 1; x < width - 1; x++)
			{
				for (var y:int = 1; y < height - 1; y++)
				{
					if (percentage > -1)
					{
						if (GetBackmap(x, y) == 1 && 
						GetBackmap(x - 1, y) == 0 &&
						GetBackmap(x + 1, y) == 0 &&
						GetBackmap(x, y - 1) == 0 &&
						GetBackmap(x, y + 1) == 0)
						{
							points.push(new Point(x, y));
						}
					}
					else
					{
						if (wallmap[x][y] == 1 && 
						wallmap[x - 1][ y] == 0 &&
						wallmap[x + 1][y] == 0 &&
						wallmap[x][ y - 1] == 0 &&
						wallmap[x][y + 1] == 0)
						{
							points.push(new Point(x, y));
						}
					}
					
				}
			}
			
			var kill:Number = points.length * (percentage / 100);
			
			if (percentage == -1)
				kill = 10000000;
			
			trace("Killing " + kill.toString() + " ones");
			
			for (var i:int = 0; i < kill && points.length > 0; i++)
			{
			
				var which:int = rand.integer(0, points.length - 1);
				
				if (percentage > -1)
				{
					SetBackmap((points[which] as Point).x, (points[which] as Point).y, 0);
				}
				else
				{
					wallmap[(points[which] as Point).x][(points[which] as Point).y] = 0;
				}
				
                points.splice(which, 1);
			}

            
        }

		
		public function FillAccessible():void
        {
			var checkmap:Array = Util.Clone(map);
			
			accessiblemap = new Array();

			for (var xx:int = 0; xx < width; xx++)
            {
				accessiblemap.push(new Array());

                for (var yy:int = 0; yy < height; yy++)
                {
					accessiblemap[accessiblemap.length - 1].push(0);
				}
			}
			
			var checkers:Array = new Array();
            checkers.push(new Point((exits[0] as Exit).x, (exits[0] as Exit).y));

            while (checkers.length > 0)
            {
				var oldcheckers:Array = new Array();

				for each (var pt:Point in checkers)
				{
					accessiblemap[pt.x][pt.y] = 1;
					oldcheckers.push(new Point());
					oldcheckers[oldcheckers.length - 1] = pt;
				}
				
				var i:int = 0;
				
                for (i = 0; i < oldcheckers.length; i++)
                {
                    var tocheck:Point = oldcheckers[i] as Point;
							
                    if (tocheck.y > 0)
                    {
                        if (checkmap[tocheck.x][tocheck.y - 1] % 2 == 0 || 
							(checkmap[tocheck.x][tocheck.y - 1] == 0 && intangmap[tocheck.x][tocheck.y - 1] == 1))
                        {
                            checkmap[tocheck.x][tocheck.y - 1] = 3;
                            checkers.push(new Point(tocheck.x, tocheck.y - 1));
                        }
                    }

                    if (tocheck.y < height - 1)
                    {
                        if (checkmap[tocheck.x][tocheck.y + 1] % 2 == 0 || 
							(checkmap[tocheck.x][tocheck.y + 1] == 0 && intangmap[tocheck.x][tocheck.y + 1] == 1))
                        {
                            checkmap[tocheck.x][tocheck.y + 1] = 3;
                            checkers.push(new Point(tocheck.x, tocheck.y + 1));
                        }
                    }

                    if (tocheck.x > 0)
                    {
                        if (checkmap[tocheck.x - 1][tocheck.y] % 2 == 0 || 
							(checkmap[tocheck.x - 1][tocheck.y] == 0 && intangmap[tocheck.x - 1][tocheck.y] == 1))
                        {
                            checkmap[tocheck.x - 1][tocheck.y] = 3;
                            checkers.push(new Point(tocheck.x - 1, tocheck.y));
                        }
                    }

                    if (tocheck.x < width - 1)
                    {
                        if (checkmap[tocheck.x + 1][tocheck.y] % 2 == 0 || 
							(checkmap[tocheck.x + 1][tocheck.y] == 0 && intangmap[tocheck.x + 1][tocheck.y] == 1))
                        {
                            checkmap[tocheck.x + 1][tocheck.y] = 3;
                            checkers.push(new Point(tocheck.x + 1, tocheck.y));
                        }
                    }
                }

                for (i = 0; i < oldcheckers.length; i++)
                {
                    checkers.splice(0, 1);
                }
            }

			return;
        }
		
		public var intangplan:Array = null;
		public var secretchamberplan:Array = null;
		public function MakeIntangibles(wigglechance:int, hintchance:int, deathchance:int):void
        {
			if(Content.bSecretChambers)
			{
				intangs.splice(0);
				
				var leftentrances:Array = new Array();
				var rightentrances:Array = new Array();
				
				for (x = upperleft.x; x < lowerright.x; x++)
				{
					for (y = upperleft.y; y < lowerright.y; y++)
					{
						
						if (x % 2 == 0 && y % 2 == 0 &&
							accessiblemap[x][y] == 1 &&
							//GetMap(x, y - 1) == 1 &&
							//GetMap(x, y + 1) == 1 &&
							watermap[x - 1][y] != 1 &&
							watermap[x + 1][y] != 1 &&
							watermap[x][y - 1] != 1 &&
							watermap[x][y + 1] != 1
							)
						{
							var fail:Boolean = false;
							
							if (candidatelists != null)
							{
								if (candidatelists[0] != null)
								{
									for each(var e:Exit in candidatelists[0])
									{
										if (Math.abs(e.x - x) <= 6 && 
											Math.abs(e.y - y) <= 6 &&
											e.id == 0)
											{
												fail = true;
												break;
											}
									}
								}
							}
							
							if (fail == false)
							{
											
								if (GetMap(x - 1, y) == 1 && GetMap(x + 1, y) == 0 && 
									GetMap(x - 1, y + 1) == 1 && GetMap(x - 1, y - 1) == 1)
									leftentrances.push(new Point(x, y));
								else if (GetMap(x - 1, y) == 0 && GetMap(x + 1, y) == 1 &&
									GetMap(x + 1, y + 1) == 1 && GetMap(x + 1, y - 1) == 1)
									rightentrances.push(new Point(x, y));
							}
						}
					}
				}
					
				var rcull:int = 0;
				
				while (leftentrances.length - rightentrances.length > 3)
				{
					rcull = rand.integer(0, leftentrances.length);
					leftentrances.splice(rcull, 1);
				}
				
				while (rightentrances.length - leftentrances.length > 3)
				{
					rcull = rand.integer(0, rightentrances.lengt);
					rightentrances.splice(rcull, 1);
				}
				
				while (rightentrances.length + leftentrances.length > 6)
				{
					if (leftentrances.length >= rightentrances.length)
					{
						rcull = rand.integer(0, leftentrances.length);
						leftentrances.splice(rcull, 1);
					}
					else
					{
						rcull = rand.integer(0, rightentrances.length);
						rightentrances.splice(rcull, 1);
					}
				}
				
				trace("Pre: Secrets on left: " + leftentrances.length.toString() + "  Secrets on right: " + rightentrances.length.toString());
				
				for (var side:int = 0; side < 2; side++)
				{
					var dirx:int = 0;
					var diry:int = 0;
					var curx:int = 0;
					var cury:int = 0;
					
					var iterations:int = 0;
					
					if (side == 0)
						iterations = leftentrances.length;
					else
						iterations = rightentrances.length;
					
					for (var i:int = 0; i < iterations; i++)
					{
						dirx = -1 + (side * 2); // i.e., -1 for left, +1 for right
						diry = 0;
						
						intangplan = new Array();
						intangplan.splice(0);
						
						secretchamberplan = new Array();
						secretchamberplan.splice(0);
						
						if (side == 0)
						{
							curx = (leftentrances[i] as Point).x + dirx; // prime it
							cury = (leftentrances[i] as Point).y;
						}
						else
						{
							curx = (rightentrances[i] as Point).x + dirx; // prime it
							cury = (rightentrances[i] as Point).y;
						}
						
						
						intangplan.push(new Point(curx, cury));
						
						var bAlive:Boolean = true;
						var bValid:Boolean = true;
						
						var step:int = 0;
				
						
						while (bAlive && bValid)
						{
							curx += dirx;
							cury += diry;
							
							step++;
		
				
							if (!NearIllegal(curx, cury))
							{	
								if (rand.integer(0, 100) >= deathchance || diry == -1 || diry == 1)
								{
								
									if (rand.integer(0, 100) < wigglechance && curx % 2 == 0 && cury % 2 == 0)
									{
									
										var newdir:int = (rand.integer(0, 2) * 2) - 1;
										
										if (dirx != 0)
										{
											dirx = 0;
											diry = newdir;
										}
										else
										{
											dirx = newdir;
											diry = 0;
										}
									}
									
									for each(var checkp:Point in intangplan)
									{
										if (checkp.x == curx && checkp.y == cury)
											bValid = false;
									}
									
									intangplan.push(new Point(curx, cury));
								}
								else
								{
									bAlive = false;
									
									MakeSecretChamber(curx, cury, dirx, diry);
								}
								
							}
							else
							{
								bValid = false;
							}
						}
						
						if (intangplan.length < 6 || intangplan.length > 25)
							bValid = false;
						
						if (bValid)
						{
							for each (var p:Point in intangplan)
							{
								intangs.push(new Point(p.x, p.y));
							}
							
							for each (var sp:Point in secretchamberplan)
							{
								intangs.push(new Point(sp.x, sp.y));
								
							}
							
							for each(var intangpoint:Point in intangs)
							{
								if (intangpoint.x < 0)
								{
									intangmap[intangpoint.x * -1][intangpoint.y * -1] = Content.INTANG_CHAMBER;
									//secrets.push(new Point(intangpoint.x * -1, intangpoint.y * -1));
								}
								else if (intangmap[intangpoint.x][intangpoint.y] == 0) // Don't set 2s to 1s
								{
									intangmap[intangpoint.x][intangpoint.y] = Content.INTANG_TUNNEL;
								}
							}
						}
						else
						{
							if (side == 0)
							{
								leftentrances.splice(i, 1);
								iterations--;
								i--;
							}
							else
							{
								rightentrances.splice(i, 1);
								iterations--;
								i--;
							}
						}
					}
				}
				
				trace("Post: Secrets on left: " + leftentrances.length.toString() + "  Secrets on right: " + rightentrances.length.toString());
				/*
				// Translate point array to intangmap grid
				for each(var intangpoint:Point in intangs)
				{
					if (intangpoint.x < 0)
					{
						intangmap[intangpoint.x * -1][intangpoint.y * -1] = Content.INTANG_CHAMBER;
						//secrets.push(new Point(intangpoint.x * -1, intangpoint.y * -1));
					}
					else if (intangmap[intangpoint.x][intangpoint.y] == 0) // Don't set 2s to 1s
					{
						intangmap[intangpoint.x][intangpoint.y] = Content.INTANG_TUNNEL;
					}
				}
				*/
			}
			
			var x:int;
			var y:int; 
			for (x = upperleft.x + 5; x < lowerright.x - 5; x++)
            {
                for (y = upperleft.y + 5; y < lowerright.y - 5; y++)
                {
					if (intangmap[x][y] == 0 &&
						watermap[x - 1][y] == 0)
					{
						var bQualifiedSecretTunnel:Boolean = false;
						
						for (var xx:int = x; true ; xx++ )
						{
							if (xx == 143 && y == 126)
							{
								var c:int = 0;
							}
							
							i = backmap[0][0];
							
							if (intangmap[xx][y] == 0 &&
								intangmap[xx + 1][y] == 0 &&
								GetBackmap(xx, y - 1) == 1 && 
								GetBackmap(xx, y) == 0 &&  
								GetBackmap(xx, y + 1) == 1 &&
								watermap[xx][y - 1] == 0 &&
								watermap[xx][y] == 0 &&
								watermap[xx][y + 1] == 0 &&
								watermap[xx + 1][y] == 0)
							{
								if (!bQualifiedSecretTunnel)
								{
									if ( xx >= x + Content.nSecretTunnelMinimum)
									{
										xx = x - 1;
										bQualifiedSecretTunnel = true;
									}
								}
								else
								{
									intangmap[xx][y] = Content.INTANG_RESERVE;
								}
							}
							else
							{
								if(bQualifiedSecretTunnel && rand.integer(0, 2) != 0)
									intangmap[xx - 1][y] = 0; // "Undo" last one
									
								break;
							}
						}
						
						if (bQualifiedSecretTunnel && rand.integer(0, 2) != 0)
						{
							intangmap[x][y] = 0; // "Undo" first one
						}
					}
				}
			}
			
			//Iterate through grid and clamp "hint reveals" if legal
			
			for (x = 0; x < this.width; x++)
            {
                for (y = 0; y < this.height - 1; y++)
                {
					
					
					if (intangmap[x][y] == Content.INTANG_CHAMBER && intangmap[x][y + 1] != 1)
					{
						intangmap[x][y] = 0;
						SetBackmap(x, y, 0);
						chambermap[x][y] = 1;
						secrets.push(new Point(x, y));
					}
				}
			}
			
			
		}
		
		public function GrowIce(starts:int):Array
		{
			var checkmap:Array = Util.Clone(map);
			
			var checkers:Array = new Array();
            
			var generalstop:int = 30;
			var fuels:Array = new Array();
			
			
			
			
			
			for (var starti:int = 0; starti < starts; starti++)
			{
				var xx:int = rand.integer(50, width - 50);
				var yy:int = rand.integer(50, width - 50);
				var fails:int = 0;
				
				do
				{
					fails++;
					if (fails > 500)
					{
						trace("Not finding ice spots [] [] [] [] [] [] []");
						break;
					}
					xx = rand.integer(50, width - 50);
					yy = rand.integer(50, width - 50);
				} while (!ValidIceStart(xx, yy));
				
				fuels.push(rand.integer(Content.iIceFuelMin, Content.iIceFuelMax));
				checkmap[xx][yy] = 10 + starti;
				checkers.push(new Point(xx, yy));
			}
			
			if (fails <= 500)
			{
				while (checkers.length > 0)
				{
					var oldcheckers:Array = new Array();

					for each (var pt:Point in checkers)
					{
						oldcheckers.push(new Point());
						oldcheckers[oldcheckers.length - 1] = pt;
					}
					
					var i:int = 0;
					
					for (i = 0; i < oldcheckers.length; i++)
					{
						var tocheck:Point = oldcheckers[i] as Point;
						var species:int = checkmap[tocheck.x][tocheck.y];
						
						if (fuels[species - 10] > 0)
						{
							if (tocheck.y > 0)
							{
								if (ValidForIce(tocheck.x, tocheck.y - 1) == true && checkmap[tocheck.x][tocheck.y - 1] < 3)
								{
									checkmap[tocheck.x][tocheck.y - 1] = species;
									
									if (rand.integer(1, 100) > generalstop)
									{
										fuels[species - 10]--;
										checkers.push(new Point(tocheck.x, tocheck.y - 1));
									}
								}
							}

							if (tocheck.y < height - 1)
							{
								if (ValidForIce(tocheck.x, tocheck.y + 1) == true && checkmap[tocheck.x][tocheck.y + 1] < 3)
								{
									checkmap[tocheck.x][tocheck.y + 1] = species;
									
									if (rand.integer(1, 100) > generalstop)
									{
										fuels[species - 10]--;
										checkers.push(new Point(tocheck.x, tocheck.y + 1));
									}
								}
							}

							if (tocheck.x > 0)
							{
								if (ValidForIce(tocheck.x - 1, tocheck.y) == true && checkmap[tocheck.x - 1][tocheck.y] < 3)
								{
									checkmap[tocheck.x - 1][tocheck.y] = species;
									
									if (rand.integer(1, 100) > generalstop)
									{
										fuels[species - 10]--;
										checkers.push(new Point(tocheck.x - 1, tocheck.y));
									}
								}
							}

							if (tocheck.x < width - 1)
							{
								if (ValidForIce(tocheck.x + 1, tocheck.y) == true && checkmap[tocheck.x + 1][tocheck.y]< 3)
								{
									checkmap[tocheck.x + 1][tocheck.y] = species;
									
									if (rand.integer(1, 100) > generalstop)
									{
										fuels[species - 10]--;
										checkers.push(new Point(tocheck.x + 1, tocheck.y));
									}
								}
							}
						}
					}

					for (i = 0; i < oldcheckers.length; i++)
					{
						checkers.splice(0, 1);
					}
				}
			}
			
			var ices:Array = new Array;
			
			for (var ix:int = 10; ix < this.width - 10; ix++)
            {
                for (var iy:int = 10; iy < this.height - 10; iy++)
                {
					if (checkmap[ix][iy] >= 10)
					{
						ices.push(new Point(ix, iy));
					}
					else if (watermap[ix][iy] == 1 && watermap[ix][iy - 1] == 0 && GetMap(ix, iy) == 0)
					{
						ices.push(new Point(ix, iy));
					}
				}
			}

			return ices;
		}
		
		public function ValidIceStart(x:int, y:int):Boolean
		{
			if (GetMap(x, y) != 0 ||
				watermap[x][y] != 0 ||
				spikemap[x][y] != 0 ||
				intangmap[x][y] != 0 ||
				gemmap[x][y] != 0) return false;
				
			for each(var ex:Exit in exits)
			{
				if (Util.Distance(ex.x, ex.y, x, y) <= 3)
					return false;
			}
			
			if (GetMap(x - 1,y) == 1 ||
				GetMap(x + 1,y) == 1 ||
				GetMap(x,y - 1) == 1 ||
				GetMap(x,y + 1) == 1)
				{
					return true;
				}
				
			return false;
		}
		
		public function ValidForIce(x:int, y:int):Boolean
		{
			if (GetMap(x, y) != 0 ||
				watermap[x][y] != 0 ||
				spikemap[x][y] != 0 ||
				intangmap[x][y] != 0 ||
				gemmap[x][y] != 0) return false;
				
			for each(var ex:Exit in exits)
			{
				if (Util.Distance(ex.x, ex.y, x, y) <= 3)
					return false;
			}
			
			return true;
		}
		
		public function MakeSecretChamber(startx:int, starty:int, dirx:int, diry:int):void
		{
			
			var checkmap:Array = Util.Clone(map);
			
			var checkers:Array = new Array();
            

			var groundstop:int = 60;
			var ceilingstop:int = 50;
			var generalstop:int = 30;
			var fuel:int = rand.integer(10, 20);
			
			
			
			for each (var intang:Point in intangplan)
			{
				checkmap[intang.x][intang.y] = 4;
				
				checkmap[intang.x][intang.y + 1] = 4;
				checkmap[intang.x][intang.y - 1] = 4;
				checkmap[intang.x + 1][intang.y] = 4;
				checkmap[intang.x - 1][intang.y] = 4;
				checkmap[intang.x - 1][intang.y + 1] = 4;
				checkmap[intang.x + 1][intang.y - 1] = 4;
				checkmap[intang.x + 1][intang.y + 1] = 4;
				checkmap[intang.x - 1][intang.y - 1] = 4;
				
			}
			
			checkmap[startx][starty] = 3;
			
			startx += dirx;
			starty += diry;
			
			checkmap[startx][starty] = 3;
			checkers.push(new Point(startx, starty));
			
            while (checkers.length > 0)
            {
				var oldcheckers:Array = new Array();

				for each (var pt:Point in checkers)
				{
					oldcheckers.push(new Point());
					oldcheckers[oldcheckers.length - 1] = pt;
				}
				
				var i:int = 0;
				
                for (i = 0; i < oldcheckers.length; i++)
                {
                    var tocheck:Point = oldcheckers[i] as Point;
							
					if (fuel > 0)
					{
						if (tocheck.y > 0)
						{
							if (NearIllegal(tocheck.x, tocheck.y - 1) == false && checkmap[tocheck.x][tocheck.y - 1] < 3)
							{
								checkmap[tocheck.x][tocheck.y - 1] = 3;
								
								if (rand.integer(1, 100) > ceilingstop)
								{
									fuel--;
									checkers.push(new Point(tocheck.x, tocheck.y - 1));
								}
							}
						}

						if (tocheck.y < height - 1)
						{
							if (NearIllegal(tocheck.x, tocheck.y + 1) == false && checkmap[tocheck.x][tocheck.y + 1] < 3)
							{
								checkmap[tocheck.x][tocheck.y + 1] = 3;
								
								if (rand.integer(1, 100) > groundstop)
								{
									fuel--;
									checkers.push(new Point(tocheck.x, tocheck.y + 1));
								}
							}
						}

						if (tocheck.x > 0)
						{
							if (NearIllegal(tocheck.x - 1, tocheck.y) == false && checkmap[tocheck.x - 1][tocheck.y] < 3)
							{
								checkmap[tocheck.x - 1][tocheck.y] = 3;
								
								if (rand.integer(1, 100) > generalstop)
								{
									fuel--;
									checkers.push(new Point(tocheck.x - 1, tocheck.y));
								}
							}
						}

						if (tocheck.x < width - 1)
						{
							if (NearIllegal(tocheck.x + 1, tocheck.y) == false && checkmap[tocheck.x + 1][tocheck.y]< 3)
							{
								checkmap[tocheck.x + 1][tocheck.y] = 3;
								
								if (rand.integer(1, 100) > generalstop)
								{
									fuel--;
									checkers.push(new Point(tocheck.x + 1, tocheck.y));
								}
							}
						}
					}
				}

                for (i = 0; i < oldcheckers.length; i++)
                {
                    checkers.splice(0, 1);
                }
            }
			
			for (var x:int = 0; x < this.width; x++)
            {
                for (var y:int = 0; y < this.height; y++)
                {
					if (checkmap[x][y] == 3)
					{
						secretchamberplan.push(new Point(x * -1, y * -1));
						secrets.unshift(new Point(x, y));
						
					}
				}
			}

			return;
		}
		
		public function NearIllegal(xtest:int, ytest:int):Boolean
		{
			if (xtest < 0 || xtest >= this.width || ytest < 0 || ytest >= this.height)
				return false;
			
			for (var x:int = xtest - 1; x <= xtest + 1; x++)
            {
                for (var y:int = ytest - 1; y <= ytest + 1; y++)
                {
					if (GetMap(x, y) != 1 || watermap[x][y] >= 1 || chambermap[x][y] >= 1 || intangmap[x][y] >= 1)
					{
						return true;
					}
				}
			}
			
			return false;
		}
		
		public function NearIntang(xtest:int, ytest:int):Boolean
		{
			
			return false;
		}
		
		public var candidatelists:Array = null;
        public function MakeSecrets():void
        {
            secrets.splice(0);
			floorsecrets.splice(0);

			candidatelists = new Array();
			var exitlist:Array = new Array();

			var i:int = 0;
			var n:int = 0;

            for (i = 0; i < exits.length; i++)
            {
				if ((exits[i] as Exit).id != 99)
				{
					var thisexit:Array = new Array();
					thisexit.push(exits[i]);
					
					candidatelists.push(GetCandidates(thisexit));

					exitlist.push(exits[i]);
				}
            }
			
            candidatelists.push(GetCandidates(exitlist));

			var length:int = (candidatelists[0] as Array).length;
			
            for (var c:int = 1; c < candidatelists.length; c++)
            {
                for (n = 0; n < length; n++)
                {
                    if((candidatelists[c][n] as Exit).id > 3)
                        (candidatelists[0][n] as Exit).id += (candidatelists[c][n] as Exit).id;
                }
            }

        
            var openspaces:int = 0;
            var max:int = 0;

            for (n = 0; n < candidatelists[0].length; n++)
            {
                var mindistance:Number = 10;
                var tooclose:Boolean = false;

                for (i = 0; i < exits.length; i++)
                {
                    if (
						Math.sqrt(
							Math.pow((exits[i] as Exit).x - (candidatelists[0][n] as Exit).x, 2) +
							Math.pow((exits[i] as Exit).y - (candidatelists[0][n] as Exit).y, 2)
							) < mindistance)
                    {
                        tooclose = true;
                        break;
                    }
                }

                if (/*GetMap((candidatelists[0][n] as Exit).x, (candidatelists[0][n] as Exit).y + 1) != 1 ||*/ tooclose)
                {
                    (candidatelists[0] as Array).splice(n, 1);
                    n--;
                }
                else
                {
                    if ((candidatelists[0][n] as Exit).id > 4)
                    {
                        if ((candidatelists[0][n] as Exit).id > max)
                            max = (candidatelists[0][n] as Exit).id;

                        openspaces++;
                    }
                }
                
            }

            var top:int = openspaces; // / 5;
			
            candidatelists[0].sort(ExitSorter);

            for (i = 0; i < top; i++)
            {
			
				secrets.push(new Point((candidatelists[0][i] as Exit).x, (candidatelists[0][i] as Exit).y));
				
				if (GetMap((candidatelists[0][i] as Exit).x, (candidatelists[0][i] as Exit).y + 1) == 1)
				{
					floorsecrets.push(new Point((candidatelists[0][i] as Exit).x, (candidatelists[0][i] as Exit).y));
				}
			
            }
			
			KillNonwallSecrets();
        }
		
		public function KillNonwallSecrets():void
		{
			for (var i:int = 0; i < secrets.length; i++)
			{
				if (wallmap[(secrets[i] as Point).x][(secrets[i] as Point).y] == 0)
				{
					secrets.splice(i, 1);
					i--;
				}
			}
		}
		
		public function ExitSorter(a:Exit, b:Exit):int
		{
			if (a.id < b.id) 
				return 1;
			else if (a.id > b.id) 
				return -1;
			else 
				return 0;
		}

        public function GetCandidates(checkers:Array):Array
        {
			var checkmap:Array = Util.Clone(map);
			

			
            while (checkers.length > 0)
            {
                var oldcheckers:Array = new Array();// Util.Clone(checkers);

				for each (var ex:Exit in checkers)
				{
					oldcheckers.push(new Point());
					oldcheckers[oldcheckers.length - 1] = ex;
				}

				var i:int = 0;
                for (i = 0; i < oldcheckers.length; i++)
                {

                    var tocheck:Exit = oldcheckers[i] as Exit;

                    if (tocheck.y > 0)
                    {
                        if (checkmap[tocheck.x][tocheck.y - 1] == 0 || checkmap[tocheck.x][tocheck.y - 1] == 2)
                        {
                            checkmap[tocheck.x][tocheck.y - 1] = checkmap[tocheck.x][tocheck.y] + 5;
                            checkers.push(new Exit(tocheck.x, tocheck.y - 1, 0));
                        }
                    }

                    if (tocheck.y < height - 1)
                    {
                        if (checkmap[tocheck.x][tocheck.y + 1] == 0 || checkmap[tocheck.x][tocheck.y + 1] == 2)
                        {
                            checkmap[tocheck.x][tocheck.y + 1] = checkmap[tocheck.x][tocheck.y] + 5;
                            checkers.push(new Exit(tocheck.x, tocheck.y + 1, 0));
                        }
                    }

                    if (tocheck.x > 0)
                    {
                        if (checkmap[tocheck.x - 1][tocheck.y] == 0 || checkmap[tocheck.x - 1][tocheck.y] == 2)
                        {
                            checkmap[tocheck.x - 1][tocheck.y] = checkmap[tocheck.x][tocheck.y] + 5;
                            checkers.push(new Exit(tocheck.x - 1, tocheck.y, 0));
                        }
                    }

                    if (tocheck.x < width - 1)
                    {
                        if (checkmap[tocheck.x + 1][tocheck.y] == 0 || checkmap[tocheck.x + 1][tocheck.y] == 2)
                        {
                            checkmap[tocheck.x + 1][tocheck.y] = checkmap[tocheck.x][tocheck.y] + 5;
                            checkers.push(new Exit(tocheck.x + 1, tocheck.y, 0));
                        }
                    }
                }

                for (i = 0; i < oldcheckers.length; i++)
                {
                    checkers.splice(0, 1);
                }
            }

            var candidates:Array = new Array();

            for (var x:int = upperleft.x; x < lowerright.x; x++)
            {
                for (var y:int = upperleft.y; y < lowerright.y; y++)
                {
                    var weight:int = checkmap[x][y];
                 
                    candidates.push(new Exit(x, y, weight));
					
					if (weight > 1)
						var a:int = 1;
                }
            }

            return candidates;
        }
		
		public function DestroyFakeExits():void
		{
			for (var ex:int = 0; ex < exits.length; ex++)
			{
                if ((exits[ex] as Exit).id == 99)
				{
					exits.splice(ex, 1);
					ex--;
				}
            }
		}
		
		public function MakeWall(variant:int = 0):void
        {
			
			
			var xx:int = 0;
			var yy:int = 0;
			var lifetime:int = (((lowerright.x - upperleft.x) + (lowerright.y - upperleft.y)) / 2) / 2; // /2 for average, then /2 for taste
			
			wallmap = Util.Clone(map);//new Array();
			/*
			for (var xx:int = 0; xx < width; xx++)
			{
				wallmap.push(new Array());
				for (var yy:int = 0; yy < height; yy++)
				{
					(wallmap[xx] as Array).push(0);
				}
			}
			*/
			
			for each (var fillexit:Exit in exits)
			{
				wallmap[fillexit.x][fillexit.y] = 1;
				wallmap[fillexit.x][fillexit.y - 1] = 1;
				wallmap[fillexit.x][fillexit.y - 2] = 1;
			}
			
			brush = 1;
			
			for each (var start:Exit in exits)
			{
				var checkers:Array = new Array();
				
				checkers.push(new Exit(start.x, start.y, 1));
				
				while (checkers.length > 0)
				{
					var oldcheckers:Array = new Array();// Util.Clone(checkers);

					for each (var ex:Exit in checkers)
					{
						oldcheckers.push(new Exit(ex.x, ex.y, ex.id));
					}

					var i:int = 0;
					for (i = 0; i < oldcheckers.length; i++)
					{

						var tocheck:Exit = oldcheckers[i] as Exit;
						
						brush = tocheck.id;

						if (tocheck.y > 0)
						{
							if (wallmap[tocheck.x][tocheck.y - 1] == 0)
							{
								if (ConsiderFlipping(tocheck.x, tocheck.y, brush) == true)
									brush = FlipBrush(brush);
									
								wallmap[tocheck.x][tocheck.y - 1] = brush;
								checkers.push(new Exit(tocheck.x, tocheck.y - 1, brush));
							}
						}
						
						brush = tocheck.id;

						if (tocheck.y < height - 1)
						{
							if (wallmap[tocheck.x][tocheck.y + 1] == 0)
							{
								if (ConsiderFlipping(tocheck.x, tocheck.y, brush) == true)
									brush = FlipBrush(brush);
									
								wallmap[tocheck.x][tocheck.y + 1] = brush;
								checkers.push(new Exit(tocheck.x, tocheck.y + 1, brush));
							}
						}
						
						brush = tocheck.id;

						if (tocheck.x > 0)
						{
							if (wallmap[tocheck.x - 1][tocheck.y] == 0)
							{
								if (ConsiderFlipping(tocheck.x, tocheck.y, brush) == true)
									brush = FlipBrush(brush);
									
								wallmap[tocheck.x - 1][tocheck.y] = brush;
								checkers.push(new Exit(tocheck.x - 1, tocheck.y, brush));
							}
						}
						
						brush = tocheck.id;

						if (tocheck.x < width - 1)
						{
							if (wallmap[tocheck.x + 1][tocheck.y] == 0)
							{
								if (ConsiderFlipping(tocheck.x, tocheck.y, brush) == true)
									brush = FlipBrush(brush);
									
								wallmap[tocheck.x + 1][tocheck.y] = brush;
								checkers.push(new Exit(tocheck.x + 1, tocheck.y, brush));
							}
						}
					}

					for (i = 0; i < oldcheckers.length; i++)
					{
						checkers.splice(0, 1);
					}
					
					for (i = 0; i < checkers.length; i++)
					{
						if ((checkers[i] as Exit).id == 1)
						{
							if (rand.integer(0, 100) <= momentum)
							{
								(checkers[i] as Exit).id = 2;
							}
						}
						else if ((checkers[i] as Exit).id == 2)
						{
							if (rand.integer(0, 100) <= momentum)
							{
								(checkers[i] as Exit).id = 1;
							}
						}
						
						
						if (rand.integer(0, lifetime) == 0)
						{
							checkers.splice(i, 1);
							i--;
						}
					}
					
					checkers = Shuffle(checkers);
				} // while checkers > 0
			} // for each exit
			
			for (xx = 0; xx < width; xx++)
			{
				for (yy = 0; yy < height; yy++)
				{
					if (wallmap[xx][yy] == 2)
						wallmap[xx][yy] = 0;
					else 
						wallmap[xx][yy] = 1;
				}
			}
			
			DestroyFakeExits();
			
			for each (var finalexit:Exit in exits)
			{
				wallmap[finalexit.x][finalexit.y - 1] = 1;
				wallmap[finalexit.x][finalexit.y] = 1;
				wallmap[finalexit.x - 1][finalexit.y - 1] = 1;
				wallmap[finalexit.x + 1][finalexit.y - 1] = 1;
				wallmap[finalexit.x - 1][finalexit.y] = 1;
				wallmap[finalexit.x + 1][finalexit.y] = 1;
				
				SetMap(finalexit.x, finalexit.y - 1, 0);
				SetMap(finalexit.x, finalexit.y, 0);
				
				if (finalexit.id == 0)
				{
					for (xx = finalexit.x - 1; xx <= finalexit.x + 1; xx++)
					{
						for (yy = 0; yy < finalexit.y + 1; yy++)
						{
							wallmap[xx][yy] = 1;
						}
					}
				}
				else if (finalexit.id == 1)
				{
					for (xx = finalexit.x - 1; xx <= finalexit.x + 1; xx++)
					{
						for (yy = finalexit.y - 1; yy < this.height; yy++)
						{
							wallmap[xx][yy] = 1;
						}
					}
				}
				else if (finalexit.id == 3)
				{
					for (xx = finalexit.x - 1; xx < this.width; xx++)
					{
						for (yy = finalexit.y - 1; yy <= finalexit.y + 1; yy++)
						{
							wallmap[xx][yy] = 1;
						}
					}
				}
				else if (finalexit.id == 2)
				{
					for (xx = 0; xx <= finalexit.x + 1; xx++)
					{
						for (yy = finalexit.y - 1; yy <= finalexit.y + 1; yy++)
						{
							wallmap[xx][yy] = 1;
						}
					}
				}
			}
			
			/* temporary garbage to try roots
			for (xx = 10; xx < width - 10; xx++)
			{
				for (yy = 10; yy < height - 10; yy++)
				{
					if (wallmap[xx][yy] == 1)
					{
						if (wallmap[xx][yy - 1] == 1)
						{
							wallqualmap[xx][yy] = 1;
						}
						else if (wallmap[xx][yy - 1] == 0 &&
							(wallmap[xx - 1][yy] == 1 || wallmap[xx + 1][yy] == 1) &&
							wallmap[xx][yy + 1] == 1)
						{
							wallqualmap[xx][yy] = 1;
						}
					}
					
				}
			}*/
			
			var startpoints:Array = new Array();
		
			for (xx = 10; xx < width - 10; xx++)
			{
				for (yy = 10; yy < height - 10; yy++)
				{
					if (wallmap[xx][yy] == 1 && GetMap(xx, yy) == 0 && GetMap(xx, yy - 1) == 1 && GetMap(xx, yy - 2) == 1 &&
						(xx + yy) % 4 == 0)
					{
						startpoints.push(new PointPlus(xx, yy - 1, "d"));
					}
				}
			}
			
			var cuts:int = startpoints.length / 7;
			for (i = 0; i < cuts; i++)
			{
				var which:int = rand.integer(0, startpoints.length);
				startpoints.splice(which, 1);
			}
			
			while(startpoints.length > 0)
			{
				var thispoint:PointPlus = (startpoints[0] as PointPlus);
				var travelx:int = thispoint.x;
				var travely:int = thispoint.y;
				
				while (true)
				{
					if (travelx == 147 && travely == 136)
					{
						var a:int = 2;
					}
					
					if (travelx == 151 && travely == 136)
					{
						var b:int = 2;
					}
					
					if ((thispoint.obj as String) == "d")
					{
						AddRoot(travelx, travely);
						travely++;
						if (wallmap[travelx][travely + 1] == 0 ||
							wallqualmap[travelx - 1][travely] == 1 ||
							wallqualmap[travelx][travely + 1] == 1 ||
							wallqualmap[travelx + 1][travely] == 1
							)
						{
							AddRoot(travelx, travely);
							startpoints.splice(0, 1);
							break;
						}
						else if (rand.integer(0, 5) == 0 && int(travelx) % 2 == 0)
						{
							AddRoot(travelx, travely);
							
							if (wallmap[travelx - 1][travely] == 1 && rand.integer(0, 3) != 0)
								startpoints.push(new PointPlus(travelx - 1, travely, "l"));
								
							if (wallmap[travelx + 1][travely] == 1 && rand.integer(0, 3) != 0)
								startpoints.push(new PointPlus(travelx + 1, travely, "r"));
								
							startpoints.splice(0, 1);
							break;
						}
					}
					else if ((thispoint.obj as String) == "r")
					{
						AddRoot(travelx, travely);
						travelx++;
						if (wallqualmap[travelx][travely - 1] == 1 ||
							wallqualmap[travelx + 1][travely] == 1 ||
							wallqualmap[travelx][travely + 1] == 1)
						{
							AddRoot(travelx, travely);
							startpoints.splice(0, 1);
							break;
						}
						else if(wallmap[travelx + 1][travely] == 0 || rand.integer(0, 5))
						{
							AddRoot(travelx, travely);
							startpoints.push(new PointPlus(travelx, travely + 1, "d"));
							startpoints.splice(0, 1);
							break;
						}
						else if (rand.integer(0, 14))
						{
							//startpoints.push(new PointPlus(travelx, travely + 1, "d"));
						}
					}
					else if ((thispoint.obj as String) == "l")
					{
						AddRoot(travelx, travely);
						travelx--;
						if (wallqualmap[travelx][travely - 1] == 1 ||
							wallqualmap[travelx - 1][travely] == 1 ||
							wallqualmap[travelx][travely + 1] == 1)
						{
							AddRoot(travelx, travely);
							startpoints.splice(0, 1);
							break;
						}
						else if(wallmap[travelx - 1][travely] == 0 || rand.integer(0, 5))
						{
							AddRoot(travelx, travely);
							startpoints.push(new PointPlus(travelx, travely + 1, "d"));
							startpoints.splice(0, 1);
							break;
						}
						else if (rand.integer(0, 14))
						{
							//startpoints.push(new PointPlus(travelx, travely + 1, "d"));
						}
					}
					
					if (GetMap(travelx, travely) == 1 &&  
						GetMap(travelx, travely - 1) == 1)
						{
							startpoints.splice(0, 1);
							break;
						}
				}
			}
		}
		
		public function AddRoot(xx:int, yy:int):void
		{
			wallqualmap[xx][yy] = 1;
			wallmap[xx][yy] = 1;
		}
		
		public function ConsiderFlipping(xx:int, yy:int, brush:int):Boolean
		{
			return false;
			
			if (wallmap[xx - 1][yy] == 1 && wallmap[xx + 1][yy] == 1 && rand.integer(0, 2) == 0)
			{
				return true;
			}
			else if (wallmap[xx][yy - 1] == 1 && wallmap[xx][yy + 1] == 1 && rand.integer(0, 2) == 0)
			{
				return true;
			}
			
			return false;
		}
		
		public function FlipBrush(brush:int):int
		{
			if (brush == 2)
				return 1;
			else
				return 2;
		}
		
		public function GenerateGem():int
		{
			var gem:int = 0;
			
			var roll:int = rand.integer(0, 100);
			
			if (roll >= (Content.nGemChance * 100))
			{
				return 0;
			}
			
			roll = rand.integer(0, 1000);
			
			if (roll < (Content.nLytratChance * 1000))
			{
				gem = 5;
			}
			else if (roll < (Content.nReodChance * 1000) + (Content.nLytratChance * 1000))
			{
				gem = 3;
			}
			else
			{
				gem = 1;
			}
			
			roll = rand.integer(0, 100);
			
			if (roll < (Content.nClusterChance * 100))
			{
				gem += 1;
			}
			
			return gem;
		}
		
		public function MakeGems():void
		{
			for (var pt:int = 0; pt < secrets.length / 3; pt++)
			{
				if (spikemap[(secrets[pt] as Point).x][(secrets[pt] as Point).y] == 0)
				{
					gemmap[(secrets[pt] as Point).x][(secrets[pt] as Point).y] = GenerateGem();
				}
			}
			
			for (pt = secrets.length / 3; pt < secrets.length; pt++)
			{
				if (chambermap[(secrets[pt] as Point).x][(secrets[pt] as Point).y] == 1)
				{
					if (spikemap[(secrets[pt] as Point).x][(secrets[pt] as Point).y] == 0)
					{
						gemmap[(secrets[pt] as Point).x][(secrets[pt] as Point).y] = GenerateGem();
					}
				}
			}
		}
		
		public function ApplyMiracles():void
		{
			MiracleManager.IntegrateZoneMiracles();
			MiracleManager.PopulateZoneMiracles(this.description.coords.x, this.description.coords.y);
			
			for each(var m:Miracle in MiracleManager.arrayZoneMiracles)
			{
				if (m.universal)
				{
					if (m.id == Content.BLANK)
					{
						SetMap(m.x, m.y, 0);
					}
					else if(m.id == Content.TERRAIN)
					{
						SetMap(m.x, m.y, 1);
					}
					else if (m.id == Content.FACADE)
					{
						facademap[m.x][m.y] = int(m.strData);
					}
					else if (m.id == Content.WALLPAPER)
					{
						wallpapermap[m.x][m.y] = int(m.strData);
					}
				}
				else // profile
				{
					if (m.id == 0)
					{
						gemmap[m.x][m.y] = 0;
					}
				}
			}
		}
		
		public function Finish():void
		{
			waterlist.splice(0);
			
			for (var xx:int = 0; xx < width; xx++)
			{
				for (var yy:int = 1; yy < height; yy++)
				{
					if (watermap[xx][yy] == 1 && watermap[xx][yy - 1] == 0)
						waterlist.push(new PointPlus(xx, yy, "s"));
					else if (watermap[xx][yy] == 1)
						waterlist.push(new PointPlus(xx, yy, ""));
						
					if (intangmap[xx][yy] == Content.INTANG_RESERVE)
					{
						SetMap(xx, yy, 1);
						intangmap[xx][yy] = Content.INTANG_TUNNEL;
					}
				}
			}
		}
	}
}