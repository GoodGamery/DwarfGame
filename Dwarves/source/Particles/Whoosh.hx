package particles;

import flixel.*;

class Whoosh extends Particle
{
    public var nDirection : Float = 0;
    public var nSpeed : Float = 0;
    public function new(p : PlayState, X : Int, Y : Int, dir : Float, sp : Float)
    {
        super(p, X, Y);
        loadGraphic(Content.cParticle, true, true, 30, 30);
        
        animation.add("w", [16, 17, 18, 19, 20], 13, false);
        playDefaultAnimation();
        
        nDirection = dir;
        nSpeed = sp;
        
        AngleToCartSpeed();
    }
    
    override public function playDefaultAnimation() {
        animation.play("w", true);
    }
    
    override public function update(elapsed : Float) : Void
    {
        if (this.animation.frameIndex == 3)
        {
            this.condemned = true;
        }
    }
}


