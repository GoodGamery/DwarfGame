package components;


class PointInt
{
    public var x : Int;
    public var y : Int;

    public inline function new(?x : Int = 0, ?y : Int = 0) {
        this.x = x;
        this.y = y;
    }
}