package hud;

import flash.geom.Point;
import org.flixel.FlxSprite;
import org.flixel.FlxG;
import org.flixel.FlxGroupXY;
import org.flixel.FlxTextPlus;

class Meter extends FlxGroupXY
{
    public var shadow : FlxSprite;
    public var bg : FlxSprite;
    public var fill : FlxSprite;
    public var text : FlxTextPlus;
    public var meterwidth : Int = 0;
    public var meterheight : Int = 0;
    public var metercolor : Int = 0xFFFFFFFF;
    public var meterbackcolor : Int = 0xFFFFFFFF;
    
    public function new(x : Int, y : Int, width : Int, height : Int, col : Int, bcol : Int)
    {
        super();
        
        meterwidth = width;
        meterheight = height;
        metercolor = col;
        meterbackcolor = bcol;
        
        shadow = new FlxSprite(x - 1, y - 1);
        shadow.makeGraphic(width + 2, height + 2, 0xFF000000, false);
        shadow.scrollFactor.x = 0;
        shadow.scrollFactor.y = 0;
        add(shadow);
        
        bg = new FlxSprite(x, y);
        bg.makeGraphic(width, height, bcol, false);
        bg.scrollFactor.x = 0;
        bg.scrollFactor.y = 0;
        add(bg);
        
        fill = new FlxSprite(x, y);
        fill.makeGraphic(width, height, col, false);
        fill.scrollFactor.x = 0;
        fill.scrollFactor.y = 0;
        add(fill);
        
        text = try cast(add(new FlxTextPlus(x - 1, y + (height / 2) - 7, width, "")), FlxTextPlus) catch(e:Dynamic) null;
        text.scrollFactor.x = 0;
        text.scrollFactor.y = 0;
        text.shadow = 0xFF000000;
        text.alignment = "center";
        add(text);
    }
    
    public function SetValue(amount : Int, max : Int) : Void
    {
        text.text = Std.string(amount) + "/" + Std.string(max);
        
        if (amount <= 0)
        {
            fill.visible = false;
        }
        else
        {
            fill.visible = true;
            fill.makeGraphic(Math.ceil(meterwidth * (amount / max)), meterheight, metercolor, false);
        }
    }
}

