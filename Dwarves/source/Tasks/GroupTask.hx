package tasks;

import haxe.Constraints.Function;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;
import flixel.*;

class GroupTask extends Task
{
    public var group : FlxSpriteGroup = null;
    public var sx : Int = 0;
    public var sy : Int = 0;
    public var tx : Int = 0;
    public var ty : Int = 0;
    public var fTypeX : Function;
    public var fTypeY : Function;
    public var bKill : Bool;
    public function new(name : String, dataobject : Dynamic, seconds : Float, grp : FlxSpriteGroup, startx : Int, starty : Int, targetx : Int, targety : Int, xtype : Function, ytype : Function, kill : Bool, callback : Function = null)
    {
        super(name, dataobject, seconds);
        
        group = grp;
        
        sx = startx;
        sy = starty;
        tx = targetx;
        ty = targety;
        fTypeX = xtype;
        fTypeY = ytype;
        
        group.x = sx;
        group.y = sy;
    }
    
    override public function Progress() : Bool
    {
        var done : Bool = false;
        
        if (super.Progress())
        {
            group.x = tx;
            group.y = ty;
            done = true;
            
            if (bKill)
            {
                group.doomed = true;
            }
            
            if (fCallback != null)
            {
                fCallback();
            }
        }
        else
        {
            if (sx != tx)
            {
                group.x = fTypeX(sx, tx, nProgress);
            }
            
            if (sy != ty)
            {
                group.y = fTypeY(sy, ty, nProgress);
            }
            
            if (fTypeY == Util.ArcCurrent)
            {
                group.y = fTypeY(sy, sy - 24, nProgress);
            }
        }
        
        return done;
    }
}
