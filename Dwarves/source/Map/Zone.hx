package map;

import haxe.Constraints.Function;
import flixel.*;
import flash.geom.Point;
import components.PointInt;
import flixel.math.FlxRandom;

class Zone
{
    public var width : Int = 256;
    public var height : Int = 256;
    public var map : Array<Dynamic> = null;
    public var wallmap : Array<Dynamic> = null;
    public var watermap : Array<Dynamic> = null;
    public var waterlist : Array<Dynamic> = null;
    public var intangmap : Array<Dynamic> = null;
    public var accessiblemap : Array<Dynamic> = null;
    public var roommap : Array<Dynamic> = null;
    public var gemmap : Array<Dynamic> = null;
    public var wallpapermap : Array<Dynamic> = null;
    public var facademap : Array<Dynamic> = null;
    public var chambermap : Array<Dynamic> = null;
    public var spikemap : Array<Dynamic> = null;
    public var wallqualmap : Array<Dynamic> = null;
    public var exits : Array<Exit> = null;
    public var rand : FlxRandom = null;
    
    public var upperleft : PointInt = new PointInt(-1, -1);
    public var lowerright : PointInt = new PointInt(-1, -1);
    
    public var description : Cave;
    
    
    
    
    public var backmap : Array<Dynamic> = null;
    public var remplats : Int = -1;
    public var points : Array<PointInt> = new Array<PointInt>();
    public var secrets : Array<PointInt> = new Array<PointInt>();
    public var intangs : Array<PointInt> = new Array<PointInt>();
    public var floorsecrets : Array<PointInt> = new Array<PointInt>();
    public var momentum : Int = 20;
    public var brush : Int = 1;
    
    
    
    
    public function CopyZone(z : Zone) : Void
    {
        map = Util.Clone(z.map);
        wallmap = Util.Clone(z.wallmap);
        watermap = Util.Clone(z.watermap);
        
        
        waterlist = new Array<Dynamic>();
        for (wpt/* AS3HX WARNING could not determine type for var: wpt exp: EField(EIdent(z),waterlist) type: null */ in z.waterlist)
        {
            waterlist.push(new PointPlus(wpt.x, wpt.y, Std.string(wpt.obj)));
        }
        
        
        intangmap = Util.Clone(z.intangmap);
        accessiblemap = Util.Clone(z.accessiblemap);
        roommap = Util.Clone(z.roommap);
        gemmap = Util.Clone(z.gemmap);
        wallpapermap = Util.Clone(z.wallpapermap);
        facademap = Util.Clone(z.facademap);
        chambermap = Util.Clone(z.chambermap);
        spikemap = Util.Clone(z.spikemap);
        wallqualmap = Util.Clone(z.wallqualmap);
        
        exits = new Array<Exit>();
        for (ex in z.exits)
        {
            exits.push(new Exit(ex.x, ex.y, ex.id));
        }
        
        upperleft = z.upperleft;
        lowerright = z.lowerright;
        
        description = new Cave();
        description.BecomeCopyOf(z.description);
        
        secrets = new Array<PointInt>();
        for (pt in z.secrets)
        {
            secrets.push(new PointInt(pt.x, pt.y));
        }
        
        intangs = new Array<PointInt>();
        for (ipt in z.intangs)
        {
            intangs.push(new PointInt(ipt.x, ipt.y));
        }
        
        floorsecrets = new Array<PointInt>();
        for (fpt in z.floorsecrets)
        {
            floorsecrets.push(new PointInt(fpt.x, fpt.y));
        }
        
        rand = new FlxRandom(Util.Seed(description.coords.x + 100, description.coords.y + 100));
    }
    
    public function new()
    {
    }
    
    public function InitZone(x : Int, y : Int) : Void
    {
        rand = new FlxRandom(Util.Seed(x, y));
        
        map = new Array<Dynamic>();
        watermap = new Array<Dynamic>();
        waterlist = new Array<Dynamic>();
        intangmap = new Array<Dynamic>();
        accessiblemap = new Array<Dynamic>();
        roommap = new Array<Dynamic>();
        gemmap = new Array<Dynamic>();
        wallpapermap = new Array<Dynamic>();
        facademap = new Array<Dynamic>();
        chambermap = new Array<Dynamic>();
        spikemap = new Array<Dynamic>();
        wallqualmap = new Array<Dynamic>();
        exits = new Array<Exit>();
        
        var xx : Int = 0;
        var yy : Int = 0;
        
        for (xx in 0...width)
        {
            map.push(new Array<Dynamic>());
            intangmap.push(new Array<Dynamic>());
            accessiblemap.push(new Array<Dynamic>());
            roommap.push(new Array<Dynamic>());
            gemmap.push(new Array<Dynamic>());
            wallpapermap.push(new Array<Dynamic>());
            facademap.push(new Array<Dynamic>());
            chambermap.push(new Array<Dynamic>());
            spikemap.push(new Array<Dynamic>());
            wallqualmap.push(new Array<Dynamic>());
            watermap.push(new Array<Dynamic>());
            
            
            for (yy in 0...height)
            {
                map[map.length - 1].push(0);
                intangmap[intangmap.length - 1].push(0);
                accessiblemap[accessiblemap.length - 1].push(0);
                roommap[roommap.length - 1].push(0);
                gemmap[gemmap.length - 1].push(0);
                wallpapermap[wallpapermap.length - 1].push(0);
                facademap[facademap.length - 1].push(0);
                chambermap[chambermap.length - 1].push(0);
                spikemap[spikemap.length - 1].push(0);
                wallqualmap[wallqualmap.length - 1].push(0);
                watermap[watermap.length - 1].push(0);
            }
        }
        
        description = new Cave(x, y);
    }
    
    
    
    
    
    
    
    public function SetMap(x : Int, y : Int, i : Int) : Void
    {
        if (x >= 0 && x < width && y >= 0 && y < height)
        {
            map[x][y] = i;
        }
    }
    
    public function GetMap(x : Int, y : Int) : Int
    {
        if (x >= 0 && x < width && y >= 0 && y < height)
        {
            return map[x][y];
        }
        else
        {
            return -1;
        }
    }
    
    public function SetBackmap(x : Int, y : Int, i : Int) : Void
    {
        if (x >= 0 && x < width && y >= 0 && y < height)
        {
            backmap[x][y] = i;
        }
    }
    
    public function GetBackmap(x : Int, y : Int) : Int
    {
        if (x >= 0 && x < width && y >= 0 && y < height)
        {
            return backmap[x][y];
        }
        else
        {
            return -1;
        }
    }
    
    /*
    private void Button_Clear_Click(object sender, EventArgs e)
    {
    secrets.Clear();
    int c = 0;

    do
    {
    Check_N.Checked = false;
    Check_S.Checked = false;
    Check_W.Checked = false;
    Check_E.Checked = false;

    c = 0;

    if (rand.Next(100) < 60)
    {
    c++;
    Check_N.Checked = true;
    }

    if (rand.Next(100) < 60)
    {
    c++;
    Check_S.Checked = true;
    }

    if (rand.Next(100) < 70)
    {
    c++;
    Check_W.Checked = true;
    }

    if (rand.Next(100) < 70)
    {
    c++;
    Check_E.Checked = true;
    }


    } while (c < 2);

    Text_LineWidth.Text = (rand.Next(13) + 3).ToString();
    Text_Wildness.Text = (rand.Next(270) + 30).ToString();
    Text_Cinch.Text = (((double)rand.Next(50) / 100) + 0.25).ToString();

    LineCave();

    //panel1.Invalidate();
    }
		*/
    
    public function Shuffle(array : Array<Dynamic>) : Array<Dynamic>
    {
        var toret : Array<Dynamic> = new Array<Dynamic>();
        
        while (array.length > 0)
        {
            var i : Int = rand.int(0, array.length);
            toret.push(array[i]);
            array.splice(i, 1);
        }
        
        return toret;
    }
    
    public function CheckExits() : Bool
    {
        for (ex in exits)
        {
            if (GetBackmap(ex.x, ex.y) != 0 || GetBackmap(ex.x, ex.y - 1) != 0)
            {
                return false;
            }
        }
        
        var i : Int = 0;
        while (i < exits.length - 1)
        {
            if (CheckPassage(new PointInt(exits[i].x, exits[i].y), new PointInt(exits[i + 1].x, exits[i + 1].y)) == false)
            {
                return false;
            }
            i++;
        }
        
        return true;
    }
    
    public function CheckPassage(a : PointInt, b : PointInt) : Bool
    {
        var checkmap : Array<Dynamic> = Util.Clone(backmap);
        
        var checkers : Array<PointInt> = new Array<PointInt>();
        checkers.push(a);
        
        while (checkers.length > 0)
        {
            var oldcheckers : Array<Point> = new Array<Point>();  // Util.Clone(checkers);  
            
            for (pt in checkers)
            {
                oldcheckers.push(pt);
            }
            
            var i : Int = 0;
            
            i = 0;
            while (i < oldcheckers.length)
            {
                var tocheck : PointInt = oldcheckers[i];
                
                if (tocheck.y == b.y && tocheck.x == b.x)
                {
                    return true;
                }
                
                if (tocheck.y > 0)
                {
                    if (checkmap[tocheck.x][tocheck.y - 1] % 2 == 0 ||
                        (checkmap[tocheck.x][tocheck.y - 1] == 0 && intangmap[tocheck.x][tocheck.y - 1] == 1))
                    {
                        checkmap[tocheck.x][tocheck.y - 1] = 3;
                        checkers.push(new PointInt(tocheck.x, tocheck.y - 1));
                    }
                }
                
                if (tocheck.y < height - 1)
                {
                    if (checkmap[tocheck.x][tocheck.y + 1] % 2 == 0 ||
                        (checkmap[tocheck.x][tocheck.y + 1] == 0 && intangmap[tocheck.x][tocheck.y + 1] == 1))
                    {
                        checkmap[tocheck.x][tocheck.y + 1] = 3;
                        checkers.push(new PointInt(tocheck.x, tocheck.y + 1));
                    }
                }
                
                if (tocheck.x > 0)
                {
                    if (checkmap[tocheck.x - 1][tocheck.y] % 2 == 0 ||
                        (checkmap[tocheck.x - 1][tocheck.y] == 0 && intangmap[tocheck.x - 1][tocheck.y] == 1))
                    {
                        checkmap[tocheck.x - 1][tocheck.y] = 3;
                        checkers.push(new PointInt(tocheck.x - 1, tocheck.y));
                    }
                }
                
                if (tocheck.x < width - 1)
                {
                    if (checkmap[tocheck.x + 1][tocheck.y] % 2 == 0 ||
                        (checkmap[tocheck.x + 1][tocheck.y] == 0 && intangmap[tocheck.x + 1][tocheck.y] == 1))
                    {
                        checkmap[tocheck.x + 1][tocheck.y] = 3;
                        checkers.push(new PointInt(tocheck.x + 1, tocheck.y));
                    }
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
        
        //map = Util.Clone(checkmap);
        
        return false;
    }
    
    
    
    public function LineCave(size : Int, cinch : Float, maxwiggle : Int) : Void
    {
        remplats = -1;
        var mult : Float = 0;
        var x : Int = 0;
        var y : Int = 0;
        
        for (x in 0...width)
        {
            for (y in 0...height)
            {
                SetMap(x, y, 1);
            }
        }
        
        
        var hcinch : Float = cinch * Content.nHorizontalCinchCoefficient;
        var vcinch : Float = cinch * Content.nCurrentVerticalCinchCoefficient;
        
        
        
        
        exits.splice(0, exits.length);
        
        var nodes : Array<Dynamic> = new Array<Dynamic>();
        
        if (description.exits.north)
        {
            x = Math.floor((width / 2) - (((width / 2) - x) * (hcinch)));
            y = Math.floor((height / 2) - (((height / 2) - y) * vcinch));
            
            exits.push(new Exit(x, y, 0));
        }
        
        if (description.exits.south)
        {
            x = Math.floor((width / 2) - (((width / 2) - x) * hcinch));
            y = Math.floor((height / 2) - (((height / 2) - y) * vcinch));
            
            exits.push(new Exit(x, y, 1));
        }
        
        if (description.exits.west)
        {
            x = Math.floor((width / 2) - (((width / 2) - x) * hcinch));
            y = Math.floor((height / 2) - (((height / 2) - y) * vcinch));
            
            exits.push(new Exit(x, y, 2));
        }
        
        if (description.exits.east)
        {
            x = Math.floor((width / 2) - (((width / 2) - x) * hcinch));
            y = Math.floor((height / 2) - (((height / 2) - y) * vcinch));
            
            exits.push(new Exit(x, y, 3));
        }
        
        if (exits.length == 1)
        {
            x = (width / 2) - (((width / 2) - x) * hcinch);
            y = (height / 2) - (((height / 2) - y) * vcinch);
            
            exits.push(new Exit(x, y, 99));
        }
        
        exits = Shuffle(exits);
        var ex : Int = 0;
        ex = 0;
        while (ex < exits.length)
        {
            if (!exits[ex].handled)
            {
                var digger : PointInt = new PointInt(exits[ex].x, exits[ex].y);
                var target : PointInt = null;
                var targetexit : Int = -1;
                
                if (ex == 0)
                {
                    targetexit = Math.floor(rand.int(0, exits.length - 1) + 1);  // <- Do NOT get tricked into thinking the rand is exclusive!  
                    
                    exits[ex].handled = true;
                    exits[targetexit].handled = true;
                    
                    target = new PointInt(exits[targetexit].x, exits[targetexit].y);
                }
                else if (nodes.length > 0)
                {
                    targetexit = rand.int(0, nodes.length);
                    
                    exits[ex].handled = true;
                    
                    target = new PointInt(nodes[targetexit].x, nodes[targetexit].y);
                }
                else
                {
                    trace("No nodes?!?!?!?!?!!?!?!?!??!?!?!?!?!??!?!?!?!?!??!?!");
                    target = new PointInt(0, 0);
                }
                
                
                var toofar : Bool = true;
                var stopdistance : Float = size / 2;
                var hopdistance : Float = size / 2;
                
                var wtf : Int = 0;
                var wiggle : Float = 0;
                var angle : Float = -999;
                
                do
                {
                    nodes.push(new PointInt(Math.floor(digger.x), Math.floor(digger.y)));
                    
                    
                    var xdiff : Float = target.x - digger.x;
                    var ydiff : Float = target.y - digger.y;
                    
                    var dist : Float = Math.sqrt(Math.pow(xdiff, 2) + Math.pow(ydiff, 2));
                    
                    if (dist <= stopdistance)
                    {
                        toofar = false;
                    }
                    else
                    {
                        wtf++;
                        
                        if (dist <= stopdistance)
                        {
                            wiggle = 0;
                            angle = Math.asin((target.y - digger.y) / dist);
                        }
                        else if (rand.int(0, 100) <= 98 && angle != -999)
                        {  //Console.WriteLine("Preserving previous: " + (angle * (180 / Math.PI)));  
                            
                        }
                        else
                        {
                            wiggle = rand.int(0, maxwiggle) - (maxwiggle / 2);
                            wiggle *= Math.PI / 180;
                            angle = Math.asin((target.y - digger.y) / dist) + wiggle;
                        }
                        
                        var threshold : Float = Math.PI / 2;
                        
                        if ((angle - (Math.PI / 2) < threshold) ||
                            (angle - (3 * (Math.PI / 2)) < threshold))
                        {
                            var dir : Int = 1;
                            
                            while (Math.abs(angle - (Math.PI / 2)) < threshold ||
                            Math.abs(angle - (3 * (Math.PI / 2))) < threshold)
                            {
                                angle += dir * (Math.PI / 16);
                            }
                        }
                        
                        var trav : Float = rand.int(Math.floor(hopdistance / 2), Math.floor(hopdistance * 4));
                        
                        var xtrav : Float = Math.cos(angle) * trav * -1;
                        var ytrav : Float = Math.sin(angle) * trav * -1;
                        
                        if ((xtrav > 0 && xdiff < 0) || xtrav < 0 && xdiff > 0)
                        {
                            xtrav *= -1;
                        }
                        
                        if ((ytrav > 0 && ydiff < 0) || ytrav < 0 && ydiff > 0)
                        {
                            ytrav *= -1;
                        }
                        
                        mult = (rand.int(0, 100) + 100) / 100;
                        //trace("mult a = " + mult.toString());
                        //trace("mult b = " + (int(size * mult)).toString());
                        
                        StampLine(Math.floor(size * mult), new PointInt(Math.floor(digger.x), Math.floor(digger.y)), new PointInt(Math.floor(digger.x + xtrav), Math.floor(digger.y + ytrav)));
                        
                        digger.x += xtrav;
                        digger.y += ytrav;
                    }
                }
                while ((toofar));
                
                mult = (rand.int(0, 100) + 100) / 100;
                //trace("mult c = " + mult.toString());
                //trace("mult d = " + (int(size * mult)).toString());
                
                var t : PointInt = new PointInt(Math.floor(target.x), Math.floor(target.y));
                
                StampLine(Math.floor(size * mult), t, t);
            }
            ex++;
        }
        
        // Exit Floors
        ex = 0;
        while (ex < exits.length)
        {
            if (exits[ex].id == 0)
            {
                SetMap(exits[ex].x - 1, exits[ex].y + 1, 1);
                SetMap(exits[ex].x, exits[ex].y + 1, 1);
                SetMap(exits[ex].x + 1, exits[ex].y + 1, 1);
            }
            else if (exits[ex].id == 99)
            {  //exits.splice(ex, 1);  
                //ex--;
                
            }
            ex++;
        }
        
        DefineBounds();
        ResetRandom();
    }
    
    public function ResetRandom() : Void
    {
        rand = new FlxRandom(Util.Seed(this.description.coords.x + 100, this.description.coords.y + 100));
    }
    
    public function DefineBounds() : Void
    {
        var x : Int = 0;
        var y : Int = 0;
        
        var empty : Bool = true;
        
        x = 0;
        while (x < width && empty == true)
        {
            y = 0;
            while (y < height && empty == true)
            {
                if (GetMap(x, y) != 1)
                {
                    empty = false;
                }
                y++;
            }
            x++;
        }
        
        trace("Empty?? " + Std.string(empty));
        
        y = 0;
        while (y < height && upperleft.y == -1)
        {
            x = 0;
            while (x < width && upperleft.y == -1)
            {
                if (GetMap(x, y) != 1)
                {
                    upperleft.y = y;
                }
                x++;
            }
            y++;
        }
        
        x = 0;
        while (x < width && upperleft.x == -1)
        {
            y = 0;
            while (y < height && upperleft.x == -1)
            {
                if (GetMap(x, y) != 1)
                {
                    upperleft.x = x;
                }
                y++;
            }
            x++;
        }
        
        y = Math.floor(height - 1);
        while (y > 0 && lowerright.y == -1)
        {
            x = Math.floor(width - 1);
            while (x > 0 && lowerright.y == -1)
            {
                if (GetMap(x, y) != 1)
                {
                    lowerright.y = y;
                }
                x--;
            }
            y--;
        }
        
        x = Math.floor(width - 1);
        while (x > 0 && lowerright.x == -1)
        {
            y = Math.floor(height - 1);
            while (y > 0 && lowerright.x == -1)
            {
                if (GetMap(x, y) != 1)
                {
                    lowerright.x = x;
                }
                y--;
            }
            x--;
        }
        
        upperleft.x -= 4;
        upperleft.y -= 4;
        lowerright.x += 4;
        lowerright.y += 4;
    }
    
    public function CleanUp() : Void
    {
        var y : Int = Math.floor(upperleft.y + 2);
        while (y < lowerright.y - 2)
        {
            var x : Int = Math.floor(upperleft.x + 2);
            while (x < lowerright.x - 2)
            {
                if (GetMap(x - 1, y) == 1 && GetMap(x, y) == 0 && GetMap(x + 1, y) == 1 &&
                    GetMap(x, y + 1) == 1)
                {
                    SetMap(x, y, 1);
                }
                else if (GetMap(x, y - 1) == 1 &&
                    GetMap(x - 1, y) == 1 && GetMap(x, y) == 0 && GetMap(x - 1, y) == 1 &&
                    GetMap(x, y + 1) == 1)
                {
                    SetMap(x, y, 1);
                }
                
                var bNearExitOrWater : Bool = false;
                
                var xx : Int = Math.floor(x - 1);
                while (xx <= x + 1 && bNearExitOrWater == false)
                {
                    var yy : Int = Math.floor(y - 1);
                    while (yy <= y + 1 && bNearExitOrWater == false)
                    {
                        if (watermap[xx][yy] == 1)
                        {
                            bNearExitOrWater = true;
                        }
                        yy++;
                    }
                    xx++;
                }
                
                
                if (bNearExitOrWater == false)
                {
                    for (exit in exits)
                    {
                        if (Math.abs(x - exit.x) <= 2 &&
                            Math.abs(y - exit.y) <= 2)
                        {
                            bNearExitOrWater = true;
                        }
                    }
                }
                
                if (bNearExitOrWater == false)
                {
                    if ((  //							 GetMap(x, y - 1) == 1 &&  
                        GetMap(x - 1, y) == 0 && GetMap(x, y) == 0 && GetMap(x + 1, y) == 1 &&
                        GetMap(x - 1, y + 1) == 1 && GetMap(x, y + 1) == 0 && GetMap(x + 1, y + 1) == 0 &&
                        GetMap(x, y + 2) == 1)
                        ||
                        (  //							 GetMap(x, y - 1) == 1 &&  
                        GetMap(x - 1, y) == 1 && GetMap(x, y) == 0 && GetMap(x + 1, y) == 0 &&
                        GetMap(x - 1, y + 1) == 0 && GetMap(x, y + 1) == 0 && GetMap(x + 1, y + 1) == 1 &&
                        GetMap(x, y + 2) == 1))
                    {
                        SetMap(x - 1, y, 0);
                        SetMap(x + 1, y, 0);
                    }
                }
                x++;
            }
            y++;
        }
    }
    
    public function MakeSpikes() : Void
    {
        var y : Int = Math.floor(upperleft.y + 10);
        while (y < lowerright.y)
        {
            var x : Int = Math.floor(upperleft.x + 1);
            while (x < lowerright.x)
            {
                var bValid : Bool = true;
                
                if (
                    GetMap(x, y - 1) == 0 &&
                    GetMap(x - 1, y) == 1 && GetMap(x, y) == 0 &&
                    GetMap(x, y + 1) == 1)
                {
                    var length : Int = 0;
                    var keepgoing : Bool = true;
                    
                    var xx : Int = x;
                    while (xx < lowerright.x)
                    {
                        for (exit in exits)
                        {
                            if (xx == exit.x && y == exit.y)
                            {
                                bValid = false;
                                break;
                            }
                        }
                        
                        if (
                            //GetMap(xx, y - 1) == 0 &&
                            GetMap(xx, y) == 0 &&
                            GetMap(xx, y + 1) == 1)
                        {
                            if (GetMap(xx + 1, y) == 1)
                            {
                                length = Math.floor(xx - x + 2);
                                break;
                            }
                        }
                        else
                        {
                            bValid = false;
                            break;
                        }
                        xx++;
                    }
                    
                    var yoff : Int = 0;
                    
                    var pitheight : Int = 0;
                    var leftentry : Int = 0;
                    var rightentry : Int = 0;
                    
                    keepgoing = true;
                    
                    yoff = 0;
                    while (yoff < length + 2 && (leftentry == 0 || rightentry == 0))
                    {
                        if (leftentry == 0 && GetMap(x - 1, y - yoff) == 0)
                        {
                            leftentry = yoff;
                        }
                        
                        if (rightentry == 0 && GetMap(x + length, y - yoff) == 0)
                        {
                            rightentry = yoff;
                        }
                        yoff++;
                    }
                    
                    if (rand.int(0, 100) <= Content.nRequireSpaceForSpikesChance * 100)
                    
                    { // Guarantee jump space
                        
                        {
                            if (bValid)
                            {
                                xx = x;
                                while (xx < lowerright.x && keepgoing)
                                {
                                    if (GetMap(xx, y) == 1)
                                    {
                                        keepgoing = false;
                                        break;
                                    }
                                    
                                    yoff = 0;
                                    while ((yoff < length || yoff < leftentry + length || yoff < rightentry + length) && keepgoing)
                                    {
                                        if (GetMap(xx, y - yoff) == 1)
                                        {
                                            bValid = false;
                                            keepgoing = false;
                                            break;
                                        }
                                        yoff++;
                                    }
                                    xx++;
                                }
                            }
                        }
                    }
                    
                    if (bValid)
                    {
                        xx = x;
                        while (xx < lowerright.x)
                        {
                            if (GetMap(xx, y) == 0 &&
                                GetMap(xx, y + 1) == 1 &&
                                chambermap[x][y] == 0)
                            {
                                spikemap[xx][y] = 1;
                            }
                            else
                            {
                                break;
                            }
                            xx++;
                        }
                    }
                }
                x++;
            }
            y++;
        }
    }
    
    public function DropExits() : Void
    {
        for (exit in exits)
        {
            while (GetMap(exit.x, exit.y + 1) == 0)
            {
                exit.y++;
            }
        }
    }
    
    public function StampLine(size : Int, a : PointInt, b : PointInt) : Void
    {
        var stamp : Array<Dynamic> = new Array<Dynamic>();
        
        for (x in 0...size)
        {
            stamp.push(new Array<Dynamic>());
            
            for (y in 0...size)
            {
                stamp[stamp.length - 1].push(0);
            }
        }
        
        stamp = MakeCircleStamp(stamp, size);
        
        var z : Point = null;
        var xn : Float = -1;
        var yn : Float = -1;
        var perc : Float = -1;
        
        if (Math.abs(a.x - b.x) < Math.abs(a.y - b.y))
        {
            if (a.y > b.y)
            {
                z = a;
                a = b;
                b = z;
            }
            
            yn = a.y;
            while (yn <= b.y)
            {
                perc = (yn - a.y) / (b.y - a.y);
                var xchange : Float = perc * (b.x - a.x);
                xn = xchange + a.x;
                
                StampAt(SetMap, stamp, size, Math.floor(xn), Math.floor(yn));
                yn++;
            }
        }
        else if (a.x == b.x)
        {
            StampAt(SetMap, stamp, size, Math.floor(a.x), Math.floor(a.y));
        }
        else
        {
            if (a.x > b.x)
            {
                z = a;
                a = b;
                b = z;
            }
            
            xn = a.x;
            while (xn <= b.x)
            {
                perc = (xn - a.x) / (b.x - a.x);
                var ychange : Float = perc * (b.y - a.y);
                yn = ychange + a.y;
                
                StampAt(SetMap, stamp, size, Math.floor(xn), Math.floor(yn));
                xn++;
            }
        }
    }
    
    public function MakeCircleStamp(stamp : Array<Dynamic>, size : Int) : Array<Dynamic>
    {
        var halfsize : Float = size / 2;
        
        for (y in 0...size)
        {
            for (x in 0...size)
            {
                var hcorrection : Float = 0;
                var vcorrection : Float = 0;
                
                if (size % 2 == 0)
                {
                    if (x >= halfsize)
                    {
                        hcorrection = 1;
                    }
                    
                    if (y >= halfsize)
                    {
                        vcorrection = 1;
                    }
                }
                
                
                var xx : Float = x - halfsize + hcorrection;
                var yy : Float = y - halfsize + vcorrection;
                
                if (Math.sqrt((yy * yy) + (xx * xx)) < halfsize + 0.5)
                {
                    stamp[x][y] = 1;
                }
                else
                {
                    stamp[x][y] = 0;
                }
            }
        }
        
        return stamp;
    }
    
    
    public function StampAt(SetMapFunction : Function, stamp : Array<Dynamic>, size : Int, x : Int, y : Int) : Void
    {
        var halfsize : Float = size / 2;
        
        var sx : Int = Math.floor(x - Math.floor(halfsize));
        var sy : Int = Math.floor(y - Math.floor(halfsize));
        
        for (yy in 0...size)
        {
            for (xx in 0...size)
            {
                var cx : Int = Math.floor(sx + xx);
                var cy : Int = Math.floor(sy + yy);
                
                
                if (stamp[xx][yy] == 1)
                {
                    SetMapFunction(cx, cy, 0);
                }
            }
        }
    }
    
    
    public function ApplyFilter(f : Function, items : Int, variable : Int, deathchance : Int) : Bool
    //for (var i:int = 0; i < iterations; i++)   // PSH WHO DOES ITERATIONS ANYMORE
    {
        var failout : Int = 0;
        var keepgoing : Bool = false;
        
        do
        {
            backmap = Util.Clone(map);
            keepgoing = false;
            failout++;
            
            f(items, variable, deathchance);
            
            if (CheckExits() == false)
            {
                keepgoing = true;
            }
        }
        while ((keepgoing && failout < 4));
        
        if (failout == 4)
        
        { //trace("FAILED OUT");
            
            return true;
        }
        else
        {
            map = Util.Clone(backmap);
            
            return false;
        }
    }
    
    public function BackmapSafe() : Bool
    {
        var safe1 : Bool = false;
        var safe2 : Bool = false;
        
        for (ysafe in 0...height)
        {
            for (xsafe in 0...width)
            {
                if (GetBackmap(xsafe, ysafe) == 1)
                {
                    safe1 = true;
                }
                
                if (GetBackmap(xsafe, ysafe) == 0)
                {
                    safe2 = true;
                }
                
                if (safe1 && safe2)
                {
                    return true;
                }
            }
        }
        
        return false;
    }
    
    public function HowHighUp(x : Int, y : Int) : Int
    {
        var howhigh : Int = 0;
        
        while (GetBackmap(x, y) == 0)
        {
            howhigh++;
            y++;
        }
        
        return howhigh;
    }
    
    public function HowHighUpWater(x : Int, y : Int) : Int
    {
        var howhigh : Int = 0;
        
        while (GetMap(x, y) == 0 && watermap[x][y] == 0)
        {
            howhigh++;
            y++;
        }
        
        return howhigh;
    }
    
    
    public function Plats(items : Int, variable : Int, notused : Int) : Void
    {
        if (BackmapSafe() == false)
        {
            return;
        }
        
        for (i in 0...items)
        {
            remplats++;
            
            if (remplats % 10 == 0)
            {
                points.splice(0, points.length);
                
                var y : Int = upperleft.y;
                while (y < lowerright.y)
                {
                    var x : Int = upperleft.x;
                    while (x < lowerright.x)
                    {
                        if (GetBackmap(x, y) == 1 && (GetBackmap(x + 1, y) == 0) ||
                            (GetBackmap(x, y) == 0 && (GetBackmap(x + 1, y) == 1) ||
                            (HowHighUp(x, y) > 5 && rand.int(0, 100) < 40)
                            ||
                            (GetBackmap(x, y) == 0 && rand.int(0, 100) < 10)))
                        {
                            points.push(new PointInt(x, y));
                        }
                        x++;
                    }
                    y++;
                }
            }
            
            if (points.length > 0)
            {
                var p : Int = rand.int(0, points.length);
                var pt : PointInt = points[p];
                
                var span : Int = Math.floor(rand.int(0, variable) + (variable / 2) + 1);
                
                var h : Int = -1;
                
                h = Math.floor(pt.x - (span / 2));
                while (h < pt.x + (span / 2))
                {
                    SetBackmap(h, pt.y + 1, 1);
                    h++;
                }
                
                h = Math.floor(pt.x - (span / 2) + 1 + (rand.int(0, 2)));
                while (h < pt.x + (span / 2) - 1 - (rand.int(0, 2)))
                {
                    SetBackmap(h, pt.y, 1);
                    h++;
                }
            }
            else
            {
                trace("No valid plat points??");
            }
        }
    }
    
    public function Pools(items : Int, variable : Int, notused : Int) : Void
    {
        var points : Array<Dynamic> = new Array<Dynamic>();
        var success : Int = 0;
        var fail : Int = 0;
        
        var x : Int = 0;
        var y : Int = 0;
        
        while (success < items && fail < 500)
        {
            x = rand.int(upperleft.x, lowerright.x);
            y = rand.int(upperleft.y, lowerright.y);
            
            if (GetBackmap(x, y) == 0 && watermap[x][y] == 0)
            {
                var shallow : Bool = false;
                while (!shallow && GetBackmap(x, y) == 0 && watermap[i][y] == 0)
                {
                    if (x == 130 && y == 120)
                    {
                        var a : Int = 2;
                    }
                    
                    var i : Int = x;
                    
                    while (i != 0 && (GetBackmap(i, y) == 0 || watermap[i][y + 1] > 0) && watermap[i][y] == 0)
                    {
                        i--;
                    }
                    
                    var startx : Int = Math.floor(i + 1);
                    
                    i = startx;
                    while ((GetBackmap(i, y) == 0 || watermap[i][y + 1] > 0) && watermap[i][y] == 0)
                    {
                        shallow = true;
                        
                        if (GetBackmap(i, y + 1) > 0 || watermap[i][y + 1] > 0)
                        {  // shallow  
                            
                        }
                        else
                        {
                            shallow = false;
                            x = i;
                            y++;
                            break;
                        }
                        i++;
                    }
                    
                    if (shallow)
                    {
                        i = startx;
                        while ((GetBackmap(i, y) == 0 || watermap[i][y + 1] > 0) && watermap[i][y] == 0)
                        {
                            watermap[i][y] = 1;
                            success++;
                            i++;
                        }
                    }
                }
            }
            
            fail++;
        }
    }
    
    public function Pillars(items : Int, variable : Int, notused : Int) : Void
    {
        var points : Array<Dynamic> = new Array<Dynamic>();
        var fail : Int = 0;
        
        while (points.length < variable && fail != -1)
        {
            var x : Int = rand.int(upperleft.x, lowerright.x);
            var y : Int = rand.int(upperleft.y, lowerright.y);
            
            if (GetBackmap(x, y) == 0 && GetBackmap(x, y + 1) == 1)
            {
                points.push(new PointInt(x, y));
            }
            
            fail++;
        }
        
        for (pt in points)
        {
            var minY : Int = Math.floor(-1 * variable * (rand.int(50, 150) / 100));
            
            for (yy in minY...0)
            {
                SetBackmap(pt.x, pt.y + yy, 1);
            }
        }
    }
    
    public function Plateaus(items : Int, variable : Int, deathchance : Int) : Void
    /*
			for (var yy:int = upperleft.y; yy < lowerright.y; yy++)
            {
				for (var xx:int = upperleft.x; xx < lowerright.x; xx++)
                {
					
				}
			}*/
    {
        
        
        if (BackmapSafe() == false)
        {
            return;
        }
        
        var points : Array<Dynamic> = new Array<Dynamic>();
        var fail : Int = 0;
        
        while (points.length < items && fail < 500)
        {
            var x : Int = rand.int(upperleft.x + 10, lowerright.x - 10);
            var y : Int = rand.int(upperleft.y, lowerright.y);
            
            
            if (GetBackmap(x, y) == 0 && GetBackmap(x, y + 1) == 1)
            {
                fail--;
                
                var dir : Int = rand.int(0, 2);
                
                
                dir *= 2;
                dir--;
                
                if (GetBackmap(x + dir, y) == 0)
                {
                    fail++;
                }
                else
                {
                    var tosurmount : Int = 1;
                    
                    while (GetBackmap(x + dir, y - tosurmount) == 1)
                    {
                        tosurmount++;
                    }
                    
                    if (tosurmount > variable)
                    {
                        fail++;
                    }
                    else
                    {
                        var bAllDone : Bool = false;
                        
                        
                        var xx : Int = Math.floor(x + dir + dir);
                        while (xx >= upperleft.x + 10 && xx <= lowerright.x - 10 && !bAllDone)
                        {
                            var yy : Int = y;
                            while (yy > upperleft.y + 10 && !bAllDone)
                            {
                                if (rand.int(1, 100) <= deathchance)
                                {
                                    break;
                                }
                                else if (GetBackmap(xx, yy) == 0)
                                {
                                    if (yy == y - tosurmount)
                                    {
                                        bAllDone = true;
                                    }
                                    
                                    break;
                                }
                                else
                                {
                                    points.push(new PointInt(xx, yy));
                                }
                                yy--;
                            }
                            
                            if (rand.int(1, 100) <= deathchance)
                            {
                                y--;
                            }
                            xx += dir;
                        }
                    }
                }
            }
            
            fail++;
        }
        
        for (pt in points)
        {
            SetBackmap(pt.x, pt.y, 0);
        }
    }
    
    
    
    public function Clumps(items : Int, variable : Int, notused : Int) : Void
    {
        var x : Int;
        var y : Int;
        var i : Int;
        
        if (BackmapSafe() == false)
        {
            return;
        }
        
        var points : Array<Dynamic> = new Array<Dynamic>();
        var fail : Int = 0;
        
        while (points.length < items && fail < 500)
        {
            x = rand.int(upperleft.x, lowerright.x);
            y = rand.int(upperleft.y, lowerright.y);
            
            
            if (GetBackmap(x, y) == 0)
            {
                fail--;
                
                var chance : Float = rand.int(0, 100);
                
                if (GetBackmap(x + 1, y) == 1)
                {
                    chance /= 3;
                }
                if (GetBackmap(x - 1, y) == 1)
                {
                    chance /= 3;
                }
                if (GetBackmap(x, y + 1) == 1)
                {
                    chance /= 3;
                }
                if (GetBackmap(x, y - 1) == 1)
                {
                    chance /= 3;
                }
                
                if (chance <= variable)
                {
                    points.push(new PointInt(x, y));
                }
            }
            
            fail++;
        }
        
        for (pt in points)
        {
            SetBackmap(pt.x, pt.y, 1);
        }
    }
    
    public function Rounds(items : Int, variable : Int, notused : Int) : Void
    {
        var points : Array<Dynamic> = new Array<Dynamic>();
        
        
        var x : Int = 5;
        while (x < this.width - 5)
        {
            var y : Int = 5;
            while (y < this.width - 5)
            {
                if (GetBackmap(x - 1, y - 1) == 1 && GetBackmap(x + 0, y - 1) == 0 && GetBackmap(x + 1, y - 1) == 0 &&
                    GetBackmap(x - 1, y + 0) == 1 && GetBackmap(x + 0, y + 0) == 0 && GetBackmap(x + 1, y + 0) == 0 &&
                    GetBackmap(x - 1, y + 1) == 1 && GetBackmap(x + 0, y + 1) == 1 && GetBackmap(x + 1, y + 1) == 1)
                {
                    points.push(new PointInt(x, y));
                }
                else if (GetBackmap(x - 1, y - 1) == 1 && GetBackmap(x + 0, y - 1) == 1 && GetBackmap(x + 1, y - 1) == 1 &&
                    GetBackmap(x - 1, y + 0) == 1 && GetBackmap(x + 0, y + 0) == 0 && GetBackmap(x + 1, y + 0) == 0 &&
                    GetBackmap(x - 1, y + 1) == 1 && GetBackmap(x + 0, y + 1) == 0 && GetBackmap(x + 1, y + 1) == 0)
                {
                    points.push(new PointInt(x, y));
                }
                else if (GetBackmap(x - 1, y - 1) == 0 && GetBackmap(x + 0, y - 1) == 0 && GetBackmap(x + 1, y - 1) == 1 &&
                    GetBackmap(x - 1, y + 0) == 0 && GetBackmap(x + 0, y + 0) == 0 && GetBackmap(x + 1, y + 0) == 1 &&
                    GetBackmap(x - 1, y + 1) == 1 && GetBackmap(x + 0, y + 1) == 1 && GetBackmap(x + 1, y + 1) == 1)
                {
                    points.push(new PointInt(x, y));
                }
                else if (GetBackmap(x - 1, y - 1) == 1 && GetBackmap(x + 0, y - 1) == 1 && GetBackmap(x + 1, y - 1) == 1 &&
                    GetBackmap(x - 1, y + 0) == 0 && GetBackmap(x + 0, y + 0) == 0 && GetBackmap(x + 1, y + 0) == 1 &&
                    GetBackmap(x - 1, y + 1) == 0 && GetBackmap(x + 0, y + 1) == 0 && GetBackmap(x + 1, y + 1) == 1)
                {
                    points.push(new PointInt(x, y));
                }
                y++;
            }
            x++;
        }
        
        
        var i : Int = 0;
        while (i < variable && points.length > 0)
        {
            var which : Int = rand.int(0, points.length - 1);
            
            var forbidden : Bool = false;
            
            for (ex in exits)
            {
                if (
                    points[which].x == ex.x &&
                    (points[which].y == ex.y || points[which].y != ex.y - 1))
                {
                    forbidden = true;
                    break;
                }
            }
            
            if (forbidden == false)
            {
                SetBackmap(points[which].x, points[which].y, 1);
            }
            
            points.splice(which, 1);
            i++;
        }
    }
    
    public function Pixels(items : Int, variable : Int, notused : Int) : Void
    {
        var points : Array<Dynamic> = new Array<Dynamic>();
        var fail : Int = 0;
        
        
        var x : Int = 5;
        while (x < this.width - 5)
        {
            var y : Int = 5;
            while (y < this.width - 5)
            {
                var t : Int = Math.floor(GetBackmap(x + 0, y + 0) + GetBackmap(x + 1, y + 0) + GetBackmap(x + 0, y + 1) + GetBackmap(x + 1, y + 1));
                
                if (t != 0 && t != 4)
                {
                    points.push(new PointInt(x, y));
                }
                y += 2;
            }
            x += 2;
        }
        
        var i : Int = 0;
        while (i < variable && points.length > 0)
        {
            var which : Int = rand.int(0, points.length - 1);
            var onoff : Int = rand.int(0, 2);
            
            
            
            SetBackmap(points[which].x, points[which].y, onoff);
            SetBackmap(points[which].x + 1, points[which].y, onoff);
            SetBackmap(points[which].x, points[which].y + 1, onoff);
            SetBackmap(points[which].x + 1, points[which].y + 1, onoff);
            
            points.splice(which, 1);
            i++;
        }
    }
    
    public function ChewCave(items : Int, variable : Int, notused : Int) : Void
    {
        var points : Array<Dynamic> = new Array<Dynamic>();
        
        for (i in 0...items)
        {
            points.splice(0, points.length);
            
            var y : Int = 20;
            while (y < this.height - 20)
            {
                var x : Int = 20;
                while (x < this.width - 20)
                {
                    if (GetBackmap(x, y) == 1 && (GetBackmap(x, y + 1) == 0) || GetBackmap(x, y - 1) == 0)
                    {
                        points.push(new PointInt(x, y));
                    }
                    x++;
                }
                y++;
            }
        }
        
        var p : Int = 0;
        while (p < points.length)
        {
            var which : Int = rand.int(0, points.length - 1);
            
            var stamp : Array<Dynamic> = new Array<Dynamic>();
            
            for (xx in 0...variable)
            {
                stamp.push(new Array<Dynamic>());
                
                for (yy in 0...variable)
                {
                    stamp[stamp.length - 1].push(0);
                }
            }
            
            stamp = MakeCircleStamp(stamp, variable);
            
            StampAt(SetBackmap, stamp, variable, Math.floor(points[which].x), Math.floor(points[which].y));
            p++;
        }
    }
    
    public function PurgeOnes(percentage : Int, variable : Int, notused : Int) : Void
    {
        if (BackmapSafe() == false)
        {
            return;
        }
        
        var points : Array<Dynamic> = new Array<Dynamic>();
        var fail : Int = 0;
        
        
        
        var x : Int = 1;
        while (x < width - 1)
        {
            var y : Int = 1;
            while (y < height - 1)
            {
                if (percentage > -1)
                {
                    if (GetBackmap(x, y) == 1 &&
                        GetBackmap(x - 1, y) == 0 &&
                        GetBackmap(x + 1, y) == 0 &&
                        GetBackmap(x, y - 1) == 0 &&
                        GetBackmap(x, y + 1) == 0)
                    {
                        points.push(new PointInt(x, y));
                    }
                }
                else if (wallmap[x][y] == 1 &&
                    wallmap[x - 1][y] == 0 &&
                    wallmap[x + 1][y] == 0 &&
                    wallmap[x][y - 1] == 0 &&
                    wallmap[x][y + 1] == 0)
                {
                    points.push(new PointInt(x, y));
                }
                y++;
            }
            x++;
        }
        
        var kill : Float = points.length * (percentage / 100);
        
        if (percentage == -1)
        {
            kill = 10000000;
        }
        
        trace("Killing " + Std.string(kill) + " ones");
        
        var i : Int = 0;
        while (i < kill && points.length > 0)
        {
            var which : Int = rand.int(0, points.length - 1);
            
            if (percentage > -1)
            {
                SetBackmap(points[which].x, points[which].y, 0);
            }
            else
            {
                wallmap[points[which].x][points[which].y] = 0;
            }
            
            points.splice(which, 1);
            i++;
        }
    }
    
    
    public function FillAccessible() : Void
    {
        var checkmap : Array<Dynamic> = Util.Clone(map);
        
        accessiblemap = new Array<Dynamic>();
        
        for (xx in 0...width)
        {
            accessiblemap.push(new Array<Dynamic>());
            
            for (yy in 0...height)
            {
                accessiblemap[accessiblemap.length - 1].push(0);
            }
        }
        
        var checkers : Array<Dynamic> = new Array<Dynamic>();
        checkers.push(new PointInt(exits[0].x, exits[0].y));
        
        while (checkers.length > 0)
        {
            var oldcheckers : Array<PointInt> = new Array<PointInt>();
            
            for (pt in checkers)
            {
                accessiblemap[pt.x][pt.y] = 1;
                oldcheckers.push(new PointInt());
                oldcheckers[oldcheckers.length - 1] = pt;
            }
            
            var i : Int = 0;
            
            i = 0;
            while (i < oldcheckers.length)
            {
                var tocheck : PointInt = oldcheckers[i];
                
                if (tocheck.y > 0)
                {
                    if (checkmap[tocheck.x][tocheck.y - 1] % 2 == 0 ||
                        (checkmap[tocheck.x][tocheck.y - 1] == 0 && intangmap[tocheck.x][tocheck.y - 1] == 1))
                    {
                        checkmap[tocheck.x][tocheck.y - 1] = 3;
                        checkers.push(new PointInt(tocheck.x, tocheck.y - 1));
                    }
                }
                
                if (tocheck.y < height - 1)
                {
                    if (checkmap[tocheck.x][tocheck.y + 1] % 2 == 0 ||
                        (checkmap[tocheck.x][tocheck.y + 1] == 0 && intangmap[tocheck.x][tocheck.y + 1] == 1))
                    {
                        checkmap[tocheck.x][tocheck.y + 1] = 3;
                        checkers.push(new PointInt(tocheck.x, tocheck.y + 1));
                    }
                }
                
                if (tocheck.x > 0)
                {
                    if (checkmap[tocheck.x - 1][tocheck.y] % 2 == 0 ||
                        (checkmap[tocheck.x - 1][tocheck.y] == 0 && intangmap[tocheck.x - 1][tocheck.y] == 1))
                    {
                        checkmap[tocheck.x - 1][tocheck.y] = 3;
                        checkers.push(new PointInt(tocheck.x - 1, tocheck.y));
                    }
                }
                
                if (tocheck.x < width - 1)
                {
                    if (checkmap[tocheck.x + 1][tocheck.y] % 2 == 0 ||
                        (checkmap[tocheck.x + 1][tocheck.y] == 0 && intangmap[tocheck.x + 1][tocheck.y] == 1))
                    {
                        checkmap[tocheck.x + 1][tocheck.y] = 3;
                        checkers.push(new PointInt(tocheck.x + 1, tocheck.y));
                    }
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
    
    public var intangplan : Array<Dynamic> = null;
    public var secretchamberplan : Array<Dynamic> = null;
    public function MakeIntangibles(wigglechance : Int, hintchance : Int, deathchance : Int) : Void
    {
        var x : Int;
        if (Content.bSecretChambers)
        {
            intangs.splice(0, intangs.length);
            
            var leftentrances : Array<Dynamic> = new Array<Dynamic>();
            var rightentrances : Array<Dynamic> = new Array<Dynamic>();
            
            x = upperleft.x;
            while (x < lowerright.x)
            {
                y = upperleft.y;
                while (y < lowerright.y)
                {
                    if (x % 2 == 0 && y % 2 == 0 &&
                        accessiblemap[x][y] == 1 &&
                        //GetMap(x, y - 1) == 1 &&
                        //GetMap(x, y + 1) == 1 &&
                        watermap[x - 1][y] != 1 &&
                        watermap[x + 1][y] != 1 &&
                        watermap[x][y - 1] != 1 &&
                        watermap[x][y + 1] != 1)
                    {
                        var fail : Bool = false;
                        
                        if (candidatelists != null)
                        {
                            if (candidatelists[0] != null)
                            {
                                for (e in candidatelists[0])
                                {
                                    if (Math.abs(e.x - x) <= 6 &&
                                        Math.abs(e.y - y) <= 6 &&
                                        e.id == 0)
                                    {
                                        fail = true;
                                        break;
                                    }
                                }
                            }
                        }
                        
                        if (fail == false)
                        {
                            if (GetMap(x - 1, y) == 1 && GetMap(x + 1, y) == 0 &&
                                GetMap(x - 1, y + 1) == 1 && GetMap(x - 1, y - 1) == 1)
                            {
                                leftentrances.push(new PointInt(x, y));
                            }
                            else if (GetMap(x - 1, y) == 0 && GetMap(x + 1, y) == 1 &&
                                GetMap(x + 1, y + 1) == 1 && GetMap(x + 1, y - 1) == 1)
                            {
                                rightentrances.push(new PointInt(x, y));
                            }
                        }
                    }
                    y++;
                }
                x++;
            }
            
            var rcull : Int = 0;
            
            while (leftentrances.length - rightentrances.length > 3)
            {
                rcull = rand.int(0, leftentrances.length);
                leftentrances.splice(rcull, 1);
            }
            
            while (rightentrances.length - leftentrances.length > 3)
            {
                rcull = rand.int(0, rightentrances.lengt);
                rightentrances.splice(rcull, 1);
            }
            
            while (rightentrances.length + leftentrances.length > 6)
            {
                if (leftentrances.length >= rightentrances.length)
                {
                    rcull = rand.int(0, leftentrances.length);
                    leftentrances.splice(rcull, 1);
                }
                else
                {
                    rcull = rand.int(0, rightentrances.length);
                    rightentrances.splice(rcull, 1);
                }
            }
            
            trace("Pre: Secrets on left: " + Std.string(leftentrances.length) + "  Secrets on right: " + Std.string(rightentrances.length));
            
            for (side in 0...2)
            {
                var dirx : Int = 0;
                var diry : Int = 0;
                var curx : Int = 0;
                var cury : Int = 0;
                
                var iterations : Int = 0;
                
                if (side == 0)
                {
                    iterations = leftentrances.length;
                }
                else
                {
                    iterations = rightentrances.length;
                }
                
                for (var i : Int = 0; i < iterations; ++i)
                {
                    dirx = Math.floor(-1 + (side * 2));  // i.e., -1 for left, +1 for right  
                    diry = 0;
                    
                    intangplan = new Array<Dynamic>();
                    intangplan.splice(0, intangplan.length);
                    
                    secretchamberplan = new Array<Dynamic>();
                    secretchamberplan.splice(0, secretchamberplan.length);
                    
                    if (side == 0)
                    {
                        curx = Math.floor(leftentrances[i].x + dirx);  // prime it  
                        cury = leftentrances[i].y;
                    }
                    else
                    {
                        curx = Math.floor(rightentrances[i].x + dirx);  // prime it  
                        cury = rightentrances[i].y;
                    }
                    
                    
                    intangplan.push(new PointInt(curx, cury));
                    
                    var bAlive : Bool = true;
                    var bValid : Bool = true;
                    
                    var step : Int = 0;
                    
                    
                    while (bAlive && bValid)
                    {
                        curx += dirx;
                        cury += diry;
                        
                        step++;
                        
                        
                        if (!NearIllegal(curx, cury))
                        {
                            if (rand.int(0, 100) >= deathchance || diry == -1 || diry == 1)
                            {
                                if (rand.int(0, 100) < wigglechance && curx % 2 == 0 && cury % 2 == 0)
                                {
                                    var newdir : Int = Math.floor((rand.int(0, 2) * 2) - 1);
                                    
                                    if (dirx != 0)
                                    {
                                        dirx = 0;
                                        diry = newdir;
                                    }
                                    else
                                    {
                                        dirx = newdir;
                                        diry = 0;
                                    }
                                }
                                
                                for (checkp in intangplan)
                                {
                                    if (checkp.x == curx && checkp.y == cury)
                                    {
                                        bValid = false;
                                    }
                                }
                                
                                intangplan.push(new PointInt(curx, cury));
                            }
                            else
                            {
                                bAlive = false;
                                
                                MakeSecretChamber(curx, cury, dirx, diry);
                            }
                        }
                        else
                        {
                            bValid = false;
                        }
                    }
                    
                    if (intangplan.length < 6 || intangplan.length > 25)
                    {
                        bValid = false;
                    }
                    
                    if (bValid)
                    {
                        for (p in intangplan)
                        {
                            intangs.push(new PointInt(p.x, p.y));
                        }
                        
                        for (sp in secretchamberplan)
                        {
                            intangs.push(new PointInt(sp.x, sp.y));
                        }
                        
                        for (intangpoint in intangs)
                        {
                            if (intangpoint.x < 0)
                            {
                                intangmap[intangpoint.x * -1][intangpoint.y * -1] = Content.INTANG_CHAMBER;
                            }
                            else if (intangmap[intangpoint.x][intangpoint.y] == 0)
                            
                            { // Don't set 2s to 1s
                                
                                {
                                    intangmap[intangpoint.x][intangpoint.y] = Content.INTANG_TUNNEL;
                                }
                            }
                        }
                    }
                    else if (side == 0)
                    {
                        leftentrances.splice(i, 1);
                        iterations--;
                        i--;
                    }
                    else
                    {
                        rightentrances.splice(i, 1);
                        iterations--;
                        i--;
                    }
                }
            }
            
            trace("Post: Secrets on left: " + Std.string(leftentrances.length) + "  Secrets on right: " + Std.string(rightentrances.length));
        }
        
        var x : Int;
        var y : Int;
        x = Math.floor(upperleft.x + 5);
        while (x < lowerright.x - 5)
        {
            y = Math.floor(upperleft.y + 5);
            while (y < lowerright.y - 5)
            {
                if (intangmap[x][y] == 0 &&
                    watermap[x - 1][y] == 0)
                {
                    var bQualifiedSecretTunnel : Bool = false;
                    
                    for (xx in 0...x)
                    {
                        if (xx == 143 && y == 126)
                        {
                            var c : Int = 0;
                        }
                        
                        if (intangmap[xx][y] == 0 &&
                            intangmap[xx + 1][y] == 0 &&
                            GetBackmap(xx, y - 1) == 1 &&
                            GetBackmap(xx, y) == 0 &&
                            GetBackmap(xx, y + 1) == 1 &&
                            watermap[xx][y - 1] == 0 &&
                            watermap[xx][y] == 0 &&
                            watermap[xx][y + 1] == 0 &&
                            watermap[xx + 1][y] == 0)
                        {
                            if (!bQualifiedSecretTunnel)
                            {
                                if (xx >= x + Content.nSecretTunnelMinimum)
                                {
                                    xx = Math.floor(x - 1);
                                    bQualifiedSecretTunnel = true;
                                }
                            }
                            else
                            {
                                intangmap[xx][y] = Content.INTANG_RESERVE;
                            }
                        }
                        else
                        {
                            if (bQualifiedSecretTunnel && rand.int(0, 2) != 0)
                            {
                                intangmap[xx - 1][y] = 0;
                            }  // "Undo" last one  
                            
                            break;
                        }
                    }
                    
                    if (bQualifiedSecretTunnel && rand.int(0, 2) != 0)
                    {
                        intangmap[x][y] = 0;
                    }
                }
                y++;
            }
            x++;
        }
        
        //Iterate through grid and clamp "hint reveals" if legal
        
        x = 0;
        while (x < this.width)
        {
            y = 0;
            while (y < this.height - 1)
            {
                if (intangmap[x][y] == Content.INTANG_CHAMBER && intangmap[x][y + 1] != 1)
                {
                    intangmap[x][y] = 0;
                    SetBackmap(x, y, 0);
                    chambermap[x][y] = 1;
                    secrets.push(new PointInt(x, y));
                }
                y++;
            }
            x++;
        }
    }
    
    public function GrowIce(starts : Int) : Array<Dynamic>
    {
        var checkmap : Array<Dynamic> = Util.Clone(map);
        
        var checkers : Array<Dynamic> = new Array<Dynamic>();
        
        var generalstop : Int = 30;
        var fuels : Array<Dynamic> = new Array<Dynamic>();
        
        
        
        
        
        for (starti in 0...starts)
        {
            var xx : Int = rand.int(50, width - 50);
            var yy : Int = rand.int(50, width - 50);
            var fails : Int = 0;
            
            do
            {
                fails++;
                if (fails > 500)
                {
                    trace("Not finding ice spots [] [] [] [] [] [] []");
                    break;
                }
                xx = rand.int(50, width - 50);
                yy = rand.int(50, width - 50);
            }
            while ((!ValidIceStart(xx, yy)));
            
            fuels.push(rand.int(Content.iIceFuelMin, Content.iIceFuelMax));
            checkmap[xx][yy] = 10 + starti;
            checkers.push(new PointInt(xx, yy));
        }
        
        if (fails <= 500)
        {
            while (checkers.length > 0)
            {
                var oldcheckers : Array<Dynamic> = new Array<Dynamic>();
                
                for (pt in checkers)
                {
                    oldcheckers.push(new PointInt());
                    oldcheckers[oldcheckers.length - 1] = pt;
                }
                
                var i : Int = 0;
                
                i = 0;
                while (i < oldcheckers.length)
                {
                    var tocheck : PointInt = oldcheckers[i];
                    var species : Int = checkmap[tocheck.x][tocheck.y];
                    
                    if (fuels[species - 10] > 0)
                    {
                        if (tocheck.y > 0)
                        {
                            if (ValidForIce(tocheck.x, tocheck.y - 1) == true && checkmap[tocheck.x][tocheck.y - 1] < 3)
                            {
                                checkmap[tocheck.x][tocheck.y - 1] = species;
                                
                                if (rand.int(1, 100) > generalstop)
                                {
                                    fuels[species - 10]--;
                                    checkers.push(new PointInt(tocheck.x, tocheck.y - 1));
                                }
                            }
                        }
                        
                        if (tocheck.y < height - 1)
                        {
                            if (ValidForIce(tocheck.x, tocheck.y + 1) == true && checkmap[tocheck.x][tocheck.y + 1] < 3)
                            {
                                checkmap[tocheck.x][tocheck.y + 1] = species;
                                
                                if (rand.int(1, 100) > generalstop)
                                {
                                    fuels[species - 10]--;
                                    checkers.push(new PointInt(tocheck.x, tocheck.y + 1));
                                }
                            }
                        }
                        
                        if (tocheck.x > 0)
                        {
                            if (ValidForIce(tocheck.x - 1, tocheck.y) == true && checkmap[tocheck.x - 1][tocheck.y] < 3)
                            {
                                checkmap[tocheck.x - 1][tocheck.y] = species;
                                
                                if (rand.int(1, 100) > generalstop)
                                {
                                    fuels[species - 10]--;
                                    checkers.push(new PointInt(tocheck.x - 1, tocheck.y));
                                }
                            }
                        }
                        
                        if (tocheck.x < width - 1)
                        {
                            if (ValidForIce(tocheck.x + 1, tocheck.y) == true && checkmap[tocheck.x + 1][tocheck.y] < 3)
                            {
                                checkmap[tocheck.x + 1][tocheck.y] = species;
                                
                                if (rand.int(1, 100) > generalstop)
                                {
                                    fuels[species - 10]--;
                                    checkers.push(new PointInt(tocheck.x + 1, tocheck.y));
                                }
                            }
                        }
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
        }
        
        var ices : Array<Dynamic> = new Array<Dynamic>();
        
        var ix : Int = 10;
        while (ix < this.width - 10)
        {
            var iy : Int = 10;
            while (iy < this.height - 10)
            {
                if (checkmap[ix][iy] >= 10)
                {
                    ices.push(new PointInt(ix, iy));
                }
                else if (watermap[ix][iy] == 1 && watermap[ix][iy - 1] == 0 && GetMap(ix, iy) == 0)
                {
                    ices.push(new PointInt(ix, iy));
                }
                iy++;
            }
            ix++;
        }
        
        return ices;
    }
    
    public function ValidIceStart(x : Int, y : Int) : Bool
    {
        if (GetMap(x, y) != 0 ||
            watermap[x][y] != 0 ||
            spikemap[x][y] != 0 ||
            intangmap[x][y] != 0 ||
            gemmap[x][y] != 0)
        {
            return false;
        }
        
        for (ex in exits)
        {
            if (Util.Distance(ex.x, ex.y, x, y) <= 3)
            {
                return false;
            }
        }
        
        if (GetMap(x - 1, y) == 1 ||
            GetMap(x + 1, y) == 1 ||
            GetMap(x, y - 1) == 1 ||
            GetMap(x, y + 1) == 1)
        {
            return true;
        }
        
        return false;
    }
    
    public function ValidForIce(x : Int, y : Int) : Bool
    {
        if (GetMap(x, y) != 0 ||
            watermap[x][y] != 0 ||
            spikemap[x][y] != 0 ||
            intangmap[x][y] != 0 ||
            gemmap[x][y] != 0)
        {
            return false;
        }
        
        for (ex in exits)
        {
            if (Util.Distance(ex.x, ex.y, x, y) <= 3)
            {
                return false;
            }
        }
        
        return true;
    }
    
    public function MakeSecretChamber(startx : Int, starty : Int, dirx : Int, diry : Int) : Void
    {
        var checkmap : Array<Dynamic> = Util.Clone(map);
        
        var checkers : Array<Dynamic> = new Array<Dynamic>();
        
        
        var groundstop : Int = 60;
        var ceilingstop : Int = 50;
        var generalstop : Int = 30;
        var fuel : Int = rand.int(10, 20);
        
        
        
        for (intang in intangplan)
        {
            checkmap[intang.x][intang.y] = 4;
            
            checkmap[intang.x][intang.y + 1] = 4;
            checkmap[intang.x][intang.y - 1] = 4;
            checkmap[intang.x + 1][intang.y] = 4;
            checkmap[intang.x - 1][intang.y] = 4;
            checkmap[intang.x - 1][intang.y + 1] = 4;
            checkmap[intang.x + 1][intang.y - 1] = 4;
            checkmap[intang.x + 1][intang.y + 1] = 4;
            checkmap[intang.x - 1][intang.y - 1] = 4;
        }
        
        checkmap[startx][starty] = 3;
        
        startx += dirx;
        starty += diry;
        
        checkmap[startx][starty] = 3;
        checkers.push(new PointInt(startx, starty));
        
        while (checkers.length > 0)
        {
            var oldcheckers : Array<Dynamic> = new Array<Dynamic>();
            
            for (pt in checkers)
            {
                oldcheckers.push(new PointInt());
                oldcheckers[oldcheckers.length - 1] = pt;
            }
            
            var i : Int = 0;
            
            i = 0;
            while (i < oldcheckers.length)
            {
                var tocheck : PointInt = oldcheckers[i];
                
                if (fuel > 0)
                {
                    if (tocheck.y > 0)
                    {
                        if (NearIllegal(tocheck.x, tocheck.y - 1) == false && checkmap[tocheck.x][tocheck.y - 1] < 3)
                        {
                            checkmap[tocheck.x][tocheck.y - 1] = 3;
                            
                            if (rand.int(1, 100) > ceilingstop)
                            {
                                fuel--;
                                checkers.push(new PointInt(tocheck.x, tocheck.y - 1));
                            }
                        }
                    }
                    
                    if (tocheck.y < height - 1)
                    {
                        if (NearIllegal(tocheck.x, tocheck.y + 1) == false && checkmap[tocheck.x][tocheck.y + 1] < 3)
                        {
                            checkmap[tocheck.x][tocheck.y + 1] = 3;
                            
                            if (rand.int(1, 100) > groundstop)
                            {
                                fuel--;
                                checkers.push(new PointInt(tocheck.x, tocheck.y + 1));
                            }
                        }
                    }
                    
                    if (tocheck.x > 0)
                    {
                        if (NearIllegal(tocheck.x - 1, tocheck.y) == false && checkmap[tocheck.x - 1][tocheck.y] < 3)
                        {
                            checkmap[tocheck.x - 1][tocheck.y] = 3;
                            
                            if (rand.int(1, 100) > generalstop)
                            {
                                fuel--;
                                checkers.push(new PointInt(tocheck.x - 1, tocheck.y));
                            }
                        }
                    }
                    
                    if (tocheck.x < width - 1)
                    {
                        if (NearIllegal(tocheck.x + 1, tocheck.y) == false && checkmap[tocheck.x + 1][tocheck.y] < 3)
                        {
                            checkmap[tocheck.x + 1][tocheck.y] = 3;
                            
                            if (rand.int(1, 100) > generalstop)
                            {
                                fuel--;
                                checkers.push(new PointInt(tocheck.x + 1, tocheck.y));
                            }
                        }
                    }
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
        
        var x : Int = 0;
        while (x < this.width)
        {
            var y : Int = 0;
            while (y < this.height)
            {
                if (checkmap[x][y] == 3)
                {
                    secretchamberplan.push(new PointInt(x * -1, y * -1));
                    secrets.unshift(new PointInt(x, y));
                }
                y++;
            }
            x++;
        }
        
        return;
    }
    
    public function NearIllegal(xtest : Int, ytest : Int) : Bool
    {
        if (xtest < 0 || xtest >= this.width || ytest < 0 || ytest >= this.height)
        {
            return false;
        }
        
        var x : Int = Math.floor(xtest - 1);
        while (x <= xtest + 1)
        {
            var y : Int = Math.floor(ytest - 1);
            while (y <= ytest + 1)
            {
                if (GetMap(x, y) != 1 || watermap[x][y] >= 1 || chambermap[x][y] >= 1 || intangmap[x][y] >= 1)
                {
                    return true;
                }
                y++;
            }
            x++;
        }
        
        return false;
    }
    
    public function NearIntang(xtest : Int, ytest : Int) : Bool
    {
        return false;
    }
    
    public var candidatelists : Array<Dynamic> = null;
    public function MakeSecrets() : Void
    {
        secrets.splice(0, secrets.length);
        floorsecrets.splice(0, floorsecrets.length);
        
        candidatelists = new Array<Dynamic>();
        var exitlist : Array<Dynamic> = new Array<Dynamic>();
        
        var i : Int = 0;
        var n : Int = 0;
        
        i = 0;
        while (i < exits.length)
        {
            if (exits[i].id != 99)
            {
                var thisexit : Array<Dynamic> = new Array<Dynamic>();
                thisexit.push(exits[i]);
                
                candidatelists.push(cast((thisexit), GetCandidates));
                
                exitlist.push(exits[i]);
            }
            i++;
        }
        
        candidatelists.push(cast((exitlist), GetCandidates));
        
        var length : Int = candidatelists[0].length;
        
        var c : Int = 1;
        while (c < candidatelists.length)
        {
            for (n in 0...length)
            {
                if (candidatelists[c][n].id > 3)
                {
                    candidatelists[0][n].id += candidatelists[c][n].id;
                }
            }
            c++;
        }
        
        
        var openspaces : Int = 0;
        var max : Int = 0;
        
        n = 0;
        while (n < candidatelists[0].length)
        {
            var mindistance : Float = 10;
            var tooclose : Bool = false;
            
            i = 0;
            while (i < exits.length)
            {
                if (
                    Math.sqrt(
                            Math.pow(exits[i].x - candidatelists[0][n].x, 2) +
                            Math.pow(exits[i].y - candidatelists[0][n].y, 2)
                ) < mindistance)
                {
                    tooclose = true;
                    break;
                }
                i++;
            }
            
            if (  /*GetMap((candidatelists[0][n] as Exit).x, (candidatelists[0][n] as Exit).y + 1) != 1 ||*/  tooclose)
            {
                candidatelists[0].splice(n, 1);
                n--;
            }
            else if (candidatelists[0][n].id > 4)
            {
                if (candidatelists[0][n].id > max)
                {
                    max = candidatelists[0][n].id;
                }
                
                openspaces++;
            }
            n++;
        }
        
        var top : Int = openspaces;  // / 5;  
        
        candidatelists[0].sort(ExitSorter);
        
        for (i in 0...top)
        {
            secrets.push(new PointInt(candidatelists[0][i].x, candidatelists[0][i].y));
            
            if (GetMap(candidatelists[0][i].x, candidatelists[0][i].y + 1) == 1)
            {
                floorsecrets.push(new PointInt(candidatelists[0][i].x, candidatelists[0][i].y));
            }
        }
        
        KillNonwallSecrets();
    }
    
    public function KillNonwallSecrets() : Void
    {
        var i : Int = 0;
        while (i < secrets.length)
        {
            if (wallmap[secrets[i].x][secrets[i].y] == 0)
            {
                secrets.splice(i, 1);
                i--;
            }
            i++;
        }
    }
    
    public function ExitSorter(a : Exit, b : Exit) : Int
    {
        if (a.id < b.id)
        {
            return 1;
        }
        else if (a.id > b.id)
        {
            return -1;
        }
        else
        {
            return 0;
        }
    }
    
    public function GetCandidates(checkers : Array<Dynamic>) : Array<Dynamic>
    {
        var checkmap : Array<Dynamic> = Util.Clone(map);
        
        
        
        while (checkers.length > 0)
        {
            var oldcheckers : Array<Dynamic> = new Array<Dynamic>();  // Util.Clone(checkers);  
            
            for (ex in checkers)
            {
                oldcheckers.push(new PointInt());
                oldcheckers[oldcheckers.length - 1] = ex;
            }
            
            var i : Int = 0;
            i = 0;
            while (i < oldcheckers.length)
            {
                var tocheck : Exit = oldcheckers[i];
                
                if (tocheck.y > 0)
                {
                    if (checkmap[tocheck.x][tocheck.y - 1] == 0 || checkmap[tocheck.x][tocheck.y - 1] == 2)
                    {
                        checkmap[tocheck.x][tocheck.y - 1] = checkmap[tocheck.x][tocheck.y] + 5;
                        checkers.push(new Exit(tocheck.x, tocheck.y - 1, 0));
                    }
                }
                
                if (tocheck.y < height - 1)
                {
                    if (checkmap[tocheck.x][tocheck.y + 1] == 0 || checkmap[tocheck.x][tocheck.y + 1] == 2)
                    {
                        checkmap[tocheck.x][tocheck.y + 1] = checkmap[tocheck.x][tocheck.y] + 5;
                        checkers.push(new Exit(tocheck.x, tocheck.y + 1, 0));
                    }
                }
                
                if (tocheck.x > 0)
                {
                    if (checkmap[tocheck.x - 1][tocheck.y] == 0 || checkmap[tocheck.x - 1][tocheck.y] == 2)
                    {
                        checkmap[tocheck.x - 1][tocheck.y] = checkmap[tocheck.x][tocheck.y] + 5;
                        checkers.push(new Exit(tocheck.x - 1, tocheck.y, 0));
                    }
                }
                
                if (tocheck.x < width - 1)
                {
                    if (checkmap[tocheck.x + 1][tocheck.y] == 0 || checkmap[tocheck.x + 1][tocheck.y] == 2)
                    {
                        checkmap[tocheck.x + 1][tocheck.y] = checkmap[tocheck.x][tocheck.y] + 5;
                        checkers.push(new Exit(tocheck.x + 1, tocheck.y, 0));
                    }
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
        
        var candidates : Array<Dynamic> = new Array<Dynamic>();
        
        var x : Int = upperleft.x;
        while (x < lowerright.x)
        {
            var y : Int = upperleft.y;
            while (y < lowerright.y)
            {
                var weight : Int = checkmap[x][y];
                
                candidates.push(new Exit(x, y, weight));
                
                if (weight > 1)
                {
                    var a : Int = 1;
                }
                y++;
            }
            x++;
        }
        
        return candidates;
    }
    
    public function DestroyFakeExits() : Void
    {
        var ex : Int = 0;
        while (ex < exits.length)
        {
            if (exits[ex].id == 99)
            {
                exits.splice(ex, 1);
                ex--;
            }
            ex++;
        }
    }
    
    public function MakeWall(variant : Int = 0) : Void
    {
        var xx : Int = 0;
        var yy : Int = 0;
        var lifetime : Int = Math.floor((((lowerright.x - upperleft.x) + (lowerright.y - upperleft.y)) / 2) / 2);  // /2 for average, then /2 for taste  
        
        wallmap = Util.Clone(map);  //new Array();  
        /*
			for (var xx:int = 0; xx < width; xx++)
			{
				wallmap.push(new Array());
				for (var yy:int = 0; yy < height; yy++)
				{
					(wallmap[xx] as Array).push(0);
				}
			}
			*/
        
        for (fillexit in exits)
        {
            wallmap[fillexit.x][fillexit.y] = 1;
            wallmap[fillexit.x][fillexit.y - 1] = 1;
            wallmap[fillexit.x][fillexit.y - 2] = 1;
        }
        
        brush = 1;
        
        for (start in exits)
        {
            var checkers : Array<Dynamic> = new Array<Dynamic>();
            
            checkers.push(new Exit(start.x, start.y, 1));
            
            while (checkers.length > 0)
            {
                var oldcheckers : Array<Dynamic> = new Array<Dynamic>();  // Util.Clone(checkers);  
                
                for (ex in checkers)
                {
                    oldcheckers.push(new Exit(ex.x, ex.y, ex.id));
                }
                
                var i : Int = 0;
                i = 0;
                while (i < oldcheckers.length)
                {
                    var tocheck : Exit = oldcheckers[i];
                    
                    brush = tocheck.id;
                    
                    if (tocheck.y > 0)
                    {
                        if (wallmap[tocheck.x][tocheck.y - 1] == 0)
                        {
                            if (ConsiderFlipping(tocheck.x, tocheck.y, brush) == true)
                            {
                                brush = FlipBrush(brush);
                            }
                            
                            wallmap[tocheck.x][tocheck.y - 1] = brush;
                            checkers.push(new Exit(tocheck.x, tocheck.y - 1, brush));
                        }
                    }
                    
                    brush = tocheck.id;
                    
                    if (tocheck.y < height - 1)
                    {
                        if (wallmap[tocheck.x][tocheck.y + 1] == 0)
                        {
                            if (ConsiderFlipping(tocheck.x, tocheck.y, brush) == true)
                            {
                                brush = FlipBrush(brush);
                            }
                            
                            wallmap[tocheck.x][tocheck.y + 1] = brush;
                            checkers.push(new Exit(tocheck.x, tocheck.y + 1, brush));
                        }
                    }
                    
                    brush = tocheck.id;
                    
                    if (tocheck.x > 0)
                    {
                        if (wallmap[tocheck.x - 1][tocheck.y] == 0)
                        {
                            if (ConsiderFlipping(tocheck.x, tocheck.y, brush) == true)
                            {
                                brush = FlipBrush(brush);
                            }
                            
                            wallmap[tocheck.x - 1][tocheck.y] = brush;
                            checkers.push(new Exit(tocheck.x - 1, tocheck.y, brush));
                        }
                    }
                    
                    brush = tocheck.id;
                    
                    if (tocheck.x < width - 1)
                    {
                        if (wallmap[tocheck.x + 1][tocheck.y] == 0)
                        {
                            if (ConsiderFlipping(tocheck.x, tocheck.y, brush) == true)
                            {
                                brush = FlipBrush(brush);
                            }
                            
                            wallmap[tocheck.x + 1][tocheck.y] = brush;
                            checkers.push(new Exit(tocheck.x + 1, tocheck.y, brush));
                        }
                    }
                    i++;
                }
                
                i = 0;
                while (i < oldcheckers.length)
                {
                    checkers.splice(0, 1);
                    i++;
                }
                
                i = 0;
                while (i < checkers.length)
                {
                    if (checkers[i].id == 1)
                    {
                        if (rand.int(0, 100) <= momentum)
                        {
                            checkers[i].id = 2;
                        }
                    }
                    else if (checkers[i].id == 2)
                    {
                        if (rand.int(0, 100) <= momentum)
                        {
                            checkers[i].id = 1;
                        }
                    }
                    
                    
                    if (rand.int(0, lifetime) == 0)
                    {
                        checkers.splice(i, 1);
                        i--;
                    }
                    i++;
                }
                
                checkers = Shuffle(checkers);
            }
        }  // for each exit  
        
        for (xx in 0...width)
        {
            for (yy in 0...height)
            {
                if (wallmap[xx][yy] == 2)
                {
                    wallmap[xx][yy] = 0;
                }
                else
                {
                    wallmap[xx][yy] = 1;
                }
            }
        }
        
        DestroyFakeExits();
        
        for (finalexit in exits)
        {
            wallmap[finalexit.x][finalexit.y - 1] = 1;
            wallmap[finalexit.x][finalexit.y] = 1;
            wallmap[finalexit.x - 1][finalexit.y - 1] = 1;
            wallmap[finalexit.x + 1][finalexit.y - 1] = 1;
            wallmap[finalexit.x - 1][finalexit.y] = 1;
            wallmap[finalexit.x + 1][finalexit.y] = 1;
            
            SetMap(finalexit.x, finalexit.y - 1, 0);
            SetMap(finalexit.x, finalexit.y, 0);
            
            if (finalexit.id == 0)
            {
                xx = Math.floor(finalexit.x - 1);
                while (xx <= finalexit.x + 1)
                {
                    yy = 0;
                    while (yy < finalexit.y + 1)
                    {
                        wallmap[xx][yy] = 1;
                        yy++;
                    }
                    xx++;
                }
            }
            else if (finalexit.id == 1)
            {
                xx = Math.floor(finalexit.x - 1);
                while (xx <= finalexit.x + 1)
                {
                    yy = Math.floor(finalexit.y - 1);
                    while (yy < this.height)
                    {
                        wallmap[xx][yy] = 1;
                        yy++;
                    }
                    xx++;
                }
            }
            else if (finalexit.id == 3)
            {
                xx = Math.floor(finalexit.x - 1);
                while (xx < this.width)
                {
                    yy = Math.floor(finalexit.y - 1);
                    while (yy <= finalexit.y + 1)
                    {
                        wallmap[xx][yy] = 1;
                        yy++;
                    }
                    xx++;
                }
            }
            else if (finalexit.id == 2)
            {
                xx = 0;
                while (xx <= finalexit.x + 1)
                {
                    yy = Math.floor(finalexit.y - 1);
                    while (yy <= finalexit.y + 1)
                    {
                        wallmap[xx][yy] = 1;
                        yy++;
                    }
                    xx++;
                }
            }
        }
        
        /* temporary garbage to try roots
			for (xx = 10; xx < width - 10; xx++)
			{
				for (yy = 10; yy < height - 10; yy++)
				{
					if (wallmap[xx][yy] == 1)
					{
						if (wallmap[xx][yy - 1] == 1)
						{
							wallqualmap[xx][yy] = 1;
						}
						else if (wallmap[xx][yy - 1] == 0 &&
							(wallmap[xx - 1][yy] == 1 || wallmap[xx + 1][yy] == 1) &&
							wallmap[xx][yy + 1] == 1)
						{
							wallqualmap[xx][yy] = 1;
						}
					}
					
				}
			}*/
        
        var startpoints : Array<Dynamic> = new Array<Dynamic>();
        
        xx = 10;
        while (xx < width - 10)
        {
            yy = 10;
            while (yy < height - 10)
            {
                if (wallmap[xx][yy] == 1 && GetMap(xx, yy) == 0 && GetMap(xx, yy - 1) == 1 && GetMap(xx, yy - 2) == 1 &&
                    (xx + yy) % 4 == 0)
                {
                    startpoints.push(new PointPlus(xx, yy - 1, "d"));
                }
                yy++;
            }
            xx++;
        }
        
        var cuts : Int = Math.floor(startpoints.length / 7);
        for (i in 0...cuts)
        {
            var which : Int = rand.int(0, startpoints.length);
            startpoints.splice(which, 1);
        }
        
        while (startpoints.length > 0)
        {
            var thispoint : PointPlus = startpoints[0];
            var travelx : Int = thispoint.x;
            var travely : Int = thispoint.y;
            
            while (true)
            {
                if (travelx == 147 && travely == 136)
                {
                    var a : Int = 2;
                }
                
                if (travelx == 151 && travely == 136)
                {
                    var b : Int = 2;
                }
                
                if ((Std.string(thispoint.obj)) == "d")
                {
                    AddRoot(travelx, travely);
                    travely++;
                    if (wallmap[travelx][travely + 1] == 0 ||
                        wallqualmap[travelx - 1][travely] == 1 ||
                        wallqualmap[travelx][travely + 1] == 1 ||
                        wallqualmap[travelx + 1][travely] == 1)
                    {
                        AddRoot(travelx, travely);
                        startpoints.splice(0, 1);
                        break;
                    }
                    else if (rand.int(0, 5) == 0 && travelx % 2 == 0)
                    {
                        AddRoot(travelx, travely);
                        
                        if (wallmap[travelx - 1][travely] == 1 && rand.int(0, 3) != 0)
                        {
                            startpoints.push(new PointPlus(travelx - 1, travely, "l"));
                        }
                        
                        if (wallmap[travelx + 1][travely] == 1 && rand.int(0, 3) != 0)
                        {
                            startpoints.push(new PointPlus(travelx + 1, travely, "r"));
                        }
                        
                        startpoints.splice(0, 1);
                        break;
                    }
                }
                else if ((Std.string(thispoint.obj)) == "r")
                {
                    AddRoot(travelx, travely);
                    travelx++;
                    if (wallqualmap[travelx][travely - 1] == 1 ||
                        wallqualmap[travelx + 1][travely] == 1 ||
                        wallqualmap[travelx][travely + 1] == 1)
                    {
                        AddRoot(travelx, travely);
                        startpoints.splice(0, 1);
                        break;
                    }
                    else if (wallmap[travelx + 1][travely] == 0 || rand.int(0, 5) > 0)
                    {
                        AddRoot(travelx, travely);
                        startpoints.push(new PointPlus(travelx, travely + 1, "d"));
                        startpoints.splice(0, 1);
                        break;
                    }
                    else if (rand.int(0, 14) > 0)
                    {  //startpoints.push(new PointPlus(travelx, travely + 1, "d"));  
                        
                    }
                }
                else if ((Std.string(thispoint.obj)) == "l")
                {
                    AddRoot(travelx, travely);
                    travelx--;
                    if (wallqualmap[travelx][travely - 1] == 1 ||
                        wallqualmap[travelx - 1][travely] == 1 ||
                        wallqualmap[travelx][travely + 1] == 1)
                    {
                        AddRoot(travelx, travely);
                        startpoints.splice(0, 1);
                        break;
                    }
                    else if (wallmap[travelx - 1][travely] == 0 || rand.int(0, 5))
                    {
                        AddRoot(travelx, travely);
                        startpoints.push(new PointPlus(travelx, travely + 1, "d"));
                        startpoints.splice(0, 1);
                        break;
                    }
                    else if (rand.int(0, 14))
                    {  //startpoints.push(new PointPlus(travelx, travely + 1, "d"));  
                        
                    }
                }
                
                if (GetMap(travelx, travely) == 1 &&
                    GetMap(travelx, travely - 1) == 1)
                {
                    startpoints.splice(0, 1);
                    break;
                }
            }
        }
    }
    
    public function AddRoot(xx : Int, yy : Int) : Void
    {
        wallqualmap[xx][yy] = 1;
        wallmap[xx][yy] = 1;
    }
    
    public function ConsiderFlipping(xx : Int, yy : Int, brush : Int) : Bool
    {
        return false;
        
        if (wallmap[xx - 1][yy] == 1 && wallmap[xx + 1][yy] == 1 && rand.int(0, 2) == 0)
        {
            return true;
        }
        else if (wallmap[xx][yy - 1] == 1 && wallmap[xx][yy + 1] == 1 && rand.int(0, 2) == 0)
        {
            return true;
        }
        
        return false;
    }
    
    public function FlipBrush(brush : Int) : Int
    {
        if (brush == 2)
        {
            return 1;
        }
        else
        {
            return 2;
        }
    }
    
    public function GenerateGem() : Int
    {
        var gem : Int = 0;
        
        var roll : Int = rand.int(0, 100);
        
        if (roll >= (Content.nGemChance * 100))
        {
            return 0;
        }
        
        roll = rand.int(0, 1000);
        
        if (roll < (Content.nLytratChance * 1000))
        {
            gem = 5;
        }
        else if (roll < (Content.nReodChance * 1000) + (Content.nLytratChance * 1000))
        {
            gem = 3;
        }
        else
        {
            gem = 1;
        }
        
        roll = rand.int(0, 100);
        
        if (roll < (Content.nClusterChance * 100))
        {
            gem += 1;
        }
        
        return gem;
    }
    
    public function MakeGems() : Void
    {
        var pt : Int = 0;
        while (pt < secrets.length / 3)
        {
            if (spikemap[secrets[pt].x][secrets[pt].y] == 0)
            {
                gemmap[secrets[pt].x][secrets[pt].y] = GenerateGem();
            }
            pt++;
        }
        
        pt = secrets.length / 3;
        while (pt < secrets.length)
        {
            if (chambermap[secrets[pt].x][secrets[pt].y] == 1)
            {
                if (spikemap[secrets[pt].x][secrets[pt].y] == 0)
                {
                    gemmap[secrets[pt].x][secrets[pt].y] = GenerateGem();
                }
            }
            pt++;
        }
    }
    
    public function ApplyMiracles() : Void
    {
        MiracleManager.IntegrateZoneMiracles();
        MiracleManager.PopulateZoneMiracles(this.description.coords.x, this.description.coords.y);
        
        for (m in MiracleManager.arrayZoneMiracles)
        {
            if (m.universal)
            {
                if (m.id == Content.BLANK)
                {
                    SetMap(m.x, m.y, 0);
                }
                else if (m.id == Content.TERRAIN)
                {
                    SetMap(m.x, m.y, 1);
                }
                else if (m.id == Content.FACADE)
                {
                    facademap[m.x][m.y] = Math.floor(m.strData);
                }
                else if (m.id == Content.WALLPAPER)
                {
                    wallpapermap[m.x][m.y] = Math.floor(m.strData);
                }
            }
            // profile
            else
            {
                
                {
                    if (m.id == 0)
                    {
                        gemmap[m.x][m.y] = 0;
                    }
                }
            }
        }
    }
    
    public function Finish() : Void
    {
        waterlist.splice(0, waterlist.length);
        
        for (xx in 0...width)
        {
            for (yy in 1...height)
            {
                if (watermap[xx][yy] == 1 && watermap[xx][yy - 1] == 0)
                {
                    waterlist.push(new PointPlus(xx, yy, "s"));
                }
                else if (watermap[xx][yy] == 1)
                {
                    waterlist.push(new PointPlus(xx, yy, ""));
                }
                
                if (intangmap[xx][yy] == Content.INTANG_RESERVE)
                {
                    SetMap(xx, yy, 1);
                    intangmap[xx][yy] = Content.INTANG_TUNNEL;
                }
            }
        }
    }
}
