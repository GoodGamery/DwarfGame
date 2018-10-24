package mon;

import flash.geom.Point;
import flash.geom.Rectangle;
import flixel.*;

class Gopher extends Talker
{
    
    public function new(p : PlayState, name : String, X : Float, Y : Float)
    {
        super(p, name, X, Y);
        
        sprFace = new FlxSprite();
        sprFace.loadGraphic(Content.cNPCOther, true, 60, 60, true);
        sprFace.animation.add("s", [1], 16, true);
        sprFace.scrollFactor.x = 0;
        sprFace.scrollFactor.y = 0;
        sprFace.animation.play("s");
        
        bAcrophobic = true;
        bFriendly = true;
        
        iRunSpeed = 15;
        
        loadGraphic(Content.cMonsters, true, 90, 90, true);
        animation.add("s", [4], 3, true);
        animation.add("w", [4, 5, 4, 6], 3, true);
        animation.play("w");
        
        //remVelocity.x = -30;
        
        width = 30;
        height = 52;
        offset.x = 30;
        offset.y = 8;
        
        facing = Content.RIGHT;
    }
    
    
    override public function update() : Void
    {
        super.update();
        return;
    }
}

