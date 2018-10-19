package  
{
	/**
	 * ...
	 * @author ...
	 */
	public class Word 
	{
		public var str:String = "";
		public var front:Boolean = false;
		public var mid:Boolean = false;
		public var back:Boolean = false;
		public var flat:Boolean = false;
		public var of:Boolean = false;
		public var s:Boolean = false;
		public var biomes:Array = new Array();
		
		public function Word() 
		{
			for (var i:int = 0; i < 12; i++)
				biomes.push(false);
		}
		
	}

}