package mon;

import flash.geom.ColorTransform;
import flixel.*;

class Crawler extends Monster
{
    public var iDir : Int = Content.RIGHT;
    public var nPredict : Float = 4;
    public var iMagnet : Int = 16;
    public var iWidth : Int = 14;
    
    public function new(p : PlayState, X : Float, Y : Float, colTrans : ColorTransform = null, speedmod : Float = 1)
    {
        super(p, "Crawler", X, Y, colTrans, speedmod);
        
        for (dir in 0...4)
        {
            animation.add(Std.string(dir), [24 + 0, 24 + 1, 24 + 2, 24 + 3], 6, true);
        }
        
        animation.play("1");
        
        bAcrophobic = false;
        bWallBonk = false;
        bDiesInWater = false;
        bForceHit = false;
        bLevelCollision = false;
        bMonsterCollision = false;
        bOriginalLevelCollision = false;
        bOriginalMonsterCollision = false;
        
        width = iWidth;
        height = iWidth;
        offset.x = 30 + 8;
        offset.y = 30 + 8;
        
        rectVulnerable.x = 0;
        rectVulnerable.width = 14;
        rectVulnerable.y = 0;
        rectVulnerable.height = 14;
        
        acceleration.y = 0;
        
        iRunSpeed = 50;
        
        iDir = Content.RIGHT;
        
        facing = Content.RIGHT;  // so that it doesn't mirror  
        
        bDiesInSpikes = false;
    }
    
    override public function update(elapsed : Float) : Void
    {
        super.update(elapsed);
    }
    
    override public function HitDeadArrow(arrow : Arrow) : Bool
    {
        return false;
    }
    
    override public function DoesThisArrowHurtMe(arrow : Arrow, hhit : Int, vhit : Int) : Bool
    {
        return false;
    }
    
    override public function UpdateMovement() : Void
    {
        var curx : Int = as3hx.Compat.parseInt(x / 30);
        var cury : Int = as3hx.Compat.parseInt(y / 30);
        var newx : Int = 0;
        var newy : Int = 0;
        
        if (bLevelCollision == true)
        {
            if (Util.IsBarrier(parent.level.getTile(curx + 1, cury + 1)) == true ||
                Util.IsBarrier(parent.level.getTile(curx - 1, cury + 1)) == true ||
                Util.IsBarrier(parent.level.getTile(curx + 1, cury - 1)) == true ||
                Util.IsBarrier(parent.level.getTile(curx - 1, cury - 1)) == true)
            {
                x = as3hx.Compat.parseInt(x / 30) * 30;
                y = as3hx.Compat.parseInt(y / 30) * 30;
                
                bLevelCollision = false;
            }
            else
            {
                acceleration.y = 420;
            }
        }
        else if (false &&
            Util.IsBarrier(parent.level.getTile(curx + 1, cury + 1)) == false &&
            Util.IsBarrier(parent.level.getTile(curx - 1, cury + 1)) == false &&
            Util.IsBarrier(parent.level.getTile(curx + 1, cury - 1)) == false &&
            Util.IsBarrier(parent.level.getTile(curx - 1, cury - 1)) == false)
        {
            bLevelCollision = true;
        }
        else
        {
            acceleration.y = 0;
            
            var iOldDir : Int = iDir;
            
            if (iDir == Content.RIGHT)
            
            { // Test front edge
                
                curx = as3hx.Compat.parseInt((x + iWidth) / 30);
                cury = as3hx.Compat.parseInt(y / 30);
                newx = as3hx.Compat.parseInt((x + iWidth + ((this.velocity.x * nPredict) / 60)) / 30);
                newy = as3hx.Compat.parseInt(y / 30);
                
                y = (cury * 30) + iMagnet;  // Make sure we're attached to surface  
                
                if (newx != curx)
                {
                    if (Util.IsBarrier(parent.level.getTile(newx, newy)) == true)
                    
                    { // +0degrees blocked
                        
                        {
                            iDir = Content.UP;
                            x = (curx * 30) + iMagnet;
                            y = (cury * 30) + iMagnet;
                        }
                    }
                }
                // Test back edge
                else
                {
                    
                    curx = as3hx.Compat.parseInt((x) / 30);
                    newx = as3hx.Compat.parseInt((x + ((this.velocity.x * nPredict) / 60)) / 30);
                    
                    if (newx != curx)
                    {
                        if (Util.IsBarrier(parent.level.getTile(newx, newy + 1)) == false)
                        
                        { // +90degrees open
                            
                            {
                                iDir = Content.DOWN;
                                x = (newx * 30) - 0;
                                y = (newy * 30) + iMagnet;
                            }
                        }
                    }
                }
            }
            else if (iDir == Content.LEFT)
            
            { // Test front edge
                
                curx = as3hx.Compat.parseInt((x) / 30);
                cury = as3hx.Compat.parseInt(y / 30);
                newx = as3hx.Compat.parseInt((x + ((this.velocity.x * nPredict) / 60)) / 30);
                newy = as3hx.Compat.parseInt(y / 30);
                
                y = (cury * 30) + 0;  // Make sure we're attached to surface  
                
                if (newx != curx)
                {
                    if (Util.IsBarrier(parent.level.getTile(newx, newy)) == true)
                    
                    { // +0degrees blocked
                        
                        {
                            iDir = Content.DOWN;
                            x = (curx * 30) + 0;
                            y = (cury * 30) + 0;
                        }
                    }
                }
                // Test back edge
                else
                {
                    
                    curx = as3hx.Compat.parseInt((x + iWidth) / 30);
                    newx = as3hx.Compat.parseInt((x + iWidth + ((this.velocity.x * nPredict) / 60)) / 30);
                    
                    if (newx != curx)
                    {
                        if (Util.IsBarrier(parent.level.getTile(newx, newy - 1)) == false)
                        
                        { // +90degrees open
                            
                            {
                                iDir = Content.UP;
                                x = (newx * 30) + iMagnet;
                                y = (newy * 30) + 0;
                            }
                        }
                    }
                }
            }
            else if (iDir == Content.DOWN)
            
            { // Test front edge
                
                curx = as3hx.Compat.parseInt(x / 30);
                cury = as3hx.Compat.parseInt((y + iWidth) / 30);
                newx = as3hx.Compat.parseInt(x / 30);
                newy = as3hx.Compat.parseInt((y + iWidth + ((this.velocity.y * nPredict) / 60)) / 30);
                
                x = (curx * 30) + 0;  // Make sure we're attached to surface  
                
                if (newy != cury)
                {
                    if (Util.IsBarrier(parent.level.getTile(newx, newy)) == true)
                    
                    { // +0degrees blocked
                        
                        {
                            iDir = Content.RIGHT;
                            x = (curx * 30) + 0;
                            y = (cury * 30) + iMagnet;
                        }
                    }
                }
                // Test back edge
                else
                {
                    
                    cury = as3hx.Compat.parseInt((y) / 30);
                    newy = as3hx.Compat.parseInt((y + ((this.velocity.y * nPredict) / 60)) / 30);
                    
                    if (newy != cury)
                    {
                        if (Util.IsBarrier(parent.level.getTile(newx - 1, newy)) == false)
                        
                        { // +90degrees open
                            
                            {
                                iDir = Content.LEFT;
                                x = (newx * 30) - 0;
                                y = (newy * 30) - 0;
                            }
                        }
                    }
                }
            }
            else if (iDir == Content.UP)
            
            { // Test front edge
                
                curx = as3hx.Compat.parseInt(x / 30);
                cury = as3hx.Compat.parseInt((y) / 30);
                newx = as3hx.Compat.parseInt(x / 30);
                newy = as3hx.Compat.parseInt((y + ((this.velocity.y * nPredict) / 60)) / 30);
                
                x = (curx * 30) + iMagnet;  // Make sure we're attached to surface  
                
                if (newy != cury)
                {
                    if (Util.IsBarrier(parent.level.getTile(newx, newy)) == true)
                    
                    { // +0degrees blocked
                        
                        {
                            iDir = Content.LEFT;
                            x = (curx * 30) + iMagnet;
                            y = (cury * 30) + 0;
                        }
                    }
                }
                // Test back edge
                else
                {
                    
                    cury = as3hx.Compat.parseInt((y + iWidth) / 30);
                    newy = as3hx.Compat.parseInt((y + iWidth + ((this.velocity.y * nPredict) / 60)) / 30);
                    
                    if (newy != cury)
                    {
                        if (Util.IsBarrier(parent.level.getTile(newx + 1, newy)) == false)
                        
                        { // +90degrees open
                            
                            {
                                iDir = Content.RIGHT;
                                x = (newx * 30) + iMagnet;
                                y = (newy * 30) + iMagnet;
                            }
                        }
                    }
                }
            }
            
            
            if (iDir == Content.RIGHT)
            {
                this.velocity.y = 0;
                this.velocity.x = iRunSpeed;
            }
            else if (iDir == Content.DOWN)
            {
                this.velocity.y = iRunSpeed;
                this.velocity.x = 0;
            }
            else if (iDir == Content.LEFT)
            {
                this.velocity.y = 0;
                this.velocity.x = -iRunSpeed;
            }
            else if (iDir == Content.UP)
            {
                this.velocity.y = -iRunSpeed;
                this.velocity.x = 0;
            }
            
            if (iDir != iOldDir)
            {
                this.play(Std.string(iDir));
            }
        }
    }
}

