package mon;

import flash.geom.Point;
import flash.geom.Rectangle;
import org.flixel.*;

class Gopher extends Talker
{
    
    public function new(p : PlayState, name : String, X : Float, Y : Float)
    {
        super(p, name, X, Y);
        
        sprFace = new FlxSprite();
        sprFace.loadGraphic(Content.cNPCOther, true, true, 60, 60, true);
        sprFace.addAnimation("s", [1], 16, true);
        sprFace.scrollFactor.x = 0;
        sprFace.scrollFactor.y = 0;
        sprFace.play("s");
        
        bAcrophobic = true;
        bFriendly = true;
        
        iRunSpeed = 15;
        
        loadGraphic(Content.cMonsters, true, true, 90, 90, true);
        addAnimation("s", [4], 3, true);
        addAnimation("w", [4, 5, 4, 6], 3, true);
        play("w");
        
        //remVelocity.x = -30;
        
        width = 30;
        height = 52;
        offset.x = 30;
        offset.y = 8;
        
        facing = RIGHT;
    }
    
    
    override public function update() : Void
    {
        super.update();
        return;
    }
}

