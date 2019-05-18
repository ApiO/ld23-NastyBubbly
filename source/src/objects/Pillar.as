package objects
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Mathieu Capdegelle
	 */
	public class Pillar extends Entity 
	{
		public static const WIDTH:int = 74;
		public static const HEIGHT:int = 286;
		public static const HEIGHT_CAPPED:int = 299;
		
		private var _pillarImage:Image = new Image(Assets.IMAGE_PILLAR);
		private var _pillarCapImage:Image = new Image(Assets.IMAGE_PILLARCAP);
		
		public function Pillar(x:int, difficulty:Number = 0.5, top:Boolean = false, capped:Boolean = true) 
		{
			width = WIDTH;
			height = capped ? HEIGHT_CAPPED : HEIGHT;
			type = "pillar";
			layer = 2;
			
			if (top)
			{
				_pillarImage.angle = 180;
				_pillarCapImage.angle = 180;
				setOrigin( WIDTH, height); 
			}
			
			if (capped)
			{
				_pillarImage.y = (top ? -1 : 1) * (HEIGHT_CAPPED - HEIGHT);
				
				graphic = new Graphiclist(_pillarImage, _pillarCapImage);
			}
			else graphic = _pillarImage;
			
			this.x = top ? x + WIDTH : x;
			this.y = top ? (height * difficulty) : FP.screen.height - (height * difficulty);
		}
		
	}

}