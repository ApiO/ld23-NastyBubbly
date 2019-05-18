package objects 
{
	import adobe.utils.XMLUI;
	import flash.display.BlendMode;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.FP;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.AngleTween;
	
	/**
	 * ...
	 * @author Mathieu Capdegelle
	 */
	public class Food extends Entity 
	{
		public static const HITBOX_SCALE:Number = 1.5;
		
		public static const FOOD_WIDTH:int = 11;
		public static const FOOD_HEIGHT:int = 13;
		public static const FOOD_MOTION_DURATION:Number = 0.9;
		public static const FOOD_MOTION_RANGE:Number = 10;
		
		public static const SPARK_WIDTH:int = 36;
		public static const SPARK_HEIGHT:int = 36;
		public static const SPARK_MOTION_DURATION:Number = 1;
		public static const SPARK_MOTION_RANGE:Number = 1;
		
		public static const SPARK_DESTROY_DURATION:Number = 0.25;
		
		private var _sparkImage:Image = new Image(Assets.IMAGE_SPARK);
		private var _foodImage:Image = new Image(Assets.IMAGE_FOOD);
		
		private var _foodMotionTime:Number;
		private var _foodMotionFlip:Boolean;
		
		private var _sparkMotionTime:Number;
		private var _sparkMotionFlip:Boolean;
		
		private var _destroying:Boolean;
		
		public function Food()
		{
			type = "food";
			layer = 1;
			setHitbox(FOOD_WIDTH * HITBOX_SCALE, FOOD_HEIGHT * HITBOX_SCALE, 
				FOOD_WIDTH/2 * HITBOX_SCALE, FOOD_HEIGHT/2 * HITBOX_SCALE);
			
			_foodImage.centerOrigin();
			_foodImage.x += 2;
			_sparkImage.centerOrigin();
			
			_foodMotionTime = 0;
			_foodMotionFlip = false;
			
			_sparkImage.alpha = 0.8;
			_sparkImage.color = 0xf6ff00;
			_sparkMotionTime = 0;
			_sparkMotionFlip = false;
			
			_destroying = false;
			
			graphic = new Graphiclist(_sparkImage, _foodImage);
		}
		
		override public function update():void 
		{
			if (!_destroying)
			{
				_sparkMotionTime += FP.elapsed;
				_foodMotionTime += FP.elapsed;
				
				if (_foodMotionTime >= FOOD_MOTION_DURATION/2)
				{
					_foodMotionFlip = !_foodMotionFlip;
					_foodMotionTime = 0;
				}
				_foodImage.y += (_foodMotionFlip ? 1 : -1) * (FP.elapsed * FOOD_MOTION_RANGE / FOOD_MOTION_DURATION) / 2;

				if (_sparkMotionTime >= SPARK_MOTION_DURATION/2)
				{
					_sparkMotionFlip = !_sparkMotionFlip;
					_sparkMotionTime = 0;
				}
				_sparkImage.scale += (_sparkMotionFlip ? 1 : -1) * (FP.elapsed * SPARK_MOTION_RANGE / SPARK_MOTION_DURATION) / 2;
			}
			else
			{
				_sparkImage.scale -= FP.elapsed / SPARK_DESTROY_DURATION;
				
				if (_sparkImage.scale <= 0)
					FP.world.remove(this);
			}
		}
		
		public function destroy():void
		{
			collidable = false;
			_foodImage.visible = false;
			_destroying = true;
		}
	}

}