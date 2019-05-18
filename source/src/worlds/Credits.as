package worlds
{
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Drs
	 */
	public class Credits extends World 
	{		
		private var _closing:Boolean = false;
		private var _fromGameOver:Boolean;
		
		public function Credits(fromGameOver:Boolean = false) 
		{
			_fromGameOver = fromGameOver;
		}
		
		override public function begin():void 
		{	
			Input.define(Assets.KEY_ENTER, Key.ENTER);
						
			var text:Text;
			
			//gaphical inits
			text = new Text("Credits", 0, 0, {size:24, color: Assets.TEXT_COLOR_HIGHLIGHT});
			text.font = "GameFont";
			text.x = FP.camera.x / 2 + 290;
			text.y = FP.camera.y / 2 + 50;
			add(new Entity(0, 0, text));
			
			text = new Text("Thanks for playing !\r\n\r\nThe team:\r\n\tDr.Panda: Developer & Paint Engineer\r\n\tDr.Squirrel: Developer & Pint Killer\r\n\tDr.Pingu: Music, Noises & Cooking\r\n\tDr.Seal: Music recordings & vibes maker\r\n\r\nOur toys:\r\n\tCoding: FD, Flashpunk\r\n\tGraphics: Photoshop, Paint.NET (95%)\r\n\tSound: Ableton Live 8\r\n\r\nFOR LD23 :)", 0, 0, {size:18});
			text.font = "GameFont";
			text.leading = -10; 
			text.x = FP.camera.x / 2 + 140;
			text.y = FP.camera.y / 2 + 100;
			add(new Entity(0, 0, text));
			
			text = new Text("Press ENTER to return to menu.", 0, 0, {size: 12, color: Assets.TEXT_COLOR_COMMENT});
			text.font = "GameFont";
			text.x = FP.camera.x / 2 + 230;
			text.y = FP.camera.y / 2 + 440;
			add(new Entity(0, 0, text));
		}
		
		override public function update():void
		{		
			if (_closing) 
			{
				super.update();
				return;
			}
			
			if (Input.pressed(Assets.KEY_ENTER)) {
				_closing = true;
				FP.world.removeAll();
				FP.world.clearTweens();
				FP.world = new Menu(_fromGameOver); //Memory leak from FP ...
				return;
			}
			
			super.update();
		}
	}

}