package particles;

import flixel.*;

class Twinkle extends Particle
{
    public function new(p : PlayState, X : Int, Y : Int)
    {
        super(p, X, Y);
        loadGraphic(Content.cTwinkle, true, 1, 1);
    
        animation.add("twinkling", [0, 1, 2, 3, 4, 4, 5, 5, 6, 7, 8, 9], 10, false);
        playDefaultAnimation();
    }

    override public function playDefaultAnimation() {
        animation.play("twinkling", true);
    }
    
    override public function update(elapsed : Float) : Void
    {
        if (this.animation.frameIndex == 11)
        {
            this.kill();
        }
    }
}


