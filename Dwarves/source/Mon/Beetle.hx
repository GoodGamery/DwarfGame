package mon;

import flash.geom.ColorTransform;
import org.flixel.*;

class Beetle extends Monster
{
    public var bEnraged : Bool = false;
    public var iBaseSpeed : Int = 0;
    
    public function new(p : PlayState, X : Float, Y : Float, colTrans : ColorTransform = null, speedmod : Float = 1)
    {
        super(p, "Beetle", X, Y, colTrans, speedmod);
        
        addAnimation("run", [40 + 0, 40 + 1, 40 + 2, 40 + 3], 6, true);
        
        
        
        play("run");
        
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
    
    override public function update() : Void
    {
        bEnraged = as3hx.Compat.parseInt(parent.hero.y / 30) == as3hx.Compat.parseInt(this.y / 30) &&
                ((this.facing == LEFT && parent.hero.x < this.x) ||
                (this.facing == RIGHT && parent.hero.x > this.x));
        
        
        if (bEnraged == false)
        {
            iRunSpeed = iBaseSpeed / 3;
        }
        else
        {
            iRunSpeed = iBaseSpeed * 3;
        }
        
        super.update();
    }
    
    override public function DoesThisArrowHurtMe(arrow : Arrow, hhit : Int, vhit : Int) : Bool
    {
        if (arrow.iBounceLife > -1)
        
        { // Was spinning
            
            {
                return false;
            }
        }
        
        if (arrow.velocity.x < 0 && this.facing == RIGHT)
        {
            return false;
        }
        
        if (arrow.velocity.x > 0 && this.facing == LEFT)
        {
            return false;
        }
        
        /*
			if (this.facing == RIGHT)
			{
				this.facing = LEFT;
				velocity.x = 0;
			}
			else
			{
				this.facing = RIGHT;
				velocity.x = 0;
			}
			*/
        velocity.x = 0;
        
        return true;
    }
}

