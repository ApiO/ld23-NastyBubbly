package hud 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Drs
	 */
	public class ShitFilter extends Entity 
	{
		private var _shitImage:Image;
		
		public function ShitFilter() 
		{
			_shitImage = new Image(Assets.IMAGE_SHITFILTER);
			_shitImage.alpha = 0;
			graphic = _shitImage;
			graphic.scrollX = 0;
			graphic.scrollY = 0;
			layer = -3;
		}
		
		public function SetAlpha(alpha:Number):void {
			_shitImage.alpha = alpha;
		}
	}

}