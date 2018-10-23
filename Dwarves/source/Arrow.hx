import flash.geom.Rectangle;
import flixel.*;
import flixel.math.FlxRect;
import particles.*;

class Arrow extends FlxSprite
{
    public var parent : PlayState = null;
    public var iSpeed : Int = 1000;
    public var iAlive : Int = Content.iArrowLife;
    public var iBounceLife : Int = -1;
    public var bBouncing : Bool = false;
    public var iDir : Int = 0;
    public var rectEffective : FlxRect;
    
    public function new(p : PlayState, X : Int, Y : Int, bRight : Bool, direction : Int)
    {
        super(30, 30);
        
        parent = p;
        
        loadGraphic(Content.cArrow, true, true, 30, 30);
        
        
        
        this.x = X;
        this.y = Y;
        
        rectEffective = new FlxRect(0, 0, this.width, this.height);
        
        var iStarting : Int = 0;
        
        addAnimation("aliveH", [iStarting], 1, false);
        addAnimation("deadH", [iStarting + 1, iStarting + 2, iStarting + 3, iStarting + 4, iStarting + 5, iStarting + 6, iStarting + 7, iStarting + 8, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9
        ], 20, false);
        
        iStarting = 10;
        
        addAnimation("aliveU", [iStarting], 1, false);
        addAnimation("deadU", [iStarting + 1, iStarting + 2, iStarting + 3, iStarting + 4, iStarting + 5, iStarting + 6, iStarting + 7, iStarting + 8, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9
        ], 20, false);
        
        iStarting = 20;
        
        addAnimation("aliveD", [iStarting], 1, false);
        addAnimation("deadD", [iStarting + 1, iStarting + 2, iStarting + 3, iStarting + 4, iStarting + 5, iStarting + 6, iStarting + 7, iStarting + 8, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, 
                iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9, iStarting + 9
        ], 20, false);
        
        addAnimation("bounce", [30, 31, 32, 33, 34, 35, 36, 37], 30, true);
        
        SetDirection(direction, bRight);
        
        cast(("alive"), ArrowPlay);
    }
    
    public function ArrowPlay(anim : String) : Void
    {
        if (iDir == 0)
        {
            play(anim + "H");
        }
        else if (iDir == -1)
        {
            play(anim + "U");
        }
        else if (iDir == 1)
        {
            play(anim + "D");
        }
    }
    
    public function SetDirection(direction : Int, bRight : Bool) : Void
    {
        iDir = direction;
        
        if (iDir == 0)
        {
            width = 16;
            height = 3;
            offset.x = 7;
            offset.y = 19;
        }
        else if (iDir == -1)
        {
            width = 3;
            height = 14;
            offset.x = 18;
            offset.y = 9;
        }
        else
        {
            width = 3;
            height = 14;
            offset.x = 18;
            offset.y = 7;
        }
        
        if (iDir == 0)
        {
            if (bRight)
            {
                facing = RIGHT;
                width = 14;
                height = 3;
                offset.x = 7;
                offset.y = 19;
            }
            else
            {
                facing = LEFT;
                width = 14;
                height = 3;
                offset.x = 9;
                offset.y = 19;
            }
            
            if (bRight)
            {
                velocity.x = iSpeed;
            }
            else
            {
                velocity.x = -iSpeed;
            }
        }
        else if (iDir == -1)
        {
            velocity.y = -iSpeed;
        }
        else if (iDir == 1)
        {
            velocity.y = iSpeed;
        }
        
        SetEffective();
    }
    
    public function SetEffective() : Void
    {
        rectEffective.x = 0;
        rectEffective.y = 0;
        rectEffective.width = this.width;
        rectEffective.height = this.height;
    }
    
    public function Bounce(hhit : Int, vhit : Int) : Void
    {
        this.play("bounce");
        
        FlxG.play(Content.soundTing, Content.volumeTing, false, false, Content.nDefaultSkip);
        
        var nUpBounceSpeed : Float = 0.35;
        var nDownBounceSpeed : Float = 0.1;
        var nLateralBounceSpeed : Float = 0.3;
        
        var nUpHeadStart : Float = 4;
        var nDownHeadStart : Float = 2;
        var nLateralHeadStart : Float = 4;
        
        
        
        if (hhit == -1 || Math.abs(this.velocity.x) < iSpeed * nLateralBounceSpeed)
        {
            var r : Int = Util.Random(0, 1);
            
            nLateralBounceSpeed = 0.08;
            
            if (r == 0)
            {
                this.velocity.x = iSpeed * nLateralBounceSpeed;
            }
            else
            {
                this.facing = LEFT;
                this.velocity.x = -iSpeed * nLateralBounceSpeed;
            }
        }
        
        if (hhit == Content.RIGHT)
        {
            this.x -= nLateralHeadStart;
            this.velocity.x = -iSpeed * nLateralBounceSpeed;  // bounce left  
            
            if (vhit == -1 || vhit == Content.DOWN)
            {
                this.y -= nUpHeadStart;
                this.velocity.y = -iSpeed * nUpBounceSpeed;
            }
            else
            {
                this.y += nDownHeadStart;
                this.velocity.y = iSpeed * nDownBounceSpeed;
            }
        }
        else if (hhit == Content.LEFT)
        {
            this.x += nLateralHeadStart;
            this.velocity.x = iSpeed * nLateralBounceSpeed;  // bounce right  
            
            if (vhit == -1 || vhit == Content.DOWN)
            {
                this.y -= nUpHeadStart;
                this.velocity.y = -iSpeed * nUpBounceSpeed;
            }
            else
            {
                this.y += nDownHeadStart;
                this.velocity.y = iSpeed * nDownBounceSpeed;
            }
        }
        else if (vhit == Content.UP)
        {
            this.y += nDownHeadStart;
            this.velocity.y = iSpeed * nDownBounceSpeed;
        }
        else if (vhit == Content.DOWN)
        {
            this.y -= nUpHeadStart;
            this.velocity.y = -iSpeed * nUpBounceSpeed;
        }
        
        if (velocity.x > 0)
        {
            this.facing = LEFT;
        }
        else if (velocity.x < 0)
        {
            this.facing = RIGHT;
        }
        
        trace("vel = " + Std.string(velocity.x) + " , " + Std.string(velocity.y));
        
        iBounceLife = Content.iArrowBounceLife;
        bBouncing = true;
        
        acceleration.y = Content.nGrav * 3;  //gravity  
        
        // Boxy thickness
        
        width = 14;
        height = 14;
        offset.x = 8;
        offset.y = 8;
        
        if (Math.abs(this.velocity.x) > Math.abs(this.velocity.y))
        {
            iDir = 0;
        }
        else if (this.velocity.y > 0)
        {
            iDir = 1;
        }
        else
        {
            iDir = -1;
        }
        
        
        
        SetEffective();
    }
    
    override public function update() : Void
    {
        var overtile : Int = -1;
        var fluid : Int = -1;
        
        if (parent != null && parent.level != null)
        {
            var xcheck : Int = as3hx.Compat.parseInt(as3hx.Compat.parseInt(this.x) / 30);
            var ycheck : Int = as3hx.Compat.parseInt(as3hx.Compat.parseInt(this.y) / 30);
            
            overtile = as3hx.Compat.parseInt(parent.level.getTile(xcheck, ycheck) % Content.iFrontSheetWidth);
            
            if (overtile == 4 || overtile == 5)
            {
                fluid = 2;
            }
            else if (overtile == 6 || overtile == 7)
            {
                fluid = 1;
            }
            else
            {
                fluid = 0;
            }
        }
        
        if (Util.Random(0, 3) == 0 && (velocity.x != 0 || velocity.y != 0))
        
        { // spawn a whoosh
            
            {
                if (fluid == 0)
                
                /*
					if(velocity.x < 0)
						parent.groupParticles.add(new Whoosh(parent, this.x - offset.x, this.y - offset.y, 180, 150));
					else if(velocity.x > 0)
						parent.groupParticles.add(new Whoosh(parent, this.x - offset.x, this.y - offset.y, 0, 150));*/{
                    
                    
                }
                else
                {
                    var xx : Float = this.x + Util.Random(-3, 3);
                    var yy : Float = this.y - 3;
                    var nDir : Float = 270;
                    var nSpeed : Float = 10;
                    
                    if (velocity.x < 0)
                    {
                        nDir = 250;
                    }
                    else if (velocity.x > 0)
                    {
                        nDir = 310;
                    }
                    else
                    {
                        yy = this.y + Util.Random(-3, 3);
                    }
                    
                    var toadd : Bub = null;
                    
                    toadd = try cast(Util.GetInvisibleSpriteByName(parent.arrayParticles, "Bub"), Bub) catch(e:Dynamic) null;
                    
                    if (toadd == null)
                    {
                        toadd = new Bub(this.parent, xx, yy, nDir, nSpeed);
                        parent.arrayParticles.push(toadd);
                        parent.groupParticles.add(toadd);
                    }
                    else
                    {
                        toadd.Reuse(xx, yy, nDir, nSpeed);
                    }
                }
            }
        }
    }
}
