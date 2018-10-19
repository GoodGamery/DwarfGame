package  
{
	import flash.utils.ByteArray;
	
	public final class Content
	{
		public static var debugtexton:Boolean = true;
		public static var stats:CurrentStats = new CurrentStats();
		
		public static const nHChance:Number = 0.35;
		public static const nVChance:Number = 0.25;
		public static const nRegionStretch:Number = 1.5;
		
		public static const bNewWater:Boolean = false;
		
		public static const nOpenChance:Number = 0.4;
		public static const nVertChance:Number = 0.4;
		public static const nNexusChance:Number = 0.06; // 0.08;
		public static const nSecretTunnelMinimum:Number = 3;
		public static const bSecretChambers:Boolean = true;
		public static const nHorizontalCinchCoefficient:Number = 1.5;
		public static const nVerticalCinchCoefficient:Number = 0.7;
		public static const nShaftCoefficient:Number = 1.5;
		public static var nCurrentVerticalCinchCoefficient:Number = 0.7;
		public static const nRequireSpaceForSpikesChance:Number = 0.9;
		public static const iIceFuelMin:int = 6;
		public static const iIceFuelMax:int = 15;
		
		public static const nGemChance:Number = 0.33;
		public static const nClusterChance:Number = 0.1;
		public static const nReodChance:Number = 0.1;
		public static const nLytratChance:Number = 0.005;
		public static const iWaterfallCap:int = 4;
		
		
		public static const iBoardWidth:int = 5;
		public static const iBoardHeight:int = 5;
		public static const iBoardX:int = 78;
		public static const iBoardY:int = 3;
		
		public static const iArrowLife:int = 6;
		public static const iArrowBounceLife:int = 60;
		public static const iArrowBounceStick:int = 50;
		public static const iArrowRebounce:int = 30;
		public static const iQuickRebounce:int = 59;
		public static const nGrav:int = 420;
		public static const nSplashBrakes:Number = 0.25; // 0.4
		public static const nForceThree:Number = 0.68;
		public static const nForceTwo:Number = 0.55;
		public static const nForceOne:Number = 0.4;
		public static const nForceTwoAndHalf:Number = 0.60;
		public static const nCollectDistance:Number = 25;
		
		public static const nCaveMapSpeed:Number = 150;

		public static const nSlideOutTime:Number = 0.5;
		public static const nSlideInTime:Number = 0.5;
		public static const nPanSpeed:Number = (1 / (0.5)) / 60; 
		public static const nEnteringPanSpeed:Number = (1 / (1)) / 60; 
		public static const nEnteringDistance:Number = 60;
		public static const nLeavingPanSpeed:Number = (1 / (3)) / 60; 
		public static const nLeavingDistance:Number = 180;
		public static const nDeadWaitTime:Number = 6;
		
		public static const nHoverBounceSpeed:Number = 5 / 60;
		public static const nHoverBounceHeight:Number = 6;
		
		public static const nMonstersTooCloseToExit:Number = 6;
		
		public static const iProperTileRadius:int = 10;
		public static const iChoiceDistance:int = 40;
		
		public static const DEFAULT:uint = 0;
		public static const DOORLEAVING:uint = 1;
		public static const DOORENTERING:uint = 1;
		
		public static const CITY:uint = 1;
		public static const INTEREST:uint = 2;
		public static const NOTE:uint = 3;
		
		public static const BLANK:uint = 0;
		public static const TERRAIN:uint = 1;
		public static const FACADE:uint = 2;
		public static const WALLPAPER:uint = 3;
		public static const DUDE:uint = 4;
		public static const SIGNPOST:uint = 5;
		
		public static const LOADING:uint = 0;
		public static const ACTION:uint = 1;
		public static const SCRIPTED:uint = 2;
		public static const LEAVING:uint = 3;
		public static const DEAD:uint = 4;
		public static const INITIALIZING:uint = 5;
		public static const PAUSEMENU:uint = 6;
		
		public static const JUSTDIED:uint = 0;
		public static const WAITFORCOIN:uint = 1;
		public static const COINGIVEN:uint = 2;
		
		public static const NEWLINE:uint = 0;
		public static const PROCESSING:uint = 1;
		public static const FINISHED:uint = 2;
		
		public static const INTANG_TUNNEL:int = 1;
		public static const INTANG_CHAMBER:int = 2;
		public static const INTANG_RESERVE:int = 3;
		
		public static const MEADOW:int = 0;
		public static const SWAMP:int = 1;
		public static const ICE:int = 2;
		public static const SAND:int = 3;
		public static const DEADWATER:int = 4;
		public static const STEAMVENTS:int = 5;
		public static const COLUMNS:int = 6;
		public static const AMBER:int = 7;
		public static const STONE:int = 8;
		
		public static const UP:uint = 0;
		public static const RIGHT:uint = 1;
		public static const DOWN:uint = 2;
		public static const LEFT:uint = 3;
		
		public static const Code_Water:uint = 0x10000000;
		public static const Code_Surface:uint = 0x01000000;
		public static const Code_Up:uint = 0x00100000;
		public static const Code_Right:uint = 0x00010000;
		public static const Code_Down:uint = 0x00001000;
		public static const Code_Left:uint = 0x00000100;
		
		public static const barriertile:int = 11;
		public static const walltile:int = 1;
		public static const iBlank:int = barriertile - 11;
		public static const iDarkOuter:int = barriertile - 10;
		public static const iSecretFlag:int = barriertile - 9;
		public static const iGrass:int = barriertile - 8;
		public static const iSpikes:int = barriertile - 7;
		public static const iWater:int = barriertile - 6;
		public static const iWaterGrass:int = barriertile - 5;
		public static const iWaterSpikes:int = barriertile - 4;
		public static const iShallow:int = barriertile - 3;
		public static const iShallowGrass:int = barriertile - 2;
		public static const iShallowSpikes:int = barriertile - 1;
		public static const iStuffAboveStuffBelow:int = barriertile + 0;
		public static const iEmptyAboveStuffBelow:int = barriertile + 1;
		public static const iStuffAboveEmptyBelow:int = barriertile + 2;
		public static const iEmptyAboveEmptyBelow:int = barriertile + 3;
		public static const iStuffAboveWaterBelow:int = barriertile + 4;
		public static const iEmptyAboveWaterBelow:int = barriertile + 5;
		public static const iBonus1:int = barriertile + 6;
		public static const iBonus2:int = barriertile + 7;
		public static const iBonus3:int = barriertile + 8;
		public static const iBonus4:int = barriertile + 9;
		
		
		
		/*
		[Embed(source='../content/glyphs.xml', mimeType="application/octet-stream")]
		public static const cGlyphs:Class; 
		
		public static var xmlGlyphs:XML;
		public static var arrayGlyphs:Array;
		public static function InitGlyphs():void
		{
			var barrayGlyphs:ByteArray = new Content.cGlyphs;
			var strGlyphs:String = barrayGlyphs.readUTFBytes(barrayGlyphs.length);
			xmlGlyphs = new XML(strGlyphs);
			
			arrayGlyphs = new Array();
			
			for each (var xmlItem:XML in xmlGlyphs.GLYPHS[0].GLYPH)
			{
				arrayGlyphs.push(new Glyph(xmlItem.@SHAPE, xmlItem.@COOLNESS));
			}
		}
		*/
		
		public static const iTwinkliness:int = 1;
		
		public static const screenwidth:int = 480;
		public static const screenheight:int = 300;
		
		public static const twidth:int = 30;
		public static const theight:int = 30;
		
		public static const heroboxwidth:int = 100;
		public static const heroboxheight:int = 100;
		
		public static const herohitwidth:int = 18;
		public static const herohitheight:int = 21;
		
		public static const herohitoffsetx:int = 35 + 6;
		public static const herohitoffsety:int = 35 + 9;
		
		//public static const worldoffsetx:int = 599;
		//public static const worldoffsety:int = -126;
		
		public static const worldoffsetx:int = 2626;
		public static const worldoffsety:int = -94;
		
		public static const nEverBars:Number = 17;
		public static const nTopOfStats:Number = 0;

		[Embed (source="../content/pc.ttf", fontFamily="NES", embedAsCFF="false")] 
        public static const strFont:String;
		
		[Embed (source="../content/statbar.png" )]
        public static const cStatBar:Class;
		
		[Embed (source="../content/hearts.png" )]
        public static const cHearts:Class;
		
		[Embed (source="../content/mapcaves.png" )]
        public static const cMapCaves:Class;
		
		[Embed (source="../content/circlemask.png" )]
        public static const cCircleMask:Class;
		
		[Embed (source="../content/spotlight.png" )]
        public static const cSpotlight:Class;
		
		[Embed (source="../content/hover.png" )]
        public static const cHover:Class;
		
		
		
		[Embed (source="../content/clock.png" )]
        public static const cClock:Class;
		
		[Embed (source="../content/choice.png" )]
        public static const cChoice:Class;
		
		[Embed (source="../content/npc.png" )]
        public static const cNPC:Class;
		
		[Embed (source="../content/npc_static.png" )]
        public static const cNPCStatic:Class;
		
		[Embed (source="../content/npc_other.png" )]
        public static const cNPCOther:Class;
		
		[Embed (source="../content/gems.png" )]
        public static const cGems:Class;
		
		[Embed (source="../content/heroreal.png" )]
        public static const cHero:Class;
		
		[Embed (source="../content/herointerim.png" )]
        public static const cHeroInterim:Class;
		
		[Embed (source="../content/maps.png" )]
        public static const cRuneMaps:Class;
		
		[Embed (source="../content/runemap_background.png" )]
        public static const cRuneMapBackground:Class;
		
		[Embed (source="../content/runemap_border.png" )]
        public static const cRuneMapBorder:Class;
		
		[Embed (source="../content/youarehere.png" )]
        public static const cYouAreHere:Class;
		
		[Embed (source="../content/cavenew.png" )]
        public static const cCaveNew:Class;
		
		[Embed (source="../content/cave.png" )]
        public static const cCave:Class;
		
		[Embed (source="../content/lilcave.png" )]
        public static const cLilCave:Class;
		
		[Embed (source="../content/arrow.png" )]
        public static const cArrow:Class;
		
		[Embed (source="../content/pellet.png" )]
        public static const cPellet:Class;
		
		[Embed (source="../content/items.png" )]
        public static const cItems:Class;

		[Embed (source="../content/monsters.png" )]
        public static const cMonsters:Class;
		
		[Embed (source="../content/monk.png" )]
        public static const cMonk:Class;
		
		[Embed (source="../content/mapnodes.png" )]
        public static const cMapNodes:Class;
		
		[Embed (source="../content/mapbars.png" )]
        public static const cMapBars:Class;
		
		[Embed (source="../content/faces.png" )]
        public static const cFaces:Class;
		
		[Embed (source="../content/chatbox.png" )]
        public static const cChatBox:Class;
		
		[Embed (source="../content/chatbubble.png" )]
        public static const cChatBubble:Class;
		
		[Embed (source="../content/particle.png" )]
        public static const cParticle:Class;
		
		[Embed (source="../content/twinkle.png" )]
        public static const cTwinkle:Class;
		
		[Embed (source="../content/splash.png" )]
        public static const cSplash:Class;
		
		[Embed (source = "../content/dwarven.txt", mimeType="application/octet-stream")]
		public static const cDwarvenLanguage:Class;
		
		[Embed (source = "../content/bounds.txt", mimeType="application/octet-stream")]
		public static const cEnvironmentBounds:Class;
		
		[Embed (source = "../content/miracles.txt", mimeType="application/octet-stream")]
		public static const cMiracles:Class;
		
		[Embed (source = "../content/miracles_game1.txt", mimeType="application/octet-stream")]
		public static const cMiraclesGame1:Class;
		
		// Cave Graphix
		
		public static const numbiomes:int = 9;
		public static const iTotalBiomes:int = 12;
		public static var biomes:Array;
		
		[Embed (source="../content/filter.png" )]
        public static const cFilter:Class;
		
		[Embed (source="../content/alert.png" )]
        public static const cAlert:Class;
		
		[Embed (source="../content/doors.png" )]
        public static const cDoors:Class;
		
		[Embed (source="../content/walls2.png" )]
        public static const cWalls:Class;
		
		[Embed (source="../content/wallpaper.png" )]
        public static const cWallpaper:Class;
		public static const iWallpaperPieces:int = 8 * 30;

		
		[Embed (source="../content/peppers.png" )]
        public static const cPeppers:Class;
		
		[Embed (source="../content/waterfall.png" )]
        public static const cWaterfall:Class;
		
		[Embed (source="../content/windmill.png" )]
        public static const cWindmill:Class;
		
		public static const iWallSheetWidth:int = 24;
		
		[Embed (source="../content/fronts_thicker.png" )]
        public static const cFronts:Class;
		
		[Embed (source="../content/fronts_thicker.png" )]
        public static const cFacade:Class;
		public static const iFacadePieces:int = 8 * 30;

		public static const iFrontSheetWidth:int = 21;
		
		[Embed (source="../content/back_columns.png" )]
        public static const cBackColumns:Class;
		
		[Embed (source="../content/back_forest.png" )]
        public static const cBackForest:Class;
		
		[Embed (source="../content/back_swamp.png" )]
        public static const cBackSwamp:Class;
	
		[Embed (source="../content/back_ice.png" )]
        public static const cBackIce:Class;
	
		[Embed (source="../content/back_sand.png" )]
        public static const cBackSand:Class;
		
		[Embed (source="../content/back_deadwater.png" )]
        public static const cBackDeadwater:Class;

		[Embed (source="../content/back_vents.png" )]
        public static const cBackVents:Class;
		
		[Embed (source="../content/back_amber2.png" )]
        public static const cBackAmber:Class;

		[Embed (source="../content/back_stone.png" )]
        public static const cBackStone:Class;
		
		[Embed(source = "../sounds/arrow.mp3")] 
		public static const soundArrow:Class;
		public static const volumeArrow:Number = 1.0;
		
		[Embed(source = "../sounds/swim.mp3")] 
		public static const soundSwim:Class;
		public static const volumeSwim:Number = 1.0;
		
		[Embed(source = "../sounds/defeated.mp3")] 
		public static const soundDefeated:Class;
		public static const volumeDefeated:Number = 0.25;
		
		[Embed(source = "../sounds/hurt.mp3")] 
		public static const soundHurt:Class;
		public static const volumeHurt:Number = 1.0;
		
		[Embed(source = "../sounds/jump.mp3")] 
		public static const soundJump:Class;
		public static const volumeJump:Number = 0.25;
		
		[Embed(source = "../sounds/lytrat.mp3")] 
		public static const soundLytrat:Class;
		public static const volumeLytrat:Number = 1.0;
		
		[Embed(source = "../sounds/offended.mp3")] 
		public static const soundOffended:Class;
		public static const volumeOffended:Number = 1.0;
		
		[Embed(source = "../sounds/pip.mp3")] 
		public static const soundPip:Class;
		public static const volumePip:Number = 1.0;
		
		[Embed(source = "../sounds/reod.mp3")] 
		public static const soundReod:Class;
		public static const volumeReod:Number = 1.0;
		
		[Embed(source = "../sounds/dreamcoin.mp3")] 
		public static const soundDreamCoin:Class;
		public static const volumeDreamCoin:Number = 1.0;
		
		[Embed(source = "../sounds/splash.mp3")] 
		public static const soundSplash:Class;
		public static const volumeSplash:Number = 0.3;
		
		[Embed(source = "../sounds/twang2.mp3")] 
		public static const soundTwang:Class;
		public static const volumeTwang:Number = 1.0;
		
		[Embed(source = "../sounds/ting.mp3")] 
		public static const soundTing:Class;
		public static const volumeTing:Number = 1.0;
		
		
		
		[Embed(source = "../sounds/chat.mp3")] 
		public static const soundChat:Class;
		public static const volumeChat:Number = 0.3;
		
		[Embed(source = "../sounds/dead.mp3")] 
		public static const soundDead:Class;
		public static const volumeDead:Number = 1.0;
		
		[Embed(source = "../sounds/enter.mp3")] 
		public static const soundEnter:Class;
		public static const volumeEnter:Number = 1.0;
		
		[Embed(source = "../sounds/leave.mp3")] 
		public static const soundLeave:Class;
		public static const volumeLeave:Number = 1.0;
		
		[Embed(source = "../sounds/refresh.mp3")] 
		public static const soundRefresh:Class;
		public static const volumeRefresh:Number = 1.0;
		
		[Embed(source = "../sounds/cricket2.mp3")] 
		public static const soundCricket:Class;
		public static const volumeCricket:Number = 0.4;
		
		[Embed(source = "../sounds/goblin.mp3")] 
		public static const soundGoblin:Class;
		public static const volumeGoblin:Number = 0.4;
		
		[Embed(source = "../sounds/spit.mp3")] 
		public static const soundSpit:Class;
		public static const volumeSpit:Number = 1.0;
		
		[Embed(source = "../sounds/song_rock.mp3")]
		public static const soundSongRock:Class;
		public static const volumeSongRock:Number = 0.8;
		
		[Embed(source = "../sounds/song_town.mp3")]
		public static const soundSongTown:Class;
		public static const volumeSongTown:Number = 0.8;
		
		[Embed(source = "../sounds/song_turtle.mp3")]
		public static const soundSongTurtle:Class;
		public static const volumeSongTurtle:Number = 0.8;
			
		[Embed(source = "../sounds/song_ice.mp3")]
		public static const soundSongIce:Class;
		public static const volumeSongIce:Number = 0.8;
		
		[Embed(source = "../sounds/song_happy.mp3")]
		public static const soundSongHappy:Class;
		public static const volumeSongHappy:Number = 0.8;
		
		[Embed(source = "../sounds/song_skip.mp3")]
		public static const soundSongSkip:Class;
		public static const volumeSongSkip:Number = 0.8;
		
		[Embed(source = "../sounds/song_desert_intro.mp3")]
		public static const soundSongDesertIntro:Class;
		[Embed(source = "../sounds/song_desert_main_full.mp3")]
		public static const soundSongDesertMain:Class;
		public static const volumeSongDesert:Number = 0.8;
		
		public static const nDefaultSkip:Number = 90;
		public static const nDefaultMusicSkip:Number = 10;
	}

}