package  
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MonsterCard
	{
		public var strName:String = "";
		public var uNeedsOne:uint = 0x00000000;
		public var uNeedsAll:uint = 0x00000000;
		public var uResists:uint = 0x00000000;
		public var nWeight:Number = 1;
		public var iNeeded:int = 0;
		public var nSatModifier:Number = 1;
		
		public function MonsterCard(string:String, needsone:uint, needsall:uint, resists:uint, weight:Number, satmodifier:Number) 
		{
			strName = string;
			uNeedsOne = needsone;
			uNeedsAll = needsall;
			uResists = resists;
			nWeight = weight;
			nSatModifier = satmodifier;
			iNeeded = 0;
		}
	}
}