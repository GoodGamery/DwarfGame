package mon;

import flash.geom.ColorTransform;
import org.flixel.*;

class Hopper extends Monster
{
    public var nHopForce : Float = Content.nForceTwo  //0.4;  ;
    public var bMoveOnlyWhenJumping : Bool = false;
    public var bTurnWhenWalking : Bool = false;
    public var bTurnWhenFalling : Bool = false;
    public var bTurnToPlayerOnJump : Bool = true;
    public var nJumpSeconds : Float = 0.05;
    public var nNextJumpSeconds : Float = 0.05;
    public var nJumpVariance : Float = 1;
    public var nDetectHero : Float = 8 * 30;
    public var bFloorRecovered : Bool = true;
    
    public function new(p : PlayState, X : Float, Y : Float, colTrans : ColorTransform = null, speedmod : Float = 1)
    {
        super(p, "Hopper", X, Y, colTrans, speedmod);
        
        addAnimation("d", [48 + 0], 1, true);
        addAnimation("jump", [48 + 1], 1, true);
        
        
        play("d");
        
        bAcrophobic = false;
        
        //remVelocity.x = -30;
        
        width = 12;
        height = 22;
        offset.x = 39;
        offset.y = 38;
        
        rectVulnerable.x = -5;
        rectVulnerable.width = 22;
        
        //boundGraphic(90, 90, 8, 8);
        
        iRunSpeed = 50;
        this.health = 40;
    }
    
    override public function update() : Void
    {
        super.update();
    }
    
    override public function Struck(hhit : Int, vhit : Int, damage : Int) : Void
    {
        bFloorRecovered = false;
        
        super.Struck(hhit, vhit, damage);
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
        
        if (isTouching(FLOOR) || bOnMonster)
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
                velocity.y = -Content.nGrav * nHopForce;
                
                var nCloseness : Float = Util.Distance(this.x, this.y, parent.hero.x, parent.hero.y);
                nCloseness /= 30;
                nCloseness = 10 - nCloseness;
                
                if (nCloseness > 0)
                {
                    nCloseness /= 10;
                    FlxG.play(Content.soundCricket, Content.volumeCricket * nCloseness, false, false);
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
        
        if (bJumping && bTurnToPlayerOnJump)
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
        
        if (bMoveOnlyWhenJumping == true && isTouching(FLOOR))
        {
            this.velocity.x = 0;
        }
    }
}

