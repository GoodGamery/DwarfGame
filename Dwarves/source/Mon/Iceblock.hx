package mon;

import flash.geom.ColorTransform;
import flixel.*;

class Iceblock extends Monster
{
    
    public function new(p : PlayState, X : Float, Y : Float, colTrans : ColorTransform = null)
    {
        super(p, "Iceblock", X, Y, colTrans, 1);
        
        addAnimation("d", [3], 1, true);
        play("d");
        
        bAcrophobic = true;
        
        this.immovable = true;
        bForceImmovable = true;
        bBlockade = true;
        bKeepRebouncing = true;
        bEatUpwardArrows = false;
        
        bAcrophobic = false;
        bWallBonk = false;
        bDiesInWater = false;
        bForceHit = false;
        
        
        
        bLevelCollision = false;
        bMonsterCollision = true;
        bOriginalLevelCollision = false;
        bOriginalMonsterCollision = true;
        bHeroCollision = true;
        
        width = 30;
        height = 30;
        offset.x = 30;
        offset.y = 30;
        
        facing = Content.RIGHT;
    }
    
    override public function update(elapsed : Float) : Void
    {
        acceleration.y = 0;
        velocity.x = 0;
        velocity.y = 0;
        
        super.update(elapsed);
    }
    
    override public function UpdatePlayerHits() : Void
    {
    }
    
    override public function DoesThisArrowHurtMe(arrow : Arrow, hhit : Int, vhit : Int) : Bool
    {
        return false;
    }
}

