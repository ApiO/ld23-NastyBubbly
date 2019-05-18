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
	import util.MusicPlayer;
	
	/**
	 * ...
	 * @author Drs
	 */
	public class GameOver extends World 
	{		
		private var _closing:Boolean = false;
		private var _gameWinned:Boolean = true;
		private var _text:TextManager;
		
		public function GameOver(win:Boolean = false) 
		{
			_gameWinned = win;
			_text = new TextManager();
		}
		
		override public function begin():void 
		{	
			add(_text);
			
			Input.define(Assets.KEY_ENTER, Key.ENTER);
			MusicPlayer.crossFadeToTrack(_gameWinned ? Assets.SOUND_WIN_LOOP : Assets.SOUND_LOOSE, 1, _gameWinned);
			var text:Text;
			
			// titles
			text = new Text("Game over", 0, 0, {size:24, color: Assets.TEXT_COLOR_HIGHLIGHT});
			text.font = "GameFont";
			text.x = FP.camera.x / 2 + 250;
			text.y = FP.camera.y / 2 + 200;
			add(new Entity(0, 0, text));
			
			_text.Print(110, 250, _gameWinned ? "gameend" : "gameover");
			
			if (_gameWinned)
			{
				text = new Text("Press SPACE to go to the following.", 0, 0, {size: 12, color: Assets.TEXT_COLOR_COMMENT});
				text.font = "GameFont";
				text.x = FP.camera.x / 2 + 200;
				text.y = FP.camera.y / 2 + 410;
				add(new Entity(0, 0, text));
			}
			
			text = new Text("Press ENTER to continue.", 0, 0, {size: 12, color: Assets.TEXT_COLOR_COMMENT});
			text.font = "GameFont";
			text.x = FP.camera.x / 2 + _gameWinned ? 200 : 240;
			text.y = FP.camera.y / 2 + 430;
			add(new Entity(0, 0, text));
			
			add(new Entity(0, 0, new Image(_gameWinned ? Assets.IMAGE_GAME_END : Assets.IMAGE_GAME_OVER)));
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
				FP.world = _gameWinned ? new Credits(true) : new Menu(true); //Memory leak from FP ...
				return;
			}
			
			super.update();
		}		
	}
}