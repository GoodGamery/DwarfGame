package map;


class Miracle
{
    public var universal : Int = 1;
    public var id : Int = -1;
    public var x : Int = -1;
    public var y : Int = -1;
    public var zx : Int = -1;
    public var zy : Int = -1;
    public var strData : String = "";
    
    public function new(zonex : Int, zoney : Int, xx : Int, yy : Int, identity : Int, data : String, u : Int)
    {
        zx = zonex;
        zy = zoney;
        x = xx;
        y = yy;
        id = identity;
        strData = data;
        universal = u;
    }
    
    public function StringRepresentation() : String
    {
        return Std.string(zx) + "," + Std.string(zy) + "," +
        Std.string(x) + "," + Std.string(y) + "," +
        Std.string(id) + "," +
        strData + "," + Std.string(universal);
    }
}
