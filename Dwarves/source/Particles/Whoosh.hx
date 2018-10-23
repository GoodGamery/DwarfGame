package particles;

import org.flixel.*;

class Whoosh extends FlxSprite
{
    public var nDirection : Float = 0;
    public var nSpeed : Float = 0;
    public function new(p : PlayState, X : Int, Y : Int, dir : Float, sp : Float)
    {
        super(30, 30);
        loadGraphic(Content.cParticle, true, true, 30, 30);
        
        this.x = X;
        this.y = Y;
        
        addAnimation("w", [16, 17, 18, 19, 20], 13, false);
        play("w");
        
        nDirection = dir;
        nSpeed = sp;
        
        AngleToCartSpeed();
    }
    
    public function AngleToCartSpeed() : Void
    {
        var rads : Float = nDirection * (Math.PI / 180);
        velocity.x = nSpeed * Math.cos(rads);
        velocity.y = nSpeed * Math.sin(rads);
    }
    
    override public function update() : Void
    {
        if (_curFrame == 3)
        {
            this.condemned = true;
        }
    }
}


