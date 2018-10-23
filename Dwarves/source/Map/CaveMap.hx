package map;

import flash.geom.Point;
import flash.geom.Rectangle;
import hud.HUD;
import flixel.FlxSprite;

class CaveMap
{
    public var arrayCaveMap : Array<Dynamic>;
    
    public var upperleft : Point = new Point(0, 0);
    public var size : Point = new Point(0, 0);
    public var circlemask : FlxSprite;
    public var youarehere : FlxSprite;
    public var cavenew : FlxSprite;
    
    public function new(cx : Int, cy : Int, radius : Int)
    {
        circlemask = new FlxSprite(0, 0);
        circlemask.loadGraphic(Content.cCircleMask, false, false, 268, 268, true);
        
        youarehere = new FlxSprite(0, 0);
        youarehere.loadGraphic(Content.cYouAreHere, false, false, 12, 12, true);
        
        cavenew = new FlxSprite(0, 0);
        cavenew.loadGraphic(Content.cCaveNew, false, false, 4, 4, true);
        
        upperleft.x = cx - radius;
        upperleft.y = cy - radius;
        size.x = (radius * 2) + 1;
        size.y = (radius * 2) + 1;
        
        arrayCaveMap = new Array<Dynamic>();
        
        var x : Int = as3hx.Compat.parseInt(cx - radius);
        while (x <= cx + radius)
        {
            arrayCaveMap.push(new Array<Dynamic>());
            
            var y : Int = as3hx.Compat.parseInt(cy - radius);
            while (y <= cy + radius)
            {
                (try cast(arrayCaveMap[arrayCaveMap.length - 1], Array) catch(e:Dynamic) null).push(new Cave(x, y));
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
                    (try cast(arrayCaveMap[x][y], Cave) catch(e:Dynamic) null).CreateSprite(centerpixelx, centerpixely, centercavex, centercavey);
                    
                    if ((try cast(arrayCaveMap[x][y], Cave) catch(e:Dynamic) null).sprite != null)
                    {
                        if (x + upperleft.x < centercavex - radius ||
                            x + upperleft.x > centercavex + radius ||
                            y + upperleft.y < centercavey - radius ||
                            y + upperleft.y > centercavey + radius)
                        {
                            (try cast(arrayCaveMap[x][y], Cave) catch(e:Dynamic) null).sprite.visible = false;
                        }
                        else
                        {
                            (try cast(arrayCaveMap[x][y], Cave) catch(e:Dynamic) null).sprite.visible = true;
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
        canvas._pixels.fillRect(new Rectangle(0, 0, canvas._pixels.width, canvas._pixels.height), 0xFF5D5D5D);
        
        var xx : Int = upperleft.x;
        while (xx < upperleft.x + size.x)
        {
            var yy : Int = upperleft.y;
            while (yy < upperleft.y + size.y)
            
            { //hud.cavepieces.add(Content.stats.cavemap.GetCave(xx, yy).sprite);
                
                
                var cavesprite : FlxSprite = Content.stats.cavemap.GetCave(xx, yy).sprite;
                
                if (cavesprite != null)
                {
                    canvas._pixels.copyPixels(cavesprite._pixels, 
                            new Rectangle(0, 0, 
                            cavesprite._pixels.width, cavesprite._pixels.height), 
                            new Point(((xx - centerx) * 12) + offsetx, ((yy - centery) * 12) + offsety), 
                            null, 
                            null, 
                            true
                );
                    
                    if (xx == centerx && yy == centery)
                    {
                        canvas._pixels.copyPixels(youarehere._pixels, 
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
        
        xx = upperleft.x;
        while (xx < upperleft.x + size.x)
        {
            yy = upperleft.y;
            while (yy < upperleft.y + size.y)
            {
                if (Content.stats.cavemap.GetCave(xx, yy).visited)
                {
                    if (yy == upperleft.y ||
                        (Content.stats.cavemap.GetCave(xx, yy).exits.north == true && Content.stats.cavemap.GetCave(xx, yy - 1).visited == false))
                    {
                        canvas._pixels.copyPixels(cavenew._pixels, 
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
                        canvas._pixels.copyPixels(cavenew._pixels, 
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
                        canvas._pixels.copyPixels(cavenew._pixels, 
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
                        canvas._pixels.copyPixels(cavenew._pixels, 
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
                        canvas._pixels.setPixel32(xx, yy, 0x00000000);
                    }
                }
            }
        }
        else
        {
            canvas._pixels.copyPixels(circlemask._pixels, 
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
                    if (canvas._pixels.getPixel32(xx, yy) == 0xFFFF00FF)
                    {
                        canvas._pixels.setPixel32(xx, yy, 0x00000000);
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
                var xworld : Int = as3hx.Compat.parseInt(x + upperleft.x);
                var yworld : Int = as3hx.Compat.parseInt(y + upperleft.y);
                
                
                
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
                    (try cast(arrayCaveMap[x][y], Cave) catch(e:Dynamic) null).border.north = true;
                }
                else
                {
                    (try cast(arrayCaveMap[x][y], Cave) catch(e:Dynamic) null).border.north = false;
                }
                
                if (c != e)
                {
                    (try cast(arrayCaveMap[x][y], Cave) catch(e:Dynamic) null).border.east = true;
                }
                else
                {
                    (try cast(arrayCaveMap[x][y], Cave) catch(e:Dynamic) null).border.east = false;
                }
                
                if (c != s)
                {
                    (try cast(arrayCaveMap[x][y], Cave) catch(e:Dynamic) null).border.south = true;
                }
                else
                {
                    (try cast(arrayCaveMap[x][y], Cave) catch(e:Dynamic) null).border.south = false;
                }
                
                if (c != w)
                {
                    (try cast(arrayCaveMap[x][y], Cave) catch(e:Dynamic) null).border.west = true;
                }
                else
                {
                    (try cast(arrayCaveMap[x][y], Cave) catch(e:Dynamic) null).border.west = false;
                }
                y++;
            }
            x++;
        }
    }
    
    public function FillRegionSense(x : Int, y : Int) : Void
    {
        var orig : String = GetCaveRegion(x, y);
        
        var checkers : Array<Dynamic> = new Array<Dynamic>();
        checkers.push(new Point(x, y));
        
        while (checkers.length > 0)
        {
            var oldcheckers : Array<Dynamic> = new Array<Dynamic>();
            
            for (pt in checkers)
            {
                GetCave(pt.x, pt.y).sensed = true;
                
                oldcheckers.push(new Point());
                oldcheckers[oldcheckers.length - 1] = pt;
            }
            
            var i : Int = 0;
            
            i = 0;
            while (i < oldcheckers.length)
            {
                var tocheck : Point = try cast(oldcheckers[i], Point) catch(e:Dynamic) null;
                
                AddCave(tocheck.x, tocheck.y - 1);
                
                if (GetCave(tocheck.x, tocheck.y - 1).strRegionName == orig &&
                    GetCave(tocheck.x, tocheck.y - 1).sensed == false)
                {
                    checkers.push(new Point(tocheck.x, tocheck.y - 1));
                }
                
                AddCave(tocheck.x, tocheck.y + 1);
                
                if (GetCave(tocheck.x, tocheck.y + 1).strRegionName == orig &&
                    GetCave(tocheck.x, tocheck.y + 1).sensed == false)
                {
                    checkers.push(new Point(tocheck.x, tocheck.y + 1));
                }
                
                AddCave(tocheck.x - 1, tocheck.y);
                
                if (GetCave(tocheck.x - 1, tocheck.y).strRegionName == orig &&
                    GetCave(tocheck.x - 1, tocheck.y).sensed == false)
                {
                    checkers.push(new Point(tocheck.x - 1, tocheck.y));
                }
                
                AddCave(tocheck.x + 1, tocheck.y);
                
                if (GetCave(tocheck.x + 1, tocheck.y).strRegionName == orig &&
                    GetCave(tocheck.x + 1, tocheck.y).sensed == false)
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
        xget -= upperleft.x;
        yget -= upperleft.y;
        
        if (xget < 0 || xget >= size.x || yget < 0 || yget >= size.y)
        {
            return null;
        }
        
        return try cast(arrayCaveMap[xget][yget], Cave) catch(e:Dynamic) null;
    }
    
    function GetCaveRegion(xget : Int, yget : Int) : String
    {
        xget -= upperleft.x;
        yget -= upperleft.y;
        
        if (xget < 0 || xget >= size.x || yget < 0 || yget >= size.y)
        {
            return "";
        }
        
        return (try cast(arrayCaveMap[xget][yget], Cave) catch(e:Dynamic) null).strRegionName;
    }
    
    public function ExploreCave(xadd : Int, yadd : Int) : Void
    {
        AddCave(xadd, yadd);
        GetCave(xadd, yadd).visited = true;
        GetCave(xadd, yadd).sensed = true;
        FillRegionSense(xadd, yadd);
    }
    
    public function AddCave(xadd : Int, yadd : Int) : Void
    {
        var xx : Int = 0;
        var yy : Int = 0;
        
        if (xadd < upperleft.x)
        {
            arrayCaveMap.unshift(new Array<Dynamic>());
            
            yy = 0;
            while (yy < size.y)
            {
                if (yy == yadd - upperleft.y || true)
                
                { // just do it
                    
                    {
                        (try cast(arrayCaveMap[0], Array) catch(e:Dynamic) null).push(new Cave(xadd, yy + upperleft.y));
                    }
                }
                else
                {
                    (try cast(arrayCaveMap[0], Array) catch(e:Dynamic) null).push(null);
                }
                yy++;
            }
            
            upperleft.x--;
            size.x++;
        }
        else if (xadd >= upperleft.x + size.x)
        {
            arrayCaveMap.push(new Array<Dynamic>());
            
            yy = 0;
            while (yy < size.y)
            {
                if (yy == yadd - upperleft.y || true)
                
                { // just do it
                    
                    {
                        (try cast(arrayCaveMap[arrayCaveMap.length - 1], Array) catch(e:Dynamic) null).push(new Cave(xadd, yy + upperleft.y));
                    }
                }
                else
                {
                    (try cast(arrayCaveMap[arrayCaveMap.length - 1], Array) catch(e:Dynamic) null).push(null);
                }
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
                        (try cast(arrayCaveMap[xx], Array) catch(e:Dynamic) null).unshift(new Cave(xx + upperleft.x, yadd));
                    }
                }
                else
                {
                    (try cast(arrayCaveMap[xx], Array) catch(e:Dynamic) null).unshift(null);
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
                        (try cast(arrayCaveMap[xx], Array) catch(e:Dynamic) null).push(new Cave(xx + upperleft.x, yadd));
                    }
                }
                else
                {
                    (try cast(arrayCaveMap[xx], Array) catch(e:Dynamic) null).push(null);
                }
                xx++;
            }
            
            size.y++;
        }
    }
}
