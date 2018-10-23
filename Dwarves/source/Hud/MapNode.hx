package hud;

import flash.geom.Point;

/**
	 * ...
	 * @author ...
	 */
class MapNode
{
    public var north : Bool = false;
    public var south : Bool = false;
    public var west : Bool = false;
    public var east : Bool = false;
    public var biome : Int = 0;
    public var where : Point = new Point(0, 0);
    
    public function new(place : Point, b : Int, n : Bool, s : Bool, w : Bool, e : Bool)
    {
        where = place;
        biome = b;
        north = n;
        south = s;
        west = w;
        east = e;
    }
}

