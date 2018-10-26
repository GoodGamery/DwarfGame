package mon;

import flash.geom.ColorTransform;
import flixel.*;

class Beetle extends Monster
{
    public var bEnraged : Bool = false;
    public var iBaseSpeed : Int = 0;
    
    public function new(p : PlayState, X : Float, Y : Float, colTrans : ColorTransform = null, speedmod : Float = 1)
    {
        super(p, "Beetle", X, Y, colTrans, speedmod);
        
        animation.add("run", [40 + 0, 40 + 1, 40 + 2, 40 + 3], 6, true);
        
        
        
        animation.play("run");
        
        bAcrophobic = true;
        
        //remVelocity.x = -30;
        
        width = 12;
        height = 28;
        offset.x = 39;
        offset.y = 32;
        
        rectVulnerable.x = -5;
        rectVulnerable.width = 22;
        rectVulnerable.height = 28;
        
        bForceHit = false;
        
        //boundGraphic(90, 90, 8, 8);
        
        iBaseSpeed = iRunSpeed;
        
        this.health = 40;
    }
    
    override public function update(elapsed : Float) : Void
    {
        bEnraged = as3hx.Compat.parseInt(parent.hero.y / 30) == as3hx.Compat.parseInt(this.y / 30) &&
                ((this.facing == Content.LEFT && parent.hero.x < this.x) ||
                (this.facing == Content.RIGHT && parent.hero.x > this.x));
        
        
        if (bEnraged == false)
        {
            iRunSpeed = iBaseSpeed / 3;
        }
        else
        {
            iRunSpeed = iBaseSpeed * 3;
        }
        
        super.update(elapsed);
    }
    
    override public function DoesThisArrowHurtMe(arrow : Arrow, hhit : Int, vhit : Int) : Bool
    {
        if (arrow.iBounceLife > -1)
        
        { // Was spinning
            
            {
                return false;
            }
        }
        
        if (arrow.velocity.x < 0 && this.facing == Content.RIGHT)
        {
            return false;
        }
        
        if (arrow.velocity.x > 0 && this.facing == Content.LEFT)
        {
            return false;
        }
        
        /*
			if (this.facing == Content.RIGHT)
			{
				this.facing = Content.LEFT;
				velocity.x = 0;
			}
			else
			{
				this.facing = Content.RIGHT;
				velocity.x = 0;
			}
			*/
        velocity.x = 0;
        
        return true;
    }
}

