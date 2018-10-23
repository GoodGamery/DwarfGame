package tasks;

import haxe.Constraints.Function;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;
import flixel.*;

class SpriteTask extends Task
{
    public var sprite : FlxSprite = null;
    public var sx : Int = 0;
    public var sy : Int = 0;
    public var tx : Int = 0;
    public var ty : Int = 0;
    public var fTypeX : Function;
    public var fTypeY : Function;
    public var bKill : Bool;
    
    public function new(name : String, dataobject : Dynamic, seconds : Float, spr : FlxSprite, startx : Int, starty : Int, targetx : Int, targety : Int, xtype : Function, ytype : Function, kill : Bool, callback : Function = null)
    {
        super(name, dataobject, seconds, callback);
        
        
        sprite = spr;
        
        sx = startx;
        sy = starty;
        tx = targetx;
        ty = targety;
        fTypeX = xtype;
        fTypeY = ytype;
        bKill = kill;
        
        sprite.x = sx;
        sprite.y = sy;
    }
    
    override public function Progress() : Bool
    {
        var done : Bool = false;
        
        if (super.Progress())
        {
            sprite.x = tx;
            sprite.y = ty;
            done = true;
            
            if (bKill)
            {
                sprite.doomed = true;
            }
        }
        else
        {
            if (sx != tx)
            {
                sprite.x = fTypeX(sx, tx, nProgress);
            }
            
            if (sy != ty)
            {
                sprite.y = fTypeY(sy, ty, nProgress);
            }
            
            if (fTypeY == Util.ArcCurrent)
            {
                sprite.y = fTypeY(sy, sy - 24, nProgress);
            }
        }
        
        return done;
    }
}
