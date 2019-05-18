package objects 
{
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Spritemap;
	import worlds.Game;
	
	/**
	 * ...
	 * @author Drs
	 */
	public class LandingNet extends Entity 
	{
		
		public static const HEIGHT_FRONT:int = 480;
		public static const WIDTH_FRONT:int = 221;
		
		public static const HEIGHT_BACK:int = 480;
		public static const WIDTH_BACK:int = 78;
		
		public static const SPEED:Number = Bubbly.MAXSPEED_X;
		
		private var _landingnNetSpriteFront:Spritemap;
		private var _landingnNetSpriteBack:Spritemap;
		
		public function LandingNet() 
		{
			layer = -1;
			type = "landingnet";
			
			setHitbox(WIDTH_FRONT / 2, HEIGHT_FRONT);
			
			_landingnNetSpriteFront = new Spritemap(Assets.SPRITE_LANDINGNET_FRONT, WIDTH_FRONT, HEIGHT_FRONT);
			_landingnNetSpriteFront.add("move", [0, 1, 2, 1, 0], 10, true);
			_landingnNetSpriteFront.x = 0;
			_landingnNetSpriteFront.y = 0;
			
			_landingnNetSpriteBack = new Spritemap(Assets.SPRITE_LANDINGNET_BACK, WIDTH_BACK, HEIGHT_BACK);
			_landingnNetSpriteBack.add("move", [0, 1, 2, 1, 0], 10, true);
			_landingnNetSpriteBack.x = 166;
			_landingnNetSpriteBack.y = 0;
			
			graphic = _landingnNetSpriteFront; 
			// render _landingnNetSpriteBack in another entity
			
			_landingnNetSpriteFront.play("move", true);
			_landingnNetSpriteBack.play("move", true);
		}
		
		override public function update():void 
		{
			x += SPEED * FP.elapsed * Game.speedRate;
			
			var cameraDistance:int = (x + WIDTH_FRONT / 1.4) - FP.camera.x;
			
			//clamp just in front of camera if bubbly is fast
			if ( cameraDistance < 0 )
			{
				x -= cameraDistance;
			}
			
			super.update();
		}
		
		override public function added():void 
		{
			FP.world.add(new LandingNetBack(this));
		}
		
		public function get landingnNetSpriteBack():Spritemap
		{
			return _landingnNetSpriteBack;
		}
	}
}