package hud
{
	import adobe.utils.ProductManager;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Point;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Ease;
	
	/**
	 * ...
	 * @author Mathieu Capdegelle
	 */
	public class BoostBar extends Entity 
	{
		public static const EXPLOSION_SIZE:uint = 100;
		
		public static const WIDTH:int = 200;
		public static const HEIGHT:int = 10;
		public static const TOP:int = 6;
		public static const LEFT:int = 10;
		public static const COLOR:uint = 0xf6ff00;
		
		private var _boostAmount:Number;
		private var _boostBar:BitmapData;
		private var _boostBarPoint:Point;
		
		private var _explosionEmitter:Emitter;
		
		private var _boostBarBack:Image = new Image(Assets.IMAGE_BOOSTBAR);
		
		public function BoostBar() 
		{
			layer = -99;
			
			_boostAmount = 0;
			_boostBarPoint = new Point(LEFT, TOP);
			_boostBar = null;
			
			_explosionEmitter = new Emitter(new BitmapData(1, 1, false, COLOR), 1, 1);
			_explosionEmitter.newType("explode", [0]);
			_explosionEmitter.setAlpha("explode", 1, 0);		
			_explosionEmitter.setMotion("explode", 0, 50, 2, 360, -40, -0.5, Ease.quadOut);
			
			_explosionEmitter.relative = false;
			graphic = new Graphiclist(_boostBarBack, _explosionEmitter);
			
			graphic.scrollX = 0;
			graphic.scrollY = 0;
		}

		override public function render():void 
		{
			super.render();
			
			// render life bar
			if (_boostBar != null && _boostAmount > 0) {
				FP.buffer.copyPixels(_boostBar, _boostBar.rect, _boostBarPoint);
			}
		}
		
		public function OnBoostAmmountChange(oldBoostAmmount:Number, newBoostAmmount:Number):void 
		{
			var oldWith:int = oldBoostAmmount * WIDTH;
			var newWidth:int = newBoostAmmount * WIDTH;
						
			_boostBar = newWidth > 0 ? new BitmapData(newWidth, HEIGHT, false, COLOR) : null;
			
			if ( newBoostAmmount < oldBoostAmmount)
			{
				for (var i:int = oldWith; i > newWidth; i--)
				{
					_explosionEmitter.emit("explode", i + LEFT, TOP + (HEIGHT / 2));
				}
			}
		}
		
		public function get boostAmmount():Number { return _boostAmount; }
		
		public function set boostAmmount(newBoostAmmount:Number):void { 
			
			if (newBoostAmmount < 0) {
				newBoostAmmount = 0;
			}
			if (newBoostAmmount > 1) newBoostAmmount = 1;
			
			if (_boostAmount != newBoostAmmount)
			{
				OnBoostAmmountChange(_boostAmount, newBoostAmmount);
				_boostAmount = newBoostAmmount;
			}
		}
	}

}