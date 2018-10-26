package particles;

import flixel.*;

class Puff extends Particle
{
    public function new(p : PlayState, X : Int, Y : Int, dir : Float, sp : Float, row : Int)
    {
        super(p, X, Y);
        loadGraphic(Content.cParticle, true, 30, 30);
        animation.add("exploding", [0 + (row * 8), 1 + (row * 8), 2 + (row * 8), 3 + (row * 8), 4 + (row * 8), 5 + (row * 8), 6 + (row * 8), 7 + (row * 8)], 15, false);
        playDefaultAnimation();
        
        nDirection = dir;
        nSpeed = sp;
        
        AngleToCartSpeed();
    }

    override public function playDefaultAnimation() {
        animation.play("exploding", true);
    }
    
    override public function Reuse(X : Int, Y : Int, ?dir : Float = 0, ?sp : Float = 0) : Void
    {
        super.Reuse(X, Y);
        
        playDefaultAnimation();
        
        nDirection = dir;
        nSpeed = sp;
        
        // TODO: This doesn't work any more
        // this._animations[0].frames = [0 + (row * 8), 1 + (row * 8), 2 + (row * 8), 3 + (row * 8), 4 + (row * 8), 5 + (row * 8), 6 + (row * 8), 7 + (row * 8)];
        
        AngleToCartSpeed();
    }

    override public function update(elapsed : Float) : Void
    {
        if (animation.frameIndex == 7)
        {
            this.visible = false;
        }
    }
}


