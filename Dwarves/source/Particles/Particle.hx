package particles;

import flixel.*;

class Particle extends FlxSprite
{
    public var nDirection : Float = 0;
    public var nSpeed : Float = 0;

    public function new(p : PlayState, X : Int, Y : Int)
    {
        super(X, Y);
    }
    
    public function Reuse(X : Int, Y : Int, ?dir : Float = 0, ?sp : Float = 0) : Void
    {
        this.x = X;
        this.y = Y;
        this.nDirection = dir;
        this.nSpeed = sp;
        this.revive();
        this.playDefaultAnimation();
    }

    public function playDefaultAnimation() {
        // Children should override this
    }

    public function AngleToCartSpeed() : Void
    {
        var rads : Float = nDirection * (Math.PI / 180);
        velocity.x = nSpeed * Math.cos(rads);
        velocity.y = nSpeed * Math.sin(rads);
    }
    
}


