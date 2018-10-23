import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import flixel.*;
import particles.Splash;
import hud.Grunt;

class Player extends FlxSprite
{
    public var bow : FlxSprite = null;
    public var parent : PlayState = null;
    public var text : FlxText = null;
    
    public var nBubbliness : Float = 0;
    public var bBearings : Bool = false;
    
    public var bWasWindJump : Bool = false;
    
    public var nWaterBoostLateral : Float = 1;
    public var nWaterBoostVertical : Float = 1;
    
    public var nWaterBoostLateralCap : Float = 2;
    public var nWaterBoostVerticalCap : Float = 2;
    
    public var nWaterBoostLateralSpurt : Float = 0.75;
    public var nWaterBoostVerticalSpurt : Float = 0.75;
    
    public var nWaterBoostLateralDecay : Float = (nWaterBoostLateralCap - 1) * (1 / (0.5));  // 3 seconds  
    public var nWaterBoostVerticalDecay : Float = (nWaterBoostVerticalCap - 1) * (1 / (0.5));  // 3 seconds  
    
    
    public function new(p : PlayState, X : Float, Y : Float, spriteBow : FlxSprite)
    {
        parent = p;
        
        super(X, Y);
        
        loadGraphic(Content.cHero, true, true, 100, 100);
        
        bow = spriteBow;
        
        facing = LEFT;
        
        if (Content.stats.bWaterBoost == false)
        {  //nWaterBoostVerticalDecay = (10 - 1) * (1 / (0.5)); // 0.5 seconds  
            
        }
        
        maxVelocity.x = 150;  //walking speed  
        maxVelocity.y = 800;
        //velocity.x = 300;
        //acceleration.x = 200;
        acceleration.y = Content.nGrav;  //gravity  
        drag.x = maxVelocity.x * 300;  //deceleration (sliding to a stop)  
        
        
        //tweak the bounding box for better feel
        width = Content.herohitwidth;
        height = Content.herohitheight;
        offset.x = Content.herohitoffsetx;
        offset.y = Content.herohitoffsety;
        
        bow.width = Content.herohitwidth;
        bow.height = Content.herohitheight;
        bow.offset.x = Content.herohitoffsetx;
        bow.offset.y = Content.herohitoffsety;
        
        addAnimation("stand", [0], 1, false);
        addAnimation("standup", [18], 1, false);
        addAnimation("standdn", [36], 1, false);
        
        addAnimation("run", [9, 10, 11, 12, 13, 14, 15, 16], 14, true);
        addAnimation("runup", [27, 28, 29, 30, 31, 32, 33, 34], 14, true);
        addAnimation("rundn", [45, 46, 47, 48, 49, 50, 51, 52], 14, true);
        
        addAnimation("jump", [55], 1, false);
        addAnimation("jumpup", [57], 1, false);
        addAnimation("jumpdn", [59], 1, false);
        
        addAnimation("fall", [56], 1, false);
        addAnimation("fallup", [58], 1, false);
        addAnimation("falldn", [60], 1, false);
        
        addAnimation("struck", [54], 1, false);
        
        addAnimation("swim", [1, 2, 3, 4, 5, 4, 3, 2], 8, true);
        addAnimation("fswim", [1, 2, 3, 4, 5, 4, 3, 2], 18, true);
        addAnimation("fswimup", [19, 20, 21, 22, 23, 22, 21, 20], 18, true);
        addAnimation("fswimdn", [37, 38, 39, 40, 41, 40, 39, 38], 18, true);
        
        addAnimation("leaving", [72, 73, 74, 75, 76, 77, 78, 79, 80, 80, 80, 80, 80, 80, 80], 10, false);
        addAnimation("arriving", [81, 82, 83, 84, 85, 86, 87, 88, 88], 10, false);
        
        //addAnimation("crouch", [22, 22], 3, true);
        
        play("arriving");
    }
    
    public var nRecoverySeconds(default, never) : Float = 2;
    public var iOuchPower(default, never) : Int = 200;
    public function Hit(iDamage : Int, iCulpritMidpointX : Int) : Void
    {
        trace("Hit for " + Std.string(iDamage) + " dmg");
        Content.stats.iHealth -= iDamage;
        parent.hud.UpdateHearts();
        
        
        this.flicker(nRecoverySeconds);
        bow.flicker(nRecoverySeconds);
        acceleration.x = 0;
        
        if (fluid == 0)
        {
            velocity.y = -Content.nGrav * 0.25;
        }
        
        if (this.x + (this.width / 2) > iCulpritMidpointX)
        {
            if (this.velocity.x < iOuchPower)
            {
                this.velocity.x = iOuchPower;
            }
            
            this.facing = LEFT;
        }
        else
        {
            if (this.velocity.x > -iOuchPower)
            {
                this.velocity.x = -iOuchPower;
            }
            
            this.facing = RIGHT;
        }
        
        play("struck");
        
        if (Content.stats.iHealth <= 0)
        {
            parent.state = Content.DEAD;
            parent.iDeadState = Content.JUSTDIED;
        }
        else
        {
            FlxG.play(Content.soundHurt, Content.volumeHurt, false, false);
        }
    }
    
    public var bJumpRecharged : Bool = true;
    public var bSpurtRecharged : Bool = true;
    public var bJumpCanBeCut : Bool = false;
    public var nShootRecharged : Float = 1;
    public var nShootRechargeSpeed : Float = 0.025;  //0.05;// 0.1;  
    public var bShock : Bool = false;
    public var overtile : Int = -1;
    public var iLastOvertile : Int = -1;
    public var fluid : Int = -1;
    public var iLastFluid : Int = -1;
    public var bDiveButton : Bool = false;
    public var bJumpButton : Bool = false;
    public var bShootButton : Bool = false;
    public var bTossButton : Bool = false;
    public var bUpButton : Bool = false;
    public var bDownButton : Bool = false;
    public var bLeftButton : Bool = false;
    public var bRightButton : Bool = false;
    public var bShooting : Bool = false;
    public var bSwimSound : Bool = false;
    override public function update() : Void
    {
        bSwimSound = false;
        
        this._bDangerFlicker = false;
        bow._bDangerFlicker = false;
        
        if (parent.state == Content.LEAVING || parent.state == Content.DEAD)
        {
            return;
        }
        
        if (Content.stats.iHealth <= Content.stats.iMaxHealth / 3 &&
            parent.hero.GetCurrentAnim() != "leaving" &&
            parent.hero.GetCurrentAnim() != "arriving")
        {
            this._bDangerFlicker = true;
            bow._bDangerFlicker = true;
        }
        
        bDiveButton = FlxG.keys.pressed("DOWN");
        bJumpButton = FlxG.keys.pressed("X") || FlxG.keys.pressed("SPACE");
        bShootButton = FlxG.keys.pressed("Z") || FlxG.keys.pressed("B");
        bTossButton = FlxG.keys.pressed("A") || FlxG.keys.pressed("B");
        bUpButton = FlxG.keys.pressed("UP");
        bDownButton = FlxG.keys.pressed("DOWN");
        bLeftButton = FlxG.keys.pressed("LEFT");
        bRightButton = FlxG.keys.pressed("RIGHT");
        bShooting = false;
        
        if (bShootButton && nShootRecharged == 1)
        {
            bShooting = true;
        }
        
        if (!bDiveButton && !bJumpButton && !bShootButton && !bTossButton && !bUpButton && !bDownButton &&
            this.GetCurrentAnim() == "arriving")
        {
            parent.spotlight.visible = false;
            
            if (this.GetCurrentFrame() == 8)
            {
                this.play("stand");
            }
            
            return;
        }
        
        bow.visible = true;
        
        nBubbliness -= 0.005;
        if (nBubbliness < 0)
        {
            nBubbliness = 0;
        }
        
        var strQual : String = "";
        
        if (bUpButton)
        {
            strQual = "up";
        }
        else if (bDownButton)
        {
            strQual = "dn";
        }
        
        //parent.debugtext.text = (this.y % 30).toString();
        
        var bReallyInWater : Bool = false;
        
        iLastFluid = fluid;
        iLastOvertile = overtile;
        if (parent != null && parent.level != null)
        {
            var xcheck : Int = as3hx.Compat.parseInt(this.x + (this.width / 2) / 30);
            var ycheck : Int = as3hx.Compat.parseInt(this.y + (this.height / 2) / 30);
            
            overtile = as3hx.Compat.parseInt(parent.level.getTile(xcheck, ycheck) % Content.iFrontSheetWidth);
            var below : Int = as3hx.Compat.parseInt(parent.level.getTile(xcheck, ycheck + 1) % Content.iFrontSheetWidth);
            
            
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
            
            //if (fluid == 1 && this.y % 30 > 3)
            //	fluid = 2;
            
            var really : Int = as3hx.Compat.parseInt(parent.level.getTile(as3hx.Compat.parseInt(this.x / 30), as3hx.Compat.parseInt(this.y / 30)) % Content.iFrontSheetWidth);
            bReallyInWater = (really == Content.iWater || really == Content.iWaterGrass || really == Content.iWaterSpikes ||
                    really == Content.iShallow || really == Content.iShallowGrass || really == Content.iShallowSpikes);
        }
        
        if (iLastFluid == 0 && fluid > 0 && velocity.y > 0)
        {
            velocity.y *= Content.nSplashBrakes;
            
            nWaterBoostVertical = 2;
        }
        
        if (iLastFluid == 0 && fluid == 1)
        {
            if (facing == LEFT)
            {
                (try cast(Util.GetInvisibleSpriteByName(parent.arrayParticles, "Splash"), Splash) catch(e:Dynamic) null).Reuse(this.x - 8, (ycheck - 1) * 30);
            }
            else
            {
                (try cast(Util.GetInvisibleSpriteByName(parent.arrayParticles, "Splash"), Splash) catch(e:Dynamic) null).Reuse(this.x - 4, (ycheck - 1) * 30);
            }
            
            FlxG.play(Content.soundSplash, Content.volumeSplash, false, false, Content.nDefaultSkip);
            
            nBubbliness = 1;
        }
        
        if (iLastFluid > 0 && fluid == 0)
        {
            nBubbliness = 1;
        }
        
        if (overtile == 1 ||
            (overtile >= Content.iStuffAboveStuffBelow && overtile <= Content.iEmptyAboveWaterBelow))
        {
            parent.spotlight.visible = true;
        }
        else
        {
            parent.spotlight.visible = false;
        }
        
        if (!bJumpButton)
        {
            bJumpRecharged = true;
        }
        
        if (iLastFluid == 2 && fluid == 1)
        {
            bJumpRecharged = true;
        }
        //else if (iLastFluid == 0 && fluid == 1)
        //	bJumpRecharged = false;
        
        
        var bInAir : Bool = false;
        var bHasPogo : Bool = false;
        
        if (fluid == 0)
        {
            nWaterBoostLateral = 1;
            nWaterBoostVertical = 1;
        }
        else
        {
            if (nWaterBoostLateral > 1)
            {
                nWaterBoostLateral -= nWaterBoostLateralDecay * FlxG.elapsed;
                
                if (nWaterBoostLateral < 1)
                {
                    nWaterBoostLateral = 1;
                }
            }
            
            if (nWaterBoostVertical > 1)
            {
                nWaterBoostVertical -= nWaterBoostVerticalDecay * FlxG.elapsed;
                
                if (nWaterBoostVertical < 1)
                {
                    trace("back to normal");
                    nWaterBoostVertical = 1;
                }
                
                if (velocity.y > 0 && velocity.y < Content.stats.nSwimDownSpeed)
                {
                    nWaterBoostVertical = 1;
                }
            }
        }
        
        if (this._flickerTimer > nRecoverySeconds * 0.75)
        {
            drag.x = 0;
            bShock = true;
        }
        else
        {
            if (bShock)
            {
                bShock = false;
                drag.x = maxVelocity.x;
            }
            
            acceleration.y = Content.nGrav;
            
            if (fluid == 2 && bDiveButton)
            {
                acceleration.y = Content.nGrav * Content.stats.nSwimDownAcceleration;
            }
            
            drag.x = maxVelocity.x * 300;
            drag.y = maxVelocity.y * 300;
            
            if (isTouching(FLOOR) && fluid == 0)
            {
                bWasWindJump = false;
                bInAir = false;
            }
            else if (fluid > 0 && bReallyInWater)
            {
                drag.x = 40;
                drag.y = 40;
                
                acceleration.x = 0;
                acceleration.y = 0;
                
                if (bLeftButton && !bRightButton)
                {
                    facing = LEFT;
                    acceleration.x = -Content.nGrav * Content.stats.nSwimLateralAcceleration;
                    
                    if (bJumpButton && bSpurtRecharged)
                    
                    { // Swim 1
                        
                        {
                            if (fluid > 1)
                            {
                                cast((1), SwimSound);
                            }
                            
                            nWaterBoostLateral = nWaterBoostLateralCap;
                            velocity.x -= Content.stats.nSwimLateralSpeed * nWaterBoostLateralSpurt;
                            nBubbliness = 1;
                        }
                    }
                }
                else if (!bLeftButton && bRightButton)
                {
                    facing = RIGHT;
                    acceleration.x = Content.nGrav * Content.stats.nSwimLateralAcceleration;
                    
                    if (bJumpButton && bSpurtRecharged)
                    
                    { // Swim 2
                        
                        {
                            if (fluid > 1)
                            {
                                cast((2), SwimSound);
                            }
                            
                            nWaterBoostLateral = nWaterBoostLateralCap;
                            velocity.x += Content.stats.nSwimLateralSpeed * nWaterBoostLateralSpurt;
                            nBubbliness = 1;
                        }
                    }
                }
                
                if (velocity.x < -Content.stats.nSwimLateralSpeed * nWaterBoostLateral)
                {
                    velocity.x = -Content.stats.nSwimLateralSpeed * nWaterBoostLateral;
                }
                else if (velocity.x > Content.stats.nSwimLateralSpeed * nWaterBoostLateral)
                {
                    velocity.x = Content.stats.nSwimLateralSpeed * nWaterBoostLateral;
                }
                
                if (bDiveButton && !bUpButton)
                {
                    acceleration.y = Content.nGrav * Content.stats.nSwimDownAcceleration;
                    
                    if (bJumpButton && bSpurtRecharged)
                    
                    { // Swim 3
                        
                        {
                            if (fluid > 1)
                            {
                                cast((3), SwimSound);
                            }
                            
                            nWaterBoostVertical = nWaterBoostVerticalCap;
                            velocity.y += Content.stats.nSwimDownSpeed * nWaterBoostVerticalSpurt;
                            nBubbliness = 1;
                        }
                    }
                }
                else if (fluid == 2 && !bDiveButton && bUpButton && bJumpButton && bSpurtRecharged)
                
                { // Swim 4
                    
                    {
                        if (fluid > 1)
                        {
                            cast((4), SwimSound);
                        }
                        
                        nWaterBoostVertical = nWaterBoostVerticalCap;
                        velocity.y -= Content.stats.nSwimUpSpeed * nWaterBoostVerticalSpurt;
                        nBubbliness = 1;
                    }
                }
                else if (fluid == 1 && velocity.y <= 0 && as3hx.Compat.parseInt(this.y) % 30 <= 2 && bJumpButton != true)
                {
                    nWaterBoostVertical = 1;
                    velocity.y = 0;
                    this.y = this.y - (this.y % 30);
                }
                else
                {
                    acceleration.y = -Content.nGrav * Content.stats.nSwimUpAcceleration;
                }
                
                if (velocity.y < -Content.stats.nSwimUpSpeed * nWaterBoostVertical)
                {
                    velocity.y = -Content.stats.nSwimUpSpeed * nWaterBoostVertical;
                }
                else if (velocity.y > Content.stats.nSwimDownSpeed * nWaterBoostVertical)
                {
                    velocity.y = Content.stats.nSwimDownSpeed * nWaterBoostVertical;
                }
                
                if (bJumpButton)
                {
                    bSpurtRecharged = false;
                }
                else if (nWaterBoostLateral == 1 && nWaterBoostVertical == 1)
                {
                    bSpurtRecharged = true;
                }
            }
            
            
            if (!isTouching(FLOOR) && bShooting && bDownButton && Content.stats.bHasWindJump && fluid == 0 && bWasWindJump == false)
            {
                bWasWindJump = true;
                Jump();
            }
            else if (!isTouching(FLOOR) && bShooting && bDownButton && fluid == 0)
            {
                if (velocity.y >= Content.stats.nSlowThreshold)
                {
                    velocity.y = Content.stats.nSlowThreshold;
                }
            }
            else if ((isTouching(FLOOR) && fluid == 0) || fluid == 1)
            {
                if (bJumpButton && bJumpRecharged)
                {
                    bWasWindJump = false;
                    
                    if (fluid == 1)
                    {
                        nWaterBoostVertical = 4;
                    }
                    
                    Jump();
                }
            }
            else if (fluid == 0)
            {
                bInAir = true;
                
                if (bJumpCanBeCut && !bJumpButton && velocity.y < 0 && !(bWasWindJump && bShootButton))
                {
                    var perc : Float = velocity.y / (-Content.nGrav * Content.stats.nPlayerJumpForce);
                    perc = 1 - perc;
                    perc *= 0.7;
                    
                    velocity.y = velocity.y * (0.3 + perc);
                    bJumpCanBeCut = false;
                }
            }
            
            if (fluid > 0)
            {
                var remframe : Int = this._curFrame;
                
                if (bLeftButton || bRightButton || bDownButton || bUpButton)
                {
                    play("fswim" + strQual, false);
                }
                else
                {
                    play("swim", false);
                }
            }
            else if (bInAir == true)
            {
                if (velocity.y < 0)
                {
                    play("jump" + strQual);
                }
                else
                {
                    play("fall" + strQual);
                }
            }
            else if (acceleration.x == 0)
            {
                play("stand" + strQual);
            }
            else
            {
                play("run" + strQual);
            }  /*
				else if (_curFrame == 1)
				{
					if(bUpButton)
						play("stand" + strQual);
				}*/  
            
            
            var xoff : Int = 0;
            var yoff : Int = 0;
            
            if (bLeftButton || bRightButton)
            {
                bBearings = true;
            }
            
            if (fluid == 0)
            {
                acceleration.x = 0;
                
                if (bLeftButton && !bRightButton)
                {
                    facing = LEFT;
                    
                    acceleration.x = -1000000;
                }
                else if (!bLeftButton && bRightButton)
                {
                    facing = RIGHT;
                    
                    acceleration.x = 1000000;
                }
            }
            
            
            
            
            var anim : String = GetCurrentAnim();
            var iDir : Int = 0;
            if (anim.charAt(anim.length - 2) + anim.charAt(anim.length - 1) == "up")
            {
                iDir = -1;
            }
            else if (anim.charAt(anim.length - 2) + anim.charAt(anim.length - 1) == "dn")
            {
                iDir = 1;
            }
            
            var shotted : Bool = bow.GetCurrentAnim().substr(0, 5) == "shoot";
            
            if ((shotted && bow.GetCurrentFrame() == 3) || !shotted)
            {
                if (iDir == -1)
                {
                    bow.play("restup");
                }
                else if (iDir == 1)
                {
                    bow.play("restdn");
                }
                else
                {
                    bow.play("rest");
                }
            }
            
            
            /*
				if (bTossButton && bShootRecharged && bInAir == false)
				{
					bShootRecharged = false;
					play("crouch", true);
					
					xoff = 14;
					
					if (facing == LEFT)
						xoff = 7;
					
					yoff = 15;
					
					parent.arrayPellets.push(new Pellet(parent, this.x + xoff, this.y + yoff, facing == RIGHT));
					parent.groupPellets.add(parent.arrayPellets[parent.arrayPellets.length - 1]);
				}
				else*/if (bShooting)
            {
                FlxG.play(Content.soundArrow, Content.volumeArrow, false, false, Content.nDefaultSkip);
                
                if (iDir != 0)
                {
                    bow.play("shoot" + strQual, true);
                }
                else
                {
                    bow.play("shoot", true);
                }
                
                nShootRecharged = 0;
                
                xoff = 2;
                
                //var xoff:int = -(30 - (this.width / 2));
                
                /*
					if (!isTouching(LEFT) && !isTouching(RIGHT))
					{
						xoff += 14;
					}
					*/
                
                yoff = 10;
                
                if (fluid > 0)
                {
                    yoff = 10;
                }
                
                
                
                if (facing == LEFT)
                {
                    xoff = 0;
                }  // -xoff;  
                
                
                if (fluid > 0)
                {
                    yoff++;
                }
                
                /*
					if (isTouching(FLOOR) && fluid == 0 && bDownButton)//&& bJumpRecharged)
					{
						Jump();
						iDir = 1;
					}
					*/
                
                if (iDir == -1)
                {
                    yoff = -7;
                    
                    if (facing == RIGHT)
                    {
                        xoff = as3hx.Compat.parseInt(12 + 3 + (-5));
                    }
                    else
                    {
                        xoff = as3hx.Compat.parseInt(0 + (5));
                    }
                    
                    
                    //trace((parent.level.getTile(int((this.x + xoff) / 30), int((this.y - 7) / 30)) % Content.iFrontSheetWidth).toString());
                    
                    if (parent.level.getTile(as3hx.Compat.parseInt((this.x + xoff) / 30), as3hx.Compat.parseInt((this.y - 7) / 30)) % Content.iFrontSheetWidth >= Content.barriertile)
                    
                    { //trace("up in ceiling");
                        
                        yoff = 0;
                    }
                }
                else if (iDir == 1)
                {
                    yoff = 7;
                    if (facing == RIGHT)
                    {
                        xoff = as3hx.Compat.parseInt(12 + 1 + (-3));
                    }
                    else
                    {
                        xoff = as3hx.Compat.parseInt(2 + (3));
                    }
                }
                
                if (iDir == 0)
                {
                    if (isTouching(RIGHT))
                    {
                        xoff -= 4;
                    }
                    
                    if (isTouching(LEFT))
                    {
                        xoff += 4;
                    }
                }
                
                parent.arrayArrows.push(new Arrow(parent, this.x + xoff, this.y + yoff, facing == RIGHT, iDir));
                parent.groupArrows.add(parent.arrayArrows[parent.arrayArrows.length - 1]);
            }
            else if (!bShootButton && !bTossButton)
            {
                nShootRecharged += (1 / nShootRechargeSpeed) * FlxG.elapsed;
                
                
                
                if (nShootRecharged >= 1)
                {
                    nShootRecharged = 1;
                }
            }
            
            if (fluid == 2 && velocity.y > 0 && Content.stats.bHasScuba == false)
            {
                velocity.y = 0;
            }
            
            
            var bReallyInSpikes : Bool = false;
            
            
            really = parent.level.getTile(as3hx.Compat.parseInt((this.x + 3) / 30), as3hx.Compat.parseInt((this.y + 3) / 30)) % Content.iFrontSheetWidth;
            bReallyInSpikes = bReallyInSpikes || (really == Content.iSpikes || really == Content.iWaterSpikes || really == Content.iShallowSpikes);
            really = parent.level.getTile(as3hx.Compat.parseInt((this.x + this.width - 3) / 30), as3hx.Compat.parseInt((this.y + 3) / 30)) % Content.iFrontSheetWidth;
            bReallyInSpikes = bReallyInSpikes || (really == Content.iSpikes || really == Content.iWaterSpikes || really == Content.iShallowSpikes);
            really = parent.level.getTile(as3hx.Compat.parseInt((this.x + 3) / 30), as3hx.Compat.parseInt((this.y + this.height - 13) / 30)) % Content.iFrontSheetWidth;
            bReallyInSpikes = bReallyInSpikes || (really == Content.iSpikes || really == Content.iWaterSpikes || really == Content.iShallowSpikes);
            really = parent.level.getTile(as3hx.Compat.parseInt((this.x + this.width - 3) / 30), as3hx.Compat.parseInt((this.y + this.height - 13) / 30)) % Content.iFrontSheetWidth;
            bReallyInSpikes = bReallyInSpikes || (really == Content.iSpikes || really == Content.iWaterSpikes || really == Content.iShallowSpikes);
            
            if (bReallyInSpikes)
            {
                Hit(Content.stats.iMaxHealth, 0);
            }
        }
        
        var Jump : Void->Void = function() : Void
        {
            FlxG.play(Content.soundJump, Content.volumeJump, false, false, Content.nDefaultSkip);
            
            bJumpCanBeCut = true;
            
            bInAir = true;
            bJumpRecharged = false;
            
            if (fluid == 2)
            {
                velocity.y = -Content.nGrav * 0.24;
            }
            else
            {
                velocity.y = -Content.nGrav * Content.stats.nPlayerJumpForce;
            }
        }
        
        var SwimSound : Int->Void = function(i : Int) : Void
        {
            if (bSwimSound == false)
            {
                trace(Std.string(i));
                FlxG.play(Content.soundSwim, Content.volumeSwim, false, false, 120);
            }
            bSwimSound = true;
        }
    }
}
