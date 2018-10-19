package Map 
{
	public class Exit
    {
        public var id:int = -1;
        public var x:int = -1;
        public var y:int = -1;
        public var handled:Boolean = false;

        public function Exit(xx:int, yy:int, identity:int)
        {
            id = identity;
            x = xx;
            y = yy;
        }
    }
}