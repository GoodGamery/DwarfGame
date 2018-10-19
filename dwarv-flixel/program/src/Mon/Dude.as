package Mon 
{
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import org.flixel.*;
	
	public class Dude extends Talker 
	{
		
		
		public var colEye:uint = Util.Color(109, 234, 20);
		public var colSkin:uint = Util.Color(255, 216, 185);
		public var colDarkSkin:uint = Util.Color(217, 151, 97);
		public var colSwirl:uint = Util.Color(255, 158, 158);
		public var colHair:uint = Util.Color(114, 103, 50);
		public var colDarkHair:uint = Util.Color(62, 55, 21);
		public var colDress:uint = Util.Color(47, 47, 47);
		public var colShirt:uint = Util.Color(26, 178, 73);
		
		public var iFace:int = 0;
		public var iClothing:int = 0;
		public var iMale:int = 0;
		
		
		public function Dude(p:PlayState, name:String, sourceface:int, sourceclothing:int, sourcemale:int, X:Number, Y:Number) 
		{
			super(p, name, X, Y);
			
			SetPaperdoll(sourceface, sourceclothing, sourcemale);
			
			bAcrophobic = true;
			bFriendly = true;
			iRunSpeed = 15;
			
			//remVelocity.x = -30;
			
			width = 24;
			height = 30;
			offset.x = 3;
			offset.y = 0;
			
			
		}
		
		public function SetPaperdoll(sourceface:int, sourceclothing:int, sourcemale:int):void
		{
			loadGraphic(Content.cNPC, true, true, 30, 30, true);
			
			iFace = sourceface;
			iClothing = sourceclothing;
			iMale = sourcemale;
			
			var clothing:int = 24 + (iClothing * 2);
			var bigface:int = (iFace);
			var lilface:int = bigface * 2;
			
			
			
			if (iMale == 1)
			{
				lilface += 12;
				clothing += 12;
				bigface += 6;
			}
			
			bigface += 12;
			
			sprFace = new FlxSprite(3, 3, Content.cNPC);
			sprFace.loadGraphic(Content.cNPC, true, false, 60, 60, true);
			sprFace.addAnimation("", [bigface], 0, false); 
			sprFace.scrollFactor.x = 0;
			sprFace.scrollFactor.y = 0;
			sprFace.play("");
			
			_pixels.copyPixels(_pixels, new Rectangle(lilface * 30, 0, 30, 30), new Point((clothing - 24) * 30, 30), null, null, true);
			_pixels.copyPixels(_pixels, new Rectangle((lilface + 1) * 30, 0, 30, 30), new Point(((clothing - 24) + 1) * 30, 30), null, null, true);

			_pixels.copyPixels(_pixels, new Rectangle(_pixels.width - 30 - (lilface * 30), 0, 30, 30), new Point(_pixels.width - 30 - ((clothing - 24) * 30), 30), null, null, true);
			_pixels.copyPixels(_pixels, new Rectangle(_pixels.width - 30 - ((lilface + 1) * 30), 0, 30, 30), new Point(_pixels.width - 30 - (((clothing - 24) + 1) * 30), 30), null, null, true);
			
			addAnimation("s", [clothing], 0, false);
			addAnimation("w", [clothing, clothing + 1], 3, true);
			
			play("w");
		}
		
		
		
		public function SetColors(newcolEye:uint, newcolSkin:uint, newcolDarkSkin:uint, newcolSwirl:uint, newcolHair:uint, newcolDarkHair:uint, newcolDress:uint, newcolShirt:uint):void
		{
			for (var j:int = 0; j < _pixels.height; j++) 
			{
				for (var i:int = 0; i < _pixels.width; i++) 
				{
					if (newcolEye > 0 && _pixels.getPixel(i, j) == colEye)
					{
						_pixels.setPixel(i, j, newcolEye);
					}
					else if (newcolSkin > 0 && _pixels.getPixel(i, j) == colSkin) 
					{
						_pixels.setPixel(i, j, newcolSkin);
					}
					else if (newcolDarkSkin > 0 && _pixels.getPixel(i, j) == colDarkSkin) 
					{
						_pixels.setPixel(i, j, newcolDarkSkin);
					}
					else if (newcolSwirl > 0 && _pixels.getPixel(i, j) == colSwirl) 
					{
						_pixels.setPixel(i, j, newcolSwirl);
					}
					else if (newcolHair > 0 && _pixels.getPixel(i, j) == colHair) 
					{
						_pixels.setPixel(i, j, newcolHair);
					}
					else if (newcolDarkHair > 0 && _pixels.getPixel(i, j) == colDarkHair) 
					{
						_pixels.setPixel(i, j, newcolDarkHair);
					}
					else if (newcolDress > 0 && _pixels.getPixel(i, j) == colDress)
					{
						_pixels.setPixel(i, j, newcolDress);
					}
					else if (newcolShirt > 0 && _pixels.getPixel(i, j) == colShirt) 
					{
						_pixels.setPixel(i, j, newcolShirt);	
					}
				}
			}
			
			for (j = 0; j < sprFace._pixels.height; j++) 
			{
				for (i = 0; i < sprFace._pixels.width; i++) 
				{
					if (newcolEye > 0 && sprFace._pixels.getPixel(i, j) == colEye)
					{
						sprFace._pixels.setPixel(i, j, newcolEye);
					}
					else if (newcolSkin > 0 && sprFace._pixels.getPixel(i, j) == colSkin) 
					{
						sprFace._pixels.setPixel(i, j, newcolSkin);
					}
					else if (newcolDarkSkin > 0 && sprFace._pixels.getPixel(i, j) == colDarkSkin) 
					{
						sprFace._pixels.setPixel(i, j, newcolDarkSkin);
					}
					else if (newcolSwirl > 0 && sprFace._pixels.getPixel(i, j) == colSwirl) 
					{
						sprFace._pixels.setPixel(i, j, newcolSwirl);
					}
					else if (newcolHair > 0 && sprFace._pixels.getPixel(i, j) == colHair) 
					{
						sprFace._pixels.setPixel(i, j, newcolHair);
					}
					else if (newcolDarkHair > 0 && sprFace._pixels.getPixel(i, j) == colDarkHair) 
					{
						sprFace._pixels.setPixel(i, j, newcolDarkHair);
					}
					else if (newcolDress > 0 && sprFace._pixels.getPixel(i, j) == colDress)
					{
						sprFace._pixels.setPixel(i, j, newcolDress);
					}
					else if (newcolShirt > 0 && sprFace._pixels.getPixel(i, j) == colShirt) 
					{
						sprFace._pixels.setPixel(i, j, newcolShirt);	
					}
				}
			}
			
			if(newcolEye > 0) colEye = newcolEye;
			if(newcolSkin > 0) colSkin = newcolSkin;
			if(newcolDarkSkin > 0) colDarkSkin = newcolDarkSkin;
			if(newcolSwirl > 0) colSwirl = newcolSwirl;
			if(newcolHair > 0) colHair = newcolHair;
			if(newcolDarkHair > 0) colDarkHair = newcolDarkHair;
			if(newcolDress > 0) colDress = newcolDress
			if(newcolShirt > 0) colShirt = newcolShirt;
		}
		
		override public function update():void
		{
			super.update();
		
		}
	}

}