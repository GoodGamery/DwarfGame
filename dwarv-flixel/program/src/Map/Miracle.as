package Map 
{
	public class Miracle
    {
		public var universal:int = 1;
        public var id:int = -1;
        public var x:int = -1;
        public var y:int = -1;
		public var zx:int = -1;
		public var zy:int = -1;
		public var strData:String = "";

        public function Miracle(zonex:int, zoney:int, xx:int, yy:int, identity:int, data:String, u:int )
        {
            zx = zonex;
			zy = zoney;
            x = xx;
            y = yy;
			id = identity;
			strData = data;
			universal = u;
        }
		
		public function StringRepresentation():String
		{
			return zx.toString() + "," + zy.toString() + "," +
				x.toString() + "," + y.toString() + "," +
				id.toString() + "," + 
				strData + "," + universal.toString();
		}
    }
}