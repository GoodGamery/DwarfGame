package Map
{
	import flash.utils.ByteArray;

	import Map.Biome;
	import org.flixel.Rndm;
	import flash.net.FileReference;
	
	
	public final class MiracleManager
	{
		public static var arrayMiracles:Array = new Array();
		public static var arrayZoneMiracles:Array = new Array();
				
		public static function LoadMiracles():void
		{
			arrayMiracles.splice(0);
			
			LoadMiraclesFrom(new Content.cMiracles as ByteArray, 1);
			LoadMiraclesFrom(new Content.cMiraclesGame1 as ByteArray, 0);

			trace("._.-`* MIRACLES LOADED: " + arrayMiracles.length.toString());
		}
		
		public static function LoadMiraclesFrom(bytes:ByteArray, universal:int):void
		{
			var s:String = bytes.readUTFBytes(bytes.length);
						
			var lines:Array = s.split("\n");
			
			for (var i:int = 0; i < lines.length; i++)
			{
				var fields:Array = (lines[i] as String).split(",");
				
				if (fields.length >= 7)
				{
					var zonex:int = int(fields[0]);
					var zoney:int = int(fields[1]);
					var xx:int = int(fields[2]);
					var yy:int = int(fields[3]);
					var identity:int = int(fields[4]);
					var data:String = fields[5];
					var universal:int = int(fields[6]);
					
					arrayMiracles.push(new Miracle(zonex, zoney, xx, yy, identity, data, universal));
				}
			}
		}
		
		public static function SaveMiracles():void
		{
			var universal_content:String = "";
			var profile_content:String = "";
			
			for (var i:int = 0; i < arrayMiracles.length; i++)
			{
				// TODO: Save in different places...
				
				/*
				if((arrayMiracles[i] as Miracle).universal == 1)
					universal_content += (arrayMiracles[i] as Miracle).StringRepresentation() + "\n\r";
				else
					profile_content += (arrayMiracles[i] as Miracle).StringRepresentation() + "\n\r";
					*/
					
				universal_content += (arrayMiracles[i] as Miracle).StringRepresentation() + "\n\r";
			}
									
			var bytes:ByteArray = new ByteArray();
			var fileRef:FileReference=new FileReference();
			fileRef.save(universal_content, "miracles.txt");
			
			//var fileRef2:FileReference=new FileReference();
			//fileRef2.save(profile_content, "miracles_game1.txt");
		}
		
		public static function PopulateZoneMiracles(zonex:int, zoney:int):void
		{
			arrayZoneMiracles.splice(0);
			
			for (var i:int = 0; i < arrayMiracles.length; i++)
			{
				if ((arrayMiracles[i] as Miracle).zx == zonex && (arrayMiracles[i] as Miracle).zy == zoney)
				{
					arrayZoneMiracles.push(arrayMiracles[i]);
					arrayMiracles.splice(i, 1);
					i--;
				}
			}
		}
		
		public static function IntegrateZoneMiracles():void
		{
			for (var i:int = 0; i < arrayZoneMiracles.length; i++)
			{
				arrayMiracles.push(arrayZoneMiracles[i]);
			}
			
			arrayZoneMiracles.splice(0);
		}
		
		public static function SetOverride(o:Miracle):void
		{
			// Remove any overrides that were at this space (one override of the same kingdom [universal/profile] per space!)
			if (o.id >= 0 || o.id <= 1000)
			{
				for (var i:int = 0; i < arrayZoneMiracles.length; i++)
				{
					if ((arrayZoneMiracles[i] as Miracle).x == o.x && (arrayZoneMiracles[i] as Miracle).y == o.y &&
						(arrayZoneMiracles[i] as Miracle).id >= 0 && (arrayZoneMiracles[i] as Miracle).id <= 1000 &&
						(arrayZoneMiracles[i] as Miracle).universal == o.universal)
						{
							arrayZoneMiracles.splice(i, 1);
							i--;
						}
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
		
		public static function UpdateProfileMiracleReport():void
		{
			
		}
	}
}