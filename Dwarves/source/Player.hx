import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
import flixel.*;
import particles.Splash;
import hud.Grunt;
import flixel.text.FlxText;
import flixel.util.FlxSpriteUtil;
import flixel.system.FlxSound;

// Adds flicker
using flixel.util.FlxSpriteUtil;

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
    
    public static inline var nWaterBoostLateralCap : Float = 2;
    public static inline var nWaterBoostVerticalCap : Float = 2;
    
    public static inline var nWaterBoostLateralSpurt : Float = 0.75;
    public static inline var nWaterBoostVerticalSpurt : Float = 0.75;
    
    public static inline var nWaterBoostLateralDecay : Float = (nWaterBoostLateralCap - 1) * (1 / (0.5));  // 3 seconds  
    public static inline var nWaterBoostVerticalDecay : Float = (nWaterBoostVerticalCap - 1) * (1 / (0.5));  // 3 seconds 

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
    
    private var bInAir : Bool = false;
    private var bHasPogo : Bool = false;

    public var _bDangerFlicker : Bool = false;

    private var _soundHurt : FlxSound;
    private var _soundSplash : FlxSound;
    private var _soundArrow : FlxSound;
    private var _soundJump : FlxSound;
    private var _soundSwim : FlxSound;

    // TODO: This isn't hooked up to anything yet
    private var _flickerTimer : Float;

    public function new(p : PlayState, X : Float, Y : Float, spriteBow : FlxSprite)
    {
        parent = p;
        
        super(X, Y);
        
        _soundHurt = FlxG.sound.load(AssetPaths.hurt__mp3);
        _soundSplash = FlxG.sound.load(AssetPaths.splash__mp3);
        _soundArrow = FlxG.sound.load(AssetPaths.arrow__mp3);
        _soundJump = FlxG.sound.load(AssetPaths.jump__mp3);
        _soundSwim = FlxG.sound.load(AssetPaths.swim__mp3);

        loadGraphic(Content.cHero, true, 100, 100);
        
        bow = spriteBow;
        
        facing = Content.LEFT;
        
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
        
        animation.add("stand", [0], 1, false);
        animation.add("standup", [18], 1, false);
        animation.add("standdn", [36], 1, false);
        
        animation.add("run", [9, 10, 11, 12, 13, 14, 15, 16], 14, true);
        animation.add("runup", [27, 28, 29, 30, 31, 32, 33, 34], 14, true);
        animation.add("rundn", [45, 46, 47, 48, 49, 50, 51, 52], 14, true);
        
        animation.add("jump", [55], 1, false);
        animation.add("jumpup", [57], 1, false);
        animation.add("jumpdn", [59], 1, false);
        
        animation.add("fall", [56], 1, false);
        animation.add("fallup", [58], 1, false);
        animation.add("falldn", [60], 1, false);
        
        animation.add("struck", [54], 1, false);
        
        animation.add("swim", [1, 2, 3, 4, 5, 4, 3, 2], 8, true);
        animation.add("fswim", [1, 2, 3, 4, 5, 4, 3, 2], 18, true);
        animation.add("fswimup", [19, 20, 21, 22, 23, 22, 21, 20], 18, true);
        animation.add("fswimdn", [37, 38, 39, 40, 41, 40, 39, 38], 18, true);
        
        animation.add("leaving", [72, 73, 74, 75, 76, 77, 78, 79, 80, 80, 80, 80, 80, 80, 80], 10, false);
        animation.add("arriving", [81, 82, 83, 84, 85, 86, 87, 88, 88], 10, false);
        
        //animation.add("crouch", [22, 22], 3, true);
        
        PlayAnim("arriving");
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
            
            this.facing = Content.LEFT;
        }
        else
        {
            if (this.velocity.x > -iOuchPower)
            {
                this.velocity.x = -iOuchPower;
            }
            
            this.facing = Content.RIGHT;
        }
        
        PlayAnim("struck");
        
        if (Content.stats.iHealth <= 0)
        {
            parent.state = Content.DEAD;
            parent.iDeadState = Content.JUSTDIED;
        }
        else
        {
            _soundHurt.play(true);
        }
    }
    
    override public function update(elapsed : Float) : Void
    {
        bSwimSound = false;
        
        if (parent.state == Content.LEAVING || parent.state == Content.DEAD)
        {
            FlxSpriteUtil.stopFlickering(this);
            FlxSpriteUtil.stopFlickering(bow);
            return;
        }
        
        if (Content.stats.iHealth <= Content.stats.iMaxHealth / 3 &&
            parent.hero.GetCurrentAnim() != "leaving" &&
            parent.hero.GetCurrentAnim() != "arriving")
        {
            FlxSpriteUtil.flicker(this);
            FlxSpriteUtil.flicker(bow);
        } else {
            FlxSpriteUtil.stopFlickering(this);
            FlxSpriteUtil.stopFlickering(bow);
        }
        
        bDiveButton = FlxG.keys.pressed.DOWN;
        bJumpButton = FlxG.keys.pressed.X || FlxG.keys.pressed.SPACE;
        bShootButton = FlxG.keys.pressed.Z || FlxG.keys.pressed.B;
        bTossButton = FlxG.keys.pressed.A || FlxG.keys.pressed.B;
        bUpButton = FlxG.keys.pressed.UP;
        bDownButton = FlxG.keys.pressed.DOWN;
        bLeftButton = FlxG.keys.pressed.LEFT;
        bRightButton = FlxG.keys.pressed.RIGHT;
        bShooting = false;
        
        if (bShootButton && nShootRecharged == 1)
        {
            bShooting = true;
        }
        
        if (!bDiveButton && !bJumpButton && !bShootButton && !bTossButton && !bUpButton && !bDownButton &&
            this.GetCurrentAnim() == "arriving")
        {
            parent.spotlight.visible = false;
            
            if (this.animation.frameIndex == 8)
            {
                this.animation.play("stand");
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
        var ycheck : Int = 0;
        var xcheck : Int = 0;
        if (parent != null && parent.level != null)
        {
            xcheck = Math.floor(this.x + (this.width / 2) / 30);
            ycheck = Math.floor(this.y + (this.height / 2) / 30);
            
            overtile = Math.floor(parent.level.getTile(xcheck, ycheck) % Content.iFrontSheetWidth);
            var below : Int = Math.floor(parent.level.getTile(xcheck, ycheck + 1) % Content.iFrontSheetWidth);
            
            
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
            
            var really : Int = Math.floor(parent.level.getTile(Math.floor(this.x / 30), Math.floor(this.y / 30)) % Content.iFrontSheetWidth);
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
            if (facing == Content.LEFT)
            {
                parent.groupParticles.recycle(Splash, null, true)
                    .Reuse(Math.floor(this.x - 8), Math.floor((ycheck - 1) * 30));
            }
            else
            {
                parent.groupParticles.recycle(Splash, null, true)
                    .Reuse(Math.floor(this.x - 4), Math.floor((ycheck - 1) * 30));
            }
            
            _soundSplash.play(true, Content.nDefaultSkip);
            
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
            
            if (isTouching(Content.DOWN) && fluid == 0)
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
                    facing = Content.LEFT;
                    acceleration.x = -Content.nGrav * Content.stats.nSwimLateralAcceleration;
                    
                    if (bJumpButton && bSpurtRecharged)
                    
                    { // Swim 1
                        
                        {
                            if (fluid > 1)
                            {
                                SwimSound(1);
                            }
                            
                            nWaterBoostLateral = nWaterBoostLateralCap;
                            velocity.x -= Content.stats.nSwimLateralSpeed * nWaterBoostLateralSpurt;
                            nBubbliness = 1;
                        }
                    }
                }
                else if (!bLeftButton && bRightButton)
                {
                    facing = Content.RIGHT;
                    acceleration.x = Content.nGrav * Content.stats.nSwimLateralAcceleration;
                    
                    if (bJumpButton && bSpurtRecharged)
                    
                    { // Swim 2
                        
                        {
                            if (fluid > 1)
                            {
                                SwimSound(2);
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
                                SwimSound(3);
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
                            SwimSound(4);
                        }
                        
                        nWaterBoostVertical = nWaterBoostVerticalCap;
                        velocity.y -= Content.stats.nSwimUpSpeed * nWaterBoostVerticalSpurt;
                        nBubbliness = 1;
                    }
                }
                else if (fluid == 1 && velocity.y <= 0 && Math.floor(this.y) % 30 <= 2 && bJumpButton != true)
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
            
            
            if (!isTouching(Content.DOWN) && bShooting && bDownButton && Content.stats.bHasWindJump && fluid == 0 && bWasWindJump == false)
            {
                bWasWindJump = true;
                Jump();
            }
            else if (!isTouching(Content.DOWN) && bShooting && bDownButton && fluid == 0)
            {
                if (velocity.y >= Content.stats.nSlowThreshold)
                {
                    velocity.y = Content.stats.nSlowThreshold;
                }
            }
            else if ((isTouching(Content.DOWN) && fluid == 0) || fluid == 1)
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
                var remframe : Int = this.animation.frameIndex;
                
                if (bLeftButton || bRightButton || bDownButton || bUpButton)
                {
                    PlayAnim("fswim" + strQual, false);
                }
                else
                {
                    PlayAnim("swim", false);
                }
            }
            else if (bInAir == true)
            {
                if (velocity.y < 0)
                {
                    PlayAnim("jump" + strQual);
                }
                else
                {
                    PlayAnim("fall" + strQual);
                }
            }
            else if (acceleration.x == 0)
            {
                PlayAnim("stand" + strQual);
            }
            else
            {
                PlayAnim("run" + strQual);
            }  /*
				else if (_curFrame == 1)
				{
					if(bUpButton)
						animation.play("stand" + strQual);
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
                    facing = Content.LEFT;
                    
                    acceleration.x = -1000000;
                }
                else if (!bLeftButton && bRightButton)
                {
                    facing = Content.RIGHT;
                    
                    acceleration.x = 1000000;
                }
            }
            
            
            
            
            var anim : String = bow.animation.name;
            var iDir : Int = 0;
            if (anim.charAt(anim.length - 2) + anim.charAt(anim.length - 1) == "up")
            {
                iDir = -1;
            }
            else if (anim.charAt(anim.length - 2) + anim.charAt(anim.length - 1) == "dn")
            {
                iDir = 1;
            }
            
            var shotted : Bool = bow.animation.name.substr(0, 5) == "shoot";
            
            if ((shotted && bow.animation.frameIndex == 3) || !shotted)
            {
                if (iDir == -1)
                {
                    bow.animation.play("restup");
                }
                else if (iDir == 1)
                {
                    bow.animation.play("restdn");
                }
                else
                {
                    bow.animation.play("rest");
                }
            }
            
            
            /*
				if (bTossButton && bShootRecharged && bInAir == false)
				{
					bShootRecharged = false;
					animation.play("crouch", true);
					
					xoff = 14;
					
					if (facing == Content.LEFT)
						xoff = 7;
					
					yoff = 15;
					
					parent.arrayPellets.push(new Pellet(parent, this.x + xoff, this.y + yoff, facing == Content.RIGHT));
					parent.groupPellets.add(parent.arrayPellets[parent.arrayPellets.length - 1]);
				}
				else*/if (bShooting)
            {
                _soundArrow.play(true, Content.nDefaultSkip);
                
                if (iDir != 0)
                {
                    bow.animation.play("shoot" + strQual, true);
                }
                else
                {
                    bow.animation.play("shoot", true);
                }
                
                nShootRecharged = 0;
                
                xoff = 2;
                
                //var xoff:int = -(30 - (this.width / 2));
                
                /*
					if (!isTouching(Content.LEFT) && !isTouching(Content.RIGHT))
					{
						xoff += 14;
					}
					*/
                
                yoff = 10;
                
                if (fluid > 0)
                {
                    yoff = 10;
                }
                
                
                
                if (facing == Content.LEFT)
                {
                    xoff = 0;
                }  // -xoff;  
                
                
                if (fluid > 0)
                {
                    yoff++;
                }
                
                /*
					if (isTouching(Content.DOWN) && fluid == 0 && bDownButton)//&& bJumpRecharged)
					{
						Jump();
						iDir = 1;
					}
					*/
                
                if (iDir == -1)
                {
                    yoff = -7;
                    
                    if (facing == Content.RIGHT)
                    {
                        xoff = Math.floor(12 + 3 + (-5));
                    }
                    else
                    {
                        xoff = Math.floor(0 + (5));
                    }
                    
                    
                    //trace((parent.level.getTile(int((this.x + xoff) / 30), int((this.y - 7) / 30)) % Content.iFrontSheetWidth).toString());
                    
                    if (parent.level.getTile(Math.floor((this.x + xoff) / 30), Math.floor((this.y - 7) / 30)) % Content.iFrontSheetWidth >= Content.barriertile)
                    
                    { //trace("up in ceiling");
                        
                        yoff = 0;
                    }
                }
                else if (iDir == 1)
                {
                    yoff = 7;
                    if (facing == Content.RIGHT)
                    {
                        xoff = Math.floor(12 + 1 + (-3));
                    }
                    else
                    {
                        xoff = Math.floor(2 + (3));
                    }
                }
                
                if (iDir == 0)
                {
                    if (isTouching(Content.RIGHT))
                    {
                        xoff -= 4;
                    }
                    
                    if (isTouching(Content.LEFT))
                    {
                        xoff += 4;
                    }
                }
                
                parent.arrayArrows.push(new Arrow(parent, Math.floor(this.x + xoff), Math.floor(this.y + yoff), facing == Content.RIGHT, iDir));
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
            
            
            var really : Int = parent.level.getTile(Math.floor((this.x + 3) / 30), Math.floor((this.y + 3) / 30)) % Content.iFrontSheetWidth;
            bReallyInSpikes = bReallyInSpikes || (really == Content.iSpikes || really == Content.iWaterSpikes || really == Content.iShallowSpikes);
            really = parent.level.getTile(Math.floor((this.x + this.width - 3) / 30), Math.floor((this.y + 3) / 30)) % Content.iFrontSheetWidth;
            bReallyInSpikes = bReallyInSpikes || (really == Content.iSpikes || really == Content.iWaterSpikes || really == Content.iShallowSpikes);
            really = parent.level.getTile(Math.floor((this.x + 3) / 30), Math.floor((this.y + this.height - 13) / 30)) % Content.iFrontSheetWidth;
            bReallyInSpikes = bReallyInSpikes || (really == Content.iSpikes || really == Content.iWaterSpikes || really == Content.iShallowSpikes);
            really = parent.level.getTile(Math.floor((this.x + this.width - 3) / 30), Math.floor((this.y + this.height - 13) / 30)) % Content.iFrontSheetWidth;
            bReallyInSpikes = bReallyInSpikes || (really == Content.iSpikes || really == Content.iWaterSpikes || really == Content.iShallowSpikes);
            
            if (bReallyInSpikes)
            {
                Hit(Content.stats.iMaxHealth, 0);
            }
        }
    
    }
    
    public function GetCurrentAnim() : String
    {
        return this.animation.name;
    }

    public function PlayAnim(anim : String, force:Bool = false, reversed:Bool = false, frame:Int = 0) {
        this.animation.play(anim, force, reversed, frame);
    }

    private function Jump() : Void
    {
        _soundJump.play(true, Content.nDefaultSkip);
        
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
    
    private function SwimSound(i : Int) : Void
    {
        if (bSwimSound == false)
        {
            _soundSwim.play(true, 120);
        }
        bSwimSound = true;
    }
}
