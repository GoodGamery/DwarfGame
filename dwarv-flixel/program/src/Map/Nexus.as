package Map 
{
	public class Nexus
    {
        public var style:int = -1;
		public var distance:Number = 9999;
        public var x:int = -1;
        public var y:int = -1;


        public function Nexus(xx:int, yy:int, st:int, dist:Number)
        {
            style = st;
            x = xx;
            y = yy;
			distance = dist;
        }
    }
}