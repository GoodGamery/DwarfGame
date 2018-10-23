package map;


class Exit
{
    public var id : Int = -1;
    public var x : Int = -1;
    public var y : Int = -1;
    public var handled : Bool = false;
    
    public function new(xx : Int, yy : Int, identity : Int)
    {
        id = identity;
        x = xx;
        y = yy;
    }
}
