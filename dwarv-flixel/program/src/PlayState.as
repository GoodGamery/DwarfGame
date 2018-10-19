package
{
	import adobe.utils.CustomActions;
	import flash.events.AsyncErrorEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import Hud.HUD;
	import Hud.MapNode;
	import Hud.Grunt;
	import Map.*;
	import org.flixel.*;
	import Mon.*;
	import Tasks.*;
	import Particles.*
 
	public class PlayState extends FlxState
	{
		public var bUpdateBreak:Boolean = true; // TODO remove this...
		
		public var firstzone:Boolean = false; // TRUE if you want a blank zone to play with
		public var bMonsters:Boolean = true; // TRUE if you want shroomstorm
		public var bSingleMonster:Boolean = false;
		public var song:Boolean = true; // TRUE if you want sample music
		public var bMikeAndSally:Boolean = false; // TRUE if you want our sample NPC couple
		public var bShowSecretPassages:Boolean = false;
		public var bShowChambers:Boolean = false;
		public var bDoorPan:Boolean = false;
		public var nSaturation:Number = 0;
		
		public var genus:String = "wallpaper";
		
		public var bPauseFarMonsters:Boolean = true;
		public var bBlackOuter:Boolean = true;
		public var nOuterDistance:Number = 2.5;
		
		public var state:int = 0;
		public var colTransLevel:ColorTransform;
		
		public var genustext:FlxText;
		public var coordstext:FlxText;
		public var totalgen:int = 0;
		public var debugtext:FlxText;
		public var distext:FlxText;
		public var level:FlxTilemap;
		public var lillevel:FlxTilemap;
		public var wall:FlxTilemap;
		public var interim_level:FlxTilemap;
		public var interim_wall:FlxTilemap;
		public var wallpaper:FlxTilemap;
		public var facade:FlxTilemap;
		
		public var monkpoints:Array;
		public var hud:HUD;
		public var oldregion:String = "";
		
		
		//public var arrayShapeBoard:Array = new Array();
		public var arrayArrows:Array = null;
		public var groupArrows:FlxGroup = null;
		public var arrayPellets:Array = null;
		public var groupPellets:FlxGroup = null;
		public var arrayParticles:Array = null;
		public var groupParticles:FlxGroup = null;
		public var groupMonsters:FlxGroup = null;
		public var groupFrontMonsters:FlxGroup = null;
		public var arrayGrunts:Array = null
		public var groupGrunts:FlxGroup = null;
		public var groupDoors:FlxGroup = null;
		public var groupPeppers:FlxGroupXY = null;
		
		
		public var hero:Player;
		public var spotlight:FlxSprite;
		public var hover:FlxSprite;
		public var bow:FlxSprite;
		public var dolly:FlxObject;
		public var dollyoffset:Number = 0;
		public var camera:FlxCamera;
		public var starring:Talker = null;
		public var iSPC:int = 0;
		public var iLineState:int = Content.NEWLINE;
		public var iDeadState:int = Content.JUSTDIED;
		
		
		public var commands:Array = null;
		public var zone:Zone = null;
		
		
		
		public var bMovedOnce:Boolean = false;
		public var ready:Boolean = false;
		public var camefrom:int = 0;
		
		
		
		public var monktext:Array =
			["Hello! Good work finding me. Me and my brethren can be sly sometimes.",
			"Augh! You call that a hairstyle?! Begone!",
			"Imagine a cave with infinite potatoes in it. But is not a cave defined by its having some empty space? Woooo wooo woo",
			"Some of my brethren breathe air; the others breathe water.",
			"Have you found the BrAnD nEw BiOmE yet!? I have, it looks kinda weird.",
			"The dwarves have a deep heritage of forgetting important things so they become cool secrets to search for.",
			"There is no end to what you can find in... THE WORLD UNDER.",
			"I hate ambigrams. I can never read what they say.",
			"Do you think the worldmountain was procedurally generated, or do you think it was made by a Creator?",
			"The worldmountain is infested with death shrooms on this build! Feel no moral qualms about slaughtering them.",
			"The thing that makes death shrooms annoying is that they bounce when you strike them, making subsequent strikes more difficult.",
			"Help! I'm stuck in a time bubble! I should be 5 minutes ago.",
			"Did you know that the Salama have adapted to having no eyeballs? Creepy.....",
			"The hacky force effect you experience when you get struck by an enemy doesn't work very well in water right now.",
			"You promised to get me my medicine in time! Now it's too... too late... *hack*....... dead"];
		
		
		override public function create():void
		{
			MiracleManager.LoadMiracles();
						
			Content.biomes = new Array();
			Content.biomes.push(new Biome(Content.cBackForest, 0, 0));
			Content.biomes.push(new Biome(Content.cBackSwamp, 1, 1));
			Content.biomes.push(new Biome(Content.cBackIce, 2, 2));
			Content.biomes.push(new Biome(Content.cBackSand, 3, 3));
			Content.biomes.push(new Biome(Content.cBackDeadwater, 4, 4));
			Content.biomes.push(new Biome(Content.cBackVents, 5, 5));
			Content.biomes.push(new Biome(Content.cBackColumns, 6, 6));
			Content.biomes.push(new Biome(Content.cBackAmber, 7, 7));
			Content.biomes.push(new Biome(Content.cBackStone, 8, 8));
			
			LoadFiles();
			
			

			FlxG.mouse.hide();
			
			camefrom = 1;

			MiracleManager.SetOverride(new Miracle(0, 0, 107, 128, Content.DUDE, "Jerome^0^0^0^0x064FF6^0xCB8B46^0x29065E^0x7E9944^0x5F99B4^say Hey, Mike!^say Shut up...........^bye", 1));
			MiracleManager.SetOverride(new Miracle(497, 3, 145, 134, Content.SIGNPOST, "Sign^say Hi Molly, I'm a sign.^bye", 1));
			
			
			//LoadZone( -1, 2); // pretty good starter
			//LoadZone( 380, 841); // pretty good starter
			
			//LoadZone(246, 2);
			
			
			//LoadZone(Util.Random(-1000, 1000), Util.Random(0, 2000));
			
			
			var startx:int = -615; //297 //-615; //-1 //-1024
			var starty:int = 3; //3
			
			// -1, 1
			
			// 497, 3 <- one of the best starts
			
			camefrom = 2;
			
			Content.stats.cavemap = new CaveMap(startx, starty, 0);		
			Content.stats.cavemap.ExploreCave(startx, starty);
			LoadZone(startx, starty);
		}
		
		public function LoadFiles():void
		{
			Util.LoadLanguage();
			Util.LoadBiomeParameters();
		}
		
		public var nDeadWait:Number = Content.nDeadWaitTime;
		public var bWasDead:Boolean = false;
		public var zonehistory:Array = new Array();
		public var bReloading:Boolean = false;
		public var nElapsedInZone:Number = 0;
		public function LoadZone(x:int, y:int):void
		{	
			FlxG.clearBitmapCache();
			
			var radius:int = 0;
			if (hud == null)
			{
				hud = add(new HUD(this)) as HUD;
				
				
				Content.stats.cavemap.RefreshBorders();
				Content.stats.cavemap.UpdateSprites((Content.screenwidth / 2) - 6 + 1, (Content.screenheight / 2) - 6 + 36 + 1, x, y, 
					3);
				Content.stats.cavemap.AddSpritesToHUD(hud.cavecanvasload, x, y, 
					(268 / 2) - 6, 
					(268 / 2) - 6,
					188 + 9,
					134 + 9,
					88,
					88,
					false);
				
			}
			else
				add(hud);
				
			Content.stats.hud = hud;

			
			// Heal!
			Content.stats.iHealth = Content.stats.iMaxHealth;
			hud.UpdateHearts();
							
			hud.pausable = false;
			hud.LoadVisible(true);
			hud.SetBars(1);
			if (camefrom == 0)
				camefrom = 1;
			else if (camefrom == 1)
				camefrom = 0;
			else if (camefrom == 2)
				camefrom = 3;
			else if (camefrom == 3)
				camefrom = 2;
				
			hud.SetLoadDirection(camefrom, bWasDead);
			
			arrayArrows = new Array();
			arrayPellets = new Array();
			arrayParticles = new Array();
			arrayAllMonsters = new Array();
			arrayFarMonsters = new Array();
			arrayNearMonsters = new Array();
			arrayAllGems = new Array();
			arrayGrunts = new Array();
			
			commands = new Array();
			ready = false;
			state = Content.LOADING;
			//ptDeviation.x = 60; ptDeviation.y = 30;
			//ptTargetDeviation.x = 60; ptTargetDeviation.y = 0;
			
			var inhistory:int = ZoneInHistory(x, y);
			
			hud.loadtext.text = "";
			
			if(inhistory > -1)
			{
				bReloading = true;
				
				zone = new Zone();
				zone.CopyZone(zonehistory[inhistory]);
				hud.loadtext.text = "[Reload] 99%";
				
				commands.push(new GenCommand("Reload", 0, 0, 0));
				
				

				commands.push(new GenCommand("ApplyMiracles", 0, 0, 0));
				
				totalgen = 2;
				
				var iTotalGarbage:int = 60;
				
				if (bWasDead)
					iTotalGarbage = 20;
				
				for (var garbage:int = 0; garbage < iTotalGarbage; garbage++)
				{
					totalgen++;
					commands.push(new GenCommand("gar", 0, 0, 0));
				}
				
				commands.push(new GenCommand("100%", 0, 0, 0));
				commands.push(new GenCommand("", 0, 0, 0));
				
				//hud.SetLoadProgress(100);
			}
			else
			{
				bReloading = false;
				
				hud.SetLoadProgress(0);
				zone = new Zone();
				NewZone(x, y);
			}
			

		}
		
		public function ZoneInHistory(x:int, y:int):int
		{
			for (var i:int = 0; i < zonehistory.length; i++)
			{
				if ((zonehistory[i] as Zone).description.coords.x == x && (zonehistory[i] as Zone).description.coords.y == y)
				{
					trace("IN HISTORY!");
					return i;
				}
			}
			
			trace("NOT in history......");
			return -1;
		}
		
		public function NewZone(x:int, y:int):void
		{
			
			
			zone = new Zone();
			
			zone.InitZone(x, y);
			
			hud.loadtext.visible = Content.debugtexton;
			hud.loadtext.text = "(" + zone.description.coords.x.toString() + "," + zone.description.coords.y.toString() + ")";
			
			
			
			//var pools:int = 30;
			
			//zone.rand.report = true;
			
			var i:int = 0;
			var v:int = 0;
			
			var size:int = zone.rand.integer((Content.biomes[zone.description.style] as Biome).bounds[0], (Content.biomes[zone.description.style] as Biome).bounds[1]) * 1;
			
			if (x % 2 != y % 2)
				size *= 1.5;
			
			var cinch:Number = zone.rand.integer((Content.biomes[zone.description.style] as Biome).bounds[2], (Content.biomes[zone.description.style] as Biome).bounds[3]) / 15; // /10
			var wiggle:int = zone.rand.integer((Content.biomes[zone.description.style] as Biome).bounds[4], (Content.biomes[zone.description.style] as Biome).bounds[5]);
			
			var plats:int = zone.rand.integer((Content.biomes[zone.description.style] as Biome).bounds[7], (Content.biomes[zone.description.style] as Biome).bounds[8]);
			if (zone.rand.integer(0, 100) > (Content.biomes[zone.description.style] as Biome).bounds[6])
				plats = 0;
			var platlength:int = zone.rand.integer((Content.biomes[zone.description.style] as Biome).bounds[9], (Content.biomes[zone.description.style] as Biome).bounds[10]);
			
			if (x % 2 != y % 2)
				plats /= 2;
			
			var pillars:int = zone.rand.integer((Content.biomes[zone.description.style] as Biome).bounds[12], (Content.biomes[zone.description.style] as Biome).bounds[13]);
			if (zone.rand.integer(0, 100) > (Content.biomes[zone.description.style] as Biome).bounds[11])
				pillars = 0;
			var pillarlength:int = zone.rand.integer((Content.biomes[zone.description.style] as Biome).bounds[14], (Content.biomes[zone.description.style] as Biome).bounds[15]);
			pillarlength /= 3;
			pillars /= 3;
			
			var clumps:int = zone.rand.integer((Content.biomes[zone.description.style] as Biome).bounds[19], (Content.biomes[zone.description.style] as Biome).bounds[20]);
			var clumpsize:int = zone.rand.integer((Content.biomes[zone.description.style] as Biome).bounds[17], (Content.biomes[zone.description.style] as Biome).bounds[18]);
			
			if (plats > 5)
				clumpsize /= plats - 5;
				
			
			clumpsize = 15;
				
			if (x % 2 != y % 2)
				clumps /= 2;
			/*if (zone.rand.integer(0, 100) > (Content.biomes[zone.style] as Biome).bounds[16])
				clumps = 0;*/
			
			var rounds:int = zone.rand.integer(0, 200);
	
				
				
			var poolroll:int = zone.rand.integer(0, 100);	
			//trace ("wtf = " + poolroll.toString());
			var pools:int = zone.rand.integer((Content.biomes[zone.description.style] as Biome).bounds[22], (Content.biomes[zone.description.style] as Biome).bounds[23]);
			if (poolroll > (Content.biomes[zone.description.style] as Biome).bounds[21])
				pools = 0;
				
				
			
			//trace("poolroll = " + poolroll.toString());
			//trace("needed " + (Content.biomes[zone.style] as Biome).bounds[21].toString());
			//trace("pools = " + pools.toString());
			//trace("pool bounds were between " + (Content.biomes[zone.style] as Biome).bounds[22].toString() + " and " + (Content.biomes[zone.style] as Biome).bounds[23].toString());
			
			//zone.rand.report = false;
			
			
			
			nSaturation = 0.2;// 0.15;
			
			if (firstzone)
			{
				commands.push(new GenCommand("LineCave", size, cinch, wiggle)); 
			}
			else
			{
				// Have a chance of forcing a zone to be "open-feeling"
				if (zone.description.exits.north == false && zone.description.exits.south == false &&
					zone.rand.integer(0, 100) < Content.nOpenChance * 100)
				{
					plats *= 0.7;
					pillars *= 0.6;
					clumps *= 0.3;
					trace("forced open!!!!!!!!!!!!!!!!!!!!!!!!!!");
				}
				
				if (zone.description.exits.north == true && zone.description.exits.south == true &&
					(zone.description.exits.west == false || zone.description.exits.east == false))
				{
					plats *= 0.2;
					clumps *= 0.3;
					size = zone.rand.integer(3, 4);
					Content.nCurrentVerticalCinchCoefficient = Content.nShaftCoefficient;
					trace("forced vert!!!!!!!!!!!!!!!!!!!!!!!!!! size = " + size.toString());
				}
				else
				{
					Content.nCurrentVerticalCinchCoefficient = Content.nVerticalCinchCoefficient;
				}
				
				commands.push(new GenCommand("LineCave", size, cinch, wiggle)); 
				
				
				
				//commands.push(new GenCommand("ChewCave", 35, 7, 0));
				
				for (i = 0; i < plats; i++)
				{
					commands.push(new GenCommand("Plats", 10, platlength, 1));
				}
				
				for (i = 0; i < 10; i++)
				{
					commands.push(new GenCommand("Pixels", 0, 10, 0));
				}
				
				for (i = 0; i < pillars; i++)
				{
					commands.push(new GenCommand("Pillars", 1, pillarlength, 1));
				}
				
				
				
				for (i = 0; i < clumps; i++)
				{
					commands.push(new GenCommand("Clumps", 700, clumpsize, 1));
				}
				
				
		
				commands.push(new GenCommand("Rounds", 0, rounds, 0));
				
				
				
				

				//commands.push(new GenCommand("Plateaus", 1000, 12, 12)); 
				
				
				commands.push(new GenCommand("PurgeOnes", 100, 0, 0)); 
				
				
				//pools = 20;
				for (i = 0; i < pools; i++)
				{
					commands.push(new GenCommand("Pools", 1, 1, 1)); 
				}
			}
			
			firstzone = false;
			
			
			
			commands.push(new GenCommand("DropExits", 0, 0, 0));
			commands.push(new GenCommand("CleanUp", 0, 0, 0));
			
			commands.push(new GenCommand("MakeWall", 1, 0, 0)); // variant 1 = roots
			commands.push(new GenCommand("PurgeOnes", -1, 0, 0)); 
			commands.push(new GenCommand("MakeSecrets", 0, 0, 0));
			
			commands.push(new GenCommand("FillAccessible", 0, 0, 0));
			commands.push(new GenCommand("MakeIntangibles", 30, 7, 16));
			commands.push(new GenCommand("FillAccessible", 0, 0, 0));
			
			
			commands.push(new GenCommand("ApplyMiracles", 0, 0, 0));
			commands.push(new GenCommand("MakeSpikes", 0, 0, 0));
			commands.push(new GenCommand("MakeGems", 0, 0, 0));
			commands.push(new GenCommand("Finish", 0, 0, 0));
			
			
			totalgen = 1 + plats + clumps + pools + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1;
			
			for (var garbage:int = 0; garbage < 30; garbage++)
			{
				totalgen++;
				commands.push(new GenCommand("", 0, 0, 0));
			}
		}
		
		
		
		public function RemakeMakerMap():void
		{
			for (var x:int = 0; x < 128; x++)
			{
				for (var y:int = 0; y < 128; y++)
				{
					if (zone.intangmap[x + 64][y + 64] == 1)
					{
						hud.makerMap._pixels.setPixel(x, y, 0xFFAAFFCC);
						hud.makerMap.dirty = true;
					}
					else if (zone.GetMap(x + 64, y + 64) == 0)
					{
						hud.makerMap._pixels.setPixel(x, y, 0xFF000000);
						hud.makerMap.dirty = true;
					}
					else if (zone.GetMap(x + 64, y + 64) == 1)
					{
						hud.makerMap._pixels.setPixel(x, y, 0xFFAA6622);
						hud.makerMap.dirty = true;
					}
				}
			}
			
			for each(var ex:Exit in zone.exits)
			{
				hud.makerMap._pixels.setPixel(ex.x - 64, ex.y - 64, 0xFF0055FF);
				hud.makerMap._pixels.setPixel(ex.x - 64, ex.y - 64 - 1, 0xFF0055FF);
			}
		}
		
		public function ReportBackupMap():void
		{
			/*
			for (var x:int = 0; x < 128; x++)
			{
				for (var y:int = 0; y < 128; y++)
				{
					if (zone.wallmap[x + 64][y + 64] == 0)
					{
						hud.backupMap._pixels.setPixel(x, y, 0xFF000000);
						hud.backupMap.dirty = true;
					}
					else 
					{
						hud.backupMap._pixels.setPixel(x, y, 0xFF000055);
						hud.backupMap.dirty = true;
					}
				}
			}
			*/
			
			/*
			for (var x:int = 0; x < 128; x++)
			{
				for (var y:int = 0; y < 128; y++)
				{
					if (zone.intangmap[x + 64][y + 64] == 1)
					{
						hud.backupMap._pixels.setPixel(x, y, 0xFFAAFFCC);
						hud.backupMap.dirty = true;
					}
					else if (zone.GetBackmap(x + 64, y + 64) == 0)
					{
						hud.backupMap._pixels.setPixel(x, y, 0xFF000000);
						hud.backupMap.dirty = true;
					}
					else if (zone.GetBackmap(x + 64, y + 64) == 1)
					{
						hud.backupMap._pixels.setPixel(x, y, 0xFFAA6622);
						hud.backupMap.dirty = true;
					}
				}
			}
			
			for each(var ex:Exit in zone.exits)
			{
				hud.backupMap._pixels.setPixel(ex.x - 64, ex.y - 64, 0xFF0055FF);
				hud.backupMap._pixels.setPixel(ex.x - 64, ex.y - 64 - 1, 0xFF0055FF);
			}
			*/
			
		}
		
		public var lastcommand:String;
		public var fails:int = 0;
		public function GenFire():void
		{

			var command:GenCommand = commands[0];

			
			var failure:Boolean = false;
						

			
			RemakeMakerMap();
			hud.makerReport.text += command.name + " ";

			if (command.name == "")
			{
			
			}
			else if (command.name == "LineCave")
			{
				zone.LineCave(command.p1 as int, command.p2 as Number, command.p3 as int);
			}
			else if (command.name == "Plats")
			{
				failure = zone.ApplyFilter(zone.Plats, command.p1 as int, command.p2 as int, command.p3 as int);
			}
			else if (command.name == "Clumps")
			{
				failure = zone.ApplyFilter(zone.Clumps, command.p1 as int, command.p2 as int, command.p3 as int);
			}
			else if (command.name == "Rounds")
			{
				failure = zone.ApplyFilter(zone.Rounds, command.p1 as int, command.p2 as int, command.p3 as int);
				
			}
			else if (command.name == "Pixels")
			{
				failure = zone.ApplyFilter(zone.Pixels, command.p1 as int, command.p2 as int, command.p3 as int);
			}
			else if (command.name == "ChewCave")
			{
				failure = zone.ApplyFilter(zone.ChewCave, command.p1 as int, command.p2 as int, command.p3 as int);
			}
			else if (command.name == "Plateaus")
			{
				failure = zone.ApplyFilter(zone.Plateaus, command.p1 as int, command.p2 as int, command.p3 as int);
			}
			else if (command.name == "PurgeOnes")
			{
				failure = zone.ApplyFilter(zone.PurgeOnes, command.p1 as int, command.p2 as int, command.p3 as int);
			}
			else if (command.name == "Pools")
			{
				failure = zone.ApplyFilter(zone.Pools, command.p1 as int, command.p2 as int, command.p3 as int);
			}
			else if (command.name == "Pillars")
			{
				failure = zone.ApplyFilter(zone.Pillars, command.p1 as int, command.p2 as int, command.p3 as int);
			}
			else if (command.name == "MakeIntangibles")
			{
				failure = zone.ApplyFilter(zone.MakeIntangibles, command.p1 as int, command.p2 as int, command.p3 as int);
			}
			else if (command.name == "DropExits")
			{
				zone.DropExits();
			}
			else if (command.name == "MakeSecrets")
			{
				zone.MakeSecrets();
			}
			else if (command.name == "CleanUp")
			{
				zone.CleanUp(); // Get rid of donut holes and 1-tile pits
			}
			else if (command.name == "MakeSpikes")
			{
				zone.MakeSpikes();
			}
			else if (command.name == "MakeWall")
			{
				zone.MakeWall(command.p1 as int);
			}
			else if (command.name == "FillAccessible")
			{
				zone.FillAccessible();
			}
			else if (command.name == "MakeGems")
			{
				zone.MakeGems();
			}
			else if (command.name == "ApplyMiracles")
			{
				zone.ApplyMiracles();
			}
			else if (command.name == "Finish")
			{
				zone.Finish();
			}

			
			if (failure && lastcommand == command.name)
			{
				lastcommand = command.name;
				fails++;
				
				if (fails > 15) // okay F this command
				{
					fails = 0;
					while (commands.length > 0 && (commands[0] as GenCommand).name == lastcommand)
						commands.splice(0, 1);
				}
			}
			else
			{
				if (lastcommand != command.name)
					fails = 0;
					
				lastcommand = command.name;
				commands.splice(0, 1);
			}
			
			
				
			if (commands.length == 0)
			{
				//hud.loading.SetValue(0, 100);
				hud.SetLoadProgress(100);
				
				state = Content.INITIALIZING;
				
				if (bReloading == false)
				{
					zonehistory.push(zone);
				}
				
				if (hud.ZoneInMapHistory(zone.description.coords.x, zone.description.coords.y) == -1)
				{
					Content.stats.arrayMapNodes.push(new MapNode(new Point(zone.description.coords.x, zone.description.coords.y), zone.description.style, zone.description.exits.north, zone.description.exits.south, zone.description.exits.west, zone.description.exits.east));

					hud.ZoneInMapHistory(zone.description.coords.x, zone.description.coords.y);
				}
				
				ReportBackupMap();
				
				initiate();
			}
			else
			{
				var progress:int = int(((totalgen - commands.length) / totalgen) * 100);
				if (progress < 0)
					progress = 0;
									
				if (commands.length < 2)
					progress = 100;
					
				hud.SetLoadProgress(progress);
			}
		}
		
		public function dump():void
		{
	
			
			ready = false;

			
			
			/*
			if (back != null) this.remove(back, true);
			if (filter != null) this.remove(filter, true);
			if (level != null) this.remove(level, true);
			if (interim_level != null) this.remove(interim_level, true);
			
			
			if (wall != null) this.remove(wall, true);
			if (wallpaper != null) this.remove(wallpaper, true);
			if (facade != null) this.remove(facade, true);
			if (bow != null) this.remove(bow, true);
			if (spotlight != null) this.remove(spotlight, true);
			if (hover != null) this.remove(hover, true);
			if (hero != null) this.remove(hero, true);
			
			if (lillevel != null) this.remove(lillevel, true);
			if (dolly != null) this.remove(dolly, true);
			if (coordstext != null) this.remove(coordstext, true);
			if (genustext != null) this.remove(genustext, true);
			if (groupArrows != null) this.remove(groupArrows, true);
			if (groupPellets != null) this.remove(groupPellets, true);
			if (groupMonsters != null) this.remove(groupMonsters, true);
			if (groupParticles != null) this.remove(groupParticles, true);
			if (debugtext != null) this.remove(debugtext, true);
			if (distext != null) this.remove(distext, true);
			if (groupGrunts != null) this.remove(groupGrunts, true);
			if (groupDoors != null) this.remove(groupDoors, true);
			if (groupPeppers != null) this.remove(groupPeppers, true);
			if (hud != null) this.remove(hud, true);*/

			
			groupNearBack.destroymembers();
			groupArrows.destroymembers();
			groupPellets.destroymembers();
			groupMonsters.destroymembers();
			groupFrontMonsters.destroymembers();
			groupParticles.destroymembers();
			groupGrunts.destroymembers();
			groupDoors.destroymembers();
			groupPeppers.destroymembers();
			
			groupNearBack = null;
			groupArrows = null;
			groupPellets = null;
			groupMonsters = null;
			groupFrontMonsters = null;
			groupParticles = null;
			groupGrunts = null;
			groupDoors = null;
			groupPeppers = null;
			
			hud.destroymembers();
			hud = null;
			
			zone = null;
			
			back = null;
			filter = null;
			
			level = null;
			interim_level = null;
			lillevel = null;
			wall = null;
			interim_wall = null;
			wallpaper = null;
			bow = null;
			hover = null;
			hero = null;
			spotlight = null;
			dolly = null;
			facade = null;
			
			coordstext = null;
			debugtext = null;
			distext = null;
			genustext = null;
			
			
			this.destroymembers();
			
			if (arrayArrows != null)
			{
				while (arrayArrows.length > 0)
				{
					this.remove(arrayArrows[0]);
					arrayArrows.splice(0, 1);
				}
				arrayArrows = null;
			}
			
			if (arrayPellets != null)
			{
				while (arrayPellets.length > 0)
				{
					this.remove(arrayPellets[0]);
					arrayPellets.splice(0, 1);
				}
				arrayPellets = null;
			}
			
			if (arrayParticles != null)
			{
				while (arrayParticles.length > 0)
				{
					this.remove(arrayParticles[0]);
					arrayParticles.splice(0, 1);
				}
				arrayParticles = null;
			}
			
			if (commands != null)
			{
				while (commands.length > 0)
				{
					this.remove(commands[0]);
					commands.splice(0, 1);
				}
				commands = null;
			}
			
			if (arrayAllGems != null)
			{
				while (arrayAllGems.length > 0)
				{
					this.remove(arrayAllGems[0]);
					arrayAllGems.splice(0, 1);
				}
				arrayAllGems = null;
			}
			
			if (arrayAllMonsters != null)
			{
				while (arrayAllMonsters.length > 0)
				{
					this.remove(arrayAllMonsters[0]);
					arrayAllMonsters.splice(0, 1);
				}
				arrayAllMonsters = null;
			}
			
			if (arrayFarMonsters != null)
			{
				while (arrayFarMonsters.length > 0)
				{
					this.remove(arrayFarMonsters[0]);
					arrayFarMonsters.splice(0, 1);
				}
				arrayFarMonsters = null;
			}
			
			if (arrayNearMonsters != null)
			{
				while (arrayNearMonsters.length > 0)
				{
					this.remove(arrayNearMonsters[0]);
					arrayNearMonsters.splice(0, 1);
				}
				arrayNearMonsters = null;
			}
			
			if (arrayGrunts != null)
			{
				while (arrayGrunts.length > 0)
				{
					this.remove(arrayGrunts[0]);
					arrayGrunts.splice(0, 1);
				}
				arrayGrunts = null;
			}
			
			
			FlxG.clearBitmapCache();
		}
				
		public var back:FlxSprite;
		public var filter:FlxSprite;
		public var groupNearBack:FlxGroupXY;
	
		public function initiate():void
		{
			
			hud.GoCorner();

			
			remove(hud);
			
			var x:int = 0;
			var y:int = 0;
			
			var mapheight:int = 256;
			var mapwidth:int = 256;
			
			back = new FlxSprite(0, 0, (Content.biomes[zone.description.style] as Biome).back);
			back.scrollFactor.x = 0;
			back.scrollFactor.y = 0;
			add(back);
			
			filter = new FlxSprite(0, 0, Content.cFilter);
			filter.scrollFactor.x = 0;
			filter.scrollFactor.y = 0;
			add(filter);
			
			groupNearBack = new FlxGroupXY();
			add(groupNearBack);
			
		
			
			var blankstr:String = "";
			var tempstr:String = "";
			for (y = 0; y < mapheight; y++)
			{
				for (x = 0; x < mapwidth; x++)
				{
					if(x % 2 == 0)
						tempstr += "0";
					else
						tempstr += "0";
						
					blankstr += "0";
					
					if (x < (mapwidth - 1))
					{
						tempstr += ",";
						blankstr += ",";
					}
					else
					{
						tempstr += "\n";
						blankstr += "\n";
					}
				}
			}
			
			level = new FlxTilemap();
			level.loadMap(blankstr, Content.cFronts, Content.twidth, Content.theight, FlxTilemap.OFF, 0, 0, (Content.iTotalBiomes * Content.iFrontSheetWidth));
			interim_level = new FlxTilemap();
			interim_level.loadMap(blankstr, Content.cFronts, Content.twidth, Content.theight, FlxTilemap.OFF, 0, 0, (Content.iTotalBiomes * Content.iFrontSheetWidth));
			
			colTransLevel = zone.description.levelColor;
			
			level._tiles.colorTransform(new Rectangle(0, 0, level._tiles.width, level._tiles.height), colTransLevel);
			
			
			lillevel = new FlxTilemap();
			lillevel.loadMap(blankstr, Content.cLilCave, 1, 1, FlxTilemap.OFF, 0, 0, Content.barriertile);
			
			
			wall = new FlxTilemap();
			wall.loadMap(blankstr,  Content.cWalls, Content.twidth, Content.theight, FlxTilemap.OFF, 0, 0, Content.walltile);
			
			interim_wall = new FlxTilemap();
			interim_wall.loadMap(blankstr,  Content.cWalls, Content.twidth, Content.theight, FlxTilemap.OFF, 0, 0, Content.walltile);
			
			wall._tiles.colorTransform(new Rectangle(0, 0, wall._tiles.width, wall._tiles.height), colTransLevel);
			
			wallpaper = new FlxTilemap();
			wallpaper.loadMap(tempstr, Content.cWallpaper, Content.twidth, Content.theight, FlxTilemap.OFF, 0, 0, (Content.iTotalBiomes * Content.iFrontSheetWidth));
			facade = new FlxTilemap();
			facade.loadMap(tempstr, Content.cFacade, Content.twidth, Content.theight, FlxTilemap.OFF, 0, 0, (Content.iTotalBiomes * Content.iFrontSheetWidth));
			
			add(wall);
			add(wallpaper);
			
			
					
			
			for (var xx:int = 0; xx < level.widthInTiles; xx++)
			{
				for (var yy:int = 0; yy < level.heightInTiles; yy++)
				{
					if (xx == 143 && yy == 126)
					{
						var n:int = 2;
					}
					if (zone.GetMap(xx, yy) == 1)
					{
						interim_level.setTile(xx, yy, Content.barriertile); 
						lillevel.setTile(xx, yy, Content.barriertile); 
					}
					else if (zone.GetMap(xx, yy) == 0)
					{
						lillevel.setTile(xx, yy, 1);
					}
					
					if (zone.watermap[xx][yy] == 1)
					{
						interim_wall.setTile(xx, yy, 1);
					}
					else
						interim_wall.setTile(xx, yy, zone.wallmap[xx][yy]);
						
					wallpaper.setTile(xx, yy, zone.wallpapermap[xx][yy]);
					facade.setTile(xx, yy, zone.facademap[xx][yy]);
				}
			}
			
			
			
			
			groupDoors = new FlxGroup();
			for (e = 0; e < zone.exits.length; e++)
			{
				groupDoors.add(new FlxSprite((zone.exits[e] as Exit).x * 30, ((zone.exits[e] as Exit).y * 30) - 30));
				(groupDoors.members[e] as FlxSprite).loadGraphic(Content.cDoors, true, false, 30, 60, false);
				(groupDoors.members[e] as FlxSprite).addAnimation("d", [(zone.exits[e] as Exit).id], 1, true);
				(groupDoors.members[e] as FlxSprite).play("d");
				
				
				//lillevel.setTile((zone.exits[e] as Exit).x, (zone.exits[e] as Exit).y - 1, 2);
				//lillevel.setTile((zone.exits[e] as Exit).x, (zone.exits[e] as Exit).y, 2);
			}
			this.add(groupDoors);
			
			FlxG.worldBounds.width = level.width;
			FlxG.worldBounds.height = level.height;

			var gemrandom:Rndm = new Rndm(Util.Seed(zone.description.mynexus.x, zone.description.mynexus.y));
			gemrandom.shuffle(9);
			
			for (xx = 0; xx < level.widthInTiles; xx++)
			{
				for (yy = 0; yy < level.heightInTiles; yy++)
				{
					var gem:int = zone.gemmap[xx][yy];
					if (gem != 0)
					{
						var xwig:int = gemrandom.integer(0, 12) - 6;
						var ywig:int = gemrandom.integer(0, 12) - 6;
						
						arrayAllGems.push(new Collectible(this, gem - 1, (xx * 30) + 10 + xwig, (yy * 30) + 10 + ywig));
						this.add(arrayAllGems[arrayAllGems.length - 1] as Collectible);
						lillevel.setTile(xx, yy, 5, true);
						
						(arrayAllGems[arrayAllGems.length - 1] as Collectible).play("d");
					}
				}
			}
			
			// Reset seed at this juncture
			zone.ResetRandom();
			
			/*
			if (zone.secrets.length > 0)
			{
				var monkpoint:Point = new Point((zone.secrets[0] as Point).x, (zone.secrets[0] as Point).y)
				//for each (var monk:Point in monkpoints)
				//{
				//	if (monk.x == zone.meta.x && monk.y == zone.meta.y)
				//	{
						var dude:Dude = new Dude(this, monkpoint.x * 30, monkpoint.y * 30);

						for (var seek:int = 0; seek < 10; seek++)
						{
							if (zone.GetMap(monkpoint.x - seek, monkpoint.y) == 1)
							{
								dude.facing = FlxObject.RIGHT;
								break;
							}
							
							if (zone.GetMap(monkpoint.x + seek, monkpoint.y) == 1)
							{
								dude.facing = FlxObject.LEFT;
								break;
							}
						}
						
						arrayFarMonsters.push(dude);
						this.add(dude);
						lillevel.setTile(monkpoint.x, monkpoint.y, 5, true);
						//break;
				//	}
				//}
			}*/
			
			ProperTiles(zone.description.style, 0, 0, level.widthInTiles, level.heightInTiles);
			
			var arrayPeppers:Array = new Array();
			
			for (xx = 0; xx < level.widthInTiles; xx++)
			{
				for (yy = 0; yy < level.heightInTiles; yy++)
				{
					var bExitHere:Boolean = false;
					
					for each (var exit:Exit in zone.exits)
					{
						if (exit.x == xx && exit.y == yy)
							bExitHere = true;
					}
					
					if (zone.GetMap(xx, yy) == 0 && zone.GetMap(xx, yy + 1) == 1 &&
						zone.spikemap[xx][yy] == 0 && bExitHere == false)
					{
						if (zone.watermap[xx][yy] == 1)
						{
							arrayPeppers.push(new PointPlus(xx, yy, "w"));
						}
						else
						{
							arrayPeppers.push(new PointPlus(xx, yy, ""));
						}
					}
				}
			}
			
			
			
			
			var variant:int = 0; 
			var iPeppers:int = arrayPeppers.length;
			var peprandom:Rndm = new Rndm(Util.Seed(zone.description.mynexus.x, zone.description.mynexus.y));
			
			peprandom.shuffle(5);
			
			if(zone.description.style == Content.MEADOW)
				variant = peprandom.integer(0, 2);
			else if (zone.description.style == Content.SWAMP)
				variant = peprandom.integer(0, 2);
			else if (zone.description.style == Content.COLUMNS)
				variant = peprandom.integer(0, 2);
			
			trace("Pepper variant = " + variant.toString());
				
			if (variant == 0)
				iPeppers = arrayPeppers.length * (zone.rand.integer(10, 30) / 100);
			else if (variant == 1)
				iPeppers = arrayPeppers.length * (zone.rand.integer(20, 50) / 100);
				
			groupPeppers = new FlxGroupXY();
				
			for (var i:int = 0; i < iPeppers; i++)
			{
				var toadd:FlxSprite;
				var spot:int = zone.rand.integer(0, arrayPeppers.length);
				var which:int = 0;
				
				var roll:int = 0;
				
				if (zone.description.style == Content.MEADOW)
				{
					if ((arrayPeppers[spot] as PointPlus).obj as String != "w")
					{
						toadd = new FlxSprite((arrayPeppers[spot] as PointPlus).x * 30, (arrayPeppers[spot] as PointPlus).y * 30);
						toadd.loadGraphic(Content.cPeppers, true, false, 30, 30, true);
						toadd.pixels.colorTransform(new Rectangle(0, 0, toadd.pixels.width, toadd.pixels.height), colTransLevel);
						
						
						toadd.addAnimation("", [zone.rand.integer(0, 2) + (variant * 2)], 0, true);
						toadd.play("");
						groupPeppers.add(toadd); 
						arrayPeppers.splice(spot, 1);
					}
				}
				else if (zone.description.style == Content.COLUMNS)
				{
					if (variant == 1)
					{
						if ((arrayPeppers[spot] as PointPlus).obj as String != "w")
						{
							toadd = new FlxSprite((arrayPeppers[spot] as PointPlus).x * 30, ((arrayPeppers[spot] as PointPlus).y * 30) + 25);
							toadd.loadGraphic(Content.cPeppers, true, false, 30, 30, true);
							toadd.pixels.colorTransform(new Rectangle(0, 0, toadd.pixels.width, toadd.pixels.height), colTransLevel);
							
							toadd.addAnimation("", [zone.rand.integer(0, 2) + 70], 0, true);
							toadd.play("");
							groupPeppers.add(toadd); 
							arrayPeppers.splice(spot, 1);
						}
					}
					else
					{
						toadd = new FlxSprite((arrayPeppers[spot] as PointPlus).x * 30, ((arrayPeppers[spot] as PointPlus).y * 30));
						toadd.loadGraphic(Content.cPeppers, true, false, 30, 30, true);
						toadd.pixels.colorTransform(new Rectangle(0, 0, toadd.pixels.width, toadd.pixels.height), colTransLevel);
						
						toadd.addAnimation("", [zone.rand.integer(0, 3) + 72], 0, true);
						toadd.play("");
						groupPeppers.add(toadd); 
						arrayPeppers.splice(spot, 1);
					}
				}
				else if (zone.description.style == Content.SWAMP)
				{
					toadd = new FlxSprite((arrayPeppers[spot] as PointPlus).x * 30, (arrayPeppers[spot] as PointPlus).y * 30);
					toadd.loadGraphic(Content.cPeppers, true, false, 30, 30, true);
					toadd.pixels.colorTransform(new Rectangle(0, 0, toadd.pixels.width, toadd.pixels.height), colTransLevel);
					
					//variant = new Rndm(Util.Seed(zone.description.mynexus.x, zone.description.mynexus.y)).integer(0, 2);
					
					if (variant == 0)
					{
						if ((arrayPeppers[spot] as PointPlus).obj as String == "w")
						{
							which = (zone.description.style * 10) + 3 + zone.rand.integer(0, 2); // two closed blooms
						}
						else
						{
							roll = zone.rand.integer(0, 10)
							if (roll == 1)
							{
								which = (zone.description.style * 10) + 5; // spore phase
							}
							else if (roll == 2)
							{
								which = (zone.description.style * 10) + 2; // sprout phase
							}
							else
								which = (zone.description.style * 10) + 0 + zone.rand.integer(0, 2); // two open blooms
						}
					}
					else
					{
						which = (zone.description.style * 10) + 6 + zone.rand.integer(0, 3); // infection
					}
					
					toadd.addAnimation("", [which], 0, true);
					toadd.play("");
					groupPeppers.add(toadd); 		
					arrayPeppers.splice(spot, 1);
				}
			}
			
			var waterfalls:int = 0;
			var xs:Array = new Array();
			
			if (zone.description.style == Content.MEADOW)
			{
				for (x = 10; x < 245; x++)
				{
					for (y = 10; y < 245; y++)
					{
						if (zone.wallmap[x][y] == 0)
						{
							xs.push(x);
						}
					}
				}
				
				while (waterfalls < Content.iWaterfallCap && xs.length > 0)
				{
					which = zone.rand.integer(0, xs.length)
					
					x = (xs[which] as int);
					
					var weight:int = 0;
					
					for (i = 0; i < xs.length; i++)
					{
						if ((xs[which] as int) == x)
							weight++;
					}
					
					for (y = 10; y < 245; y++)
					{
						
						if (wall.getTile(x, y) != 1 + (zone.description.style * Content.iWallSheetWidth))
						{
						
							toadd = new FlxSprite(x * 30, y * 30);
							toadd.loadGraphic(Content.cWaterfall, true, false, 30, 30, true);
							toadd._pixels.colorTransform(new Rectangle(0, 0, 30 * 10, 30), colTransLevel);
							
							toadd.addAnimation("", [0, 1, 2, 3, 4, 5, 6 ,7 ,8, 9], 26, true);
							toadd.play("");
							
							groupNearBack.add(toadd); 
						}
					}
					
					waterfalls++;
					xs.splice(which, 1);
					
					if (zone.rand.integer(0, 100) < 40)
						break;
				}
			}
			
			/*
			var windmill:FlxSprite = new FlxSprite(140 * 30, 130 * 30);
			windmill.loadGraphic(Content.cWindmill, true, false, 150, 150, true);
			windmill.addAnimation("s", [0, 1, 2, 3, 4, 5], 5, true);
			windmill.play("s");
			groupPeppers.add(windmill);	
			*/
			
			

			var mike:Gopher = null;
			var sally:Dude = null;

			
			if (bMikeAndSally)
			{
				//mike = new Gopher(this, "Mike", 1, 1, 1, 0, 0);
				mike = new Gopher(this, "Mike", 0, 0);
				sally = new Dude(this, "Sally", 3, 3, 0, 0, 0);
			
				arrayFarMonsters.push(mike);
				arrayFarMonsters.push(sally);
				
				arrayAllMonsters.push(mike);
				arrayAllMonsters.push(sally);
				
				this.add(mike);
				this.add(sally);
			}
			
			if (zone.description.coords.x == 497 && zone.description.coords.y == 3)
			{
				//var sign:Signpost = null;
				//sign = new Signpost(this, "Signpost", 1, 1, 1, 0, 0);
			}
			
			for each(var m:Miracle in MiracleManager.arrayZoneMiracles)
			{
				if (m.universal)
				{
					var dudelines:Array;
					var d:int;
					
					if (m.id == Content.DUDE)
					{
						dudelines = m.strData.split("^");
						
						var newdude:Dude = new Dude(this, dudelines[0] as String, int(dudelines[1]), int(dudelines[2]), int(dudelines[3]), m.x * 30, m.y * 30);
						
						newdude.SetColors(uint(dudelines[4]),
											uint(dudelines[5]),
											Util.DarkSkin(uint(dudelines[5])),
											Util.Swirl(uint(dudelines[5])),
											uint(dudelines[6]),
											Util.DarkHair(uint(dudelines[6])),
											uint(dudelines[7]),
											uint(dudelines[8]));
											
						for (d = 9; d < dudelines.length; d++)
						{
							newdude.arrayScript.push(dudelines[d]);
						}
						
						arrayFarMonsters.push(newdude);
						this.add(newdude);
					}
					else if (m.id == Content.SIGNPOST)
					{
						dudelines = m.strData.split("^");
						
						var newsign:Signpost = new Signpost(this, dudelines[0] as String, (m.x * 30) + 3, m.y * 30);
						
						for (d = 1; d < dudelines.length; d++)
						{
							newsign.arrayScript.push(dudelines[d]);
						}
						
						arrayFarMonsters.push(newsign);
						this.add(newsign);
					}
				}
			}
			
			bow = new FlxSprite(300, 0);
			bow.loadGraphic(Content.cHero, true, true, 100, 100);
			bow.addAnimation("rest", [63], 1, false);
			bow.addAnimation("shoot", [63, 64, 65, 63], 18, false);
			bow.addAnimation("restup", [66], 1, false);
			bow.addAnimation("shootup", [66, 67, 68, 66], 18, false);
			bow.addAnimation("restdn", [69], 1, false);
			bow.addAnimation("shootdn", [69, 70, 71, 69], 18, false);
			bow.play("rest");
			bow.visible = false; // Set TRUE in Player.as when hero's "arrive" animation completes
			this.add(bow);
			
			groupArrows = new FlxGroup();
			this.add(groupArrows);
			
			
			hover = new FlxSprite(30, 30);
			hover.loadGraphic(Content.cHover, true, false, 30, 30, false);
			hover.addAnimation("door", [0], 1, true);
			hover.addAnimation("talk", [1], 1, true);
			hover.addAnimation("look", [2], 1, true);
			hover.addAnimation("talking", [3, 4, 5, 6], 8, false);
			hover.visible = false;
			hover.pausable = false;
			
			
			
			hero = new Player(this, 0, 0, bow);
			hero.facing = FlxObject.RIGHT;
			this.add(hero);
			
			
			
			groupMonsters = new FlxGroup();
			groupFrontMonsters = new FlxGroup();
			if (bMonsters)
			{
				MakeMonsters(nSaturation);
			}
			if (zone.description.style == Content.ICE)
			{
				var icepoints:Array = null;
				
				icepoints = zone.GrowIce(4);
				
				if (icepoints != null)
				{
				
					for (var ip:int; ip < icepoints.length; ip++)
					{
						for each(var mon:Monster in arrayAllMonsters)
						{
							if (Util.Distance((icepoints[ip] as Point).x * 30, (icepoints[ip] as Point).y * 30, mon.x, mon.y) < 30)
							{
								icepoints.splice(ip, 1);
								ip--;
								break;
							}
						}
					}
					
					for each(var pt:Point in icepoints)
					{					
						var iceblock:Iceblock = new Iceblock(this, pt.x * 30, pt.y * 30);// , zone.description.levelColor);
						arrayAllMonsters.push(iceblock);
						arrayFarMonsters.push(iceblock);
						
						groupMonsters.add(iceblock);
						
						for each(var icegem:Collectible in arrayAllGems)
						{
							if (int(icegem.x / 30) == pt.x && int(icegem.y / 30) == pt.y)
							{
								icegem.x = (int(icegem.x / 30) * 30) + 10;
								icegem.y = (int(icegem.y / 30) * 30) + 10;
							}
						}
					}
				}
			}
			this.add(groupMonsters);
			
			groupPellets = new FlxGroup();
			this.add(groupPellets);
			
			groupParticles = new FlxGroup();
			this.add(groupParticles);
			
			var splash:Splash = new Splash(this, 0, 0);
			splash.visible = false;
			arrayParticles.push(splash);
			groupParticles.add(splash);
			
			
			
					
			var e:int = 0;
			for (e = 0; e < zone.exits.length; e++)
			{
				if ((zone.exits[e] as Exit).id == camefrom)
				{
					hero.x = ((zone.exits[e] as Exit).x * 30) + 6;
					hero.y = ((zone.exits[e] as Exit).y * 30) + 9; // 7
					
					break;
				}
			}
			
			if (hero.x == 0)
			{
				hero.x = ((zone.exits[0] as Exit).x * 30) + 6;
				hero.y = ((zone.exits[0] as Exit).y * 30) + 9; // 7
				
				camefrom = (zone.exits[0] as Exit).id;
			}
			
			if (bMikeAndSally)
			{
				mike.x = 139 * 30;
				mike.y = 132 * 30;
				mike.arrayScript.push("say Hey, Sally!")
				mike.arrayScript.push("vent Sally|What!");
				mike.arrayScript.push("say This scripting system is pretty cool, eh?");
				mike.arrayScript.push("vent Sally|Sure, I guess.");
				mike.arrayScript.push("bye");
				
				sally.x = 141 * 30;
				sally.y = 130 * 30;
				sally.arrayScript.push("say HI MOLLY!")
				sally.arrayScript.push("bye");
			}
			
			
			
			add(level);
			add(facade);
			
			this.add(groupPeppers);
			
			
			this.add(groupFrontMonsters);
			
			
			
			add(lillevel);
			lillevel.visible = false;
			lillevel.scrollFactor.x = 0;
			lillevel.scrollFactor.y = 0;
			lillevel.x = (Content.screenwidth / 2) - (256 / 2);
			lillevel.y = (Content.screenheight / 2) - (256 / 2);
			
			
			spotlight = new FlxSprite(300, 0);
			spotlight.loadGraphic(Content.cSpotlight, false, false, 30, 30);
			spotlight.alpha = 0.25;
			this.add(spotlight);
			
			
			
			dolly = new FlxObject(hero.x + dollyoffset, hero.y, 30, 30);
			this.add(dolly);
			
			//camera = new FlxCamera(0, 0, Content.screenwidth, Content.screenheight, 0);
			
			FlxG.camera.follow(dolly, FlxCamera.STYLE_LOCKON);
			FlxG.camera.setBounds(0, 0, level.width, level.height);
			FlxG.camera.width = 480 + 300;
			dollyoffset = 150;
			
			
			
			//camera.follow(dolly, FlxCamera.STYLE_PLATFORMER);
			//camera.follow(hero, FlxCamera.STYLE_PLATFORMER);
			
			//FlxG.resetCameras(camera);
			var levelrange:Point = new Point((zone.lowerright.x - zone.upperleft.x) * Content.twidth, (zone.lowerright.y - zone.upperleft.y) * Content.theight);
			var backrange:Point = new Point (720, 450);
			var midrange:Point = new Point (960, 600);
			
			/*
			back.scrollFactor.x = (backrange.x) / levelrange.x;
			back.scrollFactor.y = (backrange.y) / levelrange.y;
			back.offset.x = zone.upperleft.x * Content.twidth * 1;
			back.offset.y = zone.upperleft.y * Content.theight * 1;
			trace("back factor: " + back.scrollFactor.x.toString() + "," + back.scrollFactor.y.toString());
			
			mid.scrollFactor.x = (midrange.x) / levelrange.x;
			mid.scrollFactor.y = (midrange.y) / levelrange.y;
			mid.offset.x = zone.upperleft.x * Content.twidth * 1;
			mid.offset.y = zone.upperleft.y * Content.theight * 1;
			trace("mid factor: " + mid.scrollFactor.x.toString() + "," + mid.scrollFactor.y.toString());
			*/
			
			/*
			back.scrollFactor.x = backrange.x / ((mapwidth * Content.twidth) + backrange.x);
			back.scrollFactor.y = backrange.y / ((mapheight * Content.theight) + backrange.y);
			mid.scrollFactor.x = midrange.x / ((mapwidth * Content.twidth) + midrange.x);
			mid.scrollFactor.y = midrange.y / ((mapheight * Content.theight) + midrange.y);
			*/
			
	
			
			coordstext = new FlxText(10, 120, 200, ""); //adds a 100px wide text field at position 0,0 (upper left)
			Util.AssignFont(coordstext);
			add(coordstext);
			coordstext.scrollFactor.x = 0;
			coordstext.scrollFactor.y = 0;
			coordstext.visible = Content.debugtexton;
			
			
			
			debugtext = add(new FlxText(3, 180, 200, "")) as FlxText; //adds a 100px wide text field at position 0,0 (upper left)
			Util.AssignFont(debugtext);
			debugtext.scrollFactor.x = 0;
			debugtext.scrollFactor.y = 0;
			debugtext.visible = Content.debugtexton;
			
			distext = add(new FlxText(3, 150, 220, "")) as FlxText; //adds a 100px wide text field at position 0,0 (upper left)
			Util.AssignFont(distext);
			distext.scrollFactor.x = 0;
			distext.scrollFactor.y = 0;
			distext.visible = Content.debugtexton;

			this.add(hover);
			
			groupGrunts = new FlxGroupXY();
			add(groupGrunts);
			
			
			
			add(hud);
			
			
			hud.GoCorner();
			
			

			genustext = new FlxText(10, 290, 200, "wallpaper"); //adds a 100px wide text field at position 0,0 (upper left)
			Util.AssignFont(genustext);
			add(genustext);
			genustext.scrollFactor.x = 0;
			genustext.scrollFactor.y = 0;
			genustext.visible = Content.debugtexton;
			
			
			if (zone.description.strRegionName != oldregion)
			{
				hud.NewRegionTask(zone.description.strRegionName);
			}
			else
			{
				hud.SetBars(Content.nEverBars / 50);
			}
			
			oldregion = zone.description.strRegionName;
	

			//level.setTile(130, 120, 2);
			
			if (song)
			{		
				if (Util.strMusic == "") //FlxG.music == null || FlxG.music.volume == 0)
				{
					Util.SetMusicName((Content.biomes[zone.description.style] as Biome).song);
					Util.PlayIntroMusic();
				}
			}
			
			bWasDead = false;
			bMovedOnce = false;
			
			FlxG.play(Content.soundEnter, Content.volumeEnter, false, false);
			
			nElapsedInZone = 0;
			
			
			Content.stats.cavemap.AddSpritesToHUD(hud.cavecanvas, zone.description.coords.x, zone.description.coords.y, 
					(268 / 2) - 6, 
					(268 / 2) - 6,
					0,
					0,
					42,
					42,
					true);
			
			ready = true;
		}
		
		
		
		public function ProperTiles(biome:int, xstart:int, ystart:int, xrange:int, yrange:int):void
		{
			var thistile:int = 0;
			
			if (xstart < 2) xstart = 2;
			if (ystart < 2) ystart = 2;
			if (xstart + xrange > zone.width - 3) xrange = zone.width - 3;
			if (ystart + yrange > zone.height - 3) yrange = zone.height - 3;

			for (var xx:int = xstart; xx < xrange; xx++)
			{
				for (var yy:int = ystart; yy < yrange; yy++)
				{
					
					thistile = interim_level.getTile(xx, yy);
					
					if (thistile >= Content.barriertile)
					{
						if (interim_level.getTile(xx, yy - 1) < Content.barriertile && interim_level.getTile(xx, yy + 1) < Content.barriertile)
						{
							level.setTile(xx, yy, Content.iEmptyAboveEmptyBelow, true); 
						}
						else if (interim_level.getTile(xx, yy - 1) < Content.barriertile)
						{
							level.setTile(xx, yy, Content.iEmptyAboveStuffBelow, true); 
						}
						else if (interim_level.getTile(xx, yy + 1) < Content.barriertile)
						{
							level.setTile(xx, yy, Content.iStuffAboveEmptyBelow, true); 
						}
						else
							level.setTile(xx, yy, thistile);
					}
					else if (thistile == 0 && interim_level.getTile(xx, yy + 1) == Content.barriertile)
					{
						if (wallpaper.getTile(xx, yy) < Content.iWallpaperPieces / 2)
							level.setTile(xx, yy, Content.iGrass, true); 
						else 
							level.setTile(xx, yy, Content.iBlank, true); 
					}
					else
						level.setTile(xx, yy, thistile);
						
					// Water
					/*
					 * If 0 and water and water on top, 4
If 0 and water and no water on top, 6
If 3 and water and water on top, 5
If 3 and water and no water on top, 7
If 10 and water, 12
If 11 and water, 13
*/
					
					thistile = level.getTile(xx, yy);
					
					if (zone.watermap[xx][yy] == 1)
					{
						if (thistile == Content.iBlank)
						{
							if(zone.watermap[xx][yy - 1] == 1)
								level.setTile(xx, yy, Content.iWater);
							else 
								level.setTile(xx, yy, Content.iShallow);
						}
						else if (thistile == Content.iGrass)
						{
							if (zone.watermap[xx][yy - 1] == 1)
							{
								if (wallpaper.getTile(xx, yy) < Content.iWallpaperPieces / 2)
									level.setTile(xx, yy, Content.iWaterGrass);
								else
									level.setTile(xx, yy, Content.iWater);
							}	
							else 
							{
								if (wallpaper.getTile(xx, yy) < Content.iWallpaperPieces / 2)
									level.setTile(xx, yy, Content.iShallowGrass);
								else
									level.setTile(xx, yy, Content.iShallow);
							}
						}
						else if (thistile == Content.iStuffAboveEmptyBelow)
						{
							level.setTile(xx, yy, Content.iStuffAboveWaterBelow);
						}
						else if (thistile == Content.iEmptyAboveEmptyBelow)
						{
							level.setTile(xx, yy, Content.iEmptyAboveWaterBelow);
						}
					}
					
						
					thistile = interim_wall.getTile(xx, yy);
					var wall_to_left:int = interim_wall.getTile(xx - 1, yy);
					var wall_to_right:int = interim_wall.getTile(xx + 1, yy);
					var wall_to_up:int = interim_wall.getTile(xx, yy - 1);
					var wall_to_down:int = interim_wall.getTile(xx, yy + 1);

					
					if (thistile >= Content.walltile)
					{
						if (wall_to_up < Content.walltile && wall_to_down < Content.walltile)
						{
							wall.setTile(xx, yy, Content.walltile + 3, true); // no above, no below
						}
						else if (wall_to_up < Content.walltile)
						{
							wall.setTile(xx, yy, Content.walltile + 1, true); // no above
						}
						else if (wall_to_down < Content.walltile)
						{
							wall.setTile(xx, yy, Content.walltile + 2, true); // no below
						}
						else
							wall.setTile(xx, yy, interim_wall.getTile(xx, yy));
					}
					else
						wall.setTile(xx, yy, interim_wall.getTile(xx, yy));
						
					var qual:int = zone.wallqualmap[xx][yy];
					
					if (qual > 0)
					{
						var qual_to_left:int = zone.wallqualmap[xx - 1][yy];
						var qual_to_right:int = zone.wallqualmap[xx + 1][yy];
						var qual_to_up:int = zone.wallqualmap[xx][yy - 1];
						var qual_to_down:int = zone.wallqualmap[xx][yy + 1];
					
						if (wall_to_down == 0)
						{
							// bottom edge of wall section
							
							if (qual_to_left > 0 && qual_to_right > 0)
							{
								if (qual_to_up > 0)
									wall.setTile(xx, yy, Content.walltile + 18); // nodown
								else
									wall.setTile(xx, yy, Content.walltile + 21); // log
							}
							else if (qual_to_left > 0)
							{
								wall.setTile(xx, yy, Content.walltile + 20); // downleft
							}
							else if (qual_to_right > 0)
							{
								wall.setTile(xx, yy, Content.walltile + 19); // downright
							}
							else
							{
								wall.setTile(xx, yy, Content.walltile + 22); // uponly
							}
						}
						else
						{
							if (qual_to_down > 0)
							{
								if (qual_to_up > 0)
								{
									if (qual_to_left > 0)
									{
										if (qual_to_right > 0)
										{
											wall.setTile(xx, yy, Content.walltile + 6); // cross
										}
										else
										{
											wall.setTile(xx, yy, Content.walltile + 9); // noright
										}
									}
									else if (qual_to_right > 0)
									{
										wall.setTile(xx, yy, Content.walltile + 7); // noleft
									}
									else
									{
										wall.setTile(xx, yy, Content.walltile + 15); // post
									}
								}
								else
								{
									if (qual_to_left > 0)
									{
										if (qual_to_right > 0)
										{
											wall.setTile(xx, yy, Content.walltile + 8); // noup
										}
										else
										{
											wall.setTile(xx, yy, Content.walltile + 17); // upleft
										}
									}
									else if (qual_to_right > 0)
									{
										wall.setTile(xx, yy, Content.walltile + 16); // upright
									}
									else
									{
										wall.setTile(xx, yy, Content.walltile + 15); // post
									}
									
								}
							}
							else if(qual_to_up > 0)
							{
								if (qual_to_left > 0)
								{
									if (qual_to_right > 0)
									{
										wall.setTile(xx, yy, Content.walltile + 10); // nodown
									}
									else
									{
										wall.setTile(xx, yy, Content.walltile + 12); // downleft
									}
								}
								else if (qual_to_right > 0)
								{
									wall.setTile(xx, yy, Content.walltile + 11); // downright
								}
								else
								{
									wall.setTile(xx, yy, Content.walltile + 14); // uponly
								}
							}
							else
							{
								wall.setTile(xx, yy, Content.walltile + 13); // log
							}
						}
					}
				}
			}

			
			// Match to biome
			for (xx = xstart; xx < xrange; xx++)
			{
				for (yy = ystart; yy < yrange; yy++)
				{
					if (zone.spikemap[xx][yy] == 1)
					{
						if (level.getTile(xx, yy) == Content.iGrass)
						{
							level.setTile(xx, yy, Content.iSpikes, true);
						}
						else if (level.getTile(xx, yy) == Content.iWaterGrass)
						{
							level.setTile(xx, yy, Content.iWaterSpikes, true);
						}
						else if (level.getTile(xx, yy) == Content.iShallowGrass)
						{
							level.setTile(xx, yy, Content.iShallowSpikes, true);
						}
					}
					
					wall.setTile(xx, yy, wall.getTile(xx, yy) + (biome * Content.iWallSheetWidth));
					
					if (level.getTile(xx, yy) >= Content.barriertile)
					{
						level.setTile(xx, yy, level.getTile(xx, yy) + (biome * Content.iFrontSheetWidth) + (Content.iTotalBiomes * Content.iFrontSheetWidth));
					}
					else
					{
						level.setTile(xx, yy, level.getTile(xx, yy) + (biome * Content.iFrontSheetWidth));
					}
				}
			}
				
			var toghost:int = 0;
			
			if (bBlackOuter)
			{
				for (xx = xstart; xx < xrange; xx++)
				{
					for (yy = ystart; yy < yrange; yy++)
					{
						var bOuter:Boolean = true;
						
						for (var xxx:int = xx - 5; xxx < xx + 5 && bOuter == true; xxx++)
						{
							for (var yyy:int = yy - 5; yyy < yy + 5 && bOuter == true; yyy++)
							{
								if (xxx >= xstart && xxx < xrange && yyy >= ystart && yyy < yrange)
								{
									if (zone.GetMap(xxx, yyy) == 0 && 
										zone.intangmap[xxx][yyy] == 0 &&
										Util.Distance(xx, yy, xxx, yyy) <= nOuterDistance)
									{
										bOuter = false;
									}
								}
							}
						}
						
						if (bOuter == true)
						{
							level.setTile(xx, yy, 1 + (biome * Content.iFrontSheetWidth) + (Content.iTotalBiomes * Content.iFrontSheetWidth));
						}
						
						if (zone.intangmap[xx][yy] == 1)
						{
							if (bShowSecretPassages)
							{
								level.setTile(xx, yy, 2);
							}
							else
							{
								toghost = level.getTile(xx, yy);
								level.setTile(xx, yy, toghost - (Content.iTotalBiomes * Content.iFrontSheetWidth));	
							}
						}
						
						if (zone.chambermap[xx][yy] == 1 && bShowChambers)
						{
							level.setTile(xx, yy, 2);
						}
					}
				}
			}
			else
			{
				for (xx = xstart; xx < xrange; xx++)
				{
					for (yy = ystart; yy < yrange; yy++)
					{
						if (zone.intangmap[xx][yy] == 1)
						{
							if (bShowSecretPassages)
							{
								level.setTile(xx, yy, 2);
							}
							else
							{
								toghost = level.getTile(xx, yy);
								level.setTile(xx, yy, toghost - (Content.iTotalBiomes * Content.iFrontSheetWidth));	
							}

						}
						
						if (zone.chambermap[xx][yy] == 1 && bShowChambers)
						{
							level.setTile(xx, yy, 2);
						}
						
					}
				}
			}
			
			var valids:Array = new Array();
			
			if (zone.description.style == Content.STONE)
			{
				for (xx = xstart; xx < xrange; xx++)
				{
					for (yy = ystart; yy < yrange; yy++)
					{
						if ((interim_level.getTile(xx, yy - 1) >= Content.barriertile &&
							interim_level.getTile(xx, yy - 0) < Content.barriertile &&
							interim_level.getTile(xx, yy + 1) < Content.barriertile &&
							interim_level.getTile(xx, yy + 2) >= Content.barriertile) &&
							(interim_level.getTile(xx + 1, yy - 1) >= Content.barriertile &&
							interim_level.getTile(xx + 1, yy - 0) < Content.barriertile &&
							interim_level.getTile(xx + 1, yy + 1) < Content.barriertile &&
							interim_level.getTile(xx + 1, yy + 2) >= Content.barriertile))
						{
						
							
							if(interim_level.getTile(xx, yy - 2) >= Content.barriertile)
								level.setTile(xx, yy - 1, (biome * Content.iFrontSheetWidth) + (Content.iTotalBiomes * Content.iFrontSheetWidth) + Content.iStuffAboveStuffBelow, true);
							else
								level.setTile(xx, yy - 1, (biome * Content.iFrontSheetWidth) + (Content.iTotalBiomes * Content.iFrontSheetWidth) + Content.iEmptyAboveStuffBelow, true);
							
							wall.setTile(xx, yy, (biome * Content.iWallSheetWidth) + 7, true);
							wall.setTile(xx, yy + 1, (biome * Content.iWallSheetWidth) + 8, true);
							
							
							if(interim_level.getTile(xx + 1, yy - 2) >= Content.barriertile)
								level.setTile(xx + 1, yy - 1, (biome * Content.iFrontSheetWidth) + (Content.iTotalBiomes * Content.iFrontSheetWidth) + Content.iStuffAboveStuffBelow, true);
							else
								level.setTile(xx + 1, yy - 1, (biome * Content.iFrontSheetWidth) + (Content.iTotalBiomes * Content.iFrontSheetWidth) + Content.iEmptyAboveStuffBelow, true);
							
							wall.setTile(xx + 1, yy, (biome * Content.iWallSheetWidth) + 7, true);
							wall.setTile(xx + 1, yy + 1, (biome * Content.iWallSheetWidth) + 8, true);
						}
					}
				}
			}
			else if (zone.description.style == Content.SWAMP)
			{
				for (xx = xstart; xx < xrange; xx++)
				{
					for (yy = ystart; yy < yrange; yy++)
					{
						var quad:Boolean = true;
						
						for (var xxcheck:int = xx; xxcheck < xx + 2; xxcheck++)
						{
							for (var yycheck:int = yy; yycheck < yy + 2; yycheck++)
							{
								if (level.getTile(xxcheck, yycheck) != (biome * Content.iFrontSheetWidth) + (Content.iTotalBiomes * Content.iFrontSheetWidth) + Content.iStuffAboveStuffBelow)
								{
									quad = false;
									break;
								}
							}
						}
						
						if (quad)
						{
							var aaa:int = 2;							
							if(xx % 2 == 0 && (xx + yy) % 2 == 0)
							{
								valids.push(new Point(xx, yy));
							}
						}
					}
				}
				
				trace("valids found: " + valids.length.toString());
				for each (var flowerblock:Point in valids)
				{
					level.setTile(flowerblock.x, flowerblock.y,
						(biome * Content.iFrontSheetWidth) + (Content.iTotalBiomes * Content.iFrontSheetWidth) + Content.iBonus1,
						true);
						
					level.setTile(flowerblock.x + 1, flowerblock.y,
						(biome * Content.iFrontSheetWidth) + (Content.iTotalBiomes * Content.iFrontSheetWidth) + Content.iBonus2,
						true);
						
					level.setTile(flowerblock.x, flowerblock.y + 1,
						(biome * Content.iFrontSheetWidth) + (Content.iTotalBiomes * Content.iFrontSheetWidth) + Content.iBonus3,
						true);
						
					level.setTile(flowerblock.x + 1, flowerblock.y + 1,
						(biome * Content.iFrontSheetWidth) + (Content.iTotalBiomes * Content.iFrontSheetWidth) + Content.iBonus4,
						true);
				}
			}
			else if (zone.description.style == Content.SAND)
			{
				for (xx = xstart; xx < xrange; xx++)
				{
					for (yy = ystart; yy < yrange; yy++)
					{
						if (
							interim_level.getTile(xx, yy) >= Content.barriertile &&
							interim_level.getTile(xx, yy + 1) >= Content.barriertile &&
							interim_level.getTile(xx, yy - 1) >= Content.barriertile &&
							interim_level.getTile(xx, yy - 2) >= Content.barriertile &&
								(
									interim_level.getTile(xx + 1, yy + 1) >= Content.barriertile ||
									interim_level.getTile(xx - 1, yy + 1) >= Content.barriertile
								) 
								&&
								(
									interim_level.getTile(xx - 1, yy) < Content.barriertile ||
									interim_level.getTile(xx + 1, yy) < Content.barriertile
								)
								&&
								(
									interim_level.getTile(xx - 1, yy - 1) < Content.barriertile ||
									interim_level.getTile(xx + 1, yy - 1) < Content.barriertile
								)
								&&
								(
									interim_level.getTile(xx - 1, yy - 2) < Content.barriertile ||
									interim_level.getTile(xx + 1, yy - 2) < Content.barriertile
								)
							)
						{
							var blockadebump:int = 0;
							
							var below:int = level.getTile(xx, yy + 1);
							
							if (below == (biome * Content.iFrontSheetWidth) + (Content.iTotalBiomes * Content.iFrontSheetWidth) + Content.iStuffAboveStuffBelow ||
								below == (biome * Content.iFrontSheetWidth) + (Content.iTotalBiomes * Content.iFrontSheetWidth) + Content.iStuffAboveEmptyBelow ||
								below == (biome * Content.iFrontSheetWidth) + (Content.iTotalBiomes * Content.iFrontSheetWidth) + Content.iStuffAboveWaterBelow)
								{										
									level.setTile(xx, yy + 1, below + 1 + blockadebump);
								}
							
							blockadebump = 0;
							if (zone.intangmap[xx][yy] == 0)
								blockadebump = (Content.iTotalBiomes * Content.iFrontSheetWidth);
								
							level.setTile(xx, yy, (biome * Content.iFrontSheetWidth) + blockadebump + Content.iBonus2, true);
							
							for (var pillary:int = yy - 1; pillary > 1; pillary--)
							{
								blockadebump = 0;
								if (zone.intangmap[xx][pillary] == 0)
									blockadebump = (Content.iTotalBiomes * Content.iFrontSheetWidth);
									
								level.setTile(xx, pillary, (biome * Content.iFrontSheetWidth) + blockadebump + Content.iBonus3, true);
								
								if (interim_level.getTile(xx, pillary - 2) < Content.barriertile ||
									(interim_level.getTile(xx - 1, pillary - 2) >= Content.barriertile &&
									interim_level.getTile(xx + 1, pillary - 2) >= Content.barriertile))
								{
									blockadebump = 0;
									if (zone.intangmap[xx][pillary - 1] == 0)
										blockadebump = (Content.iTotalBiomes * Content.iFrontSheetWidth);
										
									level.setTile(xx, pillary - 1, (biome * Content.iFrontSheetWidth) + blockadebump + Content.iBonus1, true);
									break;
								}
							}
							
						}
					}
				}
			}

			
			if (groupPeppers != null && groupPeppers.members.length > 0)
			{
				for each(var s:FlxSprite in groupPeppers.members)
				{
					if (wallpaper.getTile(int(s.x / 30), int(s.y / 30)) >= Content.iWallpaperPieces / 2)
					{
						s.visible = false;
					}
					else 
					{
						s.visible = true;
						
						var tiletoclear:int = level.getTile(int(s.x / 30), int(s.y / 30));
						
						tiletoclear -= (biome * Content.iFrontSheetWidth);
						
						if (tiletoclear >= Content.iGrass && tiletoclear <= Content.iSpikes)
							tiletoclear = Content.iBlank;
						else if (tiletoclear >= Content.iWater && tiletoclear <= Content.iWaterSpikes)
							tiletoclear = Content.iWater;
						else if (tiletoclear >= Content.iShallow && tiletoclear <= Content.iShallowSpikes)
							tiletoclear = Content.iShallow;
						
						level.setTile(int(s.x / 30), int(s.y / 30), tiletoclear += (biome * Content.iFrontSheetWidth), true); 
					}
				}
			}
		}
		
		public function MakeMonsters(saturation:Number):void
		{
			var ran:Rndm = new Rndm(Util.Seed(zone.description.mynexus.x, zone.description.mynexus.y));
			
			var arrayBestiaryPossible:Array = new Array(); // One each of the possible cards for this zone
			var arrayBestiary:Array = new Array(); // One each of the possible cards for this zone
			var arrayBestiaryCards:Array = new Array(); // The deck of monster cards after duplicating according to weight * 100
			
			for each(var line:String in (Content.biomes[zone.description.style] as Biome).bestiary)
			{
				if (line != "")
				{
					var tokens:Array = line.split("|");
		
					var needsone:uint = 0;
					var needsall:uint = 0;
					var resists:uint = 0;
					var weight:Number = Number(tokens[1]);
					var satmodifier:Number = Number(tokens[2]);
					
					switch(tokens[0])
					{
						case "FaceShoot":
							needsone = Content.Code_Left | Content.Code_Right; // needs wall mount
							needsall = 0x00000000;
							resists = 0x00000000;
							break;
							
						case "Goblin":
						case "Beetle":
						case "Shroom":
						case "LittleSlab":
						case "Hopper":
							needsone = Content.Code_Down; // needs ground
							needsall = 0x00000000;
							resists = Content.Code_Water; // can't be in water
							break;
							
						case "Slab":
							needsone = Content.Code_Down; // needs ground
							needsall = 0x00000000;
							resists = Content.Code_Up | Content.Code_Water; // can't be in water, can't have tile above spawn point
							break;
							
						case "Crawler":
							needsone = Content.Code_Up | Content.Code_Right | Content.Code_Down | Content.Code_Left; // needs one wall
							needsall = 0x00000000;
							resists = 0x00000000;
							break;
							
						case "Fish":
							needsone = Content.Code_Water; // needs water
							needsall = 0x00000000;
							resists = 0x00000000;
							break;
							
						case "Bat":
							needsone = Content.Code_Up;
							needsall = 0x00000000;
							resists = Content.Code_Water; // can't be in water
							weight = 20;
							break;
					}
					
					arrayBestiaryPossible.push(new MonsterCard(tokens[0], 
						needsone,
						needsall,
						resists,
						weight,
						satmodifier));
				}
			}
			
			// Init Monsterspots
			var arrayMonsterSpots:Array = new Array();
			var mxx:int = 0;
			var myy:int = 0;
			var grounds:int = 0;
			var postgrounds:int = 0;
			for (mxx = 0; mxx < level.widthInTiles; mxx++)
			{
				for (myy = 0; myy < level.heightInTiles; myy++)
				{
					var nearexit:Boolean = false;
						
					for each(var ex:Exit in zone.exits)
					{
						if (Util.Distance(ex.x, ex.y, mxx, myy) < Content.nMonstersTooCloseToExit)
						{
							nearexit = true;
							break;
						}
					}
					

					
					if (!nearexit && zone.accessiblemap[mxx][myy] == 1 && zone.intangmap[mxx][myy] == 0)
					{
						var code:uint = 0x00000000;
								
						if (zone.watermap[mxx][myy] >= 1)
							code |= Content.Code_Water;
						
						if (interim_level.getTile(mxx, myy - 1) >= Content.barriertile)
							code |= Content.Code_Up;
							
						if (interim_level.getTile(mxx, myy + 1) >= Content.barriertile)
						{
							code |= Content.Code_Down;
							grounds++;
						}
							
						if (interim_level.getTile(mxx - 1, myy) >= Content.barriertile)
							code |= Content.Code_Left;
							
						if (interim_level.getTile(mxx + 1, myy) >= Content.barriertile)
							code |= Content.Code_Right;
						
						if (zone.watermap[mxx][myy] != 0 && // this is water
							interim_level.getTile(mxx, myy - 1) < Content.barriertile && // above is open
							zone.watermap[mxx][myy - 1] == 0) // above isn't water
						{
							code |= Content.Code_Surface;
						}
						
						
				
						arrayMonsterSpots.push(new PointPlus(mxx, myy, code));
						
						if (((arrayMonsterSpots[arrayMonsterSpots.length - 1] as PointPlus).obj as uint & Content.Code_Down) > 0)
						{
							postgrounds++;
						}
					}
				}
			}		
			//trace("PostGrounds1: " + postgrounds.toString());
			
			arrayMonsterSpots = Util.ShuffleArray(arrayMonsterSpots, ran); // That way we can randomize on monster, then sprint through spots & keep the first qualifying spot
			//trace("Grounds: " + grounds.toString());
					
			postgrounds = 0;
			
			for (var mm:int = 0; mm < arrayMonsterSpots.length; mm++)
			{
				var u:uint = (arrayMonsterSpots[mm] as PointPlus).obj as uint;
				if ((u & Content.Code_Down) > 0)
				{
					postgrounds++;
				}
			}
			
			//trace("PostGrounds: " + postgrounds.toString());
			
			var monsters:int = 0;
				
			
			//COLOR -=-=-=-=-=-=-
			var roff:Number = ran.integer(0, 500) - 250;
			var goff:Number = ran.integer(0, 500) - 250;
			var boff:Number = ran.integer(0, 500) - 250;
			var intensity:Number = Math.abs(roff) + Math.abs(goff) + Math.abs(boff);
			
			var min:int = -250;
			var max:int = 150;
			
			var speedmod:Number = ran.integer(50, 200) / 100;
			
			while (intensity < 50 || intensity > 100)
			{
				roff = ran.integer(0, max - min) + min;
				goff = ran.integer(0, max - min) + min;
				boff = ran.integer(0, max - min) + min;
				intensity = Math.abs(roff) + Math.abs(goff) + Math.abs(boff);
			}
			//COLOR -=-=-=-=-=-=-
			
		
			arrayBestiary = Util.Dupe(arrayBestiaryPossible);
			
			
			var bPickMonsters:Boolean = true;
			var arrayWinners:Array = new Array();
			var arrayMonsterSpawns:Array = new Array();
			var arrayMonsterSpotConsume:Array = new Array();
			var winner:MonsterCard = null;
			var testcode:uint = 0;
			var spotsforkinds:int = 0;
			var bStillNeeded:Boolean = true;
			var kind:int = 0;
			var kinds:int = 0;
			
			var m:int = 0;
			do
			{				
				if (bPickMonsters)
				{
					bPickMonsters = false;
					
					kinds = ran.integer(1, 4);
					
					while (kinds > arrayBestiary.length)
						kinds--;
					
					//trace("kinds: " + kinds.toString());
					
					if (kinds > 0)
					{
						m = 0;

						arrayBestiaryCards.splice(0);
						arrayWinners.splice(0);
						arrayMonsterSpawns.splice(0);
						arrayMonsterSpotConsume.splice(0);
						arrayMonsterSpotConsume = Util.Dupe(arrayMonsterSpots);
					
						
						var kindreport:String = "kinds are: ";
						
						// Make our monster deck!
						for (var b:int = 0; b < arrayBestiary.length; b++)
							for (var bb:int = 0; bb < (arrayBestiary[b] as MonsterCard).nWeight * 100; bb++)
								arrayBestiaryCards.push(arrayBestiary[b]);
						
						for (kind = 0; kind < kinds; kind++) // Different kinds to do = 1
						{
							spotsforkinds = 0;
							
							var which:int = 0;
							var unique:Boolean = true;
							
							which = ran.integer(arrayBestiaryCards.length);
							winner = (arrayBestiaryCards[which] as MonsterCard);				
							
							kindreport += winner.strName + " ";
							
							for (var spottest:int = 0; spottest < arrayMonsterSpotConsume.length; spottest++)
							{
								testcode = (arrayMonsterSpotConsume[spottest] as PointPlus).obj as uint;
								
								if ((winner.uNeedsOne & testcode) > 0 &&
									((winner.uNeedsAll & testcode) == winner.uNeedsAll &&
									!((winner.uResists & testcode) > 0)))
								{
									spotsforkinds++;
								}
							}
							
							//Remove cards for this monster kind
							for (var card:int = 0; card < arrayBestiaryCards.length; card++)
							{
								if ((arrayBestiaryCards[card] as MonsterCard).strName == winner.strName)
								{
									arrayBestiaryCards.splice(card, 1);
									card--;
								}
							}
							for (var beast:int = 0; beast < arrayBestiary.length; beast++)
							{
								if ((arrayBestiary[beast] as MonsterCard).strName == winner.strName)
								{
									arrayBestiary.splice(beast, 1);
									beast--;
								}
							}
							
							while (kinds > arrayBestiary.length)
								kinds--;
							
							if (spotsforkinds != 0)
							{
								if (bSingleMonster)
									winner.iNeeded = 1;
								else
								{
									winner.iNeeded = (spotsforkinds * saturation * winner.nSatModifier) / kinds;
									trace("Making " + winner.iNeeded.toString() + "x " + winner.strName + " given " + spotsforkinds + " slots");
								}
								
								arrayWinners.push(winner);
								
								
							}
							else
							{
								kind--; // Rewind and try a different card
							}
							
							
						}
					}
					else
					{
						// No kinds left to try. :(
						return;
					}
				}
				
				
				bStillNeeded = false;
				for (kind = 0; kind < arrayWinners.length; kind++)
				{
					if ((arrayWinners[kind] as MonsterCard).iNeeded != 0)
					{
						bStillNeeded = true;
						break;
					}
				}
				
				if (bStillNeeded)
				{
				
					var mtype:int = 0;
					
					do
					{
						mtype = ran.integer(0, arrayWinners.length); // You, Mr. Monster, are the lucky winner!
						winner = arrayWinners[mtype];
					} while (winner.iNeeded == 0);
					
					winner.iNeeded--;
					
					for (var spot:int = 0; spot < arrayMonsterSpotConsume.length; spot++)
					{
						testcode = (arrayMonsterSpotConsume[spot] as PointPlus).obj as uint;
						
						if ((winner.uNeedsOne & testcode) > 0 &&
							((winner.uNeedsAll & testcode) == winner.uNeedsAll &&
							!((winner.uResists & testcode) > 0)))
						{
							var spawnx:int = (arrayMonsterSpotConsume[spot] as PointPlus).x;
							var spawny:int = (arrayMonsterSpotConsume[spot] as PointPlus).y;
							
							arrayMonsterSpawns.push(new PointPlus(spawnx, spawny, winner.strName));

							arrayMonsterSpotConsume.splice(spot, 1);
							m++;
						
							break;
						}
						else
						{
							//TraceCodeCompare(winner.uResists, testcode);
						}
						
						if (spot == arrayMonsterSpotConsume.length - 1)
						{
							// Get rid of too-needy critters from the bestiary
							
							for (var loser:int = 0; loser < arrayWinners.length; loser++)
							{
								if ((arrayWinners[kind] as MonsterCard).iNeeded != 0) // Too-needy
								{
									for (var kill:int = 0; kill < arrayBestiary.length; kill++) // Find it
									{
										if ((arrayBestiary[which] as MonsterCard).strName == (arrayWinners[loser] as MonsterCard).strName) // Found it
										{
											arrayBestiary.splice(which, 1); // Kill it from future consideration
										}
									}
								}
							}

							bPickMonsters = true; // Try again with new monsters...
						}
					}
				}
				
				
			} while (arrayMonsterSpotConsume.length != 0 && bStillNeeded);
			
			
			
			for (var spawn:int = 0; spawn < arrayMonsterSpawns.length; spawn++)
			{
				spawnx = (arrayMonsterSpawns[spawn] as PointPlus).x;
				spawny = (arrayMonsterSpawns[spawn] as PointPlus).y;
				var spawnname:String = (arrayMonsterSpawns[spawn] as PointPlus).obj as String;
				
				var left:Boolean;
				var right:Boolean;
				left = false;
				right = false;
			
				
				var spawns:Array = new Array();
						
				if (spawnname == "Beetle")
				{
					spawns.push(new Beetle(this, spawnx * 30, spawny * 30, new ColorTransform(1, 1, 1, 1, roff, goff, boff, 0), 
						speedmod));
				}
				else if (spawnname == "Bat")
				{
					spawns.push(new Bat(this, spawnx * 30, spawny * 30, new ColorTransform(1, 1, 1, 1, roff, goff, boff, 0), 
						speedmod));
				}
				else if (spawnname == "FaceShoot")
				{
					if (spawnx == 99 && spawny == 114)
					{
						var g:int = 2;
					}
					if (interim_level.getTile(spawnx - 1, spawny) >= Content.barriertile)
						right = true;
						
					if (interim_level.getTile(spawnx + 1, spawny) >= Content.barriertile)
						left = true;
						
						
					if (left && right)
					{
						if (zone.rand.integer(0, 1) == 0)
						{
							right = false;
						}
						else
							left = false;
					}
					
					if (right)
					{
						spawns.push(new FaceShoot(this, (spawnx * 30) - 20, spawny * 30, new ColorTransform(1, 1, 1, 1, roff, goff, boff, 0), 
						speedmod));
					}
					else
					{
						spawns.push(new FaceShoot(this, (spawnx * 30) + 20, spawny * 30, new ColorTransform(1, 1, 1, 1, roff, goff, boff, 0), 
						speedmod));
						
						(spawns[spawns.length - 1] as FaceShoot).facing = FlxObject.LEFT;
					
					}
				}
				else if (spawnname == "Goblin")
				{
					spawns.push(new Goblin(this, spawnx * 30, spawny * 30, new ColorTransform(1, 1, 1, 1, roff, goff, boff, 0), 
						speedmod));
				}
				else if (spawnname == "Shroom")
				{
					spawns.push(new Shroom(this, spawnx * 30, spawny * 30, new ColorTransform(1, 1, 1, 1, roff, goff, boff, 0), 
						speedmod));
				}
				else if (spawnname == "Slab")
				{
					spawns.push(new Slab(this, spawnx * 30, spawny * 30, new ColorTransform(1, 1, 1, 1, roff, goff, boff, 0), 
						speedmod));
						
					//toadd.alpha = 0.7;
				}
				else if (spawnname == "LittleSlab")
				{
					spawns.push(new LittleSlab(this, spawnx * 30, (spawny * 30), new ColorTransform(1, 1, 1, 1, roff, goff, boff, 0), 
						speedmod));
						
					//toadd.alpha = 0.7;
				}
				else if (spawnname == "Crawler")
				{
					spawns.push(new Crawler(this, spawnx * 30, spawny * 30, new ColorTransform(1, 1, 1, 1, roff, goff, boff, 0), 
						speedmod));
					
					if (interim_level.getTile(spawnx, spawny + 1) >= Content.barriertile) // floor, so go right!
					{
						(spawns[spawns.length - 1] as Crawler).y += (spawns[spawns.length - 1] as Crawler).iMagnet;
						(spawns[spawns.length - 1] as Crawler).iDir = Content.RIGHT;
					}
					else if (interim_level.getTile(spawnx, spawny - 1) >= Content.barriertile) // ceiling, so go left!
					{
						(spawns[spawns.length - 1] as Crawler).x += (spawns[spawns.length - 1] as Crawler).iMagnet;
						(spawns[spawns.length - 1] as Crawler).iDir = Content.LEFT;
					}
					else if (interim_level.getTile(spawnx + 1, spawny) >= Content.barriertile) // wallright, so go up!
					{
						(spawns[spawns.length - 1] as Crawler).x += (spawns[spawns.length - 1] as Crawler).iMagnet;
						(spawns[spawns.length - 1] as Crawler).y += (spawns[spawns.length - 1] as Crawler).iMagnet;
						(spawns[spawns.length - 1] as Crawler).iDir = Content.UP;
					}
					else if (interim_level.getTile(spawnx - 1, spawny) >= Content.barriertile) // wallleft, so go down!
					{
						(spawns[spawns.length - 1] as Crawler).iDir = Content.DOWN;
					}
				}
				else if (spawnname == "Fish")
				{
					spawns.push(new Fish(this, spawnx * 30, spawny * 30, new ColorTransform(1, 1, 1, 1, roff, goff, boff, 0), 
						speedmod));
				}
				else if (spawnname == "Hopper")
				{
					spawns.push(new Hopper(this, spawnx * 30, spawny * 30, new ColorTransform(1, 1, 1, 1, roff, goff, boff, 0), 
						speedmod));
				}
				
				if (spawns.length > 0)
				{
					for each(var toadd:Monster in spawns)
					{
						arrayAllMonsters.push(toadd);
						arrayFarMonsters.push(toadd);
						
						if (toadd.bFrontMonster)
							groupFrontMonsters.add(toadd);
						else
							groupMonsters.add(toadd);
							
						toadd.x += toadd.offset.x - 30;
						toadd.y += toadd.offset.y - 30;
						//toadd.Pause(true);
					}
				}
				
				spawns.splice(0);
			}
			
			
		}
		
		public function TraceCodeCompare(monster:uint, spot:uint):void
		{
			var comp:String = "";
			
			
			if ((monster & Content.Code_Water) > 0) comp += "1"; else comp += "0";
			if ((monster & Content.Code_Surface) > 0) comp += "1"; else comp += "0";
			if ((monster & Content.Code_Up) > 0) comp += "1"; else comp += "0";
			if ((monster & Content.Code_Right) > 0) comp += "1"; else comp += "0";
			if ((monster & Content.Code_Down) > 0) comp += "1"; else comp += "0";
			if ((monster & Content.Code_Left) > 0) comp += "1"; else comp += "0";
			
			comp += " vs. ";
			
			if ((spot & Content.Code_Water) > 0) comp += "1"; else comp += "0";
			if ((spot & Content.Code_Surface) > 0) comp += "1"; else comp += "0";
			if ((spot & Content.Code_Up) > 0) comp += "1"; else comp += "0";
			if ((spot & Content.Code_Right) > 0) comp += "1"; else comp += "0";
			if ((spot & Content.Code_Down) > 0) comp += "1"; else comp += "0";
			if ((spot & Content.Code_Left) > 0) comp += "1"; else comp += "0";
			
			trace(comp);
		}
		
		
		
		public var bPaused:Boolean = false;
		public var bAnyKeyJustPressed:Boolean = false;
		public var bLastAnyKeyState:Boolean = false;
		override public function update():void
		{
			if (bUpdateBreak)
			{
				var whatever:int = 0;
			}
			
			nElapsedInZone += FlxG.elapsed;
			
			var mouseX:Number = FlxG.mouse.x;		//Get the X position of the mouse in the game world 
			var mouseY:Number = FlxG.mouse.y;		//Get the Y position of the mouse in the game world 
			var mousetileX:int = int(mouseX / 30);
			var mousetileY:int = int(mouseY / 30);
			var screenX:Number = FlxG.mouse.screenX;	//Get the X position of the mouse in screen space
			var pressed:Boolean = FlxG.mouse.pressed();	//Check whether the mouse is currently pressed
			var justPressed:Boolean = FlxG.mouse.justPressed();
			var justReleased:Boolean = FlxG.mouse.justReleased();
			var xdiff:int = 0;
			var ydiff:int = 0;
			var xdest:int = 0;
			var ydest:int = 0;
			
			bAnyKeyJustPressed = false;
			if (bLastAnyKeyState == false && FlxG.keys.any())
			{
				bAnyKeyJustPressed = true;
			}
			
			bLastAnyKeyState = FlxG.keys.any();
			
			
					
			switch(state)
			{
				case Content.LOADING:
				{
					GenFire();
					
					hud.update();
					
				}
				break;
				case Content.INITIALIZING:
				{
					if (ready == true)
					{
						UpdatePlayerCamera();
						
						if (bDoorPan)
						{
							StartCameraPan(Content.DOORENTERING);
							
							ptToCamera.x = ptPlayerCamera.x;
							ptToCamera.y = ptPlayerCamera.y;
							
							if (camefrom == 0)
							{
								ptFromCamera.x = ptToCamera.x;
								ptFromCamera.y = ptToCamera.y - Content.nEnteringDistance;
							}
							else if (camefrom == 1)
							{
								ptFromCamera.x = ptToCamera.x;
								ptFromCamera.y = ptToCamera.y + Content.nEnteringDistance;
							}
							else if (camefrom == 2)
							{
								ptFromCamera.x = ptToCamera.x - Content.nEnteringDistance;;
								ptFromCamera.y = ptToCamera.y;
							}
							else if (camefrom == 3)
							{
								ptFromCamera.x = ptToCamera.x + Content.nEnteringDistance;
								ptFromCamera.y = ptToCamera.y;
							}
						}
						else
						{
							StartCameraPan(Content.DEFAULT);
							
							ptFromCamera.x = ptPlayerCamera.x;
							ptFromCamera.y = ptPlayerCamera.y;
							
							ptToCamera.x = ptPlayerCamera.x;
							ptToCamera.y = ptPlayerCamera.y;
						}
						
						UpdateCameraPan();
						
						hud.LoadVisible(false);
						state = Content.ACTION;
					}
				}
				break;
				case Content.LEAVING:
				{
					super.update();
					
					UnpausedUpdates();
					UpdateCameraPan();
					
					if (hero.GetCurrentAnim() == "leaving" && hero.GetCurrentFrame() == 14)
					{
						xdiff = 0;
						ydiff = 0;
						if (camefrom == 0)
							ydiff = -1;
						else if (camefrom == 1)
							ydiff = 1;
						else if (camefrom == 2)
							xdiff = -1;
						else if (camefrom == 3)
							xdiff = 1;
						
						xdest = zone.description.coords.x + xdiff;
						ydest = zone.description.coords.y + ydiff;
						
						
						
						
						
						bPaused = false;
						this.GroupPause(false);
						
						this.dump();
						this.LoadZone(xdest, ydest);
					}
				}
				break;
				case Content.DEAD:
				{
					super.update();
				
					UnpausedUpdates();					
					//UpdateCameraPan();
					
					if (iDeadState == Content.JUSTDIED)
					{				
						nDeadWait = Content.nDeadWaitTime;
						
						CauseExplosion(5, hero.x, hero.y, 0);
						hero.visible = false;
						hero.bow.visible = false;
				
			
						Util.StopMusic();
						
						
						
						
						FlxG.play(Content.soundDead, Content.volumeDead, false, false);
						FlxG.play(Content.soundHurt, Content.volumeHurt * 0.7, false, false);
						
						iDeadState = Content.WAITFORCOIN;
					}
					else
					{
						nDeadWait -= FlxG.elapsed;
					
						if (iDeadState == Content.WAITFORCOIN &&
							nDeadWait <= Content.nDeadWaitTime / 2)
						{
							
							FlxG.play(Content.soundDreamCoin, Content.volumeDreamCoin, false, false, Content.nDefaultSkip);
							arrayGrunts.push(new Grunt(hero.x + (hero.width / 2), hero.y + (hero.height / 2) - 10, "+1 Dream Coin", 0xFF888888, 120));
							(arrayGrunts[arrayGrunts.length - 1] as Grunt).AddSprite(18);
							groupGrunts.add(arrayGrunts[arrayGrunts.length - 1] as Grunt);
							
							iDeadState = Content.COINGIVEN;
						}
						else if (iDeadState == Content.COINGIVEN && //<- superfluous
							nDeadWait <= 0)
						{
							if (camefrom == 0)
								camefrom = 1;
							else if (camefrom == 1)
								camefrom = 0;
							else if (camefrom == 2)
								camefrom = 3;
							else if (camefrom == 3)
								camefrom = 2;
					
							var currentx:int = zone.description.coords.x;
							var currenty:int = zone.description.coords.y;
							
							this.dump();
							bWasDead = true;
							this.LoadZone(currentx, currenty);						
						}
					}
				}
				break;
				case Content.SCRIPTED:
				{
					super.update();
				
					hero.bBearings = false; // Disable camera look-left/look-right
					//ptDeviation.x = ptTargetDeviation.x;
					UpdateCameraPan();
					UpdateTasks();
					
					var line:String = starring.arrayScript[iSPC];
					var command:String = line;
					var content:String = "";
					var contentpieces:Array;
					
					var checkline:String = "";
				
					var destination:String = "";
					var destinationline:int = -1;
					
					var expressionpieces:Array;
					var itemname:String = "";
					var comparator:String = "";
					var value:int = 0;
					
					var truth:Boolean = false;
			
					if (line.indexOf(" ") > -1)
					{
						command = Util.ParseCommand(line);
						content = Util.ParseContent(line);
						
						if (line.indexOf("|") > -1)
						{
							contentpieces = content.split("|");
						}
					}
					
					if (iLineState == Content.NEWLINE)
					{
						if (command == "vent")
						{
							var ventname:String = contentpieces[0];
							var venttarget:Monster = Util.GetSpriteByName(arrayAllMonsters, ventname) as Monster;
							
							/*
							if (venttarget == null)
							{
								venttarget = Util.GetMonsterByName(arrayFarMonsters, ventname);
							}*/
							
							if (venttarget != null)
							{
								StartCameraPan(Content.DEFAULT);
								ptToCamera.x = venttarget.x;
								ptToCamera.y = venttarget.y;
							
								hud.Chat(true, (venttarget as Talker).sprFace, contentpieces[1]);
								iLineState = Content.PROCESSING;
								
								hover.visible = true;
								
								hover.play("talking", true);
								hover.x = venttarget.x;// - venttarget.offset.x;
								hover.y = venttarget.y - 0 - 24;
							}
							else
							{
								hud.Chat(true, starring.sprFace, "ERR: CANNOT FIND ACTOR " + ventname);
							}
							return;
						}
						else
						{
							if (command == "say")
							{
								StartCameraPan(Content.DEFAULT);
								ptToCamera.x = starring.x;
								ptToCamera.y = starring.y;
								
								hud.Chat(true, starring.sprFace, content);
								iLineState = Content.PROCESSING;
								
								hover.visible = true;
								hover.play("talking", true);
								hover.x = starring.x;// - starring.offset.x;
								hover.y = starring.y - 0 - 24;
								return;
							}
							else if (command == "ask")
							{
								StartCameraPan(Content.DEFAULT);
								ptToCamera.x = starring.x;
								ptToCamera.y = starring.y;
									
								hud.Chat(true, starring.sprFace, contentpieces[0]);
								iLineState = Content.PROCESSING;
								
								hud.SetChoice(true);
								
								hover.visible = true;
								hover.play("talking", true);
								hover.x = starring.x;// - starring.offset.x;
								hover.y = starring.y - 0 - 24;
								return;
							}
							else if (command == "bye")
							{
								bPaused = false;
								hud.strState = "";
								hud.Chat(false);
								this.GroupPause(false);
								bLastAnyKeyState = true;
								hud.StartSlideOut(Content.nSlideOutTime);
								hero.bJumpRecharged = false;
								hero.nShootRecharged = 0;
								state = Content.ACTION;
								StartCameraPan(Content.DEFAULT);
								
								return;
							}
							else if (command == "" || command == "header")
							{
								iSPC++;
								iLineState = Content.NEWLINE;
								return;
							}
							else if (command == "test")
							{							
								expressionpieces = (contentpieces[0] as String).split(" ");
								itemname = expressionpieces[0];
								comparator = expressionpieces[1];
								value = int(expressionpieces[2]);
								
								truth = false;
								
								if (comparator == "==" && Content.stats.ChangeItem(itemname, 0) == value) truth = true;
								else if (comparator == "<=" && Content.stats.ChangeItem(itemname, 0) <= value) truth = true;
								else if (comparator == ">=" && Content.stats.ChangeItem(itemname, 0) >= value) truth = true;
								else if (comparator == ">" && Content.stats.ChangeItem(itemname, 0) > value) truth = true;
								else if (comparator == "<" && Content.stats.ChangeItem(itemname, 0) < value) truth = true;
								else if (comparator == "!=" && Content.stats.ChangeItem(itemname, 0) != value) truth = true;
								
								if (truth == true)
									destination = contentpieces[1];
								else
									destination = contentpieces[2];
									
								destinationline = Util.SPCofHeader(starring.arrayScript, destination);
								
								if (destinationline == -1)
								{
									trace("ERROR! Invalid header: " + destination);
								}
								else
								{
									iSPC = destinationline + 1;
									iLineState = Content.NEWLINE;
									return;
								}
							}
							else if (command == "change")
							{
								expressionpieces = content.split(" ");
								itemname = expressionpieces[0];
								value = int(expressionpieces[1]);
								
								Content.stats.ChangeItem(itemname, value);
								
								iSPC++;
								iLineState = Content.NEWLINE;
								return;
							}
						}
					}
					else if (iLineState == Content.PROCESSING)
					{
						if ((command == "say" || command == "vent")&& bAnyKeyJustPressed && hud.strState == "chatting")
						{
							if (hud.NextLine())
							{
								iSPC++;
								iLineState = Content.NEWLINE;
							}
						}
						else if(command == "ask" && hud.strState == "chatting")
						{
							if (hud.chattext.text.length >= (hud.arrayIntended[hud.iCurrentLine] as String).length)
							{
								hud.ChoiceVisible(true);
								
								hud.choicelefttext.text = contentpieces[1];
								hud.choicerighttext.text = contentpieces[3];
								
								if (FlxG.keys.justPressed("LEFT"))
								{
									hud.SetChoice(true);
								}
								else if (FlxG.keys.justPressed("RIGHT"))
								{
									hud.SetChoice(false);
								}
								else if (FlxG.keys.justPressed("ENTER") || FlxG.keys.justPressed("X"))
								{
									hud.ChoiceVisible(false);
		
									if (hud.choicecursor.facing == FlxObject.LEFT)
										destination = contentpieces[2];
									else
										destination = contentpieces[4];
									
									destinationline = Util.SPCofHeader(starring.arrayScript, destination);
									
									if (destinationline == -1)
									{
										trace("ERROR! Invalid header: " + destination);
									}
									else
									{
										iSPC = destinationline + 1;
										iLineState = Content.NEWLINE;
										return;
									}
								}
							}
							else if (bAnyKeyJustPressed)
							{
								hud.NextLine();
							}
						}
					}
				}
				break;
				case Content.PAUSEMENU:
				{
					if (FlxG.keys.justPressed("P") && (hud.strState == "" || hud.strState == "truepause"))
					{
						hud.SetBars(0);
						bPaused = !bPaused;
						
						if(bPaused != false)
							trace("PAUSE MISMATCH DETECTED");
							
						hud.strState = "";
						hud.GoCorner();
						
						hud.bg.visible = false;
						
						Content.stats.cavemap.AddSpritesToHUD(hud.cavecanvas, zone.description.coords.x, zone.description.coords.y, 
							(268 / 2) - 6,
							(268 / 2) - 6,
							0,
							0,
							42,
							42,
							true);
					
						
						this.GroupPause(bPaused);
						FlxG.Pause(bPaused);
						
						state = Content.ACTION;
					}
					else if(FlxG.keys.UP || FlxG.keys.DOWN || FlxG.keys.LEFT || FlxG.keys.RIGHT)
					{
						if (FlxG.keys.UP)
						{
							Content.stats.nCaveOffsetY += Content.nCaveMapSpeed * FlxG.elapsed;
						}
						
						if (FlxG.keys.DOWN)
						{
							Content.stats.nCaveOffsetY -= Content.nCaveMapSpeed * FlxG.elapsed;
						}
						
						if (FlxG.keys.LEFT)
						{
							Content.stats.nCaveOffsetX += Content.nCaveMapSpeed * FlxG.elapsed;
						}
						
						if (FlxG.keys.RIGHT)
						{
							Content.stats.nCaveOffsetX -= Content.nCaveMapSpeed * FlxG.elapsed;
						}
						
						Content.stats.cavemap.AddSpritesToHUD(hud.cavecanvas, zone.description.coords.x, zone.description.coords.y, 
							(268 / 2) - 6 + int(Content.stats.nCaveOffsetX), 
							(268 / 2) - 6 + int(Content.stats.nCaveOffsetY),
							16,
							16,
							268,
							268,
							false);
					}
				}
				break;
				default: // case Content.ACTION:
				{		
					if (hero.velocity.x != 0 || hero.velocity.y != 0)
						bMovedOnce = true;
					
					distext.text = int(mouseX / 30).toString() + "," + int(mouseY / 30).toString();//(hero.x / 30).toString() + "," + (hero.y / 30).toString();
					if (zone != null)
						coordstext.text = "(" + zone.description.coords.x.toString() + "," + zone.description.coords.y.toString() + ")";
									
					if (FlxG.keys.S)
					{
						if (genus == "terrain")
						{
							interim_level.setTile(mousetileX, mousetileY, Content.barriertile);
							zone.SetMap(mousetileX, mousetileY, 1);
							ProperTiles(zone.description.style, mousetileX - Content.iProperTileRadius, mousetileY - Content.iProperTileRadius, mousetileX + Content.iProperTileRadius, mousetileY + Content.iProperTileRadius);
							
							MiracleManager.SetOverride(new Miracle(zone.description.coords.x, zone.description.coords.y, mousetileX, mousetileY, Content.TERRAIN, "", 1));
						}
						else if (genus == "wallpaper")
						{
							wallpaper.setTile(mousetileX, mousetileY, hud.iCurrentPiece, true);
							ProperTiles(zone.description.style, mousetileX - Content.iProperTileRadius, mousetileY - Content.iProperTileRadius, mousetileX + Content.iProperTileRadius, mousetileY + Content.iProperTileRadius);
						
							MiracleManager.SetOverride(new Miracle(zone.description.coords.x, zone.description.coords.y, mousetileX, mousetileY, Content.WALLPAPER, hud.iCurrentPiece.toString(), 1));
						}
					}
					else if (FlxG.keys.E)
					{
						if (genus == "terrain")
						{
							interim_level.setTile(mousetileX, mousetileY, 0);
							zone.SetMap(mousetileX, mousetileY, 0);
							ProperTiles(zone.description.style, mousetileX - Content.iProperTileRadius, mousetileY - Content.iProperTileRadius, mousetileX + Content.iProperTileRadius, mousetileY + Content.iProperTileRadius);
							
							MiracleManager.SetOverride(new Miracle(zone.description.coords.x, zone.description.coords.y, mousetileX, mousetileY, 0, "", 1));
						}
						else if (genus == "wallpaper")
						{
							wallpaper.setTile(mousetileX, mousetileY, 0, true);
							ProperTiles(zone.description.style, mousetileX - Content.iProperTileRadius, mousetileY - Content.iProperTileRadius, mousetileX + Content.iProperTileRadius, mousetileY + Content.iProperTileRadius);
						
							MiracleManager.SetOverride(new Miracle(zone.description.coords.x, zone.description.coords.y, mousetileX, mousetileY, Content.WALLPAPER, "", 1));
						}
					}
					
					if (FlxG.keys.justPressed("R"))
					{
						ProperTiles(zone.description.style, 0, 0, level.widthInTiles, level.heightInTiles);	
					}
					
					if (FlxG.keys.justPressed("D"))
					{
						if (genus == "terrain") genus = "wallpaper";
						else if (genus == "wallpaper") genus = "terrain";
						
						genustext.text = genus;
					}
					
					if (FlxG.keys.justPressed("F"))
					{
						hud.SetCurrentPiece(hud.iCurrentPiece - 1);
					}
					else if (FlxG.keys.justPressed("G"))
					{
						hud.SetCurrentPiece(hud.iCurrentPiece + 1);
					}
					else if (FlxG.keys.justPressed("V"))
					{
						hud.SetCurrentPiece(hud.iCurrentPiece - 16);
					}
					else if (FlxG.keys.justPressed("B"))
					{
						hud.SetCurrentPiece(hud.iCurrentPiece + 16);
					}
					
					if (FlxG.keys.justPressed("F5"))
					{
						MiracleManager.IntegrateZoneMiracles();
						MiracleManager.SaveMiracles();
						MiracleManager.PopulateZoneMiracles(zone.description.coords.x, zone.description.coords.y);
					}
					
					if (FlxG.keys.justPressed("M") && (hud.strState == "" || hud.strState == "map"))
					{
						lillevel.visible = !lillevel.visible;
						
						if (lillevel.visible)
							hud.strState == "map";
						else
							hud.strState == "";
					}
					
					if (FlxG.keys.pressed("K") && FlxG.keys.pressed("L"))
					{
						hero.Hit(50000, 0);
					}
					
					if (FlxG.keys.justPressed("P") && (hud.strState == "" || hud.strState == "truepause"))
					{
						Content.stats.nCaveOffsetX = 0;
						Content.stats.nCaveOffsetY = 0;
						
						hud.SetBars(0);
						bPaused = !bPaused; // should now be "true"
						
						if(bPaused != true)
							trace("PAUSE MISMATCH DETECTED");
						
						hud.strState = "";
						hud.GoCorner();
						
						hud.bg.visible = false;
						
						Content.stats.cavemap.AddSpritesToHUD(hud.cavecanvas, zone.description.coords.x, zone.description.coords.y, 
							(268 / 2) - 6, 
							(268 / 2) - 6,
							16,
							16,
							268,
							268,
							false);
						
						
						this.GroupPause(bPaused);
						FlxG.Pause(bPaused);
						state = Content.PAUSEMENU;
					}
					
					hover.visible = false;
					
					
					var atexit:Exit = null;
					for each(var ex:Exit in zone.exits)
					{
						if (ex.x == int((hero.x + (hero.width / 2)) / 30) && ex.y == int((hero.y + (hero.height / 2)) / 30))
						{
							atexit = ex;
							
							if(hero.GetCurrentAnim() != "leaving" && hero.GetCurrentAnim() != "arriving")
								hover.visible = true;
								
							hover.play("door");
							hover.x = ex.x * 30;
							hover.y = (ex.y * 30) - nHoverBounce - 30;
						}
					}

					var totalk:Talker = null;
			
					if (atexit == null)
					{
						hover.visible = false; 
						
						if (hero.isTouching(FlxObject.FLOOR) || hero.iLastFluid > 0)
						{
							var candidates:Array = new Array();
							
							for each(var mon:Monster in arrayNearMonsters)
							{
								if ((mon is Talker) && 
									Util.Distance(mon.x, mon.y + (mon.height - 30), hero.x, hero.y) <= 30 &&
									(mon as Talker).arrayScript.length > 0)
								{
									candidates.push(mon);
								}
							}
							
							if (candidates.length > 0)
							{
								if (candidates.length == 1)
								{
									totalk = candidates[0] as Talker;
								}
								else
								{
									var nShortestDistance:Number = 99999;
									for each(var candidate:Talker in candidates)
									{
										var nDistance:Number = Util.Distance(candidate.x, candidate.y, hero.x, hero.y);
										if (nDistance < nShortestDistance)
										{
											totalk = candidate;
											nShortestDistance = nDistance;
										}
									}
								}
								
								if(hero.GetCurrentAnim() != "leaving" && hero.GetCurrentAnim() != "arriving")
									hover.visible = true;
									
								hover.play("talk");
								hover.x = totalk.x;// - totalk.offset.x;
								hover.y = totalk.y - nHoverBounce - 24;
							}
						}
					}
					
					
					if (FlxG.keys.justPressed("DOWN") && hero.GetCurrentAnim() != "arriving")
					{
						if (hud.strState == "")
						{
							if (totalk != null)
							{
								bPaused = true;
								hud.strState = "chatting";
								
								starring = totalk;
								iSPC = 0;
								state = Content.SCRIPTED;
								iLineState = Content.NEWLINE;
								
								this.GroupPause(true);
								hud.StartSlideIn(Content.nSlideInTime);
								/*
								StartCameraPan();
								ptToCamera.x = totalk.x;
								ptToCamera.y = totalk.y;
								*/
								return;
								
							}
						}
						
						if (atexit != null)
						{
							hover.visible = false;
							bow.visible = false;
							
							xdiff = 0;
							ydiff = 0;

								
							if (atexit.id == 0) ydiff = -1;
							else if (atexit.id == 1) ydiff = 1;
							else if (atexit.id == 2) xdiff = -1;
							else if (atexit.id == 3) xdiff = 1;
							
							xdest = zone.description.coords.x + xdiff;
							ydest = zone.description.coords.y + ydiff;
							
							Content.stats.cavemap.ExploreCave(xdest, ydest);
						
							if (Content.stats.cavemap.GetCave(xdest, ydest).strRegionName != zone.description.strRegionName)
							{
								trace("This's " + zone.description.strRegionName + " is not like " + Content.stats.cavemap.GetCave(xdest, ydest).strRegionName);
								Util.StopMusic();
							}
							
							state = Content.LEAVING;
							
							//hud.SetBars(0);
							
							camefrom = atexit.id;
							hero.x = (atexit.x * 30) + 6;
							hero.y = (atexit.y * 30) + 7;
							hero.velocity.x = 0;
							hero.velocity.y = 0;
							hero.acceleration.x = 0;
							hero.acceleration.y = 0;
							
							hero.play("leaving", true);
							FlxG.play(Content.soundLeave, Content.volumeLeave, false, false);
							
							if (Content.stats.iHealth < Content.stats.iMaxHealth)
							{
								
								Content.stats.iHealth = Content.stats.iMaxHealth;
								hud.UpdateHearts();
								FlxG.play(Content.soundRefresh, Content.volumeRefresh, false, false, Content.nDefaultSkip);
								arrayGrunts.push(new Grunt(hero.x + (hero.width / 2), hero.y + (hero.height / 2) - 20, "Refreshed!", 0xFFff9d9d, 120));
								(arrayGrunts[arrayGrunts.length - 1] as Grunt).AddSprite(19);
								groupGrunts.add(arrayGrunts[arrayGrunts.length - 1] as Grunt);
							}
							
							if (bDoorPan)
							{
								StartCameraPan(Content.DOORLEAVING);
								
								if (atexit.id == 0)
								{
									ptToCamera.x = ptToCamera.x;
									ptToCamera.y = ptToCamera.y - Content.nLeavingDistance;
								}
								else if (atexit.id == 1)
								{
									ptToCamera.x = ptToCamera.x;
									ptToCamera.y = ptToCamera.y + Content.nLeavingDistance;
								}
								else if (atexit.id == 2)
								{
									ptToCamera.x = ptToCamera.x - Content.nLeavingDistance;
									ptToCamera.y = ptToCamera.y;
								}
								else if (atexit.id == 3)
								{
									ptToCamera.x = ptToCamera.x + Content.nLeavingDistance;
									ptToCamera.y = ptToCamera.y;
								}
							}
							else
							{
								StartCameraPan(Content.DEFAULT);
								
								ptToCamera.x = hero.x - 6;
								ptToCamera.y = hero.y + 15;
							}
							
							SortMonstersToFront();
							
							return;
						
						}
					}
					
					if (FlxG.keys.justPressed("Q"))
					{
						/*
						
						this.dump();
						
						var rx:int = Util.Random( -5000, 5000);
						var ry:int = Util.Random( -5000, 5000);
						
						
						rx = Util.Random( -5000, 5000);
						ry = Util.Random( -5000, 5000);
						this.LoadZone(rx, ry);
						return;
						*/
						
						var montoquash:Exit = null;
						for each(var mq:Monster in arrayAllMonsters)
						{
							if (mouseX >= mq.x && mouseX <= mq.x + mq.width &&
								mouseY >= mq.y && mouseY <= mq.y + mq.height)
							{
								mq.Quash(!mon.bQuashed);
							}
						}
					}
					
					super.update();

					if (this.bPaused == false)
					{
						UnpausedUpdates();
						
						UpdatePlayerCamera();
						ptToCamera.x = ptPlayerCamera.x;
						ptToCamera.y = ptPlayerCamera.y;
						UpdateCameraPan();
					}
				}
				break;
			}
		}
		
		
		public function UnpausedUpdates():void
		{
			FlxG.collide(hero, level);
						
			UpdateTasks();
			UpdateWaterParticles();	
			UpdateAlerts();
			UpdatePellets();
			UpdateMonsters();
			UpdateArrows();
			UpdateFriendlies();
			UpdateMonsterMonsterCollide();
			//FlxG.collide(boulderGroup, level);
			
			UpdateTime();						
			UpdateBow();
			UpdateSpotlight();
			UpdateHover();
			
			
			UpdateGrunts();
			
			debugtext.text = (groupParticles.length).toString();		
		}
		
		public function SortMonstersToFront():void
		{
			/*
			for (var m:int = 0; m < arrayNearMonsters.length; m++)
			{
				this.remove(arrayNearMonsters[m], true);
				this.add(arrayNearMonsters[m]);
			}
			*/
		}
		
		
		public function UpdateMonsterMonsterCollide():void
		{
			var collidetests:int = 0;
			for (var m:int = 0; m < arrayNearMonsters.length; m++)
			{
				(arrayNearMonsters[m] as Monster).bOnMonster = false;
				
				if ((arrayNearMonsters[m] as Monster).bLevelCollision && !(arrayNearMonsters[m] as Monster).bBlockade && !(arrayNearMonsters[m] as Monster).bForceImmovable)
				{
					collidetests++;
					FlxG.collide(arrayNearMonsters[m] as Monster, level);
				}
					
				if ((arrayNearMonsters[m] as Monster).bHeroCollision)
				{
					collidetests++;
					FlxG.collide(arrayNearMonsters[m] as Monster, hero);
				}
				
				if ((arrayNearMonsters[m] as Monster).bMonsterCollision || (arrayNearMonsters[m] as Monster).bBlockade)
				{
					for (var n:int = m + 1; n < arrayNearMonsters.length; n++)
					{
						if (
							(arrayNearMonsters[m] as Monster).bBlockade 
							&&
							(arrayNearMonsters[n] as Monster).bBlockade
							== false
							)
						{
							if (
								((arrayNearMonsters[n] as Monster).bMonsterCollision && 
								(arrayNearMonsters[m] as Monster).bMonsterCollision) 
								||
								((arrayNearMonsters[n] as Monster).bBlockade || 
								(arrayNearMonsters[m] as Monster).bBlockade)
								)
								{
									FlxG.collide(arrayNearMonsters[n] as Monster, arrayNearMonsters[m] as Monster, MonsterMonsterCollide);
									collidetests++;
								}
						}
					}
				}
			}
			//trace("tests: " + collidetests.toString());
		}
		
		
		
		public function UpdateTime():void
		{
			Content.stats.iTime++;
			
			if (Content.stats.iTime >= 300 * 60)
				Content.stats.iTime = 0;
			
			var frame:int = (Content.stats.iTime / (300 * 60)) * 30;
			
			if (frame >= 8 && frame <= 22)
			{
				filter.visible = true;
				
				if (frame == 6 || frame == 24) 			filter.alpha = 0.2;
				else if (frame == 7 || frame == 23) 	filter.alpha = 0.4;
				else if (frame == 8 || frame == 22) 	filter.alpha = 0.6;
				else if (frame == 9 || frame == 21) 	filter.alpha = 0.8;
				else 									filter.alpha = 1.0;
				
				hud.clocktext.text = "DAEL";
				hud.clocktext.color = 0xFFCFCFCF;
			}
			else
			{
				filter.visible = false;
				
				hud.clocktext.text = "INEL";
				hud.clocktext.color = 0xFFB432FF;
			}
			
			hud.clock.frame = frame;
		}
		
		public function UpdateTasks():void
		{
			/*
			for (var t:int = 0; t < generaltasks.length; t++)
			{
				if ((generaltasks[t] as Task).Progress() == true)
				{
					
				}
			}*/
		}
		
		public function ArrowLevelCollide(arrow:Arrow, lvl:FlxTilemap):void
		{		
			Twang(arrow);
		}
		
		public function Twang(arrow:Arrow):void
		{
			arrow.velocity.x = 0;
			arrow.velocity.y = 0;
			arrow.acceleration.y = 0;
			arrow.ArrowPlay("dead");
			arrow.iAlive = Content.iArrowLife - 1;
			
			FlxG.play(Content.soundTwang, Content.volumeTwang, false, false, Content.nDefaultSkip);
		}
		
		public function ArrowLevelCollideBounceVertical(arrow:Arrow, lvl:FlxTilemap):void
		{
			if (arrow.isTouching(FlxObject.CEILING))
			{
				/*
				arrow.facing = FlxObject.RIGHT;
				arrow.SetDirection(-1, false);	
				arrow.bBouncing = false;
			
				Twang(arrow);
				*/
				
				if (arrow.velocity.y < 0)
					arrow.velocity.y *= -1;
			}
			
			if (arrow.isTouching(FlxObject.FLOOR) && arrow.iBounceLife < Content.iArrowBounceStick)
			{
				arrow.facing = FlxObject.RIGHT;
				arrow.SetDirection(1, false);	
				arrow.bBouncing = false;
			
				Twang(arrow);
			}
		}
		
		public function ArrowLevelCollideBounceHorizontal(arrow:Arrow, lvl:FlxTilemap):void
		{
			//trace("ArrowLevelCollideBounceHorizontal");
			if (arrow.isTouching(FlxObject.LEFT) && arrow.iBounceLife < Content.iArrowBounceStick)
			{
				arrow.SetDirection(0, false);	
				arrow.bBouncing = false;
				
			
				Twang(arrow);
			}
			
			if (arrow.isTouching(FlxObject.RIGHT) && arrow.iBounceLife < Content.iArrowBounceStick)
			{
				arrow.SetDirection(0, true);	
				arrow.bBouncing = false;
			
				Twang(arrow);
			}
		}
		
		public function MonsterMonsterCollide(m1:Monster, m2:Monster):void
		{
			var m1midx:int = m1.x + (m1.width / 2);
			var m1midy:int = m1.y + (m1.height / 2);
			var m2midx:int = m2.x + (m2.width / 2);
			var m2midy:int = m2.y + (m2.height / 2);
			
			var bigwidth:int = Math.max(m1.width, m2.width);
			
			if (Math.abs(m1midx + m2midx) < bigwidth / 2)
			{
				if (m1midy < m2midy)
					m1.bOnMonster = true;
				else
					m2.bOnMonster = true;
			}
			
			if (m1.strName == "FaceFire")
			{
				if(m1.facing == FlxObject.RIGHT)
					m2.Struck(-1, Content.RIGHT, 20);
				else if(m1.facing == FlxObject.LEFT)
					m2.Struck(-1, Content.LEFT, 20);
			}
		}
		
		public function HeroArrowCollide(player:Player, arrow:Arrow):void
		{
		}
		
		public function UpdateAlerts():void
		{
			
			for (var a:int = 0; a < hud.arrayAlerts.length; a++)
			{
				(hud.arrayAlerts[a] as FlxSprite).visible = false;
			}
			
			for (var xx:int = (hero.x / 30) - 15; xx <= hero.x / 30 + 15; xx++)
			{
				if (xx >= 0 && xx < level.width)
				{
					for (var yy:int = (hero.y / 30) + 5; yy < level.height; yy++)
					{
						if (zone.accessiblemap[xx][yy] != 1)
						{
							break;
						}
						else if (zone.spikemap[xx][yy] == 1 && Math.abs(yy * 30 - dolly.y) > 120)
						{
							var alert:FlxSprite = Util.GetInvisibleSpriteByName(hud.arrayAlerts, "alert") as FlxSprite;
							if (alert != null)
							{
								alert.x = xx * 30;
								alert.y = Content.screenheight - 15;
								alert.visible = true;
							}
							break;
						}
					}
				}
			}
		}
		
		public function UpdateWaterParticles():void
		{
			UpdateTwinkles();
			UpdateBreathBubs();
			UpdateDoorBubs();
		}
		
		public function UpdateTwinkles():void
		{
			
			var x:int = 0;
			var y:int = 0;
			
			if (zone.waterlist.length > 0)
			{
				for (var i:int = 0; i < Content.iTwinkliness * (zone.waterlist.length / 150); i++) //(Content.iTwinkliness * zone.waterlist.length / 150)
				{
					var r:int = Util.Random(0, zone.waterlist.length - 1);
					x = ((zone.waterlist[r] as PointPlus).x * 30);
					y = ((zone.waterlist[r] as PointPlus).y * 30);
					
					if (Math.abs(hero.x - x) < iThresholdX && Math.abs(hero.y - y) < iThresholdY)
					{
					
						x += Util.Random(0, 29);
						
						if ((zone.waterlist[r] as PointPlus).obj as String == "s")
						{
							y += Util.Random(11, 29);
						}
						else
							y += Util.Random(0, 29);
					}
					
					var toadd:Twinkle = null;
					
					toadd = Util.GetInvisibleSpriteByName(arrayParticles, "Twinkle") as Twinkle;
					
					if (toadd == null)
					{
						toadd = new Twinkle(this, x, y);
						arrayParticles.push(toadd);
						groupParticles.add(toadd);
					}
					else
					{
						toadd.Reuse(x, y);
					}
				}	
			}
		}
		
		public function UpdateBreathBubs():void
		{
			var x:int = 0;
			var y:int = 0;
			
			if (hero.iLastFluid == 2 || (hero.iLastFluid == 1 && hero.y % 30 > 2))
			{
				if (Util.Random(0, 40 - (40 * hero.nBubbliness)) == 0) // bub
				{
					x = hero.x + 8;
					y = hero.y;
					
					var dir:int = 270;
					
					if (hero.velocity.x < 0)
						dir -= Util.Random(5, 30);
					else if (hero.velocity.x > 0)
						dir += Util.Random(5, 30);
						
					var xoff:int = Util.Random(-4 + (-6 * hero.nBubbliness), 4 + (6 * hero.nBubbliness));
					var yoff:int = Util.Random(8 * hero.nBubbliness, 20 * hero.nBubbliness);
					
					MakeBub(x + xoff, y + yoff, dir, 10);
				}
			}
		}
		
		public function MakeBub(x:int, y:int, dir:Number, sp:Number):void
		{
			var toadd:Bub = null;
					
			toadd = Util.GetInvisibleSpriteByName(arrayParticles, "Bub") as Bub;
			
			if (toadd == null)
			{
				toadd = new Bub(this, x, y, dir, sp);
				arrayParticles.push(toadd);
				groupParticles.add(toadd);
			}
			else
			{
				toadd.Reuse(x, y, dir, sp);
			}
		}
		
		public function UpdateDoorBubs():void 
		{
			var x:int = 0;
			var y:int = 0;
			
			for each(var ex:Exit in zone.exits)
			{
				if (Util.Random(0, 20) == 0) // bub
				{
					if (zone.watermap[ex.x][ex.y] == 1 && zone.watermap[ex.x][ex.y - 1] == 1)
					{
						if (Math.abs(hero.x - (ex.x * 30)) < iThresholdX && Math.abs(hero.y - (ex.y * 30)) < iThresholdY)
						{
							var min:int = 30;
							var max:int = 56;
							var by:int = Util.Random(min, max);
							min = 7;
							max = 19;
							var bx:int = Util.Random(min, max);
							
							//groupParticles.add(new Bub(this, (ex.x * 30) + bx, ((ex.y - 1) * 30) + by, 270, 10));
							
							MakeBub((ex.x * 30) + bx, ((ex.y - 1) * 30) + by, 270, 10);
						}
					}
				}
			}
			
		}
		
		public function UpdateFriendlies():void
		{
			
			for (var g:int = 0; g < arrayAllGems.length; g++)
			{
				//FlxG.collide(arrayAllGems[m] as Collectible, heo);
				
				if ((arrayAllGems[g] as Collectible).doomed)
				{
					var tilex:int = ((arrayAllGems[g] as Collectible).x - 10) / 30;
					var tiley:int = ((arrayAllGems[g] as Collectible).y - 10) / 30;
					
					lillevel.setTile(tilex, tiley, 1);
					
					// Set "collected" profile miracle
					MiracleManager.SetOverride(new Miracle(zone.description.coords.x, zone.description.coords.y, tilex, tiley, 0, "", 
						0));
					
					
					var name:String = (arrayAllGems[g] as Collectible).name;
					
					if (name == "+1 Pip")
					{
						FlxG.play(Content.soundPip, Content.volumePip, false, false, Content.nDefaultSkip);
						Content.stats.ChangeItem("pip", 1);
					}
					else if (name == "+3 Pips")
					{
						FlxG.play(Content.soundPip, Content.volumePip, false, false, Content.nDefaultSkip);
					    Content.stats.ChangeItem("pip", 5);
					}
					else if (name == "+1 Reod")
					{
						FlxG.play(Content.soundReod, Content.volumeReod, false, false, Content.nDefaultSkip);
						Content.stats.ChangeItem("reod", 1);
					}
					else if (name == "+3 Reods")
					{
						FlxG.play(Content.soundReod, Content.volumeReod, false, false, Content.nDefaultSkip);
						Content.stats.ChangeItem("reod", 5);
					}
					else if (name == "+1 Lytrat")
					{
						FlxG.play(Content.soundLytrat, Content.volumeLytrat, false, false, Content.nDefaultSkip);
						Content.stats.ChangeItem("lytrat", 1);		
					}
					else if (name == "+3 Lytrats")
					{
						FlxG.play(Content.soundLytrat, Content.volumeLytrat, false, false, Content.nDefaultSkip);
						Content.stats.ChangeItem("lytrat", 5);				
					}
					
						
					this.remove(arrayAllGems[g]);
					arrayAllGems.splice(g, 1);
					g--;
				}
			}
		}
		
		public function UpdateGrunts():void
		{
			for (var a:int = 0; a < arrayGrunts.length; a++)
			{				
				if ((arrayGrunts[a] as Grunt).doomed == true)
				{
					groupGrunts.remove(arrayGrunts[a]);
					arrayGrunts.splice(a,1);
					a--;
				}
			}
		}
		
		public function UpdatePellets():void
		{
			for (var a:int = 0; a < arrayPellets.length; a++)
			{
				
				if ((arrayPellets[a] as Pellet).GetCurrentFrame() == 40)
				{
					groupPellets.remove(arrayPellets[a]);
					arrayPellets.splice(a,1);
					a--;
				}
				else
					FlxG.collide(arrayPellets[a] as Pellet, level);
			}
		}
		
		public function UpdateArrows():void
		{
			for (var a:int = 0; a < arrayArrows.length; a++)
			{
				var arrow:Arrow = arrayArrows[a];
				
				if (arrow.bBouncing == false)
				{				
					FlxG.collide(arrow, level, ArrowLevelCollide);
					
					if (arrow.iAlive < Content.iArrowLife)
					{
						if (arrow.iAlive > 0)
							arrow.iAlive--;
							
						var iCollisions:uint = arrow.allowCollisions;
						arrow.allowCollisions = FlxObject.UP;
						arrow.immovable = true;
						
						
						
						if (arrow.iDir == 0 &&
							hero.fluid == 0 &&
							!hero.bDownButton)// && hero.bJumpButton == true)
							FlxG.collide(hero, arrow, HeroArrowCollide);
							
						arrow.immovable = false;
						arrow.allowCollisions = iCollisions;
						
						if (arrow.GetCurrentFrame() == int(78 * 0.75))
						{
							arrow.flicker(100);
						}
						else if (arrow.GetCurrentFrame() == 78)
						{
							groupArrows.remove(arrayArrows[a]);
							arrayArrows.splice(a,1);
							a--;
						}
					}
					else
					{
					}
				}
				else
				{
					
					
					// collide() keeps stomping these...
					var nOldVelocityX:Number = arrow.velocity.x;
					var nOldVelocityY:Number = arrow.velocity.y;
					var nOldX:Number = arrow.x;
					var nOldY:Number = arrow.y;
					
					// Pretend we're vertical
					
					arrow.width = 3;
					arrow.height = 14;
					arrow.offset.x = 18;
					arrow.offset.y = 7;
			
					FlxG.collide(arrow, level, ArrowLevelCollideBounceVertical); // Bonk with level vertically?
					
					if (arrow.bBouncing) // Still spinning!
					{
						// Pretend we're horizontal
						
						arrow.width = 14;
						arrow.height = 3;
						arrow.offset.x = 7;
						arrow.offset.y = 19;
						
						arrow.velocity.x = nOldVelocityX;
						arrow.velocity.y = nOldVelocityY;
						arrow.x = nOldX;
						arrow.y = nOldY;
								
						FlxG.collide(arrow, level, ArrowLevelCollideBounceHorizontal); // Bonk with level horizontally?
						
						if (arrow.bBouncing) // Still spinning!
						{
							// Back to boxy
						
							arrow.width = 14;
							arrow.height = 14;
							arrow.offset.x = 8;
							arrow.offset.y = 8;
							
							arrow.iBounceLife--;
							
							if (arrow.iBounceLife == 0)
							{
								groupArrows.remove(arrayArrows[a]);
								arrayArrows.splice(a,1);
								a--;
							}
							else
							{
								arrow.velocity.x = nOldVelocityX;
								arrow.velocity.y = nOldVelocityY;
							}
						}
					}
					
				}
			}
		}
		
		public var arrayAllGems:Array = null;
		
		public var arrayAllMonsters:Array = null;
		public var arrayFarMonsters:Array = null;
		public var arrayNearMonsters:Array = null;
		
		public const iMonsterCheckBatch:int = 30;
		public const iMonsterCheckReady:int = 1;
		public var iMonsterCheckTicks:Number = 0;
		public var iFarCheck:int = 0;
		public var iNearCheck:int = 0;
		public var iThresholdX:int = Content.screenwidth;
		public var iThresholdY:int = Content.screenheight;
		public function UpdateMonsters():void
		{
			for (var i:int = 0; i < 6; i++)
			{
				if (iFarCheck >= arrayFarMonsters.length)
					iFarCheck = 0;
							
				if (iNearCheck >= arrayNearMonsters.length)
					iNearCheck = 0;
					
				
				if (arrayFarMonsters.length > 0)
				{
					if ((arrayFarMonsters[iFarCheck] as Monster).visible)
					{
						if ((arrayFarMonsters[iFarCheck] as Monster).doomed || (arrayFarMonsters[iFarCheck] as Monster).bKillIfFar ||
							(arrayFarMonsters[iFarCheck] as Monster).y > level.height + 400)
						{
							if ((arrayFarMonsters[iFarCheck] as Monster).bFrontMonster)
								groupFrontMonsters.remove(arrayFarMonsters[iFarCheck]);
							else
								groupMonsters.remove(arrayFarMonsters[iFarCheck]);
							
							var why:String = "";
							if ((arrayFarMonsters[iFarCheck] as Monster).doomed) why += " doomed";
							if ((arrayFarMonsters[iFarCheck] as Monster).bKillIfFar) why += " killiffar";
							if ((arrayFarMonsters[iFarCheck] as Monster).y > level.height + 400) why += " oow";
								
							//trace((arrayFarMonsters[iFarCheck] as Monster).strName + " removed (was far) " + why);
								
							(arrayFarMonsters[iFarCheck] as Monster).visible = false;
							//arrayFarMonsters[iFarCheck] = null;
							arrayFarMonsters.splice(iFarCheck, 1);
						}
						else if (Math.abs(hero.x - (arrayFarMonsters[iFarCheck] as Monster).x) <= iThresholdX && 
							Math.abs(hero.y - (arrayFarMonsters[iFarCheck] as Monster).y) <= iThresholdY)
						{
							//trace((arrayFarMonsters[iFarCheck] as Monster).strName + " is now near");
							
							(arrayFarMonsters[iFarCheck] as Monster).Pause(false);
							
							arrayNearMonsters.push(arrayFarMonsters[iFarCheck]);
							arrayFarMonsters.splice(iFarCheck, 1);
						}
						else
						{
							
						}
					}
				}
				iFarCheck++;
			
				if (arrayNearMonsters.length > 0)
				{
					if ((arrayNearMonsters[iNearCheck] as Monster).visible)
					{
						if((arrayNearMonsters[iNearCheck] as Monster).doomed)
						{
							if ((arrayNearMonsters[iNearCheck] as Monster).bFrontMonster)
								groupFrontMonsters.remove(arrayNearMonsters[iNearCheck]);
							else
								groupMonsters.remove(arrayNearMonsters[iNearCheck]);
							
							//trace((arrayNearMonsters[iNearCheck] as Monster).strName + " removed (was near)");
								
							(arrayNearMonsters[iNearCheck] as Monster).visible = false;
							//arrayNearMonsters[iNearCheck] = null;
							arrayNearMonsters.splice(iNearCheck, 1);
						}
						else if (Math.abs(hero.x - (arrayNearMonsters[iNearCheck] as Monster).x) > iThresholdX || 
							Math.abs(hero.y - (arrayNearMonsters[iNearCheck] as Monster).y) > iThresholdY)
						{
							if (bPauseFarMonsters)
								(arrayNearMonsters[iNearCheck] as Monster).Pause(true);
								
							//trace((arrayNearMonsters[iNearCheck] as Monster).strName + " is now far");
							
							arrayFarMonsters.push(arrayNearMonsters[iNearCheck]);
							arrayNearMonsters.splice(iNearCheck, 1);
						}
					}
				}
				iNearCheck++;
			}
			
				
		}
		
		public var ptDeviation:FlxPoint = new FlxPoint(0, 60);
		public var ptTargetDeviation:FlxPoint = new FlxPoint(0, 60);
		public var nCamSpeed:Number = 50;

		public var nCamTransfer:Number = 1;
		public var ptFromCamera:FlxPoint = new FlxPoint(0, 0);
		public var ptToCamera:FlxPoint = new FlxPoint(0, 0);
		public var ptPlayerCamera:FlxPoint = new FlxPoint(0, 0);
		
		public function UpdatePlayerCamera():void
		{
			if ((hero.bShock == false && hero.bBearings == true) || !bMovedOnce)
			{
				if (!bMovedOnce)
				{
					ptDeviation.x = 0;
					ptTargetDeviation.x = 0;
				}
				else if (hero.facing == FlxObject.RIGHT)//hero.velocity.x > 0)
					ptTargetDeviation.x = 60;
				else if (hero.facing == FlxObject.LEFT) //hero.velocity.x < 0)
					ptTargetDeviation.x = -60;
				//else
				//	ptTargetDeviation.x = 0;
				
				var nSpeedTweak:Number = ((1 - (Math.abs(ptDeviation.x) / 60)) * 2) + 1;
				
				
				if (ptDeviation.x < ptTargetDeviation.x && ptTargetDeviation.x != 0)
				{
					ptDeviation.x += FlxG.elapsed * nCamSpeed * nSpeedTweak;
					
					if (ptDeviation.x > ptTargetDeviation.x)
						ptDeviation.x = ptTargetDeviation.x;
				}
					
				if (ptDeviation.x > ptTargetDeviation.x && ptTargetDeviation.x != 0)
				{
					ptDeviation.x -= FlxG.elapsed * nCamSpeed * nSpeedTweak;
					
					if (ptDeviation.x < ptTargetDeviation.x)
						ptDeviation.x = ptTargetDeviation.x;
				}
				
			}
			
			ptPlayerCamera.x = hero.x - ((Content.twidth) / 2) + 9 + ptDeviation.x; // centered
			ptPlayerCamera.y = hero.y - ((Content.theight)) + ptDeviation.y; // down one block from centered
		}
		
		public var iPanStyle:int = Content.DEFAULT;
		
		public function StartCameraPan(style:int):void
		{
			iPanStyle = style;
			
			if (nCamTransfer != 0 && nCamTransfer != 1)
			{
				if (iPanStyle == Content.DEFAULT)
				{
					ptFromCamera.x = Util.CameraPanCurrent(ptFromCamera.x, ptToCamera.x, nCamTransfer); 
					ptFromCamera.y = Util.CameraPanCurrent(ptFromCamera.y, ptToCamera.y, nCamTransfer); 
				}
				else
				{
					ptFromCamera.x = Util.LinearCurrent(ptFromCamera.x, ptToCamera.x, nCamTransfer); 
					ptFromCamera.y = Util.LinearCurrent(ptFromCamera.y, ptToCamera.y, nCamTransfer); 
				}
			}
			
			nCamTransfer = 0;
		}
		

		public function UpdateCameraPan():void
		{
			if (nCamTransfer < 1)
			{
				if (iPanStyle == Content.DEFAULT)
					nCamTransfer += Content.nPanSpeed;
				else if (iPanStyle == Content.DOORLEAVING)
					nCamTransfer += Content.nLeavingPanSpeed;
				else if(iPanStyle == Content.DOORENTERING)
					nCamTransfer += Content.nEnteringPanSpeed;
					
				if (nCamTransfer > 1)
				{
					nCamTransfer = 1;
				}
				
				if (iPanStyle == Content.DEFAULT)
				{
					dolly.x = Util.CameraPanCurrent(ptFromCamera.x, ptToCamera.x, nCamTransfer) + dollyoffset; 
					dolly.y = Util.CameraPanCurrent(ptFromCamera.y, ptToCamera.y, nCamTransfer); 
				}
				else
				{
					dolly.x = Util.LinearCurrent(ptFromCamera.x, ptToCamera.x, nCamTransfer) + dollyoffset; 
					dolly.y = Util.LinearCurrent(ptFromCamera.y, ptToCamera.y, nCamTransfer); 
				}
			}
			else
			{
					
				ptFromCamera.x = ptToCamera.x;
				ptFromCamera.y = ptToCamera.y;
				
				dolly.x = ptFromCamera.x + dollyoffset;
				dolly.y = ptFromCamera.y;
			}
			

		}
		
		public function UpdateSpotlight():void
		{
			spotlight.x = hero.x + 35 - Content.herohitoffsetx;
			spotlight.y = hero.y + 35 - Content.herohitoffsety;
		}
		
		public var nHoverBounce:Number = 0;
		public var nHoverTrack:Number = 0;
		public function UpdateHover():void
		{
			nHoverTrack += Content.nHoverBounceSpeed;
			
			if (nHoverTrack > (2 * Math.PI))
				nHoverTrack -= (2 * Math.PI);
				
			nHoverBounce = Math.abs(Math.sin(nHoverTrack) * Content.nHoverBounceHeight);
		}
		
		public function UpdateBow():void
		{
			bow.facing = hero.facing;
			
			var anim:String = hero.GetCurrentAnim();
			
			
			
			if (anim == "stand" ||
				(anim.charAt(anim.length - 2) + anim.charAt(anim.length - 1) == "up") ||
				(anim.charAt(anim.length - 2) + anim.charAt(anim.length - 1) == "dn"))
			{
				bow.x = hero.x;
				bow.y = hero.y;
			}
			else
			{
				var xbump:int = 1;
				
				if (anim == "crouch")
				{
					xbump = -2;
					bow.y = hero.y + 4;
				}
				else if (anim != "fall")
				{
					if (anim == "struck")
						bow.y = hero.y - 1
					else
						bow.y = hero.y + 1
				}
				else 	
					bow.y = hero.y;
					
				if(hero.facing == FlxObject.RIGHT)
					bow.x = hero.x + (xbump);
				else
					bow.x = hero.x - (xbump);
				
				
			}
		}
		
		public function CauseExplosion(splode:int, x:int, y:int, row:int):void
		{
			var rot:Number = Util.Random(0, 360);
			for (var i:int = 0; i < splode; i++)
			{
				var spd:Number = Util.Random(40, 100);
				
				var toadd:Puff = null;
				
				toadd = Util.GetInvisibleSpriteByName(arrayParticles, "Puff") as Puff;
				
				if (toadd == null)
				{
					toadd = new Puff(this, x, y, ((360 / splode) * i) + rot, spd, row);
					arrayParticles.push(toadd);
					groupParticles.add(toadd);
				}
				else
					toadd.Reuse(x, y, ((360 / splode) * i) + rot, spd, row);
			}
		}	
		
		public var radj:Number = 0;
		public var gadj:Number = 0;
		public var badj:Number = 0;
		public function AdjustColor(rd:Number, gd:Number, bd:Number):void
		{
			radj += rd;
			gadj += gd;
			badj += bd;
			
			
			var colTrans:ColorTransform = new ColorTransform(1 + radj, 1 + gadj, 1 + badj, 1, 0, 0, 0);
			level._tiles = FlxG.addBitmap(Content.cFronts,false,true);
			level._tiles.colorTransform(new Rectangle(0, 0, level._tiles.width, level._tiles.height), colTrans);
			
			wall._tiles = FlxG.addBitmap(Content.cWalls,false,true);
			wall._tiles.colorTransform(new Rectangle(0, 0, wall._tiles.width, wall._tiles.height), colTrans);
			
			//trace((int(radj*10)).toString() + "," + (int(gadj*10)).toString() + "," + (int(badj*10)).toString());
		}
		
		public var bRefreshed:Boolean = true;
		public function Up():void
		{
			bRefreshed = true;
		}
		
		public function Move():void
		{
		}
		
		public function Tap(xx:int, yy:int):void
		{
		}
		
		
	}
}