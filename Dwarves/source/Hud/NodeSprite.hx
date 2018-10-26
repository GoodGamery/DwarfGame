package hud;

import flixel.*;

class NodeSprite extends FlxSprite
{
    
    public function new(X : Float, Y : Float)
    {
        super(X, Y);
        
        loadGraphic(Content.cMapNodes, true, false, 12, 12);
        
        animation.add("blank", [0], 1, true);
        animation.add("face", [1], 1, true);
        animation.add("h", [2], 1, true);
        animation.add("v", [3], 1, true);
        
        var i : Int = 4;
        while (i < Content.numbiomes + 4)
        {
            animation.add(Std.string(i - 4), [i], 1, true);
            i++;
        }
    }
    
    public function SetBiome(biome : Int) : Void
    {
        play(Std.string(biome));
    }
}

