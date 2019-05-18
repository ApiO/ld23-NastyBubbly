package objects 
{
	import net.flashpunk.Entity;
	import objects.LandingNet;
	
	/**
	 * ...
	 * @author Mathieu Capdegelle
	 */
	// "inner" class for landing net back on a deeper layer
	public class LandingNetBack extends Entity
	{
		private const HEIGHT_BACK:int = 480;
		private const WIDTH_BACK:int = 78;
		
		private var _landingNet:LandingNet;
		
		public function LandingNetBack(landingNet:LandingNet) 
		{
			layer = 1;
			_landingNet = landingNet;
			graphic = landingNet.landingnNetSpriteBack;
		}
		
		override public function update():void 
		{
			x = _landingNet.x;
			y = _landingNet.y;
		}
	}
}