package map;


class Biome
{
    public var back : String;
    public var wall : Int;
    public var front : Int;
    public var song : String = "";
    
    public var bestiary : Array<Dynamic> = new Array<Dynamic>();
    public var bounds : Array<Dynamic> = new Array<Dynamic>();
    public var overlays : Array<Dynamic> = new Array<Dynamic>();
    
    public function new(biomeAssetPath : String, w : Int, f : Int)
    {
        
        back = biomeAssetPath;
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
