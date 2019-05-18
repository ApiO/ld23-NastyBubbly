package worlds
{
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import util.TextManager;
	import worlds.Game;
	
	/**
	 * ...
	 * @author Drs
	 */
	public class Introduction extends World 
	{
		
		private var _closing:Boolean = false;
		private var _text:TextManager;
		
		public function Introduction() 
		{		
			_text = new TextManager();
			add(_text);
		}
		
		override public function begin():void 
		{	
			Input.define(Assets.KEY_ENTER, Key.ENTER);
			
			var text:Text;
			
			//gaphical inits
			text = new Text("Introduction", 0, 0, {size:24, color: Assets.TEXT_COLOR_HIGHLIGHT});
			text.font = "GameFont";
			text.x = FP.camera.x / 2 + 250;
			text.y = FP.camera.y / 2 + 200;
			add(new Entity(0, 0, text));
			
			_text.Print(70, 240, "introduction", GotoLevel);
			
			text = new Text("Press SPACE to go to the following.", 0, 0, {size: 12, color: Assets.TEXT_COLOR_COMMENT});
			text.font = "GameFont";
			text.x = FP.camera.x / 2 + 200;
			text.y = FP.camera.y / 2 + 410;
			add(new Entity(0, 0, text));
			
			text = new Text("Press ENTER to skip introduction.", 0, 0, {size: 12, color: Assets.TEXT_COLOR_COMMENT});
			text.font = "GameFont";
			text.x = FP.camera.x / 2 + 200;
			text.y = FP.camera.y / 2 + 430;
			add(new Entity(0, 0, text));
			
			add(new Entity(0, 0, new Image(Assets.IMAGE_INTRODUCTION)));
		}
		
		override public function update():void
		{		
			if (_closing) 
			{
				super.update();
				return;
			}
			
			if (Input.pressed(Assets.KEY_ENTER)) {
				remove(_text);
				GotoLevel(); //Memory leak from FP ...
				return;
			}
			
			super.update();
		}
				
		private function GotoLevel():void {
			_closing = true;
			_text.clearTweens();
			FP.world.remove(_text);
			_text = null;
			FP.world.removeAll();
			FP.world.clearTweens();
			FP.world = new Game();
			return;
		}
	}

}