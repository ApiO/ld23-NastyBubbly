package worlds
{
	import net.flashpunk.graphics.Image;
	import flash.display.Graphics;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Entity;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.World;
	import util.MusicPlayer;
	
	/**
	 * ...
	 * @author Drs
	 */
	public class Menu extends World 
	{
		
		private var _menuItem:Vector.<Entity>;
		private var _closing:Boolean = false;
		private var _selectedItemIndex:int = 0;
		private var _lastSelectedItemIndex:int = 0;
		private var _fromGameOver:Boolean;
		
		private var _level:int = 0;
		
		private const MENU_PADDING:String = "     "; //hugly : no time ! panic : haaaaaaaaaa ... monkey code !
		
		public function Menu(fromGameOver:Boolean = false) 
		{
			_fromGameOver = fromGameOver;
		}
		
		override public function begin():void 
		{
			//local recylable
			var text:Text;
			var entity:Entity;
			
			if (_fromGameOver) 
			{
				if (!MusicPlayer.playing)	
				{
					MusicPlayer.crossFadeToTrack(Assets.SOUND_MENU_LOOP, 1, true);
				}
				else
				{
					MusicPlayer.playTrack(Assets.SOUND_MENU_LOOP, 3, true);
				}
			}
			else 
			{
				if (!MusicPlayer.playing) 
				{
					MusicPlayer.playTrack(Assets.SOUND_MENU_LOOP, 3, true);
				}
			}
			
			add(new Entity(0, 0, new Image(Assets.IMAGE_MENU)));
				
			//Menu inits
			_menuItem = new Vector.<Entity>();
			
			text = new Text("# New game", 0, 0, { size:24, color: Assets.TEXT_COLOR_HIGHLIGHT } );
			text.font = "GameFont";
			text.x = 240;
			text.y = 160;
			entity = new Entity(0, 0, text)
			_menuItem.push(entity);
			add(entity);
			
			text = new Text(MENU_PADDING + "Credits", 0, 0, {size: 24, color: Assets.TEXT_COLOR_DEFAULT});
			text.font = "GameFont";
			text.x = 240;
			text.y = 200;
			entity = new Entity(0, 0, text)
			_menuItem.push(entity);
			add(entity);
			
			//gaphical inits
			text = new Text("Press ENTER to validate.", 0, 0, {size: 12, color: Assets.TEXT_COLOR_COMMENT});
			text.font = "GameFont";
			text.x = FP.camera.x / 2 + 260;
			text.y = FP.camera.y / 2 + 440;
			add(new Entity(0, 0, text));

			//init of inputs config
			Input.define(Assets.KEY_UP, Key.UP);
			Input.define(Assets.KEY_DOWN, Key.DOWN);
			Input.define(Assets.KEY_ENTER, Key.ENTER);
		}
		
		override public function update():void
		{		
			if (_closing) 
			{
				super.update();
				return;
			}
			
			if (Input.pressed(Assets.KEY_ENTER)) {
				FP.world.removeAll();
				FP.world.clearTweens();
				switch(_selectedItemIndex)
				{
					case 0:
						FP.world = new Introduction(); //Memory leak from FP ...
						break;
					case 1:
						FP.world = new Credits(); //Memory leak from FP ...
						break;
				}
				_closing = true;
				return;
			}
			
			var focuseChanged:Boolean = false;
			
			if (Input.pressed(Assets.KEY_UP)) {
				focuseChanged = true;
				_lastSelectedItemIndex = _selectedItemIndex;
				_selectedItemIndex = _selectedItemIndex == 0 ? _menuItem.length - 1 :  _selectedItemIndex - 1;
			}
			
			if (Input.pressed(Assets.KEY_DOWN)) {
				focuseChanged = true;
				_lastSelectedItemIndex = _selectedItemIndex;
				_selectedItemIndex = _selectedItemIndex == _menuItem.length - 1 ? 0 :  _selectedItemIndex + 1;
			}
			
			if (focuseChanged)
			{
				var entity:Text;
				entity = (_menuItem[_lastSelectedItemIndex].graphic as Text);
				entity.color = Assets.TEXT_COLOR_DEFAULT;
				entity.text = entity.text.replace("# ", MENU_PADDING);
				
				entity = (_menuItem[_selectedItemIndex].graphic as Text);
				entity.color = Assets.TEXT_COLOR_HIGHLIGHT;
				entity.text = "# " + entity.text.replace(MENU_PADDING,"");
			}
				
			super.update();
		}
	}
}