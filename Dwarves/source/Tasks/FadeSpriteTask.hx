package tasks;

import haxe.Constraints.Function;
import flash.display.Sprite;
import flash.events.TimerEvent;
import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.geom.Rectangle;
import flash.utils.Timer;
import flash.display.StageQuality;
import org.flixel.*;
import org.flixel.FlxGroupXY;
import spark.layouts.BasicLayout;

class FadeSpriteTask extends SpriteTask
{
    public function new(name : String, dataobject : Dynamic, seconds : Float, spr : FlxSprite, startx : Int, starty : Int, targetx : Int, targety : Int, xtype : Function, ytype : Function, kill : Bool, callback : Function = null)
    {
        super(name, dataobject, seconds, spr, startx, starty, targetx, targety, xtype, ytype, kill, callback);
    }
    
    override public function Progress() : Bool
    {
        sprite.alpha -= nSpeed;
        //sprite.dirty = true;
        
        return super.Progress();
    }
}

