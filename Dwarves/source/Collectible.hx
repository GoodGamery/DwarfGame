import flixel.*;
import hud.Grunt;

class Collectible extends FlxSprite
{
    public var parent : PlayState = null;
    public var name : String = "";
    public var col : Int;
    
    public function new(p : PlayState, gem : Int, X : Float, Y : Float)
    {
        if (gem == 0)
        {
            name = "+1 Pip";
            col = 0xFFFF82C0;
        }
        else if (gem == 1)
        {
            name = "+3 Pips";
            col = 0xFFFF82C0;
        }
        else if (gem == 2)
        {
            name = "+1 Reod";
            col = 0xFF8080FF;
        }
        else if (gem == 3)
        {
            name = "+3 Reods";
            col = 0xFF8080FF;
        }
        else if (gem == 4)
        {
            name = "+1 Lytrat";
            col = 0xFFFFCB1B;
        }
        else if (gem == 5)
        {
            name = "+3 Lytrats";
            col = 0xFFFFCB1B;
        }
        
        gem *= 3;
        
        super(X, Y);
        
        parent = p;
        
        loadGraphic(Content.cGems, true, 30, 30);
        
        width = 10;
        height = 10;
        offset.x = 10;
        offset.y = 10;
        
        animation.add("d", [0 + gem, 0 + gem, 0 + gem, 0 + gem, 0 + gem, 0 + gem, 0 + gem, 0 + gem, 0 + gem, 0 + gem, 0 + gem, 1 + gem, 2 + gem], 16, true);
        
        animation.play("d");
    }
    
    override public function update(elapsed : Float) : Void
    {
        if (Util.Distance(parent.hero.x + (parent.hero.width / 2), parent.hero.y + (parent.hero.height / 2), 
                    this.x + 5, this.y + 5
            ) < Content.nCollectDistance)
        
        {
            parent.arrayGrunts.push(new Grunt(Math.floor(this.x + (this.width / 2)), Math.floor(this.y + (this.height / 2) - 20), name, col, 60));
            parent.groupGrunts.add(try cast(parent.arrayGrunts[parent.arrayGrunts.length - 1], Grunt) catch(e:Dynamic) null);
            exists = false;
        }
    }
}
