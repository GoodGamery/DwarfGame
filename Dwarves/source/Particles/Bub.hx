package particles;

import flixel.*;

class Bub extends FlxSprite
{
    public var nDirection : Float = 0;
    public var nSpeed : Float = 0;
    public var parent : PlayState = null;
    public var nLife : Float = 0;
    
    public function new(p : PlayState, X : Int, Y : Int, dir : Float, sp : Float)
    {
        parent = p;
        
        super(30, 30);
        loadGraphic(Content.cParticle, true, true, 30, 30);
        
        strName = "Bub";
        
        addAnimation("b", [8], 4, true);
        play("b");
        
        this.x = X;
        this.y = Y;
        nDirection = dir;
        nSpeed = sp;
        
        AngleToCartSpeed();
        
        nLife = Util.Random(100, 300) / 100;
        
        update();
    }
    
    public function Reuse(X : Int, Y : Int, dir : Float, sp : Float) : Void
    {
        nLife = Util.Random(100, 300) / 100;
        visible = true;
        this.x = X;
        this.y = Y;
        nDirection = dir;
        nSpeed = sp;
        play("b", true);
        AngleToCartSpeed();
    }
    
    public function AngleToCartSpeed() : Void
    {
        var rads : Float = nDirection * (Math.PI / 180);
        velocity.x = nSpeed * Math.cos(rads);
        velocity.y = nSpeed * Math.sin(rads);
    }
    
    override public function update() : Void
    {
        if (visible)
        {
            velocity.x *= 0.99;
            
            nLife -= FlxG.elapsed;
            if (nLife < 0)
            {
                this.visible = false;
                return;
            }
            
            var overtile : Int = -1;
            var fluid : Int = -1;
            
            if (parent != null && parent.level != null)
            {
                var xcheck : Int = as3hx.Compat.parseInt(this.x + 2 / 30);
                var ycheck : Int = as3hx.Compat.parseInt(this.y + 2 / 30);
                
                overtile = as3hx.Compat.parseInt(parent.level.getTile(xcheck, ycheck) % Content.iFrontSheetWidth);
                
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
                    this.visible = false;
                }
            }
        }
    }
}


