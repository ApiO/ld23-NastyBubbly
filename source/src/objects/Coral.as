package objects
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Mathieu Capdegelle
	 */
	public class Coral extends Entity 
	{
		public static const YELLOW:uint = 0xf2efb4;
		public static const RED:uint = 0xfdbbc7;
		public static const MAGENTA:uint = 0xf3bde1;
		public static const VIOLET:uint = 0xc8a8e2;
		public static const BLUE:uint = 0x79d2ea;
		public static const GREEN:uint = 0x9ee6db;
		public static const BLACK:uint = 0xa59f97;
		
		private var _coralImage:Image = new Image(Assets.IMAGE_CORAL);
		
		public function Coral(x:int, y:int, color:uint = YELLOW, scale:Number = 1.0, flipped:Boolean = false) 
		{
			_coralImage.color = color;
			_coralImage.tinting = 1;
			_coralImage.scale = scale;
			_coralImage.flipped = flipped;
			layer = 3;
			
			this.x = x;
			this.y = y;
			
			graphic = _coralImage;
		}
	}
}