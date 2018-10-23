package particles;

import org.flixel.*;
import org.flixel.system.FlxAnim;

class Puff extends FlxSprite
{
    public var nDirection : Float = 0;
    public var nSpeed : Float = 0;
    public function new(p : PlayState, X : Int, Y : Int, dir : Float, sp : Float, row : Int)
    {
        super(30, 30);
        loadGraphic(Content.cParticle, true, true, 30, 30);
        
        strName = "Puff";
        
        this.x = X;
        this.y = Y;
        
        addAnimation("exploding", [0 + (row * 8), 1 + (row * 8), 2 + (row * 8), 3 + (row * 8), 4 + (row * 8), 5 + (row * 8), 6 + (row * 8), 7 + (row * 8)], 15, false);
        play("exploding");
        
        nDirection = dir;
        nSpeed = sp;
        
        AngleToCartSpeed();
    }
    
    public function Reuse(X : Int, Y : Int, dir : Float, sp : Float, row : Int) : Void
    {
        visible = true;
        
        
        play("exploding", true);
        
        this.x = X;
        this.y = Y;
        
        nDirection = dir;
        nSpeed = sp;
        
        (try cast(this._animations[0], FlxAnim) catch(e:Dynamic) null).frames = [0 + (row * 8), 1 + (row * 8), 2 + (row * 8), 3 + (row * 8), 4 + (row * 8), 5 + (row * 8), 6 + (row * 8), 7 + (row * 8)];
        
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
        if (_curFrame == 7)
        {
            this.visible = false;
        }
    }
}


