import haxe.Constraints.Function;
import flash.utils.ByteArray;
import flixel.system.FlxSound;
import flixel.system.FlxAssets;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.math.FlxRandom;
import Content;
import openfl.Assets;
import flixel.FlxG;

@:final class Util
{
    public static var bPressed : Bool = false;
    public static var startx : Int = 0;
    public static var starty : Int = 0;
    public static var currentx : Int = 0;
    public static var currenty : Int = 0;
    public static var nFailThreshold : Float = 25;
    
    public static function AssignFont(text : FlxText) : Void
    {
        text.setFormat("NES", 8);
    }
    
    
    public static function SetCharAt(str : String, char : String, index : Int) : String
    {
        return str.substr(0, index) + char + str.substr(index + 1);
    }
    
    public static function ParseCommand(str : String) : String
    {
        return str.substr(0, str.indexOf(" "));
    }
    
    public static function ParseContent(str : String) : String
    {
        return str.substr(str.indexOf(" ") + 1, str.length - str.indexOf(" "));
    }
    
    public static function SPCofHeader(lines : Array<Dynamic>, header : String) : Int
    {
        var i : Int = 0;
        while (i < lines.length)
        {
            var line : String = Std.string(lines[i]);
            if (line.indexOf(" ") > -1 && ParseCommand(line) == "header")
            {
                if (ParseContent(line).toLowerCase() == header.toLowerCase())
                {
                    return i;
                }
            }
            i++;
        }
        
        return -1;
    }
    
    public static function GetSpriteByName(sprites : Array<Dynamic>, name : String) : FlxSprite
    {
        for (mon in sprites)
        {
            if (mon.strName == name)
            {
                return mon;
            }
        }
        
        return null;
    }
    
    public static function GetInvisibleSpriteByName(sprites : Array<Dynamic>, name : String) : FlxSprite
    {
        for (mon in sprites)
        {
            if (mon.visible == false && mon.strName == name)
            {
                return mon;
            }
        }
        
        return null;
    }
    
    
    
    public static function Random(low : Int, highinclusive : Int) : Int  // INCLUSIVE ON BOTH ENDS!!!  
    {
        return Math.floor(Math.random() * (1 + highinclusive - low)) + low;
    }
    
    public static function Seed(x : Int, y : Int) : Int
    {
        x += Content.worldoffsetx;
        y += Content.worldoffsety;
        
        if (x < 0)
        {
            x--;
        }
        else if (x >= 0)
        {
            x++;
        }
        
        if (y < 0)
        {
            y--;
        }
        else if (y >= 0)
        {
            y++;
        }
        
        return ((x + (y * 64)) + (x % 13) + (y * x) + ((y * x) % 7));
    }
    
    public static function QuadSeed(x1 : Int, y1 : Int, x2 : Int, y2 : Int, x3 : Int, y3 : Int, x4 : Int, y4 : Int) : Int
    {
        return ((Seed(x1, y1) * 1) +
                (Seed(x2, y2) * 25) +
                (Seed(x3, y3) * 127) +
                (Seed(x4, y4) * 503));
    }
    
    public static function Clone(source : Dynamic) : Dynamic
    {
        var myBA : ByteArray = new ByteArray();
        myBA.writeObject(source);
        myBA.position = 0;
        return (myBA.readObject());
    }
    
    public static function Dupe(source : Array<Dynamic>) : Array<Dynamic>
    {
        var toret : Array<Dynamic> = new Array<Dynamic>();
        
        var i : Int = 0;
        while (i < source.length)
        {
            toret.push(source[i]);
            i++;
        }
        
        return toret;
    }
    
    public static function ShuffleArray(array : Array<Dynamic>, ran : FlxRandom) : Array<Dynamic>
    {
        var temp : Array<Dynamic> = new Array<Dynamic>();
        var toret : Array<Dynamic> = new Array<Dynamic>();
        var i : Int = 0;
        while (i < array.length)
        {
            temp.push(array[i]);
            i++;
        }
        
        i = 0;
        while (i < array.length)
        {
            var r : Int = ran.int(0, temp.length);
            
            toret.push(temp[r]);
            
            temp.splice(r, 1);
            i++;
        }
        
        return toret;
    }
    
    public static function Distance(a : Float, b : Float, x : Float, y : Float) : Float
    {
        return Math.sqrt(Math.pow(a - x, 2) + Math.pow(b - y, 2));
    }
    
    public static var words : Array<Dynamic>;
    public static function LoadLanguage() : Void
    {
        var s : String = Assets.getText("assets/data/dwarven.txt");
        
        words = new Array<Dynamic>();
        
        var lines : Array<Dynamic> = s.split("\n");
        lines.splice(0, 1);
        
        var i : Int = 0;
        while (i < lines.length)
        {
            var line : Array<Dynamic> = (Std.string(lines[i])).split(",");
            
            words.push(new Word());
            
            
            words[i].str = line[0];
            words[i].front = line[1] == "1";
            words[i].mid = line[2] == "1";
            words[i].back = line[3] == "1";
            words[i].flat = line[4] == "1";
            words[i].of = line[5] == "1";
            words[i].s = line[6] == "1";
            
            var b : Int = 7;
            while (b < line.length)
            {
                if (line[b] == "1")
                {
                    words[i].biomes[b - 7] = true;
                }
                b++;
            }
            i++;
        }
    }
    
    public static function LoadBiomeParameters() : Void
    {
        var s : String = Assets.getText("assets/data/bounds.txt");
        
        var lines : Array<String> = s.split("\n");
        lines.splice(0, 1);  // Get rid of header line  
        
        var w : Int = 1;
        var line : Array<String> = (Std.string(lines[0])).split(",");
        
        w = 1;
        while (w < Content.numbiomes + 1)
        {
            Content.biomes[w - 1].song = Std.string(line[w]);
            w++;
        }
        
        lines.splice(0, 1);  // Get rid of song line  
        
        var i : Int = 0;
        while (i < lines.length)
        {
            line = (Std.string(lines[i])).split(",");
            
            if (i <= 5)
            { // monsters
                
                {
                    w = 1;
                    while (w < Content.numbiomes + 1)
                    {
                        Content.biomes[w - 1].bestiary[i] = Std.string(line[w]);
                        w++;
                    }
                }
            }
            else if (i <= 15)
            { // overlays
                
                {
                    w = 1;
                    while (w < Content.numbiomes + 1)
                    {
                        Content.biomes[w - 1], Biome) catch(e:Dynamic) null).overlays[i - 6] = Std.string(line[w]);
                        w++;
                    }
                }
            }
            // bounds
            else
            {
                
                {
                    w = 1;
                    while (w < Content.numbiomes + 1)
                    {
                        Content.biomes[w - 1], Biome) catch(e:Dynamic) null).bounds[i - 16] = Std.string(line[w]);
                        w++;
                    }
                }
            }
            i++;
        }
    }
    
    public static var strMusic : String = "";
    
    public static function SetMusicName(name : String) : Void
    {
        strMusic = name;
    }
    
    public static function StopMusic() : Void
    {
        if (music != null)
        {
            music.stop();
        }
        
        if (silence != null)
        {
            silence.stop();
        }
        
        strMusic = "";
    }
    
    public static function PlayIntroMusic() : Void
    {
        switch (strMusic)
        {
            case "happy":
                PlayMusicData(AssetPaths.song_happy__mp3, Content.volumeSongHappy, Content.nDefaultMusicSkip + 50, PlayMusic, true, 40);
                return;
            case "turtle":
                PlayMusicData(AssetPaths.song_turtle__mp3, Content.volumeSongTurtle, Content.nDefaultMusicSkip, PlayMusic, true);
                return;
            case "town":
                PlayMusicData(AssetPaths.song_town__mp3, Content.volumeSongTown, Content.nDefaultMusicSkip + 50, PlayMusic, true, 60);
                return;
            case "rock":
                PlayMusicData(AssetPaths.song_rock__mp3, Content.volumeSongRock, Content.nDefaultMusicSkip, PlayMusic, true);
                return;
            case "ice":
                PlayMusicData(AssetPaths.song_ice__mp3, Content.volumeSongIce, Content.nDefaultMusicSkip, PlayMusic, true);
                return;
            case "skip":
                PlayMusicData(AssetPaths.song_skip__mp3, Content.volumeSongSkip, Content.nDefaultMusicSkip, PlayMusic, true, 20);
                return;
            case "desert":
                PlayMusicData(AssetPaths.song_desert_intro__mp3, Content.volumeSongDesert, Content.nDefaultMusicSkip, PlayMusic, true, 50);
                return;
        }
        
        trace("Tried to play " + strMusic + " but failed!");
        
        return;
    }
    
    public static function PlayMusic() : Void
    {
        switch (strMusic)
        {
            case "happy":
                PlayMusicData(AssetPaths.song_happy__mp3 Content.soundSongHappy, Content.volumeSongHappy, Content.nDefaultMusicSkip + 50, PlayMusic, false, 50);
                return;
            case "turtle":
                PlayMusicData(AssetPaths.song_turtle__mp3, Content.volumeSongTurtle, Content.nDefaultMusicSkip, PlayMusic, false);
                return;
            case "town":
                PlayMusicData(AssetPaths.song_town__mp3, Content.volumeSongTown, Content.nDefaultMusicSkip, PlayMusic, false);
                return;
            case "rock":
                PlayMusicData(AssetPaths.song_rock__mp3, Content.volumeSongRock, Content.nDefaultMusicSkip, PlayMusic, false);
                return;
            case "ice":
                PlayMusicData(AssetPaths.song_ice__mp3, Content.volumeSongIce, Content.nDefaultMusicSkip, PlayMusic, false);
                return;
            case "skip":
                PlayMusicData(AssetPaths.song_skip__mp3, Content.volumeSongSkip, Content.nDefaultMusicSkip + 40, PlayMusic, false, 20);
                return;
            case "desert":
                PlayMusicData(AssetPaths.song_desert_main_full__mp3, Content.volumeSongDesert, Content.nDefaultMusicSkip + 50, PlayMusic, true, 20);
                return;
        }
        
        trace("Tried to play " + strMusic + " but failed!");
        
        return;
    }
    
    public static var music : FlxSound;
    public static var silence : FlxSound;
    public static var fLoopCallback : Function = null;
    
    public static function PlayMusicData(musicAssetPath : String, Volume : Float = 1.0, position : Float = 0, loopcallback : Function = null, firsttime : Bool = true, silencebump : Float = 0) : Void
    {
        trace("/// Playing " + strMusic + " first time = " + Std.string(firsttime));
        if (firsttime)
        {
            FlxG.sound.playMusic(musicAssetPath, Volume, false);  // NOT looped
        }
        
        music.play(true, position);
        
        // TODO: I don't get the purpose of this
        // playSilence(musicAssetPath, position + silencebump, loopcallback, firsttime);
    }
    
    public static function playSilence(musicAsset : FlxSoundAsset, position : Float = 0, loopcallback : Function = null, firsttime : Bool = true) : Void
    {
        trace("/// Playing silence for " + strMusic + " first time = " + Std.string(firsttime));
        if (firsttime)
        {
            if (silence == null)
            {
                silence = new FlxSound();
            }
            else if (silence.active)
            {
                silence.stop();
            }
            
            silence.loadEmbedded(musicAsset, true);
            silence.volume = 0;
        }
        
        fLoopCallback = loopcallback;
        silence.play(true, position);
    }
    
    public static function IsBarrier(tile : Int) : Bool
    {
        if (tile % Content.iFrontSheetWidth < Content.barriertile)
        {
            return false;
        }
        
        return true;
    }
    
    public static function MakeName(seed : Int, hard : Bool, soft : Bool) : String
    {
        var r : FlxRandom = new FlxRandom(seed);
        
        var w : Int = -1;
        var front : String = "";
        while (front == "")
        {
            w = r.int(0, words.length - 1);
            if (words[w].front)
            {
                front = words[w].str;
            }
        }
        
        var mid : String = "";
        while (mid == "")
        {
            w = r.int(0, words.length - 1);
            if (words[w].mid)
            {
                mid = words[w].str;
            }
        }
        
        if (r.int(0, 2) == 1)
        {
            mid = "";
        }
        
        var back : String = "";
        while (back == "")
        {
            w = r.int(0, words.length - 1);
            if (words[w].back)
            {
                back = words[w].str;
            }
            
            if ((hard && back.charAt(back.length - 1) == "y") ||
                (hard && back.charAt(back.length - 1) == "a") ||
                (soft && back.charAt(back.length - 1) == "r") ||
                (soft && back.charAt(back.length - 1) == "s"))
            {
                back = "";
            }
        }
        
        front = Capitalize(front);
        
        return front + mid + back;
    }
    
    public static function MakeRegionName(seed : Int, biome : Int) : String
    {
        var r : FlxRandom = new FlxRandom(seed);
        var name : String = MakeName(seed, false, false);
        var w : Int = -1;
        var place : String = "";
        while (place == "")
        {
            w = r.int(0, words.length - 1);
            if (words[w].front == false &&
                words[w].mid == false &&
                words[w].back == false)
            {
                if (biome == -1 || words[w].biomes[biome] == true)
                {
                    place = words[w].str;
                }
            }
        }
        
        place = Capitalize(place);

        var type : Int = -1;
        
        while (type == -1)
        {
            type = r.int(0, 3);
            
            if (type == 0 && words[w].s == false)
            {
                type = -1;
            }
            
            if (type == 1 && words[w].of == false)
            {
                type = -1;
            }
            
            if (type == 2 && words[w].flat == false)
            {
                type = -1;
            }
        }
        
        var fullname : String = "";
        if (type == 0)
        {
            fullname = name + "'s " + place;
        }
        else if (type == 1)
        {
            fullname = place + " of " + name;
        }
        else if (type == 2)
        {
            fullname = name + " " + place;
        }
        
        return fullname;
    }
    
    public static function Capitalize(str : String) : String
    {
        return str.substr(0, 1).toUpperCase() + str.substr(1, str.length - 1);
    }
    
    public static function Clamp(a : Float, aleft : Float, aright : Float, bleft : Float, bright : Float) : Float
    {
        a -= aleft;
        var perc : Float = a / (aright - aleft);
        var toret : Float = perc * (bright - bleft);
        toret += bleft;
        return toret;
    }
    
    public static function CameraPanCurrent(start : Float, end : Float, perc : Float) : Float
    {
        return EaseEndCurrent(start, end, perc);
    }
    
    public static function EaseBothCurrent(start : Float, end : Float, perc : Float) : Float
    {
        return ((end - start) * ((Math.sin((Math.PI * perc) - (Math.PI / 2)) * 0.5) + 0.5)) + start;
    }
    
    public static function SkidCurrent(start : Float, end : Float, perc : Float) : Float
    {
        return ((end - start) * ((Math.sin((Math.PI * 1.4 * perc) - (Math.PI * 1.4 / 2)) * 0.6) + 0.5)) + start;
    }
    
    public static function LinearCurrent(start : Float, end : Float, perc : Float) : Float
    {
        return ((end - start) * perc) + start;
    }
    
    public static function EaseStartCurrent(start : Float, end : Float, perc : Float) : Float
    {
        return ((end - start) * Math.pow(perc, 2)) + start;
    }
    
    public static function EaseEndCurrent(start : Float, end : Float, perc : Float) : Float
    {
        return ((end - start) * ((Math.pow(perc - 1, 2) * -1) + 1)) + start;
    }
    
    public static function BulgeCurrent(start : Float, end : Float, perc : Float) : Float
    {
        return ((end - start) * ((2.604167 * Math.pow(perc - 0.308, 2)) - 0.247041698288)) + start;
    }
    
    public static function HyperbolaCurrent(start : Float, end : Float, perc : Float) : Float
    //y=(((x-0.5)^3) * 4) + 0.5
    {
        
        
        return ((end - start) * ((Math.pow(perc - 0.5, 3) * 4) + 0.5)) + start;
    }
    
    public static function LolCurrent(start : Float, end : Float, perc : Float) : Float
    {
        return ((end - start) * (0)) + start;
    }
    
    public static function Color(R : Int, B : Int, G : Int) : Int
    {
        var code : Int;
        
        code = ((R * 256 * 256) + (B * 256) + G);
        
        return code;
    }
    
    public static function ColorF(R : Float, B : Float, G : Float) : Int
    {
        return Color(Math.floor(R), Math.floor(B), Math.floor(G));
    }
    
    public static function HexR(hex : Int) : Int
    {
        return ((hex & 0xFF0000) >> 16);
    }
    
    public static function HexG(hex : Int) : Int
    {
        return ((hex & 0x00FF00) >> 8);
    }
    
    public static function HexB(hex : Int) : Int
    {
        return (hex & 0x0000FF);
    }
    
    public static function DarkSkin(newcolSkin : Int) : Int
    {
        return Util.ColorF(Util.HexR(newcolSkin) * 0.85, 
                Util.HexG(newcolSkin) * 0.70, 
                Util.HexB(newcolSkin) * 0.52
        );
    }
    
    public static function Swirl(newcolSkin : Int) : Int
    {
        return Util.ColorF(Util.HexR(newcolSkin) * 1, 
                Util.HexG(newcolSkin) * 0.73, 
                Util.HexB(newcolSkin) * 0.85
        );
    }
    
    public static function DarkHair(newcolHair : Int) : Int
    {
        return Util.ColorF(Util.HexR(newcolHair) * 0.54, 
                Util.HexG(newcolHair) * 0.53, 
                Util.HexB(newcolHair) * 0.42
        );
    }
    
    public static function IntToCommaString(num : Int) : String  // from null.point3r on stackoverflow.com  
    {
        var str : String = "";
        var sign : String = (num > 0) ? "" : "-";
        num = Math.floor(Math.abs(num));
        while (num > 0)
        {
            var tmp : Int = (num % 1000);
            str = ((num > 999) ? "," + ((tmp < 100) ? ((tmp < 10) ? "00" : "0") : "") : "") + tmp + str;
            num = Math.floor((num / 1000));
        }
        return sign + str;
    }

    public function new()
    {
    }
}

