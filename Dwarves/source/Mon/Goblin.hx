package mon;

import flash.geom.ColorTransform;
import flixel.*;

class Goblin extends Monster
{
    public var nHopForce : Float = Content.nForceTwo;  //0.4;
    public var bMoveOnlyWhenJumping : Bool = false;
    public var bTurnWhenWalking : Bool = false;
    public var bTurnWhenFalling : Bool = false;
    public var bTurnToPlayerOnJump : Bool = true;
    public var nJumpSeconds : Float = 0.2;
    public var nNextJumpSeconds : Float = 0.05;
    public var nJumpVariance : Float = 1.5;
    public var nDetectHero : Float = 10 * 30;
    public var bFloorRecovered : Bool = true;
    
    public var nImpatience : Float = 0;
    public var iRetreatStrat : Int = 0;
    public var iRetreatDistance : Int = 0;
    public var nWander : Float = 0;
    
    public function new(p : PlayState, X : Float, Y : Float, colTrans : ColorTransform = null, speedmod : Float = 1)
    {
        super(p, "Goblin", X, Y, colTrans, speedmod);
        
        animation.add("d", [50 + 0, 50 + 1, 50 + 0, 50 + 2], 16, true);
        animation.add("jump", [50 + 2], 11, true);
        
        
        
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
        
        bDiesInWater = false;
        bDiesInSpikes = true;
        iRunSpeed = 80;
        this.health = 100;
        nDamageDealt = 1000;
        
        this._cFlickerColor = 0x00FFFFFF;
    }
    
    override public function update() : Void
    {
        super.update();
    }
    
    override public function DoesThisArrowHurtMe(arrow : Arrow, hhit : Int, vhit : Int) : Bool
    {
        ForceStruck(vhit, hhit);
        
        this.flicker(nRecoverySeconds);
        
        return false;
    }
    
    override public function Struck(hhit : Int, vhit : Int, damage : Int) : Void
    {
    }
    
    override public function UpdateWallBonk() : Void
    {
        if ((velocity.y > 0 && bTurnWhenFalling) ||
            (bTurnWhenWalking && isTouching(FLOOR)))
        {
            if (facing == LEFT && isTouching(LEFT))
            {
                velocity.x = iRunSpeed;
                facing = RIGHT;
            }
            else if (facing == RIGHT && isTouching(RIGHT))
            {
                velocity.x = -iRunSpeed;
                facing = LEFT;
            }
        }
    }
    
    
    
    public var nJumpTimer : Float = 0;
    override public function UpdateMovement() : Void
    {
        var bJumping : Bool = false;
        
        if (iRetreatStrat == 0)
        {
            if (isTouching(FLOOR))
            {
                if (isTouching(RIGHT))
                {
                    nImpatience += FlxG.elapsed;
                }
                
                if (isTouching(LEFT))
                {
                    nImpatience -= FlxG.elapsed;
                }
                
                if (nImpatience > 1)
                {
                    iRetreatStrat = -1;
                    iRetreatDistance = Util.Random(33, 53);
                }
                else if (nImpatience < -1)
                {
                    iRetreatStrat = 1;
                    iRetreatDistance = 33;
                    if (Util.Random(0, 1) == 0)
                    {
                        iRetreatDistance = 63;
                    }
                }
            }
        }
        
        if (Util.Random(0, 1000) == 0)
        {
            iRetreatStrat = Math.floor((Util.Random(0, 1) * 2) - 1);
            iRetreatDistance = Util.Random(63, 200);
        }
        
        if (iRetreatStrat < 0)
        {
            facing = LEFT;
            iRetreatStrat -= Math.floor(iRunSpeed * FlxG.elapsed);
        }
        else if (iRetreatStrat > 0)
        {
            facing = RIGHT;
            iRetreatStrat += Math.floor(iRunSpeed * FlxG.elapsed);
        }
        
        if (Math.abs(iRetreatStrat) > iRetreatDistance)
        {
            nJumpTimer = 1000;
            nImpatience = 0;
            iRetreatStrat = 0;
            nWander = Util.Random(1, 6);
        }
        
        nWander -= FlxG.elapsed;
        if (nWander < 0)
        {
            nWander = 0;
        }
        
        if (iRetreatStrat == 0)
        {
            if (isTouching(FLOOR) ||
                (this.y > parent.hero.y && (isTouching(LEFT) || isTouching(RIGHT))))
            {
                bFloorRecovered = true;
                
                nJumpTimer += 1;
                if (nJumpTimer >= nNextJumpSeconds * 60)
                {
                    nJumpTimer = 0;
                    bJumping = true;
                    
                    nNextJumpSeconds = nJumpSeconds * (1 + (((Util.Random(0, 100) / 100) - 0.5) * nJumpVariance));
                }
                
                if (bJumping)
                {
                    var force : Float = nHopForce;
                    var r : Int = Util.Random(0, 2);
                    
                    if (r == 1)
                    {
                        force = Content.nForceThree;
                    }
                    else if (r == 2)
                    {
                        force = Content.nForceOne;
                    }
                    
                    velocity.y = -Content.nGrav * force;
                    
                    var nCloseness : Float = Util.Distance(this.x, this.y, parent.hero.x, parent.hero.y);
                    nCloseness /= 30;
                    nCloseness = 10 - nCloseness;
                    
                    if (nCloseness > 0)
                    {
                        nCloseness /= 10;
                        FlxG.play(Content.soundGoblin, Content.volumeGoblin * nCloseness, false, false);
                    }
                }
            }
            
            if (this.velocity.y < 0)
            {
                this.play("jump");
            }
            else
            {
                this.play("d");
            }
            
            if (bJumping && bTurnToPlayerOnJump && nWander <= 0)
            {
                if (Util.Distance(parent.hero.x, parent.hero.y, x, y) <= nDetectHero)
                {
                    if (parent.hero.x < x)
                    {
                        facing = LEFT;
                    }
                    else
                    {
                        facing = RIGHT;
                    }
                }
            }
            
            if (bMoveOnlyWhenJumping == true && isTouching(FLOOR))
            {
                this.velocity.x = 0;
            }
        }
        else if (this.velocity.y < 0)
        {
            this.play("jump");
        }
        else
        {
            this.play("sit");
        }
        
        if (bMoveOnlyWhenJumping == false ||
            (bMoveOnlyWhenJumping == true && !isTouching(FLOOR)))
        {
            if (bFloorRecovered)
            {
                if (facing == LEFT)
                {
                    if (this.velocity.x < -iRunSpeed)
                    {
                        this.velocity.x += speedrecover;
                    }
                    else
                    {
                        this.velocity.x = -iRunSpeed;
                    }
                }
                else if (facing == RIGHT)
                {
                    if (this.velocity.x > iRunSpeed)
                    {
                        this.velocity.x -= speedrecover;
                    }
                    else
                    {
                        this.velocity.x = iRunSpeed;
                    }
                }
            }
        }
    }
}

