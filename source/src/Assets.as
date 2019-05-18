package  
{
	/**
	 * ...
	 * @author Mathieu Capdegelle
	 */
	public class Assets
	{
		// Bubbly graphics
		[Embed(source = '../assets/graphics/bubbly/body.png')]	public static const SPRITE_BODY:Class;
		[Embed(source = '../assets/graphics/bubbly/eyes.png')]	public static const SPRITE_EYES:Class;
		[Embed(source = '../assets/graphics/bubbly/mouth.png')] public static const SPRITE_MOUTH:Class;
		[Embed(source = '../assets/graphics/bubbly/shit.png')] public static const SPRITE_SHIT:Class;
		
		// object graphics
		[Embed(source = '../assets/graphics/objects/sign.png')] public static const IMAGE_SIGN:Class;
		[Embed(source = '../assets/graphics/objects/coral.png')] public static const IMAGE_CORAL:Class;
		[Embed(source = '../assets/graphics/objects/pillar.png')] public static const IMAGE_PILLAR:Class;
		[Embed(source = '../assets/graphics/objects/pillarcap.png')] public static const IMAGE_PILLARCAP:Class;
		[Embed(source = '../assets/graphics/objects/spark.png')] public static const IMAGE_SPARK:Class;
		[Embed(source = '../assets/graphics/objects/food.png')] public static const IMAGE_FOOD:Class;
		[Embed(source = '../assets/graphics/objects/bubble.png')] public static const SPRITE_BUBBLE:Class;
		[Embed(source = '../assets/graphics/objects/little-bubble.png')] public static const IMAGE_LITTLEBUBBLE:Class;
		[Embed(source = "../assets/graphics/objects/landingnet-back.png")] public static const SPRITE_LANDINGNET_BACK:Class;
		[Embed(source = "../assets/graphics/objects/landingnet-front.png")] public static const SPRITE_LANDINGNET_FRONT:Class;
		[Embed(source = "../assets/graphics/objects/treasure-chest.png")] public static const SPRITE_TREASURECHEST:Class;
		
		// hud
		[Embed(source = '../assets/graphics/hud/boostbar.png')] public static const IMAGE_BOOSTBAR:Class;
		[Embed(source = "../assets/graphics/hud/dialog-bubble.png")] public static const IMAGE_DIALOG:Class;
		[Embed(source = '../assets/graphics/hud/shit-filter.png')] public static const IMAGE_SHITFILTER:Class;
		
		// fonts
		[Embed(source = '../assets/fonts/GROBOLD.ttf', embedAsCFF = "false", fontFamily = 'GameFont')] public const GAME_FONT:Class;
		
		// dialogs
		[Embed(source = "../assets/scenes/dialog.xml", mimeType = "application/octet-stream")] public static const DIALOG:Class;
		
		// backdrop graphics
		[Embed(source = '../assets/graphics/backdrops/aquarium-background.jpg')] public static const BACKDROP_AQUARIUM_BACKGROUND:Class;
		[Embed(source = '../assets/graphics/backdrops/aquarium-horizon.png')] public static const BACKDROP_AQUARIUM_HORIZON:Class;
		[Embed(source = '../assets/graphics/backdrops/aquarium-ground.png')] public static const BACKDROP_AQUARIUM_GROUND:Class;
		
		// scenes
		[Embed(source = "../assets/scenes/game.xml", mimeType = "application/octet-stream")] public static const SCENE_GAME:Class;
		
		// sounds
		[Embed(source = '../assets/sounds/sfx.swf', symbol = 'theme.wav')] public static const SOUND_MENU_LOOP:Class;
		[Embed(source = '../assets/sounds/sfx.swf', symbol = 'gameplayintro1.wav')] public static const SOUND_GAME1_INTRO:Class;
		[Embed(source = '../assets/sounds/sfx.swf', symbol = 'gameplay1.wav')] public static const SOUND_GAME1_LOOP:Class;
		[Embed(source = '../assets/sounds/sfx.swf', symbol = 'gameplayintro2.wav')] public static const SOUND_GAME2_INTRO:Class;
		[Embed(source = '../assets/sounds/sfx.swf', symbol = 'gameplay2.wav')] public static const SOUND_GAME2_LOOP:Class;
		[Embed(source = '../assets/sounds/sfx.swf', symbol = 'blurp.wav')] public static const SOUND_BLURP:Class;
		[Embed(source = '../assets/sounds/sfx.swf', symbol = 'fart.wav')] public static const SOUND_FART_LOOP:Class;
		[Embed(source = '../assets/sounds/sfx.swf', symbol = 'eat.wav')] public static const SOUND_EAT:Class;
		[Embed(source = '../assets/sounds/sfx.swf', symbol = 'gameover.wav')] public static const SOUND_LOOSE:Class;
		[Embed(source = '../assets/sounds/sfx.swf', symbol = 'ending.wav')] public static const SOUND_WIN_LOOP:Class;
		[Embed(source = '../assets/sounds/sfx.swf', symbol = 'bubble.wav')] public static const SOUND_BUBBLE:Class;
		
		[Embed(source = '../assets/sounds/sfx.swf', symbol = 'voicef1.wav')] public static const SOUND_VOICE1:Class;
		[Embed(source = '../assets/sounds/sfx.swf', symbol = 'voicef2.wav')] public static const SOUND_VOICE2:Class;
		[Embed(source = '../assets/sounds/sfx.swf', symbol = 'voicef3.wav')] public static const SOUND_VOICE3:Class;
		[Embed(source = '../assets/sounds/sfx.swf', symbol = 'voicef4.wav')] public static const SOUND_VOICE4:Class;
		
		public static const GIRL_YELLS_SOUNDS:Array = [SOUND_VOICE1, SOUND_VOICE2, SOUND_VOICE3, SOUND_VOICE4]
		
		//Font color
		public static const TEXT_COLOR_DEFAULT:uint = 0x727272;
		public static const TEXT_COLOR_HIGHLIGHT:uint = 0x404040;
		public static const TEXT_COLOR_COMMENT:uint = 0x606060;
		
		//Inputs Key
		public static const KEY_UP:String = "up";
		public static const KEY_DOWN:String = "down";
		public static const KEY_ENTER:String = "enter";
		public static const KEY_SPACE:String = "space";
		
		// menus
		[Embed(source = '../assets/graphics/menus/game-over.jpg')] public static const IMAGE_GAME_OVER:Class;
		[Embed(source = '../assets/graphics/menus/game-end.jpg')] public static const IMAGE_GAME_END:Class;
		[Embed(source = '../assets/graphics/menus/introduction.jpg')] public static const IMAGE_INTRODUCTION:Class;
		[Embed(source = '../assets/graphics/menus/menu.jpg')] public static const IMAGE_MENU:Class;
	}

}