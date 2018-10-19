package Map 
{
	public class Biome
    {
        public var back:Class;
		public var wall:int;
		public var front:int;
		public var song:String = "";

		public var bestiary:Array = new Array();
		public var bounds:Array = new Array();
		public var overlays:Array = new Array();

        public function Biome(b:Class, w:int, f:int)
        {
			back = b;
			wall = w;
			front = f;
			
			for (var m:int = 0; m < 6; m++)
				bestiary.push("");
			
			for (var i:int = 0; i < 40; i++)
				bounds.push(0);
				
			for (var c:int = 0; i < 10; i++)
				overlays.push("");
        }
    }
}