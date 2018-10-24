package map;

import flash.geom.Point;
import flash.geom.Rectangle;
import hud.HUD;
import flixel.FlxSprite;

class CaveMap
{
    public var arrayCaveMap : Array<Array<Cave>>;
    
    public var upperleft : Point = new Point(0, 0);
    public var size : Point = new Point(0, 0);
    public var circlemask : FlxSprite;
    public var youarehere : FlxSprite;
    public var cavenew : FlxSprite;
    
    public function new(cx : Int, cy : Int, radius : Int)
    {
        circlemask = new FlxSprite(0, 0);
        circlemask.loadGraphic(Content.cCircleMask, false, 268, 268, true);
        
        youarehere = new FlxSprite(0, 0);
        youarehere.loadGraphic(Content.cYouAreHere, false, 12, 12, true);
        
        cavenew = new FlxSprite(0, 0);
        cavenew.loadGraphic(Content.cCaveNew, false, 4, 4, true);
        
        upperleft.x = cx - radius;
        upperleft.y = cy - radius;
        size.x = (radius * 2) + 1;
        size.y = (radius * 2) + 1;
        
        arrayCaveMap = [[]];
        
        var x : Int = Math.floor(cx - radius);
        while (x <= cx + radius)
        {
            arrayCaveMap.push(new Array<Cave>());
            
            var y : Int = Math.floor(cy - radius);
            while (y <= cy + radius)
            {
                arrayCaveMap[arrayCaveMap.length - 1].push(new Cave(x, y));
                y++;
            }
            x++;
        }
    }
    
    public function UpdateSprites(centerpixelx : Int, centerpixely : Int, centercavex : Int, centercavey : Int, radius : Int) : Void
    {
        var x : Int = 0;
        while (x < size.x)
        {
            var y : Int = 0;
            while (y < size.y)
            {
                if (arrayCaveMap[x][y] != null)
                {
                    arrayCaveMap[x][y].CreateSprite(centerpixelx, centerpixely, centercavex, centercavey);
                    
                    if (arrayCaveMap[x][y].sprite != null)
                    {
                        if (x + upperleft.x < centercavex - radius ||
                            x + upperleft.x > centercavex + radius ||
                            y + upperleft.y < centercavey - radius ||
                            y + upperleft.y > centercavey + radius)
                        {
                            arrayCaveMap[x][y].sprite.visible = false;
                        }
                        else
                        {
                            arrayCaveMap[x][y].sprite.visible = true;
                        }
                    }
                }
                y++;
            }
            x++;
        }
    }
    
    public function AddSpritesToHUD(canvas : FlxSprite, centerx : Int, centery : Int, offsetx : Int, offsety : Int, positionx : Int, positiony : Int, cropx : Int, cropy : Int, mask : Bool) : Void
    {
        canvas.pixels.fillRect(new Rectangle(0, 0, canvas.pixels.width, canvas.pixels.height), 0xFF5D5D5D);
        
        var xx : Int = Math.floor(upperleft.x);
        var yy : Int = 0;
        while (xx < upperleft.x + size.x)
        {
            yy = Math.floor(upperleft.y);
            while (yy < upperleft.y + size.y)
            
            { //hud.cavepieces.add(Content.stats.cavemap.GetCave(xx, yy).sprite);
                
                
                var cavesprite : FlxSprite = Content.stats.cavemap.GetCave(xx, yy).sprite;
                
                if (cavesprite != null)
                {
                    canvas.pixels.copyPixels(cavesprite.pixels, 
                            new Rectangle(0, 0, 
                            cavesprite.pixels.width, cavesprite.pixels.height), 
                            new Point(((xx - centerx) * 12) + offsetx, ((yy - centery) * 12) + offsety), 
                            null, 
                            null, 
                            true
                );
                    
                    if (xx == centerx && yy == centery)
                    {
                        canvas.pixels.copyPixels(youarehere.pixels, 
                                new Rectangle(0, 0, 
                                12, 12), 
                                new Point(((xx - centerx) * 12) + offsetx, ((yy - centery) * 12) + offsety), 
                                null, 
                                null, 
                                true
                );
                    }
                }
                yy++;
            }
            xx++;
        }
        
        xx = Math.floor(upperleft.x);
        while (xx < upperleft.x + size.x)
        {
            yy = Math.floor(upperleft.y);
            while (yy < upperleft.y + size.y)
            {
                if (Content.stats.cavemap.GetCave(xx, yy).visited)
                {
                    if (yy == upperleft.y ||
                        (Content.stats.cavemap.GetCave(xx, yy).exits.north == true && Content.stats.cavemap.GetCave(xx, yy - 1).visited == false))
                    {
                        canvas.pixels.copyPixels(cavenew.pixels, 
                                new Rectangle(0, 0, 
                                4, 4), 
                                new Point(((xx - centerx) * 12) + 6 - 2 + offsetx, ((yy - centery) * 12) + 0 - 3 + offsety), 
                                null, 
                                null, 
                                true
                );
                    }
                    
                    if (xx == upperleft.x ||
                        (Content.stats.cavemap.GetCave(xx, yy).exits.west == true && Content.stats.cavemap.GetCave(xx - 1, yy).visited == false))
                    {
                        canvas.pixels.copyPixels(cavenew.pixels, 
                                new Rectangle(0, 0, 
                                4, 4), 
                                new Point(((xx - centerx) * 12) + 0 - 3 + offsetx, ((yy - centery) * 12) + 6 - 2 + offsety), 
                                null, 
                                null, 
                                true
                );
                    }
                    
                    if (yy == upperleft.y + size.y - 1 ||
                        (Content.stats.cavemap.GetCave(xx, yy).exits.south == true && Content.stats.cavemap.GetCave(xx, yy + 1).visited == false))
                    {
                        canvas.pixels.copyPixels(cavenew.pixels, 
                                new Rectangle(0, 0, 
                                4, 4), 
                                new Point(((xx - centerx) * 12) + 6 - 2 + offsetx, ((yy - centery) * 12) + 12 - 1 + offsety), 
                                null, 
                                null, 
                                true
                );
                    }
                    
                    if (xx == upperleft.x + size.x - 1 ||
                        (Content.stats.cavemap.GetCave(xx, yy).exits.east == true && Content.stats.cavemap.GetCave(xx + 1, yy).visited == false))
                    {
                        canvas.pixels.copyPixels(cavenew.pixels, 
                                new Rectangle(0, 0, 
                                4, 4), 
                                new Point(((xx - centerx) * 12) + 12 - 1 + offsetx, ((yy - centery) * 12) + 6 - 2 + offsety), 
                                null, 
                                null, 
                                true
                );
                    }
                }
                yy++;
            }
            xx++;
        }
        
        
        
        canvas.dirty = true;
        
        canvas.x = positionx - ((268 - cropx) / 2);
        canvas.y = positiony - ((268 - cropy) / 2);
        
        if (!mask)
        {
            for (xx in 0...268)
            {
                for (yy in 0...268)
                {
                    if (xx <= ((268 - cropx) / 2) ||
                        xx >= 268 - ((268 - cropx) / 2) ||
                        yy <= ((268 - cropy) / 2) ||
                        yy >= 268 - ((268 - cropy) / 2))
                    {
                        canvas.pixels.setPixel32(xx, yy, 0x00000000);
                    }
                }
            }
        }
        else
        {
            canvas.pixels.copyPixels(circlemask.pixels, 
                    new Rectangle(0, 0, 
                    268, 268), 
                    new Point(0, 0), 
                    null, 
                    null, 
                    true
            );
            
            for (xx in 0...268)
            {
                for (yy in 0...268)
                {
                    if (canvas.pixels.getPixel32(xx, yy) == 0xFFFF00FF)
                    {
                        canvas.pixels.setPixel32(xx, yy, 0x00000000);
                    }
                }
            }
        }
    }
    
    public function RefreshBorders() : Void
    {
        var x : Int = 0;
        while (x < size.x)
        {
            var y : Int = 0;
            while (y < size.y)
            {
                var xworld : Int = Math.floor(x + upperleft.x);
                var yworld : Int = Math.floor(y + upperleft.y);
                
                
                
                if (xworld == 0 && yworld == 4)
                {
                    var i : Int = 2;
                }
                
                var n : String = GetCaveRegion(xworld, yworld - 1);
                var e : String = GetCaveRegion(xworld + 1, yworld);
                var s : String = GetCaveRegion(xworld, yworld + 1);
                var w : String = GetCaveRegion(xworld - 1, yworld);
                
                var c : String = GetCaveRegion(xworld, yworld);
                
                if (c != n)
                {
                    arrayCaveMap[x][y].border.north = true;
                }
                else
                {
                    arrayCaveMap[x][y].border.north = false;
                }
                
                if (c != e)
                {
                    arrayCaveMap[x][y].border.east = true;
                }
                else
                {
                    arrayCaveMap[x][y].border.east = false;
                }
                
                if (c != s)
                {
                    arrayCaveMap[x][y].border.south = true;
                }
                else
                {
                    arrayCaveMap[x][y].border.south = false;
                }
                
                if (c != w)
                {
                    arrayCaveMap[x][y].border.west = true;
                }
                else
                {
                    arrayCaveMap[x][y].border.west = false;
                }
                y++;
            }
            x++;
        }
    }
    
    public function FillRegionSense(x : Int, y : Int) : Void
    {
        var orig : String = GetCaveRegion(x, y);
        
        var checkers : Array<Point> = new Array<Point>();
        checkers.push(new Point(x, y));
        
        while (checkers.length > 0)
        {
            var oldcheckers : Array<Point> = new Array<Point>();
            
            for (pt in checkers)
            {
                GetCaveF(pt.x, pt.y).sensed = true;
                
                oldcheckers.push(new Point());
                oldcheckers[oldcheckers.length - 1] = pt;
            }
            
            var i : Int = 0;
            
            i = 0;
            while (i < oldcheckers.length)
            {
                var tocheck : Point = oldcheckers[i];
                
                AddCaveF(tocheck.x, tocheck.y - 1.0);
                
                if (GetCaveF(tocheck.x, tocheck.y - 1).strRegionName == orig &&
                    GetCaveF(tocheck.x, tocheck.y - 1).sensed == false)
                {
                    checkers.push(new Point(tocheck.x, tocheck.y - 1));
                }
                
                AddCaveF(tocheck.x, tocheck.y + 1.0);
                
                if (GetCaveF(tocheck.x, tocheck.y + 1).strRegionName == orig &&
                    GetCaveF(tocheck.x, tocheck.y + 1).sensed == false)
                {
                    checkers.push(new Point(tocheck.x, tocheck.y + 1));
                }
                
                AddCaveF(tocheck.x - 1, tocheck.y);
                
                if (GetCaveF(tocheck.x - 1, tocheck.y).strRegionName == orig &&
                    GetCaveF(tocheck.x - 1, tocheck.y).sensed == false)
                {
                    checkers.push(new Point(tocheck.x - 1, tocheck.y));
                }
                
                AddCaveF(tocheck.x + 1, tocheck.y);
                
                if (GetCaveF(tocheck.x + 1, tocheck.y).strRegionName == orig &&
                    GetCaveF(tocheck.x + 1, tocheck.y).sensed == false)
                {
                    checkers.push(new Point(tocheck.x + 1, tocheck.y));
                }
                i++;
            }
            
            i = 0;
            while (i < oldcheckers.length)
            {
                checkers.splice(0, 1);
                i++;
            }
        }
        
        return;
    }
    
    function GetCave(xget : Int, yget : Int) : Cave
    {
        xget -= Math.floor(upperleft.x);
        yget -= Math.floor(upperleft.y);
        
        if (xget < 0 || xget >= size.x || yget < 0 || yget >= size.y)
        {
            return null;
        }
        
        return arrayCaveMap[xget][yget];
    }
    
    function GetCaveRegion(xget : Int, yget : Int) : String
    {
        xget -= Math.floor(upperleft.x);
        yget -= Math.floor(upperleft.y);
        
        if (xget < 0 || xget >= size.x || yget < 0 || yget >= size.y)
        {
            return "";
        }
        
        return arrayCaveMap[xget][yget].strRegionName;
    }
    
    public function ExploreCave(xadd : Int, yadd : Int) : Void
    {
        AddCave(xadd, yadd);
        GetCave(xadd, yadd).visited = true;
        GetCave(xadd, yadd).sensed = true;
        FillRegionSense(xadd, yadd);
    }
    
    public function AddCaveF(x : Float, y : Float) : Void
    {
        AddCave(Math.floor(x), Math.floor(y));
    }

    public function GetCaveF(x : Float, y : Float) : Cave
    {
        return GetCave(Math.floor(x), Math.floor(y));
    }

    public function AddCave(xadd : Int, yadd : Int) : Void
    {
        var xx : Int = 0;
        var yy : Int = 0;
        
        if (xadd < upperleft.x)
        {
            arrayCaveMap.unshift(new Array<Cave>());
            
            yy = 0;
            while (yy < size.y)
            {
                if (yy == yadd - upperleft.y || true)
                
                { // just do it
                    
                    {
                        arrayCaveMap[0].push(new Cave(xadd, Math.floor(yy + upperleft.y)));
                    }
                }
                else
                {
                    arrayCaveMap[0].push(null);
                }
                yy++;
            }
            
            upperleft.x--;
            size.x++;
        }
        else if (xadd >= upperleft.x + size.x)
        {
            arrayCaveMap.push(new Array<Cave>());
            
            yy = 0;
            while (yy < size.y)
            {
                arrayCaveMap[arrayCaveMap.length - 1].push(new Cave(xadd, Math.floor(yy + upperleft.y)));
                yy++;
            }
            
            size.x++;
        }
        else if (yadd < upperleft.y)
        {
            xx = 0;
            while (xx < size.x)
            {
                if (xx == xadd - upperleft.x || true)
                
                { // just do it
                    
                    {
                        arrayCaveMap[xx].unshift(new Cave(Math.floor(xx + upperleft.x), yadd));
                    }
                }
                else
                {
                    arrayCaveMap[xx].unshift(null);
                }
                xx++;
            }
            
            upperleft.y--;
            size.y++;
        }
        else if (yadd >= upperleft.y + size.y)
        {
            xx = 0;
            while (xx < size.x)
            {
                if (xx == xadd - upperleft.x || true)
                
                { // just do it
                    
                    {
                        arrayCaveMap[xx].push(new Cave(Math.floor(xx + upperleft.x), yadd));
                    }
                }
                else
                {
                    arrayCaveMap[xx].push(null);
                }
                xx++;
            }
            
            size.y++;
        }
    }
}
