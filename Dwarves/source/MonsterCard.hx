import flash.geom.Point;

/**
	 * ...
	 * @author ...
	 */
class MonsterCard
{
    public var strName : String = "";
    public var uNeedsOne : Int = 0x00000000;
    public var uNeedsAll : Int = 0x00000000;
    public var uResists : Int = 0x00000000;
    public var nWeight : Float = 1;
    public var iNeeded : Int = 0;
    public var nSatModifier : Float = 1;
    
    public function new(string : String, needsone : Int, needsall : Int, resists : Int, weight : Float, satmodifier : Float)
    {
        strName = string;
        uNeedsOne = needsone;
        uNeedsAll = needsall;
        uResists = resists;
        nWeight = weight;
        nSatModifier = satmodifier;
        iNeeded = 0;
    }
}
