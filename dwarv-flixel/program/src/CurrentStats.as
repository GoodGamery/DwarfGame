package  
{
	import flash.geom.Point;
	import Hud.Grunt;
	import Hud.HUD;
	import Map.CaveMap;

	
	public class CurrentStats 
	{
		public var nDamageDealt:Number = 10;
		public var iHealth:int = 60;
		public var iMaxHealth:int = 60;
		public var iHearts:int = 3;
		public var bHasScuba:Boolean = true;
		public var bHasWindJump:Boolean = false;
		public var bWaterBoost:Boolean = false;
		public var nSlowThreshold:Number = 10;
		
		
		public var nSwimUpSpeed:Number = 60;
		public var nSwimDownSpeed:Number = 40;
		public var nSwimLateralSpeed:Number = 70;
		
		public var nSwimUpAcceleration:Number = 0.2;
		public var nSwimDownAcceleration:Number = 0.2;
		public var nSwimLateralAcceleration:Number = 0.2;
		
		public var nCaveOffsetX:Number = 0;
		public var nCaveOffsetY:Number = 0;
		
		
		
		
		
		public var nPlayerJumpForce:Number = Content.nForceThree; //Content.nForceTwoAndHalf;
		
		public var iTime:int = 0;
		
		public var arrayMapNodes:Array;
		public var inventory:Array;
		
		public var hud:HUD = null;
		public var cavemap:CaveMap = null;
		
		public function CurrentStats() 
		{
			arrayMapNodes = new Array();
			inventory = new Array();
			ChangeItem("pip", 0);
			ChangeItem("reod", 0);
			ChangeItem("lytrat", 0);
			
			if (bWaterBoost == false)
			{
				nSwimUpSpeed = 100;
				nSwimDownSpeed = 70;
				nSwimLateralSpeed = 120;
				
				nSwimUpAcceleration = 0.8;
				nSwimDownAcceleration = 0.8;
				nSwimLateralAcceleration = 0.8;
			}
		}
		
		public function ChangeItem(name:String, change:int):int 
		{
			var retval:int = ChangeItemInner(name, change);
			
			if (hud != null && change != 0)
			{
				if (name == "pip")
					hud.pipstext.text = retval.toString();
				else if (name == "reod")
					hud.reodstext.text = retval.toString();
				else if (name == "lytrat")
					hud.lytratstext.text = retval.toString();
			}
			
			return retval;
		}
		
		public function ChangeItemInner(name:String, change:int):int
		{
			for (var i:int = 0; i < inventory.length; i++)
			{
				if ((inventory[i] as NumItem).strName == name)
				{
					(inventory[i] as NumItem).iAmount += change;
					
					if ((inventory[i] as NumItem).iAmount < 0)
						(inventory[i] as NumItem).iAmount = 0;
						
					return (inventory[i] as NumItem).iAmount;
				}
			}
			
			if (change >= 0)
			{
				inventory.push(new NumItem(name, change));
				return change;
			}
			
			return 0;
		}
		
	}

}