package  
{
	import flash.utils.ByteArray;
	import Map.Biome;
	import org.flixel.FlxSound;
	import org.flixel.FlxSprite;
	import org.flixel.FlxText
	import org.flixel.FlxTextPlus;
	import org.flixel.Rndm;
	
	public final class Util
	{
		public static var bPressed:Boolean = false;
		public static var startx:int = 0;
		public static var starty:int = 0;
		public static var currentx:int = 0;
		public static var currenty:int = 0;
		public static var nFailThreshold:Number = 25;
		
		public static function AssignFont(text:FlxText):void
		{
			text.setFormat("NES", 8);
		}
		
		
		public static function SetCharAt(str:String, char:String, index:int):String
		{
			return str.substr(0,index) + char + str.substr(index + 1);
		}
		
		public static function ParseCommand(str:String):String
		{
			return str.substr(0, str.indexOf(" "));
		}
		
		public static function ParseContent(str:String):String
		{
			return str.substr(str.indexOf(" ") + 1, str.length - str.indexOf(" "));
		}
		
		public static function SPCofHeader(lines:Array, header:String):int
		{
			for (var i:int = 0; i < lines.length; i++)
			{
				var line:String = lines[i] as String;
				if (line.indexOf(" ") > -1 && ParseCommand(line) == "header")
				{
					if (ParseContent(line).toLowerCase() == header.toLowerCase())
						return i;
				}
			}
			
			return -1;
		}
		
		public static function GetSpriteByName(sprites:Array, name:String):FlxSprite
		{
			for each (var mon:FlxSprite in sprites)
            {
                if (mon.strName == name)
				{
					return mon;
				}
            }
			
			return null;
		}
		
		public static function GetInvisibleSpriteByName(sprites:Array, name:String):FlxSprite
		{
			for each (var mon:FlxSprite in sprites)
            {
                if (mon.visible == false && mon.strName == name)
				{
					return mon;
				}
            }
			
			return null;
		}
		
		
		
		public static function Random(low:int, highinclusive:int):int // INCLUSIVE ON BOTH ENDS!!!
		{
			return Math.floor(Math.random() * (1+highinclusive-low)) + low;
		}
		
		public static function Seed(x:int, y:int):int
        {
            x += Content.worldoffsetx;
            y += Content.worldoffsety;
			
			if (x < 0)
				x--;
			else if (x >= 0)
				x++;
				
			if (y < 0)
				y--;
			else if (y >= 0)
				y++;
			
            return (x + (y * 64)) + (x % 13) + (y * x) + ((y * x) % 7);
        }
		
		public static function QuadSeed(x1:int, y1:int, x2:int, y2:int, x3:int, y3:int, x4:int, y4:int):int
		{
			return (Seed(x1, y1) * 1) +
					(Seed(x2, y2) * 25) +
					(Seed(x3, y3) * 127) +
					(Seed(x4, y4) * 503);
		}
 
		public static function Clone(source:Object):*
		{
			var myBA:ByteArray = new ByteArray();
			myBA.writeObject(source);
			myBA.position = 0;
			return(myBA.readObject());
		}
		
		public static function Dupe(source:Array):Array
		{
			var toret:Array = new Array;
			
			for (var i:int = 0; i < source.length; i++)
				toret.push(source[i]);
				
			return toret;
		}
		
		public static function ShuffleArray(array:Array, ran:Rndm):Array
		{
			var temp:Array = new Array();
			var toret:Array = new Array();
			for (var i:uint = 0; i < array.length; i++)
			{
			   temp.push(array[i]);
			}
			
			for (i = 0; i < array.length; i++)
			{
			   var r:int = ran.integer(0, temp.length);
			   
			   toret.push( temp[r] );
			   
			   temp.splice(r, 1);
			}
			
			return toret;
		}
		
		public static function Distance(a:Number, b:Number, x:Number, y:Number):Number
		{
			return Math.sqrt(Math.pow(a - x, 2) + Math.pow(b - y, 2));
		}
		
		public static var words:Array;
		public static function LoadLanguage():void
		{
			var bytes:ByteArray = new Content.cDwarvenLanguage();
			var s:String = bytes.readUTFBytes(bytes.length);
						
			words = new Array();
	
			var lines:Array = s.split("\n");
			lines.splice(0, 1);
			
			for (var i:int = 0; i < lines.length; i++)
			{
				var line:Array = (lines[i] as String).split(",");
				
				words.push(new Word());
				
				
				(words[i] as Word).str = line[0];
				(words[i] as Word).front = line[1] == "1";
				(words[i] as Word).mid = line[2] == "1";
				(words[i] as Word).back = line[3] == "1";
				(words[i] as Word).flat = line[4] == "1";
				(words[i] as Word).of = line[5] == "1";
				(words[i] as Word).s = line[6] == "1";
				
				for (var b:int = 7; b < line.length; b++)
				{
					
					if (line[b] == "1")
						(words[i] as Word).biomes[b - 7] = true;		
				}
			}
		}
		
		public static function LoadBiomeParameters():void
		{
			var bytes:ByteArray = new Content.cEnvironmentBounds();
			var s:String = bytes.readUTFBytes(bytes.length);
	
			var lines:Array = s.split("\n");
			lines.splice(0, 1); // Get rid of header line
			
			var w:int = 1;
			var line:Array = (lines[i] as String).split(",");
			
			for (w = 1; w < Content.numbiomes + 1; w++)
			{
				(Content.biomes[w - 1] as Biome).song = line[w] as String;
			}
			
			lines.splice(0, 1); // Get rid of song line
			
			for (var i:int = 0; i < lines.length; i++)
			{
				line = (lines[i] as String).split(",");
				
				if (i <= 5) // monsters
				{
					for (w = 1; w < Content.numbiomes + 1; w++)
					{
						(Content.biomes[w - 1] as Biome).bestiary[i] = line[w] as String;
					}
				}
				else if (i <= 15) // overlays
				{
					for (w = 1; w < Content.numbiomes + 1; w++)
					{
						(Content.biomes[w - 1] as Biome).overlays[i - 6] = line[w] as String;
					}
				}
				else // bounds
				{
					for (w = 1; w < Content.numbiomes + 1; w++)
					{
						(Content.biomes[w - 1] as Biome).bounds[i - 16] = int(line[w] as String);
					}
				}
			}
		}
		
		public static var strMusic:String = "";
		
		public static function SetMusicName(name:String):void
		{
			strMusic = name;
		}
		
		public static function StopMusic():void
		{
			if (music != null)
				music.stop();
				
			if (silence != null)
				silence.stop();
				
			strMusic = "";
		}

		public static function PlayIntroMusic():void
		{
			switch(strMusic)
			{
				case "happy":
					PlayMusicData(Content.soundSongHappy, Content.volumeSongHappy, Content.nDefaultMusicSkip + 50, PlayMusic, true, 40);
					return;
				case "turtle":
					PlayMusicData(Content.soundSongTurtle, Content.volumeSongTurtle, Content.nDefaultMusicSkip, PlayMusic, true);
					return;
				case "town":
					PlayMusicData(Content.soundSongTown, Content.volumeSongTown, Content.nDefaultMusicSkip + 50, PlayMusic, true, 60);
					return;
				case "rock":
					PlayMusicData(Content.soundSongRock, Content.volumeSongRock, Content.nDefaultMusicSkip, PlayMusic, true);
					return;
				case "ice":
					PlayMusicData(Content.soundSongIce, Content.volumeSongIce, Content.nDefaultMusicSkip, PlayMusic, true);
					return;
				case "skip":
					PlayMusicData(Content.soundSongSkip, Content.volumeSongSkip, Content.nDefaultMusicSkip, PlayMusic, true, 20);
					return;
				case "desert":
					PlayMusicData(Content.soundSongDesertIntro, Content.volumeSongDesert, Content.nDefaultMusicSkip, PlayMusic, true, 50);
					return;
			}
			
			trace("Tried to play " + strMusic + " but failed!");
			
			return;
		}
		
		public static function PlayMusic():void
		{
			switch(strMusic)
			{
				case "happy":
					PlayMusicData(Content.soundSongHappy, Content.volumeSongHappy, Content.nDefaultMusicSkip + 50, PlayMusic, false, 50);
					return;
				case "turtle":
					PlayMusicData(Content.soundSongTurtle, Content.volumeSongTurtle, Content.nDefaultMusicSkip, PlayMusic, false);
					return;
				case "town":
					PlayMusicData(Content.soundSongTown, Content.volumeSongTown, Content.nDefaultMusicSkip, PlayMusic, false);
					return;
				case "rock":
					PlayMusicData(Content.soundSongRock, Content.volumeSongRock, Content.nDefaultMusicSkip, PlayMusic, false);
					return;
				case "ice":
					PlayMusicData(Content.soundSongIce, Content.volumeSongIce, Content.nDefaultMusicSkip, PlayMusic, false);
					return;
				case "skip":
					PlayMusicData(Content.soundSongSkip, Content.volumeSongSkip, Content.nDefaultMusicSkip + 40, PlayMusic, false, 20);
					return;
				case "desert":
					PlayMusicData(Content.soundSongDesertMain, Content.volumeSongDesert, Content.nDefaultMusicSkip + 50, PlayMusic, true, 20);
					return;
			}
			
			trace("Tried to play " + strMusic + " but failed!");
			
			return;
		}
		
		public static var music:FlxSound;
		public static var silence:FlxSound;
		public static var fLoopCallback:Function = null; 
		
		public static function PlayMusicData(Music:Class, Volume:Number=1.0, position:Number = 0, loopcallback:Function = null, firsttime:Boolean = true, silencebump:Number = 0):void
		{	
			trace("/// Playing " + strMusic + " first time = " + firsttime.toString());
			if (firsttime)
			{
				if(music == null)
					music = new FlxSound();
				else if(music.active)
					music.stop();
					
				music.loadEmbedded(Music,false); // NOT looped
				music.volume = Volume;
				music.survive = true;
			}
			
			music.play(true, position, false);
			
			playSilence(Music, position + silencebump, loopcallback, firsttime);
		}
		
		public static function playSilence(Music:Class, position:Number = 0, loopcallback:Function = null, firsttime:Boolean = true):void
		{
			trace("/// Playing silence for " + strMusic + " first time = " + firsttime.toString());
			if (firsttime)
			{
				if(silence == null)
					silence = new FlxSound();
				else if(silence.active)
					silence.stop();
					
				silence.loadEmbedded(Music,true);
				silence.volume = 0;
				silence.survive = true;
			}
			
			if (loopcallback != null)
			{
				fLoopCallback = loopcallback;
				silence.play(true, position, true);
			}
			else
				silence.play(true, position, false);
		}
		
		public static function IsBarrier(tile:int):Boolean
		{
			if (tile % Content.iFrontSheetWidth < Content.barriertile)
			{
				return false;
			}
			
			return true;
		}
		
		public static function MakeName(seed:int, hard:Boolean, soft:Boolean):String
		{
			var r:Rndm = new Rndm(seed);
			
			var w:int = -1;
			var front:String = "";
			while (front == "")
			{
				w = r.integer(0, words.length - 1);
				if ((words[w] as Word).front)
					front = (words[w] as Word).str;
			}
			
			var mid:String = "";
			while (mid == "")
			{
				w = r.integer(0, words.length - 1);
				if ((words[w] as Word).mid)
					mid = (words[w] as Word).str;
			}
						
			if (r.integer(0, 2) == 1)
				mid = "";
				
			var back:String = "";
			while (back == "")
			{
				w = r.integer(0, words.length - 1);
				if ((words[w] as Word).back)
					back = (words[w] as Word).str;
					
				if (	(hard && back.charAt(back.length - 1) == "y") ||
						(hard && back.charAt(back.length - 1) == "a") ||
						(soft && back.charAt(back.length - 1) == "r") ||
						(soft && back.charAt(back.length - 1) == "s"))
						back = "";
			}
			
			front = Capitalize(front);
			
			return front + mid + back;
		}
		
		public static function MakeRegionName(seed:int, biome:int):String
		{
			var r:Rndm = new Rndm(seed);
			
			var name:String = MakeName(seed, false, false);
			
			var w:int = -1;
			
			var place:String = "";
			while (place == "")
			{
				w = r.integer(0, words.length - 1);
				if ((words[w] as Word).front == false &&
					(words[w] as Word).mid == false &&
					(words[w] as Word).back == false)
					{
						if(biome == -1 || ((words[w] as Word).biomes[biome] as Boolean) == true)
							place = (words[w] as Word).str;
					}
			}
			
			place = Capitalize(place);
			
			
			
			
			var type:int = -1;
			
			while (type == -1)
			{
				type = r.integer(0, 3);
				
				if (type == 0 && (words[w] as Word).s == false)
					type = -1;
					
				if (type == 1 && (words[w] as Word).of == false)
					type = -1;
					
				if (type == 2 && (words[w] as Word).flat == false)
					type = -1;
			}
				
			var fullname:String = "";
			if(type == 0)
			{
				fullname = name + "'s " + place;
			}
			else if(type == 1)
			{
				fullname = place + " of " + name;
			}
			else if(type == 2)
			{
				fullname = name + " " + place;
			}
			
			return fullname;
		}
		
		public static function Capitalize(str:String):String
		{
			return str.substr(0,1).toUpperCase() + str.substr(1, str.length - 1);
		}
		
		public static function Clamp(a:Number, aleft:Number, aright:Number, bleft:Number, bright:Number):Number
		{
			a -= aleft;
			var perc:Number = a / (aright - aleft);
			var toret:Number = perc * (bright - bleft);
			toret += bleft;
			return toret;
		}
		
		public static function CameraPanCurrent(start:Number, end:Number, perc:Number):Number
		{
			return EaseEndCurrent(start, end, perc);
		}
		
		public static function EaseBothCurrent(start:Number, end:Number, perc:Number):Number
		{
			return ((end - start) * ((Math.sin((Math.PI * perc) - (Math.PI / 2)) * 0.5) + 0.5)) + start;
		}
		
		public static function SkidCurrent(start:Number, end:Number, perc:Number):Number
		{
			return ((end - start) * ((Math.sin((Math.PI * 1.4 * perc) - (Math.PI * 1.4 / 2)) * 0.6) + 0.5)) + start;
		}
		
		public static function LinearCurrent(start:Number, end:Number, perc:Number):Number
		{
			return ((end - start) * perc) + start;
		}
		
		public static function EaseStartCurrent(start:Number, end:Number, perc:Number):Number
		{
			return ((end - start) * Math.pow(perc, 2)) + start;
		}
		
		public static function EaseEndCurrent(start:Number, end:Number, perc:Number):Number
		{
			return ((end - start) * ((Math.pow(perc - 1, 2) * -1) + 1)) + start;
		}
		
		public static function BulgeCurrent(start:Number, end:Number, perc:Number):Number
		{
			return ((end - start) * ((2.604167 * Math.pow(perc - 0.308, 2)) - 0.247041698288)) + start;

		}
		
		public static function HyperbolaCurrent(start:Number, end:Number, perc:Number):Number
		{
			
			//y=(((x-0.5)^3) * 4) + 0.5
			
			return ((end - start) * ((Math.pow(perc-0.5,3) * 4) + 0.5)) + start;
		}
		
		public static function LolCurrent(start:Number, end:Number, perc:Number):Number
		{
			return ((end - start) * (0)) + start;
		}
		
		public static function Color(R:int, B:int, G:int):uint
		{
			var code:uint;
			
			code = (R * 256 * 256) + (B * 256) + G;
			
			return code;
		}
		
		public static function HexR(hex:uint):int
		{
			return (hex & 0xFF0000) >> 16;
		}
		
		public static function HexG(hex:uint):int
		{
			return (hex & 0x00FF00) >> 8;
		}
		
		public static function HexB(hex:uint):int
		{
			return (hex & 0x0000FF);
		}
		
		public static function DarkSkin(newcolSkin:uint):uint
		{
			return Util.Color( Util.HexR(newcolSkin) * 0.85,
							Util.HexG(newcolSkin) * 0.70,
							Util.HexB(newcolSkin) * 0.52);
		}
		
		public static function Swirl(newcolSkin:uint):uint
		{
			return Util.Color( Util.HexR(newcolSkin) * 1,
							Util.HexG(newcolSkin) * 0.73,
							Util.HexB(newcolSkin) * 0.85);
		}
		
		public static function DarkHair(newcolHair:uint):uint
		{
			return Util.Color( Util.HexR(newcolHair) * 0.54,
							Util.HexG(newcolHair) * 0.53,
							Util.HexB(newcolHair) * 0.42);
		}
		
		public static function IntToCommaString(num:int):String // from null.point3r on stackoverflow.com
		{
			var str:String="";
			var sign:String=num>0?"":"-";
			num=Math.abs(num);
			while (num > 0)
			{
				var tmp:int=num%1000;
				str=(num>999?","+(tmp<100?(tmp<10?"00":"0"):""):"")+tmp+str;
				num=num/1000;
			}
			return sign+str;
		}
	}

}