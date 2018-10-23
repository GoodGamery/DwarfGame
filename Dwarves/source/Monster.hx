import flash.geom.ColorTransform;
import flash.geom.Point;
import flash.geom.Rectangle;
import org.flixel.*;

class Monster extends FlxSprite
{
    public var parent : PlayState = null;
    public var bPaused : Bool = false;
    public var bAcrophobic : Bool = false;
    public var bWallBonk : Bool = true;
    public var bForceHit : Bool = true;
    public var bKillIfFar : Bool = false;
    public var bOriginalLevelCollision : Bool = true;
    public var bOriginalMonsterCollision : Bool = true;
    public var bLevelCollision : Bool = true;
    public var bHeroCollision : Bool = false;
    public var bMonsterCollision : Bool = true;
    public var bKeepRebouncing : Bool = false;
    public var bBlockade : Bool = false;
    public var bForceImmovable : Bool = false;
    public var bEatUpwardArrows : Bool = false;
    public var nLastX : Float = -9999999;
    public var nLastY : Float = -9999999;
    public var bFrontMonster : Bool = false;
    public var sBroom : FlxSprite = null;
    public var sBump : FlxSprite = null;
    public var iRunSpeed : Int = 30;
    public var bFriendly : Bool = false;
    public var nDamageDealt : Float = 20;
    public var groupStuck : FlxGroupXY = new FlxGroupXY();
    public var rectVulnerable : FlxRect;
    public var bDiesInWater : Bool = true;
    public var bDiesInSpikes : Bool = true;
    public var nRecoverySeconds : Float = 0.25;
    public var bOnMonster : Bool = false;
    public var nStruckPower : Float = 100;
    public var strID : String = "";
    public var bQuashed : Bool = false;
    public var strPrequashAnim : String = "";
    
    public function Quash(quash : Bool) : Void
    {
        bQuashed = quash;
        
        if (quash)
        {
            bLevelCollision = false;
            bMonsterCollision = false;
            strPrequashAnim = this.GetCurrentAnim();
            this.play("q");
        }
        else
        {
            bLevelCollision = bOriginalLevelCollision;
            bMonsterCollision = bOriginalMonsterCollision;
            this.play(strPrequashAnim);
        }
    }
    
    public function new(p : PlayState, name : String, X : Float, Y : Float, colTrans : ColorTransform = null, speedmod : Float = 1)
    {
        super(X, Y);
        
        strName = name;
        
        strID = strName + "|" + Std.string(x) + "|" + Std.string(y);
        
        _bPixelFix = false;
        parent = p;
        
        loadGraphic(Content.cMonsters, true, true, 90, 90, true);
        addAnimation("q", [2], 16, true);
        
        if (colTrans != null)
        {
            this._colorTransform = colTrans;
            this._defaultColorTransform = colTrans;
        }
        
        facing = LEFT;
        
        iRunSpeed *= as3hx.Compat.parseInt(speedmod);
        maxVelocity.x = 200;  //walking speed  
        maxVelocity.y = 800;
        //velocity.x = 300;
        //acceleration.x = 200;
        acceleration.y = 420;  //gravity  
        //drag.x = maxVelocity.x * 300;		//deceleration (sliding to a stop)
        
        
        //tweak the bounding box for better feel
        width = 30;
        height = 30;
        offset.x = 30;
        offset.y = 30;
        
        rectVulnerable = new FlxRect(0, 0, width, height);
        
        addAnimation("ph", [0], 1, false);
        addAnimation("ph2", [1], 1, false);
        
        sBroom = new FlxSprite(X + (width / 2), Y + (height / 2));
        sBroom.width = 1;
        sBroom.height = 1;
        
        sBump = new FlxSprite(X + (width / 2), Y + (height / 2));
        sBump.width = 1;
        sBump.height = 1;
        
        cast((true), Pause);
        
        this._cFlickerColor = 0xFFFFFFFF;
        this.health = 20;
    }
    
    public var remVelocity : FlxPoint = new FlxPoint(0, 0);
    public var remAcceleration : FlxPoint = new FlxPoint(0, 0);
    public var bOncePaused : Bool = false;
    public function Pause(pause : Bool) : Void
    {
        bPaused = pause;
        
        if (pause)
        
        { //play("ph");
            
            
            remVelocity.x = this.velocity.x;
            remVelocity.y = this.velocity.y;
            remAcceleration.x = this.acceleration.x;
            remAcceleration.y = this.acceleration.y;
            
            this.velocity.x = 0;
            this.velocity.y = 0;
            this.acceleration.x = 0;
            this.acceleration.y = 0;
            
            bOncePaused = true;
        }
        //play("ph2");
        else
        {
            
            
            if (bOncePaused)
            {
                this.velocity.x = remVelocity.x;
                this.velocity.y = remVelocity.y;
                this.acceleration.x = remAcceleration.x;
                this.acceleration.y = remAcceleration.y;
            }
        }
    }
    
    public function Reuse() : Void
    {
    }
    
    override public function update() : Void
    {
        if (bPaused || visible == false || doomed == true || bQuashed == true)
        {
            this.velocity.x = 0;
            this.velocity.y = 0;
            this.acceleration.x = 0;
            this.acceleration.y = 0;
            
            if (nLastX != -9999999 && nLastY != -9999999)
            {
                x = nLastX;
                y = nLastY;
            }
        }
        else
        {
            if (this.flickering == false)
            {
                UpdateMovement();
            }
            
            if (bWallBonk)
            {
                UpdateWallBonk();
            }
            
            if (bAcrophobic && this.flickering == false)
            {
                UpdateAcrophobia();
            }
            
            if (bFriendly == false)
            {
                UpdateArrowHits();
                UpdatePlayerHits();
            }
            
            if (bDiesInWater)
            {
                if (IsInWater())
                {
                    Slay();
                }
            }
            
            if (bDiesInSpikes)
            {
                if (IsInSpikes())
                {
                    Slay();
                }
            }
            
            if (bForceImmovable)
            {
                if (nLastX != -9999999 && nLastY != -9999999)
                {
                    x = nLastX;
                    y = nLastY;
                }
            }
        }
        
        nLastX = x;
        nLastY = y;
    }
    
    public function Slay() : Void
    {
        this.doomed = true;
        parent.CauseExplosion(5, this.x, this.y, 0);
        
        if (parent.nElapsedInZone > 1)
        {
            var nCloseness : Float = Util.Distance(this.x, this.y, parent.hero.x, parent.hero.y);
            nCloseness /= 30;
            nCloseness = 20 - nCloseness;
            
            if (nCloseness > 0)
            {
                nCloseness /= 10;
                FlxG.play(Content.soundDefeated, Content.volumeDefeated * nCloseness, false, false, Content.nDefaultSkip);
            }
        }
    }
    
    public function IsInWater() : Bool
    {
        var bReallyInWater : Bool = false;
        
        if (parent != null && parent.level != null)
        
        /*
				var xcheck:int = int(this.x + (this.width / 2)) / 30;
				var ycheck:int = int(this.y + (this.height / 2)) / 30;
				
				var overtile:int = parent.level.getTile(xcheck, ycheck) % Content.iFrontSheetWidth;
				var below:int = parent.level.getTile(xcheck, ycheck + 1) % Content.iFrontSheetWidth;
				var fluid:int = 0;
	
				if (overtile == Content.iWater || overtile == Content.iWaterGrass || overtile == Content.iWaterSpikes)
					fluid = 2;
				else if (overtile == Content.iShallow || overtile == Content.iShallowGrass || overtile == Content.iShallowSpikes)
					fluid = 1;
				else
					fluid = 0;*/{
            
            
            var really : Int = as3hx.Compat.parseInt(parent.level.getTile(as3hx.Compat.parseInt(this.x / 30), as3hx.Compat.parseInt(this.y / 30)) % Content.iFrontSheetWidth);
            bReallyInWater = (really == Content.iWater || really == Content.iWaterGrass || really == Content.iWaterSpikes ||
                    really == Content.iShallow || really == Content.iShallowGrass || really == Content.iShallowSpikes);
        }
        
        return bReallyInWater;
    }
    
    public function IsInSpikes() : Bool
    {
        var bReallyInSpikes : Bool = false;
        
        if (parent != null && parent.level != null)
        {
            var really : Int = as3hx.Compat.parseInt(parent.level.getTile(as3hx.Compat.parseInt(this.x / 30), as3hx.Compat.parseInt(this.y / 30)) % Content.iFrontSheetWidth);
            bReallyInSpikes = (really == Content.iSpikes || really == Content.iWaterSpikes || really == Content.iShallowSpikes);
        }
        
        return bReallyInSpikes;
    }
    
    
    
    public function UpdateArrowHits() : Void
    {
        if (bPaused == false && bQuashed == false)
        {
            var vhit : Int = -1;
            var hhit : Int = -1;
            
            var a : Int = 0;
            while (a < parent.arrayArrows.length)
            {
                var thisarrow : Arrow = (try cast(parent.arrayArrows[a], Arrow) catch(e:Dynamic) null);
                
                if (rectVulnerable.offsetOverlaps(this.x, this.y, 
                            (try cast(parent.arrayArrows[a], Arrow) catch(e:Dynamic) null).rectEffective, 
                            (try cast(parent.arrayArrows[a], Arrow) catch(e:Dynamic) null).x, 
                            (try cast(parent.arrayArrows[a], Arrow) catch(e:Dynamic) null).y
                ))
                
                { // ((parent.arrayArrows[a] as Arrow).iBounceLife < Content.iArrowRebounce ||  // Not spinning (or spinning and allowed to rebounce)
                    
                    //	(bKeepRebouncing && (parent.arrayArrows[a] as Arrow).iBounceLife < Content.iQuickRebounce)))
                    
                    if ((try cast(parent.arrayArrows[a], Arrow) catch(e:Dynamic) null).iAlive > 0 &&  // Not in twang/dead state, AND  
                        (try cast(parent.arrayArrows[a], Arrow) catch(e:Dynamic) null).iBounceLife == -1)
                    
                    { // never bounced
                        
                        {
                            if ((try cast(parent.arrayArrows[a], Arrow) catch(e:Dynamic) null).velocity.y > 0)
                            {
                                vhit = Content.DOWN;
                            }
                            else if ((try cast(parent.arrayArrows[a], Arrow) catch(e:Dynamic) null).velocity.y < 0)
                            {
                                vhit = Content.UP;
                            }
                            
                            if ((try cast(parent.arrayArrows[a], Arrow) catch(e:Dynamic) null).velocity.x > 0)
                            {
                                hhit = Content.RIGHT;
                            }
                            else if ((try cast(parent.arrayArrows[a], Arrow) catch(e:Dynamic) null).velocity.x < 0)
                            {
                                hhit = Content.LEFT;
                            }
                            
                            
                            if (DoesThisArrowHurtMe(try cast(parent.arrayArrows[a], Arrow) catch(e:Dynamic) null, vhit, hhit))
                            {
                                parent.groupArrows.remove(parent.arrayArrows[a]);
                                parent.arrayArrows.splice(a, 1);
                                a--;
                            }
                            else
                            {
                                (try cast(parent.arrayArrows[a], Arrow) catch(e:Dynamic) null).Bounce(hhit, vhit);
                                
                                // Make it so it doesn't call 'struck'
                                vhit = -1;
                                hhit = -1;
                            }
                        }
                    }
                    else if ((try cast(parent.arrayArrows[a], Arrow) catch(e:Dynamic) null).iAlive > 0 &&
                        (try cast(parent.arrayArrows[a], Arrow) catch(e:Dynamic) null).iBounceLife < Content.iQuickRebounce)
                    {
                        if ((try cast(parent.arrayArrows[a], Arrow) catch(e:Dynamic) null).velocity.x > 0)
                        
                        { // right
                            
                            {
                                if (thisarrow.x + 7 < this.x + rectVulnerable.x + 5)
                                
                                { // Hitting left face
                                    
                                    hhit = Content.RIGHT;
                                }
                                // bonk!
                                else
                                {
                                    
                                    hhit = Content.LEFT;
                                }
                            }
                        }
                        else if ((try cast(parent.arrayArrows[a], Arrow) catch(e:Dynamic) null).velocity.x < 0)
                        
                        { // left
                            
                            {
                                if (thisarrow.x + 7 > this.x + rectVulnerable.x + rectVulnerable.width - 5)
                                
                                { // Hitting right face
                                    
                                    hhit = Content.LEFT;
                                }
                                // bonk!
                                else
                                {
                                    
                                    hhit = Content.RIGHT;
                                }
                            }
                        }
                        
                        if ((try cast(parent.arrayArrows[a], Arrow) catch(e:Dynamic) null).velocity.y > 0)
                        
                        { // down
                            
                            {
                                if (thisarrow.y + 7 < this.y + rectVulnerable.y + 5)
                                
                                { // Hitting top face
                                    
                                    vhit = Content.DOWN;
                                }
                                // bonk!
                                else
                                {
                                    
                                    vhit = Content.UP;
                                }
                            }
                        }
                        else if ((try cast(parent.arrayArrows[a], Arrow) catch(e:Dynamic) null).velocity.y < 0)
                        
                        { // up
                            
                            {
                                if (thisarrow.y + 7 > this.y + rectVulnerable.y + rectVulnerable.height - 5)
                                
                                { // Hitting bottom face
                                    
                                    vhit = Content.UP;
                                }
                                // bonk!
                                else
                                {
                                    
                                    vhit = Content.DOWN;
                                }
                            }
                        }
                        
                        var str_hhit : String = "hhit = -1";
                        
                        if (hhit == Content.LEFT)
                        {
                            str_hhit = "hhit = LEFT";
                        }
                        else if (hhit == Content.RIGHT)
                        {
                            str_hhit = "hhit = RIGHT";
                        }
                        
                        var str_vhit : String = "vhit = -1";
                        
                        if (vhit == Content.UP)
                        {
                            str_vhit = "vhit = UP";
                        }
                        else if (vhit == Content.DOWN)
                        {
                            str_vhit = "vhit = DOWN";
                        }
                        
                        trace("Bounce! " + str_hhit + " " + str_vhit);
                        
                        (try cast(parent.arrayArrows[a], Arrow) catch(e:Dynamic) null).Bounce(hhit, vhit);
                        
                        // Make it so it doesn't call 'struck'
                        vhit = -1;
                        hhit = -1;
                    }
                }
                a++;
            }
            
            if (vhit != -1 || hhit != -1)
            {
                Struck(hhit, vhit, Content.stats.nDamageDealt);
                
                if (this.doomed == false)
                {
                    FlxG.play(Content.soundOffended, Content.volumeOffended, false, false, Content.nDefaultSkip);
                }
            }
        }
    }
    
    public function DoesThisArrowHurtMe(arrow : Arrow, hhit : Int, vhit : Int) : Bool
    {
        return true;
    }
    
    public function HitDeadArrow(arrow : Arrow) : Bool
    {
        return false;
    }
    
    public function ForceStruck(hhit : Int, vhit : Int) : Void
    {
        if (bForceHit)
        {
            if (vhit == Content.UP)
            {
                velocity.y -= nStruckPower;
            }
            else if (vhit == Content.DOWN)
            {
                velocity.y += nStruckPower;
            }
        }
        
        if (bForceHit)
        {
            if (hhit == Content.LEFT)
            {
                velocity.x -= nStruckPower;
            }
            else if (hhit == Content.RIGHT)
            {
                velocity.x += nStruckPower;
            }
        }
    }
    
    public function Struck(hhit : Int, vhit : Int, damage : Int) : Void
    {
        ForceStruck(hhit, vhit);
        
        this.flicker(nRecoverySeconds);
        
        this.health -= Content.stats.nDamageDealt;
        
        //trace(this.health.toString() + " health left");
        
        
        if (this.health <= 0)
        {
            Slay();
        }
    }
    
    public function UpdatePlayerHits() : Void
    {
        this.y += 2;
        this.height -= 2;  // haircut to avoid diagonal through-block hits  
        
        
        if (this.visible &&
            this.overlaps(parent.hero) &&
            parent.hero.flickering == false &&
            parent.state != Content.LEAVING &&
            parent.state != Content.DEAD &&
            parent.hero.GetCurrentAnim() != "leaving" &&
            parent.hero.GetCurrentAnim() != "arriving")
        {
            parent.hero.Hit(nDamageDealt, this.x + (this.width / 2));
        }
        
        this.y -= 2;
        this.height += 2;
    }
    
    
    
    public var speedrecover : Int = 5;
    public function UpdateMovement() : Void
    {
        if (isTouching(FLOOR))
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
    
    public function UpdateWallBonk() : Void
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
    
    public function UpdateAcrophobia() : Void
    {
        if (isTouching(FLOOR))
        {
            if (facing == LEFT)
            {
                sBroom.x = this.x - 4;
            }
            else if (facing == RIGHT)
            {
                sBroom.x = this.x + this.width - 1 + 4;
            }
            
            sBroom.y = this.y + height + 2;
            
            if (sBroom.overlaps(parent.level))
            {
            }
            else if (facing == LEFT)
            {
                facing = RIGHT;
            }
            else if (facing == RIGHT)
            {
                facing = LEFT;
            }
        }
    }
}
