import flash.utils.ByteArray;
import flixel.system.FlxAssets;

@:final class Content
{
    public static var debugtexton : Bool = true;
    public static var stats : CurrentStats = new CurrentStats();
    
    public static inline var nHChance : Float = 0.35;
    public static inline var nVChance : Float = 0.25;
    public static inline var nRegionStretch : Float = 1.5;
    
    public static var bNewWater : Bool = false;
    
    public static inline var nOpenChance : Float = 0.4;
    public static inline var nVertChance : Float = 0.4;
    public static inline var nNexusChance : Float = 0.06;  // 0.08;  
    public static inline var nSecretTunnelMinimum : Float = 3;
    public static var bSecretChambers : Bool = true;
    public static inline var nHorizontalCinchCoefficient : Float = 1.5;
    public static inline var nVerticalCinchCoefficient : Float = 0.7;
    public static inline var nShaftCoefficient : Float = 1.5;
    public static var nCurrentVerticalCinchCoefficient : Float = 0.7;
    public static inline var nRequireSpaceForSpikesChance : Float = 0.9;
    public static inline var iIceFuelMin : Int = 6;
    public static inline var iIceFuelMax : Int = 15;
    
    public static inline var nGemChance : Float = 0.33;
    public static inline var nClusterChance : Float = 0.1;
    public static inline var nReodChance : Float = 0.1;
    public static inline var nLytratChance : Float = 0.005;
    public static inline var iWaterfallCap : Int = 4;
    
    
    public static inline var iBoardWidth : Int = 5;
    public static inline var iBoardHeight : Int = 5;
    public static inline var iBoardX : Int = 78;
    public static inline var iBoardY : Int = 3;
    
    public static inline var iArrowLife : Int = 6;
    public static inline var iArrowBounceLife : Int = 60;
    public static inline var iArrowBounceStick : Int = 50;
    public static inline var iArrowRebounce : Int = 30;
    public static inline var iQuickRebounce : Int = 59;
    public static inline var nGrav : Int = 420;
    public static inline var nSplashBrakes : Float = 0.25;  // 0.4  
    public static inline var nForceThree : Float = 0.68;
    public static inline var nForceTwo : Float = 0.55;
    public static inline var nForceOne : Float = 0.4;
    public static inline var nForceTwoAndHalf : Float = 0.60;
    public static inline var nCollectDistance : Float = 25;
    
    public static inline var nCaveMapSpeed : Float = 150;
    
    public static inline var nSlideOutTime : Float = 0.5;
    public static inline var nSlideInTime : Float = 0.5;
    public static var nPanSpeed : Float = (1 / (0.5)) / 60;
    public static var nEnteringPanSpeed : Float = (1 / (1)) / 60;
    public static inline var nEnteringDistance : Float = 60;
    public static var nLeavingPanSpeed : Float = (1 / (3)) / 60;
    public static inline var nLeavingDistance : Float = 180;
    public static inline var nDeadWaitTime : Float = 6;
    
    public static var nHoverBounceSpeed : Float = 5 / 60;
    public static inline var nHoverBounceHeight : Float = 6;
    
    public static inline var nMonstersTooCloseToExit : Float = 6;
    
    public static inline var iProperTileRadius : Int = 10;
    public static inline var iChoiceDistance : Int = 40;
    
    public static inline var DEFAULT : Int = 0;
    public static inline var DOORLEAVING : Int = 1;
    public static inline var DOORENTERING : Int = 1;
    
    public static inline var CITY : Int = 1;
    public static inline var INTEREST : Int = 2;
    public static inline var NOTE : Int = 3;
    
    public static inline var BLANK : Int = 0;
    public static inline var TERRAIN : Int = 1;
    public static inline var FACADE : Int = 2;
    public static inline var WALLPAPER : Int = 3;
    public static inline var DUDE : Int = 4;
    public static inline var SIGNPOST : Int = 5;
    
    public static inline var LOADING : Int = 0;
    public static inline var ACTION : Int = 1;
    public static inline var SCRIPTED : Int = 2;
    public static inline var LEAVING : Int = 3;
    public static inline var DEAD : Int = 4;
    public static inline var INITIALIZING : Int = 5;
    public static inline var PAUSEMENU : Int = 6;
    
    public static inline var JUSTDIED : Int = 0;
    public static inline var WAITFORCOIN : Int = 1;
    public static inline var COINGIVEN : Int = 2;
    
    public static inline var NEWLINE : Int = 0;
    public static inline var PROCESSING : Int = 1;
    public static inline var FINISHED : Int = 2;
    
    public static inline var INTANG_TUNNEL : Int = 1;
    public static inline var INTANG_CHAMBER : Int = 2;
    public static inline var INTANG_RESERVE : Int = 3;
    
    public static inline var MEADOW : Int = 0;
    public static inline var SWAMP : Int = 1;
    public static inline var ICE : Int = 2;
    public static inline var SAND : Int = 3;
    public static inline var DEADWATER : Int = 4;
    public static inline var STEAMVENTS : Int = 5;
    public static inline var COLUMNS : Int = 6;
    public static inline var AMBER : Int = 7;
    public static inline var STONE : Int = 8;
    
    public static inline var UP : Int = 0;
    public static inline var RIGHT : Int = 1;
    public static inline var DOWN : Int = 2;
    public static inline var LEFT : Int = 3;
    
    public static inline var Code_Water : Int = 0x10000000;
    public static inline var Code_Surface : Int = 0x01000000;
    public static inline var Code_Up : Int = 0x00100000;
    public static inline var Code_Right : Int = 0x00010000;
    public static inline var Code_Down : Int = 0x00001000;
    public static inline var Code_Left : Int = 0x00000100;
    
    public static inline var barriertile : Int = 11;
    public static inline var walltile : Int = 1;
    public static var iBlank : Int = barriertile - 11;
    public static var iDarkOuter : Int = barriertile - 10;
    public static var iSecretFlag : Int = barriertile - 9;
    public static var iGrass : Int = barriertile - 8;
    public static var iSpikes : Int = barriertile - 7;
    public static var iWater : Int = barriertile - 6;
    public static var iWaterGrass : Int = barriertile - 5;
    public static var iWaterSpikes : Int = barriertile - 4;
    public static var iShallow : Int = barriertile - 3;
    public static var iShallowGrass : Int = barriertile - 2;
    public static var iShallowSpikes : Int = barriertile - 1;
    public static var iStuffAboveStuffBelow : Int = barriertile + 0;
    public static var iEmptyAboveStuffBelow : Int = barriertile + 1;
    public static var iStuffAboveEmptyBelow : Int = barriertile + 2;
    public static var iEmptyAboveEmptyBelow : Int = barriertile + 3;
    public static var iStuffAboveWaterBelow : Int = barriertile + 4;
    public static var iEmptyAboveWaterBelow : Int = barriertile + 5;
    public static var iBonus1 : Int = barriertile + 6;
    public static var iBonus2 : Int = barriertile + 7;
    public static var iBonus3 : Int = barriertile + 8;
    public static var iBonus4 : Int = barriertile + 9;
    
    
    
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
    
    public static inline var iTwinkliness : Int = 1;
    
    public static inline var screenwidth : Int = 480;
    public static inline var screenheight : Int = 300;
    
    public static inline var twidth : Int = 30;
    public static inline var theight : Int = 30;
    
    public static inline var heroboxwidth : Int = 100;
    public static inline var heroboxheight : Int = 100;
    
    public static inline var herohitwidth : Int = 18;
    public static inline var herohitheight : Int = 21;
    
    public static var herohitoffsetx : Int = 35 + 6;
    public static var herohitoffsety : Int = 35 + 9;
    
    //public static const worldoffsetx:int = 599;
    //public static const worldoffsety:int = -126;
    
    public static inline var worldoffsetx : Int = 2626;
    public static var worldoffsety : Int = -94;
    
    public static inline var nEverBars : Float = 17;
    public static inline var nTopOfStats : Float = 0;
    
    @:meta(Embed(source="../content/pc.ttf",fontFamily="NES",embedAsCFF="false"))

    public static var strFont : String;
    
    @:meta(Embed(source="../content/statbar.png"))

    public static var cStatBar : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/hearts.png"))

    public static var cHearts : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/mapcaves.png"))

    public static var cMapCaves : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/circlemask.png"))

    public static var cCircleMask : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/spotlight.png"))

    public static var cSpotlight : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/hover.png"))

    public static var cHover : FlxGraphicAsset;
    
    
    
    @:meta(Embed(source="../content/clock.png"))

    public static var cClock : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/choice.png"))

    public static var cChoice : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/npc.png"))

    public static var cNPC : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/npc_static.png"))

    public static var cNPCStatic : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/npc_other.png"))

    public static var cNPCOther : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/gems.png"))

    public static var cGems : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/heroreal.png"))

    public static var cHero : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/herointerim.png"))

    public static var cHeroInterim : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/maps.png"))

    public static var cRuneMaps : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/runemap_background.png"))

    public static var cRuneMapBackground : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/runemap_border.png"))

    public static var cRuneMapBorder : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/youarehere.png"))

    public static var cYouAreHere : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/cavenew.png"))

    public static var cCaveNew : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/cave.png"))

    public static var cCave : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/lilcave.png"))

    public static var cLilCave : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/arrow.png"))

    public static var cArrow : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/pellet.png"))

    public static var cPellet : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/items.png"))

    public static var cItems : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/monsters.png"))

    public static var cMonsters : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/monk.png"))

    public static var cMonk : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/mapnodes.png"))

    public static var cMapNodes : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/mapbars.png"))

    public static var cMapBars : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/faces.png"))

    public static var cFaces : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/chatbox.png"))

    public static var cChatBox : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/chatbubble.png"))

    public static var cChatBubble : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/particle.png"))

    public static var cParticle : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/twinkle.png"))

    public static var cTwinkle : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/splash.png"))

    public static var cSplash : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/miracles.txt",mimeType="application/octet-stream"))

    public static var cMiracles : Class<Dynamic>;
    
    @:meta(Embed(source="../content/miracles_game1.txt",mimeType="application/octet-stream"))

    public static var cMiraclesGame1 : Class<Dynamic>;
    
    // Cave Graphix
    
    public static inline var numbiomes : Int = 9;
    public static inline var iTotalBiomes : Int = 12;
    public static var biomes : Array<Dynamic>;
    
    @:meta(Embed(source="../content/filter.png"))

    public static var cFilter : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/alert.png"))

    public static var cAlert : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/doors.png"))

    public static var cDoors : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/walls2.png"))

    public static var cWalls : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/wallpaper.png"))

    public static var cWallpaper : FlxGraphicAsset;
    public static var iWallpaperPieces : Int = 8 * 30;
    
    
    @:meta(Embed(source="../content/peppers.png"))

    public static var cPeppers : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/waterfall.png"))

    public static var cWaterfall : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/windmill.png"))

    public static var cWindmill : FlxGraphicAsset;
    
    public static inline var iWallSheetWidth : Int = 24;
    
    @:meta(Embed(source="../content/fronts_thicker.png"))

    public static var cFronts : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/fronts_thicker.png"))

    public static var cFacade : FlxGraphicAsset;
    public static var iFacadePieces : Int = 8 * 30;
    
    public static inline var iFrontSheetWidth : Int = 21;
    
    @:meta(Embed(source="../content/back_columns.png"))

    public static var cBackColumns : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/back_forest.png"))

    public static var cBackForest : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/back_swamp.png"))

    public static var cBackSwamp : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/back_ice.png"))

    public static var cBackIce : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/back_sand.png"))

    public static var cBackSand : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/back_deadwater.png"))

    public static var cBackDeadwater : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/back_vents.png"))

    public static var cBackVents : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/back_amber2.png"))

    public static var cBackAmber : FlxGraphicAsset;
    
    @:meta(Embed(source="../content/back_stone.png"))

    public static var cBackStone : FlxGraphicAsset;
    
    @:meta(Embed(source="../sounds/arrow.mp3"))

    public static var soundArrow : Class<Dynamic>;
    public static inline var volumeArrow : Float = 1.0;
    
    @:meta(Embed(source="../sounds/swim.mp3"))

    public static var soundSwim : Class<Dynamic>;
    public static inline var volumeSwim : Float = 1.0;
    
    @:meta(Embed(source="../sounds/defeated.mp3"))

    public static var soundDefeated : Class<Dynamic>;
    public static inline var volumeDefeated : Float = 0.25;
    
    @:meta(Embed(source="../sounds/hurt.mp3"))

    public static var soundHurt : Class<Dynamic>;
    public static inline var volumeHurt : Float = 1.0;
    
    @:meta(Embed(source="../sounds/jump.mp3"))

    public static var soundJump : Class<Dynamic>;
    public static inline var volumeJump : Float = 0.25;
    
    @:meta(Embed(source="../sounds/lytrat.mp3"))

    public static var soundLytrat : Class<Dynamic>;
    public static inline var volumeLytrat : Float = 1.0;
    
    @:meta(Embed(source="../sounds/offended.mp3"))

    public static var soundOffended : Class<Dynamic>;
    public static inline var volumeOffended : Float = 1.0;
    
    @:meta(Embed(source="../sounds/pip.mp3"))

    public static var soundPip : Class<Dynamic>;
    public static inline var volumePip : Float = 1.0;
    
    @:meta(Embed(source="../sounds/reod.mp3"))

    public static var soundReod : Class<Dynamic>;
    public static inline var volumeReod : Float = 1.0;
    
    @:meta(Embed(source="../sounds/dreamcoin.mp3"))

    public static var soundDreamCoin : Class<Dynamic>;
    public static inline var volumeDreamCoin : Float = 1.0;
    
    @:meta(Embed(source="../sounds/splash.mp3"))

    public static var soundSplash : Class<Dynamic>;
    public static inline var volumeSplash : Float = 0.3;
    
    @:meta(Embed(source="../sounds/twang2.mp3"))

    public static var soundTwang : Class<Dynamic>;
    public static inline var volumeTwang : Float = 1.0;
    
    @:meta(Embed(source="../sounds/ting.mp3"))

    public static var soundTing : Class<Dynamic>;
    public static inline var volumeTing : Float = 1.0;
    
    
    
    @:meta(Embed(source="../sounds/chat.mp3"))

    public static var soundChat : Class<Dynamic>;
    public static inline var volumeChat : Float = 0.3;
    
    @:meta(Embed(source="../sounds/dead.mp3"))

    public static var soundDead : Class<Dynamic>;
    public static inline var volumeDead : Float = 1.0;
    
    @:meta(Embed(source="../sounds/enter.mp3"))

    public static var soundEnter : Class<Dynamic>;
    public static inline var volumeEnter : Float = 1.0;
    
    @:meta(Embed(source="../sounds/leave.mp3"))

    public static var soundLeave : Class<Dynamic>;
    public static inline var volumeLeave : Float = 1.0;
    
    @:meta(Embed(source="../sounds/refresh.mp3"))

    public static var soundRefresh : Class<Dynamic>;
    public static inline var volumeRefresh : Float = 1.0;
    
    @:meta(Embed(source="../sounds/cricket2.mp3"))

    public static var soundCricket : Class<Dynamic>;
    public static inline var volumeCricket : Float = 0.4;
    
    @:meta(Embed(source="../sounds/goblin.mp3"))

    public static var soundGoblin : Class<Dynamic>;
    public static inline var volumeGoblin : Float = 0.4;
    
    @:meta(Embed(source="../sounds/spit.mp3"))

    public static var soundSpit : Class<Dynamic>;
    public static inline var volumeSpit : Float = 1.0;
    
    @:meta(Embed(source="../sounds/song_rock.mp3"))

    public static var soundSongRock : Class<Dynamic>;
    public static inline var volumeSongRock : Float = 0.8;
    
    @:meta(Embed(source="../sounds/song_town.mp3"))

    public static var soundSongTown : Class<Dynamic>;
    public static inline var volumeSongTown : Float = 0.8;
    
    @:meta(Embed(source="../sounds/song_turtle.mp3"))

    public static var soundSongTurtle : Class<Dynamic>;
    public static inline var volumeSongTurtle : Float = 0.8;
    
    @:meta(Embed(source="../sounds/song_ice.mp3"))

    public static var soundSongIce : Class<Dynamic>;
    public static inline var volumeSongIce : Float = 0.8;
    
    @:meta(Embed(source="../sounds/song_happy.mp3"))

    public static var soundSongHappy : Class<Dynamic>;
    public static inline var volumeSongHappy : Float = 0.8;
    
    @:meta(Embed(source="../sounds/song_skip.mp3"))

    public static var soundSongSkip : Class<Dynamic>;
    public static inline var volumeSongSkip : Float = 0.8;
    
    @:meta(Embed(source="../sounds/song_desert_intro.mp3"))

    public static var soundSongDesertIntro : Class<Dynamic>;
    @:meta(Embed(source="../sounds/song_desert_main_full.mp3"))

    public static var soundSongDesertMain : Class<Dynamic>;
    public static inline var volumeSongDesert : Float = 0.8;
    
    public static inline var nDefaultSkip : Float = 90;
    public static inline var nDefaultMusicSkip : Float = 10;

    public function new()
    {
    }
}

