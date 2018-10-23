import flash.geom.Point;

/**
	 * ...
	 * @author ...
	 */
class PointPlus extends Point
{
    public var obj : Dynamic = null;
    
    public function new(x : Float, y : Float, o : Dynamic)
    {
        super(x, y);
        obj = o;
    }
}

