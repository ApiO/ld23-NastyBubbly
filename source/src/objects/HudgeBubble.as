package objects 
{

	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	
	public class HudgeBubble extends Bubble 
	{
		public static const HEIGHT:int = 48;
		public static  const WIDTH:int = 48;
		
		private var _explode:Boolean = false;
		private var _bubbleSprite:Spritemap = new Spritemap(Assets.SPRITE_BUBBLE, HEIGHT, WIDTH);
		
		private var _explodeSound:Sfx = new Sfx(Assets.SOUND_BUBBLE, null, "effect");
		
		public function HudgeBubble() 
		{
			setHitbox(HEIGHT, WIDTH)
			_bubbleSprite.add("wait", [0, 1, 2, 3], 5, true);
			_bubbleSprite.add("explode", [4, 5, 6, 7, 8, 9, 10, 11], 20, false);
			
			graphic = new Graphiclist(_bubbleSprite);
			_bubbleSprite.play("wait", true);
		}
		
		override public function update():void 
		{
			
			if (_explode && _bubbleSprite.complete) {
				FP.world.remove(this);
			}
			
			super.update();
		}
		
		override public function Destroy():void 
		{
			_explode = true;
			collidable = false;
			_bubbleSprite.play("explode", true);
			_explodeSound.play(0.5);
		}
		
	}

}