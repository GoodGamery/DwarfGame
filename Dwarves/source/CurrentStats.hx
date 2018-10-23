import flash.geom.Point;
import hud.Grunt;
import hud.HUD;
import map.CaveMap;

class CurrentStats
{
    public var nDamageDealt : Float = 10;
    public var iHealth : Int = 60;
    public var iMaxHealth : Int = 60;
    public var iHearts : Int = 3;
    public var bHasScuba : Bool = true;
    public var bHasWindJump : Bool = false;
    public var bWaterBoost : Bool = false;
    public var nSlowThreshold : Float = 10;
    
    
    public var nSwimUpSpeed : Float = 60;
    public var nSwimDownSpeed : Float = 40;
    public var nSwimLateralSpeed : Float = 70;
    
    public var nSwimUpAcceleration : Float = 0.2;
    public var nSwimDownAcceleration : Float = 0.2;
    public var nSwimLateralAcceleration : Float = 0.2;
    
    public var nCaveOffsetX : Float = 0;
    public var nCaveOffsetY : Float = 0;
    
    
    
    
    
    public var nPlayerJumpForce : Float = Content.nForceThree;  //Content.nForceTwoAndHalf;  
    
    public var iTime : Int = 0;
    
    public var arrayMapNodes : Array<Dynamic>;
    public var inventory : Array<Dynamic>;
    
    public var hud : HUD = null;
    public var cavemap : CaveMap = null;
    
    public function new()
    {
        arrayMapNodes = new Array<Dynamic>();
        inventory = new Array<Dynamic>();
        ChangeItem("pip", 0);
        ChangeItem("reod", 0);
        ChangeItem("lytrat", 0);
        
        if (bWaterBoost == false)
        {
            nSwimUpSpeed = 100;
            nSwimDownSpeed = 70;
            nSwimLateralSpeed = 120;
            
            nSwimUpAcceleration = 0.8;
            nSwimDownAcceleration = 0.8;
            nSwimLateralAcceleration = 0.8;
        }
    }
    
    public function ChangeItem(name : String, change : Int) : Int
    {
        var retval : Int = ChangeItemInner(name, change);
        
        if (hud != null && change != 0)
        {
            if (name == "pip")
            {
                hud.pipstext.text = Std.string(retval);
            }
            else if (name == "reod")
            {
                hud.reodstext.text = Std.string(retval);
            }
            else if (name == "lytrat")
            {
                hud.lytratstext.text = Std.string(retval);
            }
        }
        
        return retval;
    }
    
    public function ChangeItemInner(name : String, change : Int) : Int
    {
        var i : Int = 0;
        while (i < inventory.length)
        {
            if ((try cast(inventory[i], NumItem) catch(e:Dynamic) null).strName == name)
            {
                (try cast(inventory[i], NumItem) catch(e:Dynamic) null).iAmount += change;
                
                if ((try cast(inventory[i], NumItem) catch(e:Dynamic) null).iAmount < 0)
                {
                    (try cast(inventory[i], NumItem) catch(e:Dynamic) null).iAmount = 0;
                }
                
                return (try cast(inventory[i], NumItem) catch(e:Dynamic) null).iAmount;
            }
            i++;
        }
        
        if (change >= 0)
        {
            inventory.push(new NumItem(name, change));
            return change;
        }
        
        return 0;
    }
}

