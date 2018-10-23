package hud;

import haxe.Constraints.Function;
import flash.geom.Point;
import org.flixel.FlxSprite;
import org.flixel.FlxG;
import org.flixel.FlxGroup;
import org.flixel.FlxGroupXY;
import org.flixel.FlxTextPlus;
import org.flixel.FlxText;
import org.flixel.FlxObject;

class HUD extends FlxGroup
{
    public var parent : PlayState;
    public var bg : FlxSprite;
    public var statbar : FlxGroupXY;
    public var pausemenu : FlxGroupXY;
    public var statback : FlxSprite;
    //public var cornerbg:FlxSprite;
    public var loadtext : FlxText;
    public var progressbar : FlxText;
    
    public var pipstext : FlxTextPlus;
    public var reodstext : FlxTextPlus;
    public var lytratstext : FlxTextPlus;
    public var clocktext : FlxTextPlus;
    
    public var loadmap : FlxGroupXY;
    
    public var runemap_background : FlxSprite;
    public var cavepieces : FlxGroupXY;
    public var cavecanvas : FlxSprite;
    public var cavecanvasload : FlxSprite;
    public var cavecanvaspaused : FlxSprite;
    
    public var runemap_border : FlxSprite;
    public var runemap : FlxSprite;
    
    public var fillup : FlxSprite;
    public var walker : FlxSprite;
    public var mapcanvas : FlxSprite;
    
    public var mappieces : FlxGroupXY;
    //public var health:Meter;
    public var arrayHearts : Array<Dynamic>;
    public var groupHearts : FlxGroupXY;
    
    public var loading : Meter;
    public var chatgroup : FlxGroupXY;
    public var strState : String = "";
    public var clock : FlxSprite;
    
    public var topbar : FlxSprite = new FlxSprite(-1, -1);
    public var bottombar : FlxSprite = new FlxSprite(-1, -1);
    
    public var arrayAlerts : Array<Dynamic> = new Array<Dynamic>();
    public var groupAlerts : FlxGroupXY = new FlxGroupXY();
    
    public var character : FlxSprite = new FlxSprite(0, 0);
    public var face : FlxSprite = new FlxSprite(0);
    public var chatbox : FlxSprite = new FlxSprite(66);
    public var barheight(default, never) : Int = 50;
    public var inout : Float = 1;
    public var announcetext : FlxText;
    public var chattext : FlxText;
    public var choicelefttext : FlxText;
    public var choicerighttext : FlxText;
    public var choicecursor : FlxSprite;
    public var task : Int = 0;
    
    public var piecebar : FlxGroupXY;
    public var iCurrentPiece : Int = Content.iWallpaperPieces / 2;
    
    public var maker : FlxGroupXY;
    public var makerReport : FlxTextPlus;
    public var makerBlocker : FlxSprite;
    public var makerMap : FlxSprite;
    public var backupMap : FlxSprite;
    
    public function new(p : PlayState)
    {
        parent = p;
        
        super();
        
        /*
			cornerbg = new FlxSprite(-1, -1);
			cornerbg.makeGraphic(41, 41, 0xFF000000, false);
			cornerbg.scrollFactor.x = 0;
			cornerbg.scrollFactor.y = 0;
			add(cornerbg);
			*/
        
        
        
        bg = new FlxSprite(-1, -1);
        bg.makeGraphic(Content.screenwidth, Content.screenheight, 0xFF222222, false);
        bg.scrollFactor.x = 0;
        bg.scrollFactor.y = 0;
        add(bg);
        
        
        
        loadtext = try cast(add(new FlxText(0, 150, 200, "")), FlxText) catch(e:Dynamic) null;
        Util.AssignFont(loadtext);
        loadtext.scrollFactor.x = 0;
        loadtext.scrollFactor.y = 0;
        loadtext.color = 0xFFFFFFFF;
        
        loading = new Meter(50, 220, 380, 12, 0xFFAAAA22, 0xFF333308);
        loading.SetValue(0, 100);
        loading.text.visible = false;
        add(loading);
        
        topbar.makeGraphic(Content.screenwidth, barheight, 0xFF000000, false);
        bottombar.makeGraphic(Content.screenwidth, barheight, 0xFF000000, false);
        
        topbar.visible = true;
        bottombar.visible = true;
        
        topbar.scrollFactor.x = 0;
        topbar.scrollFactor.y = 0;
        bottombar.scrollFactor.x = 0;
        bottombar.scrollFactor.y = 0;
        
        cast((1), SetBars);
        
        announcetext = new FlxText(0, 80, 480, "");
        Util.AssignFont(announcetext);
        announcetext.scrollFactor.x = 0;
        announcetext.scrollFactor.y = 0;
        announcetext.shadow = 0xFF000000;
        announcetext.alignment = "center";
        announcetext.text = "";
        add(announcetext);
        
        add(topbar);
        add(bottombar);
        
        for (a in 0...20)
        {
            var alert : FlxSprite = new FlxSprite(0, 0, Content.cAlert);
            //alert.scrollFactor.x = 0;
            alert.scrollFactor.y = 0;
            alert.visible = false;
            alert.strName = "alert";
            arrayAlerts.push(alert);
            groupAlerts.add(alert);
        }
        add(groupAlerts);
        
        
        chatgroup = new FlxGroupXY();
        
        
        face.loadGraphic(Content.cFaces, false, false, 66, 66, false);
        face.scrollFactor.x = 0;
        face.scrollFactor.y = 0;
        chatgroup.add(face);
        
        chatbox.loadGraphic(Content.cChatBubble, false, false, 395, 66, false);
        chatbox.scrollFactor.x = 0;
        chatbox.scrollFactor.y = 0;
        chatgroup.add(chatbox);
        
        chattext = new FlxTextPlus(chatbox.x + 10, chatbox.y + 10, 395 - 20, "");
        Util.AssignFont(chattext);
        chattext.color = 0xFF000000;
        chattext.scrollFactor.x = 0;
        chattext.scrollFactor.y = 0;
        chattext.alignment = "left";
        chatgroup.add(chattext);
        
        
        var choicetextsize : Int = 100;
        
        choicelefttext = new FlxText(chatbox.x + 98 - (choicetextsize / 2) + Content.iChoiceDistance, chatbox.y + 34, choicetextsize, "Left Choice");
        Util.AssignFont(choicelefttext);
        choicelefttext.color = 0xFF006A25;
        choicelefttext.scrollFactor.x = 0;
        choicelefttext.scrollFactor.y = 0;
        choicelefttext.alignment = "center";
        chatgroup.add(choicelefttext);
        choicelefttext.visible = false;
        
        choicerighttext = new FlxText(chatbox.x + 98 + 98 + 98 - (choicetextsize / 2) - Content.iChoiceDistance, chatbox.y + 34, choicetextsize, "Right Choice");
        Util.AssignFont(choicerighttext);
        choicerighttext.color = 0xFF006A25;
        choicerighttext.scrollFactor.x = 0;
        choicerighttext.scrollFactor.y = 0;
        choicerighttext.alignment = "center";
        chatgroup.add(choicerighttext);
        choicerighttext.visible = false;
        
        choicecursor = new FlxSprite(chatbox.x + 98 - 15 + Content.iChoiceDistance, chatbox.y + 25);
        //choicecursor = new FlxSprite(chatbox.x + 98 + 98 + 98 - 15 - 25, chatbox.y + 25);
        choicecursor.loadGraphic(Content.cChoice, false, true, 30, 34, false);
        choicecursor.scrollFactor.x = 0;
        choicecursor.scrollFactor.y = 0;
        
        chatgroup.add(choicecursor);
        choicecursor.visible = false;
        
        
        add(chatgroup);
        chatgroup.visible = false;
        
        statbar = new FlxGroupXY();
        add(statbar);
        
        statback = new FlxSprite(-1, -1, Content.cStatBar);
        statback.scrollFactor.x = 0;
        statback.scrollFactor.y = 0;
        statbar.add(statback);
        
        clock = new FlxSprite(480 - 42, 0);
        clock.loadGraphic(Content.cClock, true, false, 42, 42, false);
        clock.scrollFactor.x = 0;
        clock.scrollFactor.y = 0;
        add(clock);
        
        loadmap = new FlxGroupXY();
        
        runemap_background = new FlxSprite(188, 134);
        runemap_background.loadGraphic(Content.cRuneMapBackground, true, false, 106, 106, true);
        runemap_background.scrollFactor.x = 0;
        runemap_background.scrollFactor.y = 0;
        
        cavepieces = new FlxGroupXY();
        
        
        cavecanvasload = new FlxSprite(16, 16);
        cavecanvasload.makeGraphic(268, 268, 0xFF5D5D5D, true);
        cavecanvasload.scrollFactor.x = 0;
        cavecanvasload.scrollFactor.y = 0;
        
        cavecanvaspaused = new FlxSprite(16, 16);
        cavecanvaspaused.makeGraphic(268, 268, 0xFF5D5D5D, true);
        cavecanvaspaused.scrollFactor.x = 0;
        cavecanvaspaused.scrollFactor.y = 0;
        cavecanvaspaused.visible = false;
        
        runemap_border = new FlxSprite(188, 134);
        runemap_border.loadGraphic(Content.cRuneMapBorder, true, false, 106, 106, true);
        runemap_border.scrollFactor.x = 0;
        runemap_border.scrollFactor.y = 0;
        
        runemap = new FlxSprite(188, 134);
        runemap.loadGraphic(Content.cRuneMaps, true, false, 106, 106, true);
        runemap.addAnimation("n", [0], 1, true);
        runemap.addAnimation("s", [1], 1, true);
        runemap.addAnimation("w", [2], 1, true);
        runemap.addAnimation("e", [3], 1, true);
        runemap.scrollFactor.x = 0;
        runemap.scrollFactor.y = 0;
        
        
        
        
        fillup = new FlxSprite(188, 134);
        fillup.scrollFactor.x = 0;
        fillup.scrollFactor.y = 0;
        
        walker = new FlxSprite((Content.screenwidth / 2) - 50, (Content.screenheight / 2) - 50 - 50);
        walker.loadGraphic(Content.cHeroInterim, true, false, 100, 100, true);
        walker.addAnimation("w", [0, 1, 2, 3, 4, 5, 6, 7], 14, true);
        walker.addAnimation("e", [8, 9, 10, 11, 12, 13, 14, 15], 14, true);
        walker.addAnimation("n", [16, 17, 18, 19, 20, 21], 10, true);
        walker.addAnimation("s", [24, 25, 26, 27, 28, 29], 10, true);
        walker.addAnimation("ew", [22, 23], 1, true);
        walker.addAnimation("ns", [30, 31], 1, true);
        walker.scrollFactor.x = 0;
        walker.scrollFactor.y = 0;
        
        
        loadmap.add(fillup);
        loadmap.add(runemap_background);
        loadmap.add(cavecanvasload);
        //loadmap.add(runemap_border);
        loadmap.add(runemap);
        loadmap.add(walker);
        
        add(loadmap);
        
        pausemenu = new FlxGroupXY();
        pausemenu.add(cavecanvaspaused);
        add(pausemenu);
        
        
        mappieces = new FlxGroupXY();
        add(mappieces);
        /*
			mapcanvas = new FlxSprite(0, 0);
			mapcanvas.makeGraphic(200, 200, 0xFF330000, true);
			mapcanvas.scrollFactor.x = 0;
			mapcanvas.scrollFactor.y = 0;
			add(mapcanvas);
			*/
        //health = new Meter(41, 0, 87, 14, 0xFFFF0000, 0xFF550000);
        //health.text.text = "100/100";
        //statbar.add(health);
        
        arrayHearts = new Array<Dynamic>();
        groupHearts = new FlxGroupXY();
        for (h in 0...6)
        {
            var heartadd : FlxSprite = new FlxSprite(44 + (15 * h), 1);
            heartadd.loadGraphic(Content.cHearts, true, false, 14, 14, false);
            heartadd.scrollFactor.x = 0;
            heartadd.scrollFactor.y = 0;
            heartadd.addAnimation("1", [0], 1, true);
            heartadd.addAnimation("/", [1], 1, true);
            heartadd.addAnimation("0", [2], 1, true);
            heartadd.play("1");
            
            if (h >= Content.stats.iHearts)
            {
                heartadd.visible = false;
            }
            
            arrayHearts.push(heartadd);
            groupHearts.add(try cast(arrayHearts[arrayHearts.length - 1], FlxSprite) catch(e:Dynamic) null);
        }
        statbar.add(groupHearts);
        UpdateHearts();
        
        
        
        pipstext = new FlxTextPlus(120, 0, 44, Std.string(Content.stats.ChangeItem("pip", 0)));
        Util.AssignFont(pipstext);
        pipstext.scrollFactor.x = 0;
        pipstext.scrollFactor.y = 0;
        pipstext.shadow = 0xFF000000;
        pipstext.alignment = "right";
        //add.pipstext;
        //statbar.add(pipstext);
        
        reodstext = new FlxTextPlus(120 + 36, 0, 44, Std.string(Content.stats.ChangeItem("reod", 0)));
        Util.AssignFont(reodstext);
        reodstext.scrollFactor.x = 0;
        reodstext.scrollFactor.y = 0;
        reodstext.shadow = 0xFF000000;
        reodstext.alignment = "right";
        //add.reodstext;
        //statbar.add(reodstext);
        
        lytratstext = new FlxTextPlus(120 + 36 + 36, 0, 44, Std.string(Content.stats.ChangeItem("lytrat", 0)));
        Util.AssignFont(lytratstext);
        lytratstext.scrollFactor.x = 0;
        lytratstext.scrollFactor.y = 0;
        lytratstext.shadow = 0xFF000000;
        lytratstext.alignment = "right";
        //add.lytratstext;
        //statbar.add(lytratstext);
        
        clocktext = try cast(add(new FlxTextPlus(404, 1, 44, "dael")), FlxTextPlus) catch(e:Dynamic) null;
        Util.AssignFont(clocktext);
        clocktext.scrollFactor.x = 0;
        clocktext.scrollFactor.y = 0;
        clocktext.color = 0xFFCFCFCF;
        clocktext.alignment = "left";
        statbar.add(clocktext);
        
        cavecanvas = new FlxSprite(16, 16);
        cavecanvas.makeGraphic(268, 268, 0xFF5D5D5D, true);
        cavecanvas.scrollFactor.x = 0;
        cavecanvas.scrollFactor.y = 0;
        cavecanvas.visible = false;
        add(cavecanvas);
        
        //GoCorner();
        cast((false), StatBarVisible);
        
        
        piecebar = new FlxGroupXY();
        
        for (pc in 0...16)
        {
            var piece : FlxSprite = new FlxSprite(pc * 30, 300);
            
            piece.loadGraphic(Content.cWallpaper, true, false, 30, 30, false);
            
            var an : Int = 0;
            while (an < Content.iWallpaperPieces)
            {
                piece.addAnimation(Std.string(an), [an], 0, true);
                an++;
            }
            
            piece.play(Std.string(pc - 8));
            
            piece.scrollFactor.x = 0;
            piece.scrollFactor.y = 0;
            piecebar.add(piece);
        }
        
        
        
        this.add(piecebar);
        
        if (Content.debugtexton)
        {
            var marker : FlxSprite = new FlxSprite(0 + (8 * 30), 300 - 10);
            marker.makeGraphic(30, 5, 0xFFFFAAFF, false);
            marker.scrollFactor.x = 0;
            marker.scrollFactor.y = 0;
            add(marker);
        }
        
        cast((Content.iWallpaperPieces / 2), SetCurrentPiece);
        
        
        maker = new FlxGroupXY();
        
        
        makerBlocker = new FlxSprite(480, 0);
        makerBlocker.makeGraphic(330, Content.screenheight + 36, 0xFFCC00CC, false);
        makerBlocker.scrollFactor.x = 0;
        makerBlocker.scrollFactor.y = 0;
        maker.add(makerBlocker);
        
        makerMap = new FlxSprite(500, Content.screenheight - 128 - 20);
        makerMap.makeGraphic(128, 128, 0xFFAA6622, false);
        makerMap.scrollFactor.x = 0;
        makerMap.scrollFactor.y = 0;
        maker.add(makerMap);
        
        backupMap = new FlxSprite(500 + 128 + 20, Content.screenheight - 128 - 20);
        backupMap.makeGraphic(128, 128, 0xFFAA6622, false);
        backupMap.scrollFactor.x = 0;
        backupMap.scrollFactor.y = 0;
        maker.add(backupMap);
        
        makerReport = new FlxTextPlus(480 + 20, 20, 300, "test", true);
        makerReport.color = 0xFFFFFFFF;
        makerReport.scrollFactor.x = 0;
        makerReport.scrollFactor.y = 0;
        maker.add(makerReport);
        
        
        
        
        add(maker);
    }
    
    public function ChoiceVisible(bVisible : Bool) : Void
    {
        choicelefttext.visible = bVisible;
        choicerighttext.visible = bVisible;
        choicecursor.visible = bVisible;
    }
    
    public function SetChoice(bLeft : Bool) : Void
    {
        if (bLeft)
        {
            choicecursor.facing = FlxObject.LEFT;
            choicecursor.x = chatbox.x + 98 - 15 + Content.iChoiceDistance;
        }
        else
        {
            choicecursor.facing = FlxObject.RIGHT;
            choicecursor.x = chatbox.x + 98 + 98 + 98 - 15 - Content.iChoiceDistance;
        }
    }
    
    public function UpdateHearts() : Void
    {
        var ratio : Float = Content.stats.iHealth / Content.stats.iMaxHealth;
        
        ratio *= Content.stats.iHearts * 2;
        
        if (ratio < Content.stats.iHearts * 2)
        {
            ratio = as3hx.Compat.parseInt(ratio);
        }
        
        var h : Int = 0;
        while (h < Content.stats.iHearts)
        {
            if (ratio == (h * 2) + 1)
            {
                (try cast(arrayHearts[h], FlxSprite) catch(e:Dynamic) null).play("/");
            }
            else if (ratio < (h * 2) + 1)
            {
                (try cast(arrayHearts[h], FlxSprite) catch(e:Dynamic) null).play("0");
            }
            else
            {
                (try cast(arrayHearts[h], FlxSprite) catch(e:Dynamic) null).play("1");
            }
            h++;
        }
    }
    
    public function SetCurrentPiece(current : Int) : Void
    {
        iCurrentPiece = current;
        
        if (iCurrentPiece < 0)
        {
            iCurrentPiece += Content.iWallpaperPieces;
        }
        else if (iCurrentPiece >= Content.iWallpaperPieces)
        {
            iCurrentPiece -= Content.iWallpaperPieces;
        }
        
        for (n in 0...16)
        {
            var animnum : Int = as3hx.Compat.parseInt(iCurrentPiece + n - 8);
            
            if (animnum < 0)
            {
                animnum += Content.iWallpaperPieces;
            }
            else if (animnum >= Content.iWallpaperPieces)
            {
                animnum -= Content.iWallpaperPieces;
            }
            
            (try cast(piecebar.members[n], FlxSprite) catch(e:Dynamic) null).play(Std.string(animnum));
        }
    }
    
    public function LoadVisible(t : Bool) : Void
    {
        bg.visible = t;
        loadtext.visible = t;
        loading.visible = false;
        loadmap.visible = t;
    }
    
    public function SetLoadDirection(camefrom : Int, wasdead : Bool) : Void
    {
        var str : String = "";
        
        if (camefrom == 1)
        {
            str = "n";
        }
        if (camefrom == 0)
        {
            str = "s";
        }
        if (camefrom == 2)
        {
            str = "e";
        }
        if (camefrom == 3)
        {
            str = "w";
        }
        
        runemap.play(str);
        
        if (!wasdead)
        {
            walker.play(str);
        }
        // Sleeping
        else
        {
            
            if (camefrom < 2)
            {
                walker.play("ns");
            }
            else
            {
                walker.play("ew");
            }
        }
    }
    
    public function SetLoadProgress(amount : Float) : Void
    //trace("progress amount: " + amount.toString());
    {
        
        
        if (amount == 100)
        {
        }
        
        if (amount <= 0)
        {
            fillup.visible = false;
        }
        else
        {
            var size : Int = Math.ceil(106 * (amount / 100));
            fillup.visible = true;
            
            if (runemap.GetCurrentAnim() == "e")
            {
                fillup.x = 188;
                fillup.y = 134;
                fillup.makeGraphic(size, 106, 0xFFFFDA47, false);
            }
            else if (runemap.GetCurrentAnim() == "w")
            {
                fillup.x = 188 + 106 - size;
                fillup.y = 134;
                fillup.makeGraphic(size, 106, 0xFFC0BC9A, false);
            }
            else if (runemap.GetCurrentAnim() == "n")
            {
                fillup.x = 188;
                fillup.y = 134 + 106 - size;
                fillup.makeGraphic(106, size, 0xFF30D050, false);
            }
            else if (runemap.GetCurrentAnim() == "s")
            {
                fillup.x = 188;
                fillup.y = 134;
                fillup.makeGraphic(106, size, 0xFF4749FF, false);
            }
        }
    }
    
    public var strIntended : String = "How are you seeing this";
    public var arrayIntended : Array<Dynamic> = null;
    public var iCurrentLine : Int = 0;
    
    public var nLetterCooldown : Float = 0;
    public var nLetterDelay : Float = 2;
    
    public var nChatSoundCooldown : Float = 0;
    public var nChatSoundDelay : Float = 2;
    public function Chat(c : Bool, spr : FlxSprite = null, text : String = "This is some sample text that you are not supposed to see.") : Void
    {
        if (c)
        {
            arrayIntended = text.split("^");
            iCurrentLine = 0;
            
            var line : Int = 0;
            while (line < arrayIntended.length)
            {
                var fromhere : Int = 0;
                
                var chars : Int = 0;
                while (chars < (Std.string(arrayIntended[line])).length)
                {
                    if ((Std.string(arrayIntended[line])).charAt(chars) == "F")
                    {
                        var i : Int = 2;
                    }
                    if (fromhere > 44)
                    {
                        var track : Int = chars;
                        while (track > 0)
                        {
                            if ((Std.string(arrayIntended[line])).charAt(track) == " " ||
                                (Std.string(arrayIntended[line])).charAt(track) == "-")
                            {
                                arrayIntended[line] = Util.SetCharAt(arrayIntended[line], "\n", track);
                                fromhere = as3hx.Compat.parseInt(chars - track);
                                
                                break;
                            }
                            track--;
                        }
                    }
                    else
                    {
                        fromhere++;
                    }
                    chars++;
                }
                line++;
            }
            
            chatgroup.members.splice(0);
            chatgroup.add(face);
            chatgroup.add(chatbox);
            chatgroup.add(chattext);
            
            if (spr != null)
            {
                chatgroup.add(spr);
                spr.x = chatgroup.x + 3;
                spr.y = chatgroup.y + 3;
            }
            
            chatgroup.x = 10;
            chatgroup.y = Content.screenheight - 66 - 10;
            
            nLetterCooldown = 0;
            nChatSoundCooldown = 0;
            
            chattext.text = "";
        }
        else
        {
            chatgroup.members.splice(0);
            arrayIntended = null;
        }
        
        chatgroup.visible = c;
    }
    
    public function NextLine() : Bool
    {
        if (chattext.text.length < (Std.string(arrayIntended[iCurrentLine])).length)
        {
            chattext.text = (Std.string(arrayIntended[iCurrentLine]));
            return false;
        }
        
        iCurrentLine++;
        if (iCurrentLine >= arrayIntended.length)
        {
            return true;
        }
        
        nLetterCooldown = 0;
        nChatSoundCooldown = 0;
        chattext.text = "";
        
        return false;
    }
    
    public function SetBars(i : Float) : Void
    {
        inout = i;
        
        if (inout < Content.nEverBars / 50)
        {
            inout = Content.nEverBars / 50;
        }
        
        
        topbar.y = (barheight * -1) + (barheight * inout) - 2;
        bottombar.y = Content.screenheight - (barheight * inout) + 2;
    }
    
    public function NewRegionTask(str : String) : Void
    //trace("NewRegionTask");
    {
        
        countdown = 2;
        announcetext.text = str;
        announcetext.visible = true;
        cast((1), SetBars);
        endfunction = StartSlideOut;
    }
    
    public var countdown : Float = 0;
    public var endfunction : Function = null;
    public var eachframe : Function = null;
    public var bInterruptFlag : Bool = false;
    override public function update() : Void
    {
        super.update();
        
        if (bInterruptFlag)
        {
            trace("Interrupted");
            bInterruptFlag = false;
            countdown = 0;
            endfunction = null;
            eachframe = null;
        }
        
        if (countdown != 0)
        {
            countdown -= FlxG.elapsed;
            
            if (countdown <= 0)
            {
                countdown = 0;
                
                if (endfunction != null)
                {
                    endfunction();
                    return;
                }
            }
            else if (eachframe != null)
            {
                eachframe();
            }
        }
        
        if (arrayIntended != null && iCurrentLine < arrayIntended.length)
        {
            if (chattext.text.length < (Std.string(arrayIntended[iCurrentLine])).length)
            {
                nLetterCooldown++;
                
                if (nLetterCooldown >= nLetterDelay)
                {
                    nLetterCooldown -= nLetterDelay;
                    
                    chattext.text = (Std.string(arrayIntended[iCurrentLine])).substr(0, chattext.text.length + 1);
                }
                
                nChatSoundCooldown++;
                
                if (nChatSoundCooldown >= nChatSoundDelay)
                {
                    nChatSoundCooldown -= nChatSoundDelay;
                    
                    if (chattext.text.length > 2 &&
                        !(chattext.text.charAt(chattext.text.length - 1) == " " &&
                        chattext.text.charAt(chattext.text.length - 2) == " "))
                    {
                        FlxG.play(Content.soundChat, Content.volumeChat, false, false, Content.nDefaultSkip);
                    }
                }
            }
        }
    }
    
    public var slideouttime : Float = 0.5;
    public function StartSlideOut(sec : Float = 0.5) : Void
    {
        slideouttime = sec;
        announcetext.visible = false;
        eachframe = SlideOut;
        endfunction = StopSlidingOut;
        countdown = slideouttime;
    }
    
    public function SlideOut() : Void
    //trace("SlideOut");
    {
        
        cast((inout - (FlxG.elapsed / slideouttime)), SetBars);
        
        if (inout < Content.nEverBars / 50)
        {
            inout = Content.nEverBars / 50;
        }
    }
    
    public function StopSlidingOut() : Void
    //trace("StopSlidingOut");
    {
        
        //SetBars(0);
        eachframe = null;
        endfunction = null;
    }
    
    public var slideintime : Float = 0.5;
    public function StartSlideIn(sec : Float = 0.5) : Void
    {
        slideintime = sec;
        announcetext.visible = false;
        eachframe = SlideIn;
        endfunction = StopSlidingIn;
        countdown = slideintime;
    }
    
    public function SlideIn() : Void
    //trace("SlideIn");
    {
        
        cast((inout + (FlxG.elapsed / slideintime)), SetBars);
        
        if (inout > 1)
        {
            inout = 1;
        }
    }
    
    public function StopSlidingIn() : Void
    //trace("StopSlidingIn");
    {
        
        eachframe = null;
        endfunction = null;
    }
    
    public function ZoneInMapHistory(x : Int, y : Int) : Int
    {
        var i : Int = 0;
        while (i < Content.stats.arrayMapNodes.length)
        {
            if ((try cast(Content.stats.arrayMapNodes[i], MapNode) catch(e:Dynamic) null).where.x == x && (try cast(Content.stats.arrayMapNodes[i], MapNode) catch(e:Dynamic) null).where.y == y)
            
            { //trace("IN MAP HISTORY!");
                
                return as3hx.Compat.parseInt(i);
            }
            i++;
        }
        
        //trace("NOT in map history......");
        return -1;
    }
    
    
    public function StatBarVisible(visible : Bool) : Void
    {
        statbar.visible = visible;
        groupHearts.visible = visible;
        pipstext.visible = visible;
        reodstext.visible = visible;
        lytratstext.visible = visible;
        clocktext.visible = visible;
        clock.visible = visible;
        cavecanvas.visible = visible;
    }
    
    public function PauseMenuVisible(visible : Bool) : Void
    {
        cavecanvaspaused.visible = visible;
    }
    
    public var nodesize : Int = 12;
    public var mapincorner : Bool = false;
    
    public function GoCenter() : Void
    {
        mapincorner = false;
        mappieces.x = 0;
        mappieces.y = 0;
        //cornerbg.visible = false;
        
        cast((false), StatBarVisible);
        cast((true), PauseMenuVisible);
        
        center.x = Content.screenwidth / 2;
        center.y = (Content.screenheight / 2) + 36;
        scope = 3;
        
        if (parent.zone != null)
        {
            Remake(parent.zone.description.coords.x, parent.zone.description.coords.y);
        }
    }
    
    public function GoCorner() : Void
    {
        mapincorner = true;
        //cornerbg.visible = true;
        cast((true), StatBarVisible);
        cast((false), PauseMenuVisible);
        
        center.x = 20 - 1;
        center.y = 20 - 1;
        scope = 1;
        
        mappieces.y = Content.nTopOfStats;
        groupHearts.y = Content.nTopOfStats;
        //cornerbg.y = Content.nTopOfStats;
        
        if (parent.zone != null)
        {
            Remake(parent.zone.description.coords.x, parent.zone.description.coords.y);
        }
    }
    
    public var center : Point = new Point(Content.screenwidth / 2, Content.screenheight / 2);
    public var scope : Int = 1;
    public function Remake(xcenter : Int, ycenter : Int) : Void
    {
        
        /*
			mappieces.clear();
			
			for (var x:int = -scope; x <= scope; x++)
			{
				for (var y:int = -scope; y <= scope; y++)
				{
					var i:int = ZoneInMapHistory(x + xcenter, y + ycenter);
					if (i != -1)
					{
						if ((Content.stats.arrayMapNodes[i] as MapNode).north)
						{
							var northbar:NodeSprite = new NodeSprite(center.x - (nodesize / 2) + (x * nodesize) + 0, center.y - (nodesize / 2) + (y * nodesize) - 6);
							northbar.SetRigid(true);
							northbar.play("v");
							mappieces.add(northbar);
						}
						
						if ((Content.stats.arrayMapNodes[i] as MapNode).west)
						{
							var westbar:NodeSprite = new NodeSprite(center.x - (nodesize / 2) + (x * nodesize) - 6, center.y - (nodesize / 2) + (y * nodesize) + 0);
							westbar.SetRigid(true);
							westbar.play("h");
							mappieces.add(westbar);
						}
						
						var node:NodeSprite = new NodeSprite(center.x - (nodesize / 2) + (x * nodesize), center.y - (nodesize / 2) + (y * nodesize));
						node.SetRigid(true);
						node.SetBiome((Content.stats.arrayMapNodes[i] as MapNode).biome);
						mappieces.add(node);
					}	
					
					
					
					if (i != -1)
					{	
						if ((Content.stats.arrayMapNodes[i] as MapNode).south)
						{
							var southbar:NodeSprite = new NodeSprite(center.x - (nodesize / 2) + (x * nodesize) + 0, center.y - (nodesize / 2) + (y * nodesize) + 6);
							southbar.SetRigid(true);
							southbar.play("v");
							mappieces.add(southbar);
						}
						
						if ((Content.stats.arrayMapNodes[i] as MapNode).east)
						{
							var eastbar:NodeSprite = new NodeSprite(center.x - (nodesize / 2) + (x * nodesize) + 6, center.y - (nodesize / 2) + (y * nodesize) + 0);
							eastbar.SetRigid(true);
							eastbar.play("h");
							mappieces.add(eastbar);
						}
					}
					
					if (x == 0 && y == 0)
					{
						var mainnode:NodeSprite = new NodeSprite(center.x - (nodesize / 2) + (x * nodesize), center.y - (nodesize / 2) + (y * nodesize));
						mainnode.SetRigid(true);
						mainnode.play("face"); 
						mappieces.add(mainnode);
					}
				}
			}
			*/
        
    }
}

