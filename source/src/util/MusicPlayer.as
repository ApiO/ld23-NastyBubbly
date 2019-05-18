package util 
{
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.sound.Fader;
	import net.flashpunk.tweens.sound.SfxFader;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Mathieu Capdegelle
	 */
	public class MusicPlayer
	{
		private static var _track:Sfx;
		private static var _loop:Boolean;
		private static var _fader:SfxFader;
		private static var _callback:Function;
		
		public static function playTrack(source:*, fadeIn:Number = 0, loop:Boolean = true, callback:Function = null):void
		{
			_callback = callback;
			_loop = loop;
			
			if (_fader != null) FP.tweener.removeTween(_fader);
			_track = new Sfx(source, onTrackCompleted);
			_fader = new SfxFader(_track);
			FP.tweener.addTween(_fader);
			
			if (fadeIn > 0)
			{
				loop ? _track.loop(0) : _track.play(0);
				_fader.fadeTo(1, fadeIn);
			}
			else
			{
				loop ? _track.loop(1) : _track.play(1);
			}
		}
		
		public static function crossFadeToTrack(source:*, duration:Number, loop:Boolean = true, callback:Function = null):void
		{
			_callback = callback;
			_loop = loop;
			
			_fader.crossFade(new Sfx(source, onTrackCompleted), loop, duration, 1);
		}
		
		public static function onTrackCompleted():void
		{
			if (_callback != null && ! _loop) _callback();
		}
		
		public static function get playing():Boolean
		{
			return _track != null ? _track.playing : false;
		}
	}
}