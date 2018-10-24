package hud;

import flash.geom.Point;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.group.FlxGroup;
import flixel.group.FlxSpriteGroup;
import flixel.text.FlxText;
import components.DwarfText;

class Grunt extends FlxSpriteGroup
{
    public var text : DwarfText;
    public var lifetime : Int;
    public var progress : Float;
    public var orig : Point;
    public var sprite : FlxSprite = null;
    public var doomed : Bool = false;
    
    public function new(x : Int, y : Int, str : String, col : Int, lt : Int)
    {
        super();
        
        orig = new Point(x, y);
        
        progress = 0;
        lifetime = lt;
        
        text = new DwarfText(x - 240, y, 480, str);
        //text.scrollFactor.x = 0;
        //text.scrollFactor.y = 0;
        text.color = col;
        text.shadow = 0xFF000000;
        text.alignment = "center";
        add(text);
    }
    
    public function AddSprite(frame : Int) : Void
    {
        sprite = new FlxSprite(0, 0);
        sprite.loadGraphic(Content.cGems, true, 30, 30, false);
        sprite.animation.add("d", [frame], 1, true);
        sprite.animation.play("d");
        this.add(sprite);
    }
    
    override public function update(elapsed:Float) : Void
    {
        if (progress < lifetime)
        {
            progress++;
            
            text.y = orig.y - ((progress / lifetime) * 15);
            
            if (sprite != null)
            {
                sprite.x = (text.x + 240) - 15;
                sprite.y = text.y - 25;
            }
            
            if (progress >= lifetime)
            {
                text.visible = false;
                doomed = true;
            }
        }
    }
}

