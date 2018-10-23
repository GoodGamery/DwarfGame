package tasks;

import haxe.Constraints.Function;
import flash.events.TimerEvent;
import flash.geom.Point;
import flash.utils.Timer;
import org.flixel.*;

class Task
{
    public var nSpeed : Float = 1 / Content.iGameFramerate;
    public var nProgress : Float = 0;
    public var strName : String = "";
    public var data : Dynamic = null;
    public var fCallback : Function = null;
    
    public function new(name : String, dataobject : Dynamic, seconds : Float, callback : Function = null)
    {
        strName = name;
        nSpeed = (1 / (Content.iGameFramerate * seconds));
        data = dataobject;
        fCallback = callback;
    }
    
    public function Progress() : Bool
    {
        nProgress += nSpeed;
        
        if (nProgress > 1)
        {
            nProgress = 1;
            
            if (fCallback != null)
            {
                fCallback();
            }
            
            return true;
        }
        
        return false;
    }
}
