package mon;

import flash.geom.ColorTransform;
import flash.geom.Point;
import flixel.*;

class Bat extends Monster
{
    public var nAngle : Float = 0;
    public var ptTargetVelocity : Point = new Point(0, 0);
    public var nSyncVelocitySpeed : Float = 500;
    public var nVertFaster : Float = 4;
    public var nDetectHero : Float = 4 * 30;
    public var nHuntPull : Float = 90;
    
    
    public function new(p : PlayState, X : Float, Y : Float, colTrans : ColorTransform = null, speedmod : Float = 1)
    {
        super(p, "Bat", X, Y, colTrans, speedmod);
        
        addAnimation("d", [44, 45, 46, 47], 9, true);
        
        
        play("d");
        
        bAcrophobic = false;
        
        //remVelocity.x = -30;
        
        width = 22;
        height = 14;
        offset.x = 36;
        offset.y = 40;
        
        
        //boundGraphic(90, 90, 8, 8);
        
        acceleration.y = 0;
        
        //bForceHit = false;
        
        var r : Rndm = new Rndm(x + (y * 2000));
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
            if (Util.Distance(parent.hero.x, parent.hero.y, x, y) <= nDetectHero)
            {
                nChangeTimer += Util.Random(0, 500) / 100;
                nChange = ((Util.Random(0, 1) * 2) - 1) * Math.PI / 5;
            }
            else
            {
                nChangeTimer += 0.2;
                nChange = Math.PI;
            }
        }
        
        nAngle += nChange * FlxG.elapsed;
        
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
        
        if (Util.Distance(parent.hero.x, parent.hero.y, x, y) <= nDetectHero)
        {
            this.ptTargetVelocity.y *= nVertFaster;
            
            if (parent.hero.x < x)
            {
                this.ptTargetVelocity.x -= nHuntPull;
            }
            else if (parent.hero.x > x)
            {
                this.ptTargetVelocity.x += nHuntPull;
            }
            
            if (parent.hero.y < y)
            {
                this.ptTargetVelocity.y -= nHuntPull;
            }
            else if (parent.hero.y - 20 > y)
            {
                this.ptTargetVelocity.y += nHuntPull;
            }
        }
        
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
    }
}

