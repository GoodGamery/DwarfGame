package mon;

import flash.geom.ColorTransform;
import flixel.*;

class FaceCrush extends Monster
{
    public var nSpitTime : Float = 2;
    public var nSpitTimer : Float = nSpitTime;
    
    public var xCEILING(default, never) : Int = 0;
    public var xFALLING(default, never) : Int = 1;
    public var xGROUND(default, never) : Int = 2;
    public var xRISING(default, never) : Int = 3;
    public var iState : Int = xCEILING;
    
    public function FaceShoot(p : PlayState, X : Float, Y : Float, colTrans : ColorTransform = null, speedmod : Float = 1)
    {
        super(p, "FaceShoot", X, Y, colTrans, speedmod);
        
        bAcrophobic = false;
        bWallBonk = false;
        bDiesInWater = false;
        bForceHit = false;
        
        bLevelCollision = true;
        bMonsterCollision = false;
        bOriginalLevelCollision = true;
        bOriginalMonsterCollision = false;
        
        addAnimation("d", [36], 6, true);
        
        play("d");
        
        
        //remVelocity.x = -30;
        
        width = 20;
        height = 30;
        offset.x = 35;
        offset.y = 30;
        
        
        //boundGraphic(90, 90, 8, 8);
        
        acceleration.y = 0;
        
        
        
        facing = RIGHT;
    }
    
    override public function update() : Void
    {
        if (bPaused || visible == false)
        {
            this.velocity.x = 0;
            this.velocity.y = 0;
            this.acceleration.x = 0;
            this.acceleration.y = 0;
            
            return;
        }
        
        if (iState == xCEILING)
        {
            acceleration.y = 0;
        }
        else if (iState == xFLOOR)
        {
            acceleration.y = 300;
        }
        
        if (this.GetCurrentAnim() == "d")
        {
            nSpitTimer -= FlxG.elapsed;
            
            if (nSpitTimer < 0)
            {
                this.play("spit");
            }
        }
        
        if (this.GetCurrentAnim() == "spit" && this.GetCurrentFrame() == 3 && nSpitTimer < 0)
        {
            nSpitTimer = nSpitTime;
            
            var toadd : Monster = null;
            
            var m : Int = 0;
            while (m < parent.arrayAllMonsters.length)
            {
                if ((try cast(parent.arrayAllMonsters[m], Monster) catch(e:Dynamic) null).visible == false &&
                    (try cast(parent.arrayAllMonsters[m], Monster) catch(e:Dynamic) null).strName == "FaceFire")
                {
                    toadd = try cast(parent.arrayAllMonsters[m], FaceFire) catch(e:Dynamic) null;
                    toadd.visible = true;
                    break;
                }
                m++;
            }
            
            if (toadd == null)
            {
                toadd = new FaceFire(this.parent, 0, 0, null, 
                        3);
                
                parent.arrayAllMonsters.push(toadd);
            }
            
            
            
            parent.arrayNearMonsters.push(toadd);
            parent.groupFrontMonsters.add(toadd);
            
            if (this.facing == RIGHT)
            {
                toadd.facing = RIGHT;
                toadd.x = this.x + 15;
                toadd.y = this.y + 8;
            }
            else if (this.facing == LEFT)
            {
                toadd.facing = LEFT;
                toadd.x = this.x - 5;
                toadd.y = this.y + 8;
            }
            
            
            toadd.Reuse();
            
            
            var nCloseness : Float = Util.Distance(this.x, this.y, parent.hero.x, parent.hero.y);
            nCloseness /= 30;
            nCloseness = 20 - nCloseness;
            
            if (nCloseness > 0)
            {
                nCloseness /= 10;
                FlxG.play(Content.soundSpit, Content.volumeSpit * nCloseness, false, false);
            }
        }
        else if (this.GetCurrentAnim() == "spit" && this.GetCurrentFrame() == 6)
        {
            this.play("d");
        }
    }
    
    override public function DoesThisArrowHurtMe(arrow : Arrow, hit : Int) : Bool
    {
        return false;
    }

    public function new()
    {
        super();
    }
}

