package mon;

import flash.geom.ColorTransform;
import flixel.*;

class LittleSlab extends Monster
{
    public var nBopHeight : Float = 0;
    
    public function new(p : PlayState, X : Float, Y : Float, colTrans : ColorTransform = null, speedmod : Float = 1)
    {
        super(p, "LittleSlab", X, Y, colTrans, speedmod);
        
        animation.add("d", [14, 15], 4, true);
        animation.play("d");
        
        bAcrophobic = true;
        
        //remVelocity.x = -30;
        
        width = 12;
        height = 22;
        offset.x = 39;
        offset.y = 38;
        
        rectVulnerable.x = -5;
        rectVulnerable.width = 22;
        
        //boundGraphic(90, 90, 8, 8);
        
        this.health = 50;
    }
    
    override public function update(elapsed : Float) : Void
    {
        super.update(elapsed);
    }
    
    override public function Struck(hhit : Int, vhit : Int, damage : Int) : Void
    {
        super.Struck(hhit, vhit, Content.stats.nDamageDealt);
    }
}

