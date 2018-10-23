package mon;

import flash.geom.Point;
import flash.geom.Rectangle;
import flixel.*;

class Talker extends Monster
{
    public var sprFace : FlxSprite = null;
    
    public var strDialogue : String = "This is some sample dialogue.";
    public var arrayScript : Array<Dynamic> = new Array<Dynamic>();
    
    
    
    public function new(p : PlayState, name : String, X : Float, Y : Float)
    {
        super(p, name, X, Y);
    }
    
    override public function update() : Void
    {
        super.update();
    }
}

