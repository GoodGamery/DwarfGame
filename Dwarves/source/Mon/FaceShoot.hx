package mon;

import flash.geom.ColorTransform;
import flixel.*;

class FaceShoot extends Monster
{
    public var nSpitTime : Float = 2.0;
    public var nSpitTimer : Float = 2.0;
    
    public function new(p : PlayState, X : Float, Y : Float, colTrans : ColorTransform = null, speedmod : Float = 1)
    {
        super(p, "FaceShoot", X, Y, colTrans, speedmod);
        
        bAcrophobic = false;
        bWallBonk = false;
        bDiesInWater = false;
        bForceHit = false;
        
        bLevelCollision = false;
        bMonsterCollision = false;
        bOriginalLevelCollision = false;
        bOriginalMonsterCollision = false;
        
        
        animation.add("spit", [32, 33, 34, 35, 34, 33, 32], Math.floor(6 * speedmod), false);
        animation.add("d", [32], 6, true);
        
        animation.play("d");
        
        
        //remVelocity.x = -30;
        
        width = 12;
        height = 22;
        offset.x = 39;
        offset.y = 38;
        
        rectVulnerable.x = -5;
        rectVulnerable.width = 22;
        rectVulnerable.y = -5;
        
        //boundGraphic(90, 90, 8, 8);
        
        acceleration.y = 0;
        
        
        
        facing = Content.RIGHT;
        
        bFrontMonster = true;
        
        var r : FlxRandom = new FlxRandom(x + (y * 2000));
        nSpitTimer += r.integer(0, 200) / 100;
    }
    
    override public function update(elapsed : Float) : Void
    {
        if (bPaused || visible == false)
        {
            this.velocity.x = 0;
            this.velocity.y = 0;
            this.acceleration.x = 0;
            this.acceleration.y = 0;
            
            return;
        }
        
        //super.update(elapsed);
        UpdateArrowHits();
        acceleration.y = 0;
        
        if (this.GetCurrentAnim() == "d")
        {
            nSpitTimer -= FlxG.elapsed;
            
            if (nSpitTimer < 0)
            {
                this.play("spit");
            }
        }
        
        if (this.GetCurrentAnim() == "spit" && this.animation.frameIndex == 3 && nSpitTimer < 0)
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
            
            if (this.facing == Content.RIGHT)
            {
                toadd.facing = Content.RIGHT;
                toadd.x = this.x + 15;
                toadd.y = this.y + 8;
            }
            else if (this.facing == Content.LEFT)
            {
                toadd.facing = Content.LEFT;
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
        else if (this.GetCurrentAnim() == "spit" && this.animation.frameIndex == 6)
        {
            this.play("d");
        }
    }
    
    override public function DoesThisArrowHurtMe(arrow : Arrow, hhit : Int, vhit : Int) : Bool
    {
        return false;
    }
}

