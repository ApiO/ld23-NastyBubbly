package util
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Dr.Panda
	 */
	public class TextManager extends Entity
	{
		private var _text:Text;
		private var _textcontainer:Entity;
		
		private var _callback:Function;
		
		private var _messageIndex:int;
		private var _message:String;
		private var _elapsed:Number;
		private var _currentDelay:Number;
		private var _fontsize:int;
		
		private var _data:XMLList;
		
		private var _ended:Boolean;
		private var _isDialog:Boolean;
		
		private var _color:uint;
		
		//private var _sound:Sfx = new Sfx(Assets.SN_TEXT);
		private var _dialogSprite:Spritemap;
		private var _dialogbubble:Entity;
		
		private var _textMarginX:int;
		private var _textMarginY:int;
		private const DIALOG_MARGINY:int = 168;
		
		public function TextManager() 
		{
			_messageIndex = 0;
		}
		
		public function Print(marginX:int, marginY:int, key:String, callback:Function = null, fontsize:int = 18, color:uint = 0xFFFFFF):void
		{
			if (_textcontainer != null) FP.world.remove(_textcontainer);
			if (_dialogbubble != null) FP.world.remove(_dialogbubble);
			
			_messageIndex = 0;
			_fontsize = fontsize;
			_textMarginX = marginX;
			_textMarginY = marginY;
			_color = color;
			_callback = callback;
			
			_ended = false;
			_isDialog = false;
			
			_data = GetSequenceData(key);
			LoadMessage();
		}
		
		public function ShoxDialog(dialogindex:int, callback:Function = null, fontsize:int = 18, color:uint = 0x404040):void
		{
			if (_textcontainer != null) FP.world.remove(_textcontainer);
			if (_dialogbubble != null) FP.world.remove(_dialogbubble);
			
			_fontsize = fontsize;
			_color = color;
			_callback = callback;
			_messageIndex = dialogindex;
			
			_textMarginX = 210;
			_textMarginY = 70;
			
			_ended = false;
			_isDialog = true;
			_data = GetSequenceData("girldialog");
			
			_dialogSprite = new Spritemap(Assets.IMAGE_DIALOG, 208, 156);
			_dialogbubble = new Entity(DIALOG_MARGINY, 0, _dialogSprite);
			FP.world.add(_dialogbubble);
			_dialogSprite.play();
			LoadMessage();
		}
		
		private function GetSequenceData(sequenceKey:String):XMLList {

			var xml:XML = FP.getXML(Assets.DIALOG);
			var data:XMLList;
			
			switch(sequenceKey)
			{
				case "introduction":
					data = xml.introduction;
					break;
				case "gameover":
					data = xml.gameover;
					break;
				case "gameend":
					data = xml.gameend;
					break;
				case "girldialog":
					data = xml.girldialog;
					break;
			}
			
			return data;
		}
		
		
		private function LoadMessage():void
		{
			//init var env
			_elapsed = 0;
			_message = _data.text[_messageIndex];
			_currentDelay = _data.text[_messageIndex].@delay;
			
			// define self and text
			_text = new Text(_message, 0, 0, { size:_fontsize, color:_color } );
			_text.leading = -10; 

			_text.font = "GameFont";
			_textcontainer = new Entity(_textMarginX, _textMarginY, _text);;
			FP.world.add(_textcontainer);
		}
		
		override public function update():void 
		{
			if (_ended || _data == null) return;
						
			var skip:Boolean = false;
			
			_elapsed += FP.elapsed;
			
			// if action key was pressed, skip text
			if (int(_elapsed) >= _currentDelay || (!_isDialog && Input.pressed(Key.SPACE)))
				skip = true;

			if (skip) 
			{
				FP.world.remove(_textcontainer);
				if (!_isDialog)
 				{
   					if (_messageIndex == _data.text.length() - 1)
					{
						_ended = true;
						if (_callback != null) 
							_callback();
					}
					else 
					{
						_messageIndex++;
						LoadMessage();
					}
				}
				else
				{
					_ended = true;
					FP.world.remove(_dialogbubble);
					if (_callback != null) 
						_callback();
				}
			}
			
			super.update();
		}
		
		override public function render():void 
		{
			super.render();
			if(_textcontainer != null)
			{
				_textcontainer.x = FP.camera.x + _textMarginX;
			}
			if(_dialogbubble != null)
			{
				_dialogbubble.x = FP.camera.x + DIALOG_MARGINY;
			}
		}
	}
}