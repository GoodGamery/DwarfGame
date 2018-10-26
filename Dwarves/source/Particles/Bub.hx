package particles;

import flixel.*;

class Bub extends Particle
{
    public var parent : PlayState = null;
    public var nLife : Float = 0;
    
    public function new(p : PlayState, X : Int, Y : Int, dir : Float, sp : Float)
    {
        super(p, X, Y);

        parent = p;
        
        loadGraphic(Content.cParticle, true, 30, 30);
        
        animation.add("b", [8], 4, true);
        playDefaultAnimation();
        
        
        AngleToCartSpeed();
        
        nLife = Util.Random(100, 300) / 100;
    }

    override public function playDefaultAnimation() {
        animation.play("b", true);
    }
    
    override public function Reuse(X : Int, Y : Int, ?dir : Float = 0, ?sp : Float = 0) : Void
    {
        super.Reuse(X, Y, dir, sp);
        nLife = Util.Random(100, 300) / 100;
        nDirection = dir;
        nSpeed = sp;
        AngleToCartSpeed();
    }
    
    override public function update(elapsed : Float) : Void
    {
        velocity.x *= 0.99;
        
        nLife -= elapsed;
        if (nLife < 0)
        {
            kill();
            return;
        }
        
        var overtile : Int = -1;
        var fluid : Int = -1;
        
        if (parent != null && parent.level != null)
        {
            var xcheck : Int = Math.floor(this.x + 2 / 30);
            var ycheck : Int = Math.floor(this.y + 2 / 30);
            
            overtile = (parent.level.getTile(xcheck, ycheck) % Content.iFrontSheetWidth);
            
            if (overtile == Content.iWater || overtile == Content.iWaterGrass || overtile == Content.iWaterSpikes)
            {
                fluid = 2;
            }
            else if (overtile == Content.iShallow || overtile == Content.iShallowGrass || overtile == Content.iShallowSpikes)
            {
                fluid = 1;
            }
            else
            {
                fluid = 0;
            }
            
            if (fluid == 1 && this.y % 30 < 8)
            {
                this.y = this.y - (this.y % 30) + 8;
                velocity.y = 0;
            }
            else if (fluid == 0)
            {
                kill();
            }
        }
    }
}


