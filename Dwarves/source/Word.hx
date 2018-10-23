
/**
	 * ...
	 * @author ...
	 */
class Word
{
    public var str : String = "";
    public var front : Bool = false;
    public var mid : Bool = false;
    public var back : Bool = false;
    public var flat : Bool = false;
    public var of : Bool = false;
    public var s : Bool = false;
    public var biomes : Array<Dynamic> = new Array<Dynamic>();
    
    public function new()
    {
        for (i in 0...12)
        {
            biomes.push(false);
        }
    }
}

