package map;


class Biome
{
    public var back : Class<Dynamic>;
    public var wall : Int;
    public var front : Int;
    public var song : String = "";
    
    public var bestiary : Array<Dynamic> = new Array<Dynamic>();
    public var bounds : Array<Dynamic> = new Array<Dynamic>();
    public var overlays : Array<Dynamic> = new Array<Dynamic>();
    
    public function new(b : Class<Dynamic>, w : Int, f : Int)
    {
        back = b;
        wall = w;
        front = f;
        
        for (m in 0...6)
        {
            bestiary.push("");
        }
        
        for (i in 0...40)
        {
            bounds.push(0);
        }
        
        for (c in 0...10)
        {
            overlays.push("");
        }
    }
}
