package mon;

import flash.geom.ColorTransform;
import flash.geom.Point;
import flixel.*;
import flixel.math.FlxRandom;

class Fish extends Monster
{
    public var nAngle : Float = 0;
    public var ptTargetVelocity : Point = new Point(0, 0);
    public var nSyncVelocitySpeed : Float = 200;
    
    
    public function new(p : PlayState, X : Float, Y : Float, colTrans : ColorTransform = null, speedmod : Float = 1)
    {
        super(p, "Fish", X, Y, colTrans, speedmod);
        
        bDiesInWater = false;
        
        //animation.add("run", [8, 9, 10, 11], 6, true);
        animation.add("d", [16, 17, 18, 19], 6, true);
        
        animation.play("d");
        
        bAcrophobic = false;
        
        //remVelocity.x = -30;
        
        width = 12;
        height = 22;
        offset.x = 39;
        offset.y = 38;
        
        rectVulnerable.x = -5;
        rectVulnerable.width = 22;
        
        //boundGraphic(90, 90, 8, 8);
        
        acceleration.y = 0;
        
        //bForceHit = false;
        
        var r : FlxRandom = new FlxRandom(x + (y * 2000));
        nAngle = r.integer(0, Math.PI * 200) / 100;
        
        this.health = 20;
    }
    
    override public function update(elapsed : Float) : Void
    {
        super.update(elapsed);
        acceleration.y = 0;
    }
    
    public var nChange : Float = Math.PI / 100;
    public var nChangeTimer : Float = 1;
    
    override public function UpdateMovement() : Void
    {
        nChangeTimer -= FlxG.elapsed;
        if (nChangeTimer < 0)
        {
            nChangeTimer += Util.Random(0, 500) / 100;
            nChange = ((Util.Random(0, 1) * 2) - 1) * Math.PI / 5;
        }
        
        nAngle += nChange * FlxG.elapsed;
        
        var bAirAbove : Bool = false;
        
        var thistile : Int = as3hx.Compat.parseInt(parent.level.getTile(as3hx.Compat.parseInt(this.x / 30), as3hx.Compat.parseInt((this.y) / 30)) % Content.iFrontSheetWidth);
        var bHereShallow : Bool = (thistile == Content.iShallow || thistile == Content.iShallowGrass || thistile == Content.iShallowSpikes);
        
        var abovetile : Int = as3hx.Compat.parseInt(parent.level.getTile(as3hx.Compat.parseInt(this.x / 30), as3hx.Compat.parseInt((this.y - 8) / 30)) % Content.iFrontSheetWidth);
        var bAboveNotShallow : Bool = !(abovetile == Content.iShallow || abovetile == Content.iShallowGrass || abovetile == Content.iShallowSpikes);
        
        
        
        
        if ((bHereShallow && bAboveNotShallow) ||
            isTouching(FLOOR) ||
            isTouching(CEILING) ||
            isTouching(LEFT) ||
            isTouching(RIGHT))
        {
            nAngle += nChange * FlxG.elapsed;
        }
        
        if (velocity.x < 0)
        {
            facing = Content.LEFT;
        }
        else if (velocity.x > 0)
        {
            facing = Content.RIGHT;
        }
        
        if (isTouching(RIGHT))
        {
            facing = Content.LEFT;
        }
        else if (isTouching(LEFT))
        {
            facing = Content.RIGHT;
        }
        
        var opp : Float = Math.sin(nAngle) * iRunSpeed;
        var adj : Float = Math.cos(nAngle) * iRunSpeed;
        
        this.ptTargetVelocity.x = adj;
        this.ptTargetVelocity.y = opp;
        
        if (velocity.x < ptTargetVelocity.x)
        {
            velocity.x += nSyncVelocitySpeed * FlxG.elapsed;
            
            if (velocity.x > ptTargetVelocity.x)
            {
                velocity.x = ptTargetVelocity.x;
            }
        }
        else if (velocity.x > ptTargetVelocity.x)
        {
            velocity.x -= nSyncVelocitySpeed * FlxG.elapsed;
            
            if (velocity.x < ptTargetVelocity.x)
            {
                velocity.x = ptTargetVelocity.x;
            }
        }
        
        if (velocity.y < ptTargetVelocity.y)
        {
            velocity.y += nSyncVelocitySpeed * FlxG.elapsed;
            
            if (velocity.y > ptTargetVelocity.y)
            {
                velocity.y = ptTargetVelocity.y;
            }
        }
        else if (velocity.y > ptTargetVelocity.y)
        {
            velocity.y -= nSyncVelocitySpeed * FlxG.elapsed;
            
            if (velocity.y < ptTargetVelocity.y)
            {
                velocity.y = ptTargetVelocity.y;
            }
        }
        
        
        if (bHereShallow && bAboveNotShallow && velocity.y < 0)
        {
            velocity.y = 1;
        }
    }
}

