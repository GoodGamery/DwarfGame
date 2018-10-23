package mon;

import flash.geom.ColorTransform;
import flixel.*;

class FaceFire extends Monster
{
    
    
    public function new(p : PlayState, X : Float, Y : Float, colTrans : ColorTransform = null, speedmod : Float = 1)
    {
        super(p, "FaceFire", X, Y, colTrans, speedmod);
        
        bDiesInWater = false;
        
        //addAnimation("run", [8, 9, 10, 11], 6, true);
        addAnimation("d", [37, 38, 39], 10, true);
        
        play("d");
        
        bAcrophobic = false;
        
        //remVelocity.x = -30;
        
        
        
        rectVulnerable.x = -3;
        rectVulnerable.width = 15;
        rectVulnerable.y = 0;
        rectVulnerable.height = 13;
        
        acceleration.y = 0;
        
        bForceHit = false;
        
        this.health = 1;
        bFrontMonster = true;
        bKillIfFar = true;
    }
    
    override public function Reuse() : Void
    {
        visible = true;
        doomed = false;
        health = 1;
        cast((false), Pause);
    }
    
    override public function update() : Void
    {
        super.update();
        acceleration.y = 0;
    }
    
    override public function UpdateMovement() : Void
    {
        if (facing == LEFT)
        {
            width = 10;
            height = 10;
            offset.x = 50;
            offset.y = 45;
            this.velocity.x = -iRunSpeed;
        }
        else if (facing == RIGHT)
        {
            width = 10;
            height = 10;
            offset.x = 30;
            offset.y = 45;
            this.velocity.x = iRunSpeed;
        }
    }
    
    override public function UpdateWallBonk() : Void
    {
        if (facing == LEFT && isTouching(LEFT))
        {
            Slay();
        }
        else if (facing == RIGHT && isTouching(RIGHT))
        {
            Slay();
        }
    }
    
    override public function Slay() : Void
    {
        this.doomed = true;
        parent.CauseExplosion(5, this.x - 10, this.y - 8, 
                6
        );  // <--- fiery smoke!  
        
        if (parent.nElapsedInZone > 2)
        {
            var nCloseness : Float = Util.Distance(this.x, this.y, parent.hero.x, parent.hero.y);
            nCloseness /= 30;
            nCloseness = 20 - nCloseness;
            
            if (nCloseness > 0)
            {
                nCloseness /= 10;
                FlxG.play(Content.soundDefeated, Content.volumeDefeated * nCloseness, false, false, Content.nDefaultSkip);
            }
        }
    }
    
    override public function UpdatePlayerHits() : Void
    {
        this.y += 2;
        this.height -= 2;  // haircut to avoid diagonal through-block hits  
        
        
        if (this.overlaps(parent.hero) &&
            parent.hero.flickering == false &&
            parent.state != Content.LEAVING &&
            parent.state != Content.DEAD &&
            parent.hero.GetCurrentAnim() != "leaving" &&
            parent.hero.GetCurrentAnim() != "arriving")
        {
            parent.hero.Hit(nDamageDealt, this.x + (this.width / 2));
            Slay();
        }
        
        this.y -= 2;
        this.height += 2;
    }
    
    override public function Struck(hhit : Int, vhit : Int, damage : Int) : Void
    {
        this.health -= Content.stats.nDamageDealt;
        
        if (this.health <= 0)
        {
            Slay();
        }
    }
}

