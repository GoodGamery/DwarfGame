package mon;

import flash.geom.ColorTransform;
import flixel.*;

class Shroom extends Monster
{
    public var nBopHeight : Float = 0;
    
    public function new(p : PlayState, X : Float, Y : Float, colTrans : ColorTransform = null, speedmod : Float = 1)
    {
        super(p, "Shroom", X, Y, colTrans, speedmod);
        
        animation.add("d", [8, 9, 10, 11], 6, true);
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
        
        nBopHeight = 0.4;
    }
    
    override public function update() : Void
    {
        super.update();
    }
    
    override public function Struck(hhit : Int, vhit : Int, damage : Int) : Void
    {
        super.Struck(hhit, vhit, Content.stats.nDamageDealt);
        
        velocity.y = -Content.nGrav * nBopHeight;
    }
}

