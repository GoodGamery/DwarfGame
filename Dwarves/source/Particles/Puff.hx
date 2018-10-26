package particles;

import flixel.*;
import flixel.system.FlxAnim;

class Puff extends Particle
{
    public function new(p : PlayState, X : Int, Y : Int, dir : Float, sp : Float, row : Int)
    {
        super(30, 30);
        loadGraphic(Content.cParticle, true, true, 30, 30);
        
        strName = "Puff";
        
        this.x = X;
        this.y = Y;
        
        addAnimation("exploding", [0 + (row * 8), 1 + (row * 8), 2 + (row * 8), 3 + (row * 8), 4 + (row * 8), 5 + (row * 8), 6 + (row * 8), 7 + (row * 8)], 15, false);
        playDefaultAnimation();
        
        nDirection = dir;
        nSpeed = sp;
        
        AngleToCartSpeed();
    }

    override public function playDefaultAnimation() {
        animation.play("exploding", true);
    }
    
    public override function Reuse(X : Int, Y : Int, dir : Float, sp : Float, row : Int) : Void
    {
        super.Reuse(X, Y);
        
        playDefaultAnimation();
        
        nDirection = dir;
        nSpeed = sp;
        
        // This doesn't work any more
        // this._animations[0].frames = [0 + (row * 8), 1 + (row * 8), 2 + (row * 8), 3 + (row * 8), 4 + (row * 8), 5 + (row * 8), 6 + (row * 8), 7 + (row * 8)];
        
        AngleToCartSpeed();
    }

    override public function update(elapsed : Float) : Void
    {
        if (_curFrame == 7)
        {
            this.visible = false;
        }
    }
}


