package 
{
	import flash.system.System;
	import net.flashpunk.Engine;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import util.MusicPlayer;
	import worlds.Menu;
	
	/**
	 * ...
	 * @author Mathieu Capdegelle
	 */
	[SWF(width = "640", height = "480")]
	public class Main extends Engine 
	{
		public function Main():void 
		{
			super(640, 480, 60, false);
			
			//FP.console.enable();

			FP.world = new Menu();
		}
		
		override public function init():void 
		{
			super.init();
		}
		
		override public function update():void
		{
			super.update();
			
			// press ESCAPE to exit debug player
			if (Input.check(Key.ESCAPE)) {
				System.exit(1);
			}
		}
	}
}