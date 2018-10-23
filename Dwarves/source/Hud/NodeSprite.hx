package hud;

import org.flixel.*;

class NodeSprite extends FlxSprite
{
    
    public function new(X : Float, Y : Float)
    {
        super(X, Y);
        
        loadGraphic(Content.cMapNodes, true, false, 12, 12);
        
        addAnimation("blank", [0], 1, true);
        addAnimation("face", [1], 1, true);
        addAnimation("h", [2], 1, true);
        addAnimation("v", [3], 1, true);
        
        var i : Int = 4;
        while (i < Content.numbiomes + 4)
        {
            addAnimation(Std.string(i - 4), [i], 1, true);
            i++;
        }
    }
    
    public function SetBiome(biome : Int) : Void
    {
        play(Std.string(biome));
    }
}

