package particles;

import org.flixel.*;

class Splash extends FlxSprite
{
    
    public function new(p : PlayState, X : Int, Y : Int)
    {
        super(30, 60);
        loadGraphic(Content.cSplash, true, true, 30, 60);
        
        strName = "Splash";
        
        this.x = X;
        this.y = Y;
        
        addAnimation("s", [0, 1, 2, 3, 4, 5], 15, false);
        play("s");
    }
    
    public function Reuse(X : Int, Y : Int) : Void
    {
        x = X;
        y = Y;
        play("s", true);
        visible = true;
    }
    
    override public function update() : Void
    {
        if (_curFrame == 5)
        {
            this.visible = false;
        }
    }
}


