package mon;

import flash.geom.Point;
import flash.geom.Rectangle;
import flixel.*;

class Signpost extends Talker
{
    
    public function new(p : PlayState, name : String, X : Float, Y : Float)
    {
        super(p, name, X, Y);
        
        sprFace = new FlxSprite();
        sprFace.loadGraphic(Content.cNPCOther, true, true, 60, 60, true);
        sprFace.animation.add("s", [0], 16, true);
        sprFace.scrollFactor.x = 0;
        sprFace.scrollFactor.y = 0;
        sprFace.animation.play("s");
        
        bAcrophobic = false;
        bFriendly = true;
        bLevelCollision = false;
        bMonsterCollision = false;
        bOriginalLevelCollision = false;
        bOriginalMonsterCollision = false;
        
        loadGraphic(Content.cNPCStatic, true, true, 30, 30, true);
        animation.add("s", [1], 16, true);
        animation.play("s");
        
        //remVelocity.x = -30;
        
        width = 24;
        height = 30;
        offset.x = 3;
        offset.y = 0;
        
        facing = Content.RIGHT;
    }
    
    
    override public function update(elapsed : Float) : Void
    {
        acceleration.y = 0;
        velocity.x = 0;
        velocity.y = 0;
        
        //super.update(elapsed)
        return;
    }
}

