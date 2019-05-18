package objects 
{
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Spritemap;
	
	/**
	 * ...
	 * @author Drs
	 */
	public class LittleBubble extends Bubble 
	{
		public static const HEIGHT:int = 24;
		public static const WIDTH:int = 24;
		
		public static const SPEED:int = 90;
		
		private var _bubbleSprite:Spritemap = new Spritemap(Assets.IMAGE_LITTLEBUBBLE, HEIGHT, WIDTH);
		
		public function LittleBubble() 
		{			
			setHitbox(HEIGHT, WIDTH);
			_bubbleSprite.add("stand", [0], 0, false);
			
			graphic = new Graphiclist(_bubbleSprite);
			_bubbleSprite.play("stand", true);
		}
		
		override public function update():void 
		{
			y -= SPEED * FP.elapsed;
			
			if (y + HEIGHT < 0 || x + WIDTH < FP.camera.x)
				Destroy();
			
			super.update();
		}
		
		override public function Destroy():void 
		{
			FP.world.remove(this);
		}
	}

}