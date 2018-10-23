package mon;

import flash.geom.Point;
import flash.geom.Rectangle;
import flixel.*;

class Dude extends Talker
{
    
    
    public var colEye : Int = Util.Color(109, 234, 20);
    public var colSkin : Int = Util.Color(255, 216, 185);
    public var colDarkSkin : Int = Util.Color(217, 151, 97);
    public var colSwirl : Int = Util.Color(255, 158, 158);
    public var colHair : Int = Util.Color(114, 103, 50);
    public var colDarkHair : Int = Util.Color(62, 55, 21);
    public var colDress : Int = Util.Color(47, 47, 47);
    public var colShirt : Int = Util.Color(26, 178, 73);
    
    public var iFace : Int = 0;
    public var iClothing : Int = 0;
    public var iMale : Int = 0;
    
    
    public function new(p : PlayState, name : String, sourceface : Int, sourceclothing : Int, sourcemale : Int, X : Float, Y : Float)
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
    
    public function SetPaperdoll(sourceface : Int, sourceclothing : Int, sourcemale : Int) : Void
    {
        loadGraphic(Content.cNPC, true, true, 30, 30, true);
        
        iFace = sourceface;
        iClothing = sourceclothing;
        iMale = sourcemale;
        
        var clothing : Int = as3hx.Compat.parseInt(24 + (iClothing * 2));
        var bigface : Int = (iFace);
        var lilface : Int = as3hx.Compat.parseInt(bigface * 2);
        
        
        
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
    
    
    
    public function SetColors(newcolEye : Int, newcolSkin : Int, newcolDarkSkin : Int, newcolSwirl : Int, newcolHair : Int, newcolDarkHair : Int, newcolDress : Int, newcolShirt : Int) : Void
    {
        var j : Int = 0;
        while (j < _pixels.height)
        {
            var i : Int = 0;
            while (i < _pixels.width)
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
                i++;
            }
            j++;
        }
        
        j = 0;
        while (j < sprFace._pixels.height)
        {
            i = 0;
            while (i < sprFace._pixels.width)
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
                i++;
            }
            j++;
        }
        
        if (newcolEye > 0)
        {
            colEye = newcolEye;
        }
        if (newcolSkin > 0)
        {
            colSkin = newcolSkin;
        }
        if (newcolDarkSkin > 0)
        {
            colDarkSkin = newcolDarkSkin;
        }
        if (newcolSwirl > 0)
        {
            colSwirl = newcolSwirl;
        }
        if (newcolHair > 0)
        {
            colHair = newcolHair;
        }
        if (newcolDarkHair > 0)
        {
            colDarkHair = newcolDarkHair;
        }
        if (newcolDress > 0)
        {
            colDress = newcolDress;
        }
        if (newcolShirt > 0)
        {
            colShirt = newcolShirt;
        }
    }
    
    override public function update() : Void
    {
        super.update();
    }
}

