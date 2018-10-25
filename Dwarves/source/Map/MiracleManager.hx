package map;

import flash.utils.ByteArray;
import map.Biome;
import flash.net.FileReference;
import openfl.Assets;

@:final class MiracleManager
{
    public static var arrayMiracles : Array<Dynamic> = new Array<Dynamic>();
    public static var arrayZoneMiracles : Array<Dynamic> = new Array<Dynamic>();
    
    public static function LoadMiracles() : Void
    {
        arrayMiracles.splice(0, arrayMiracles.length);
        
        LoadMiraclesFrom(Assets.getText("assets/data/miracles.txt"), 1);
        LoadMiraclesFrom(Assets.getText("assets/data/miracles_game1.txt"), 0);
        
        trace("._.-`* MIRACLES LOADED: " + Std.string(arrayMiracles.length));
    }
    
    public static function LoadMiraclesFrom(bytes : ByteArray, universal : Int) : Void
    {
        var s : String = bytes.readUTFBytes(bytes.length);
        
        var lines : Array<Dynamic> = s.split("\n");
        
        var i : Int = 0;
        while (i < lines.length)
        {
            var fields : Array<Dynamic> = (Std.string(lines[i])).split(",");
            
            if (fields.length >= 7)
            {
                var zonex : Int = fields[0];
                var zoney : Int = fields[1];
                var xx : Int = fields[2];
                var yy : Int = fields[3];
                var identity : Int = fields[4];
                var data : String = fields[5];
                var universal : Int = fields[6];
                
                arrayMiracles.push(new Miracle(zonex, zoney, xx, yy, identity, data, universal));
            }
            i++;
        }
    }
    
    public static function SaveMiracles() : Void
    {
        var universal_content : String = "";
        var profile_content : String = "";
        
        var i : Int = 0;
        while (i < arrayMiracles.length)
        
        { // TODO: Save in different places...
            
            
            /*
				if((arrayMiracles[i] as Miracle).universal == 1)
					universal_content += (arrayMiracles[i] as Miracle).StringRepresentation() + "\n\r";
				else
					profile_content += (arrayMiracles[i] as Miracle).StringRepresentation() + "\n\r";
					*/
            
            universal_content += (try cast(arrayMiracles[i], Miracle) catch(e:Dynamic) null).StringRepresentation() + "\n\r";
            i++;
        }
        
        var bytes : ByteArray = new ByteArray();
        var fileRef : FileReference = new FileReference();
        fileRef.save(universal_content, "miracles.txt");
    }
    
    public static function PopulateZoneMiracles(zonex : Int, zoney : Int) : Void
    {
        arrayZoneMiracles.splice(0, arrayZoneMiracles.length);
        
        var i : Int = 0;
        while (i < arrayMiracles.length)
        {
            if ((try cast(arrayMiracles[i], Miracle) catch(e:Dynamic) null).zx == zonex && (try cast(arrayMiracles[i], Miracle) catch(e:Dynamic) null).zy == zoney)
            {
                arrayZoneMiracles.push(arrayMiracles[i]);
                arrayMiracles.splice(i, 1);
                i--;
            }
            i++;
        }
    }
    
    public static function IntegrateZoneMiracles() : Void
    {
        var i : Int = 0;
        while (i < arrayZoneMiracles.length)
        {
            arrayMiracles.push(arrayZoneMiracles[i]);
            i++;
        }
        
        arrayZoneMiracles.splice(0, arrayZoneMiracles.length);
    }
    
    public static function SetOverride(o : Miracle) : Void
    // Remove any overrides that were at this space (one override of the same kingdom [universal/profile] per space!)
    {
        
        if (o.id >= 0 || o.id <= 1000)
        {
            var i : Int = 0;
            while (i < arrayZoneMiracles.length)
            {
                if ((try cast(arrayZoneMiracles[i], Miracle) catch(e:Dynamic) null).x == o.x && (try cast(arrayZoneMiracles[i], Miracle) catch(e:Dynamic) null).y == o.y &&
                    (try cast(arrayZoneMiracles[i], Miracle) catch(e:Dynamic) null).id >= 0 && (try cast(arrayZoneMiracles[i], Miracle) catch(e:Dynamic) null).id <= 1000 &&
                    (try cast(arrayZoneMiracles[i], Miracle) catch(e:Dynamic) null).universal == o.universal)
                {
                    arrayZoneMiracles.splice(i, 1);
                    i--;
                }
                i++;
            }
        }
        
        // Add the miracle to the zone's miracle list
        
        if ((o.id == Content.FACADE && o.strData == "") == false &&
            (o.id == Content.WALLPAPER && o.strData == "") == false)
        {
            arrayZoneMiracles.push(o);
            
            if (o.universal == 0)
            {
                UpdateProfileMiracleReport();
            }
        }
    }
    
    public static function UpdateProfileMiracleReport() : Void
    {
    }

    public function new()
    {
    }
}
