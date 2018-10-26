package particles;

import flixel.*;

class Splash extends Particle
{
    public function new(p : PlayState, X : Int, Y : Int)
    {
        super(X, Y);
        loadGraphic(Content.cSplash, true, true, 30, 60);
        
        strName = "Splash";
        
        animation.add("s", [0, 1, 2, 3, 4, 5], 15, false);
        playDefaultAnimation();
    }

    override public function playDefaultAnimation() {
        animation.play("s", true);
    }
    
    override public function update(elapsed : Float) : Void
    {
        if (this.animation.frameIndex == 5)
        {
            this.kill();
        }
    }
}


