package map;


class Nexus
{
    public var style : Int = -1;
    public var distance : Float = 9999;
    public var x : Int = -1;
    public var y : Int = -1;
    
    
    public function new(xx : Int, yy : Int, st : Int, dist : Float)
    {
        style = st;
        x = xx;
        y = yy;
        distance = dist;
    }
}
