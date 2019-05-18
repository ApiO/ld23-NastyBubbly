package objects
{
	import hud.BoostBar;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Emitter;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.Sfx;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	import net.flashpunk.FP;
	import net.flashpunk.utils.Ease;
	import worlds.Game;
	
	/**
	 * ...
	 * @author Mathieu Capdegelle
	 */
	
	public class Bubbly extends Entity 
	{
		public static const WIDTH:int = 56;
		public static const HEIGHT:int = 38;
		public static const MAXSPEED_X:Number = 250;
		public static const MAXSPEED_X_BOOST:Number = 390;
		public static const MAXSPEED_Y:Number = 275;
		public static const ACCELERATION:Number = 1100;
		public static const FRICTION:Number = 600;
		public static const BUBBLE_DECELERATION_RATE:Number = 0.8;
		public static const BOOST_RATE_INC:Number = 0.1;
		public static const BOOST_RATE_DEC:Number = 0.2;
		
		public var _vx:Number;
		public var _vy:Number;
		private var _boost:Boolean;
		private var _swimming:Boolean; 
		
		private var _bodySprite:Spritemap = new Spritemap(Assets.SPRITE_BODY, 56, 38);
		private var _eyeSprite:Spritemap = new Spritemap(Assets.SPRITE_EYES, 22, 20);
		private var _mouthSprite:Spritemap = new Spritemap(Assets.SPRITE_MOUTH, 22, 15);

		private var _shitEmitter:Emitter = new Emitter(Assets.SPRITE_SHIT, 10, 10);
		
		private var _eatSound:Sfx = new Sfx(Assets.SOUND_EAT, eatSoundCallback, "effect");
		private var _fartSound:Sfx = new Sfx(Assets.SOUND_FART_LOOP, null, "effect");
		private var _blurpSound:Sfx = new Sfx(Assets.SOUND_BLURP, null, "effect");
		
		private var _totalTimeUsingBoost:Number = 0;
		
		public function Bubbly() 
		{
			setHitbox(WIDTH - 10, HEIGHT);
			
			_vx = 0;
			_vy = 0;
			_boost = false;
			boostAmmount = 0;
			_swimming = false;
			
			_bodySprite.add("swim", [0, 1, 0, 2], 10, true);
			_bodySprite.add("_boost", [0, 1, 0, 2], 18, true);
			
			_eyeSprite.add("swim", [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 2, 3], 10, true);
			_eyeSprite.add("_boost", [4, 5, 6, 7, 4, 5, 6, 7, 4, 5, 6, 7, 4, 5, 6, 7, 1, 2, 3], 18, true);
			_eyeSprite.x = 34;
			_eyeSprite.y = 4;
			
			_mouthSprite.add("idle", [0]);
			_mouthSprite.add("eat", [1, 2, 0, 2, 0, 2, 0, 2], 10, false);
			_mouthSprite.add("blurp", [1], 2, false);
			_mouthSprite.x = 38;
			_mouthSprite.y = 22;
			
			_shitEmitter.newType("_boost", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]);
			_shitEmitter.setAlpha("_boost", 1, 0);		
			_shitEmitter.setMotion("_boost", 0, 50, 1, 360, -40, -0.5);
			_shitEmitter.relative = false;
			
			graphic = new Graphiclist(_bodySprite, _eyeSprite, _mouthSprite, _shitEmitter);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (_mouthSprite.complete)
			{
				_mouthSprite.play("idle");
			}
			
			// vertical control
			switch (true) 
			{
				case (Input.check(Key.UP)):
					_vy -= ACCELERATION * FP.elapsed;
					break;
				case (Input.check(Key.DOWN)):
					_vy += ACCELERATION * FP.elapsed;
					break;
				default:
					_vy = FP.approach(_vy, 0, FRICTION * FP.elapsed);
			}
			
			// swiming control
			if (_swimming)
			{
				_vx += ACCELERATION * FP.elapsed;
			}
			
			// _boost control
			if (Input.check(Key.SPACE) && boostAmmount > 0)
			{
				_bodySprite.play("_boost");
				_eyeSprite.play("_boost");
				_shitEmitter.emit("_boost", x + 15, y + 25);
				if(!_boost) _fartSound.loop();
				
				boostAmmount -= BOOST_RATE_DEC * FP.elapsed;
				_boost = true;
				_totalTimeUsingBoost += FP.elapsed;
			}
			else {
				_bodySprite.play("swim");
				_eyeSprite.play("swim");
				_boost = false;
				_fartSound.stop();
			}
			
			// update velocity		
			if (Math.abs(_vy) > MAXSPEED_Y) 
				_vy = ((_vy < 0) ? -1 : 1) * MAXSPEED_Y;
			
			if (Math.abs(_vx) > (_boost ? MAXSPEED_X_BOOST : MAXSPEED_X))
				_vx = ((_vx < 0) ? -1 : 1) * (_boost ? MAXSPEED_X_BOOST : MAXSPEED_X);
				
			// bubble collision
			var bubble:Bubble = collide("bubble", x, y) as Bubble;
			if (bubble != null)
			{
				bubble.Destroy();
				_vx -= (_boost ? MAXSPEED_X_BOOST : MAXSPEED_X) * BUBBLE_DECELERATION_RATE;
			}
				
			// apply motion
			moveBy(_vx * FP.elapsed * Game.speedRate, _vy * FP.elapsed * Game.speedRate, ["pillar", "treasurchest"], false);
			
			// food collision
			var food:Food = collide("food", x + 15, y) as Food;
			if (food != null)
			{
				boostAmmount += BOOST_RATE_INC;
				
				_mouthSprite.play("eat", true);
				food.destroy();
				_eatSound.play(0.5);
			}
			
			// force nasty bubbly to stay in the game zone
			if (y < 0)
				y = 0;
			if (y > FP.height - height)
				y = FP.height - height;
		}
		
		// quick fix :(
		public function stopFartSound():void
		{
			_fartSound.stop();
		}
		
		public function startSwimming():void
		{
			_swimming = true;
		}
		
		public function stopSwimming():void
		{
			_swimming = false;
		}
		
		public function eatSoundCallback():void
		{
			if (Math.random() <= 0.2) 
			{
				_blurpSound.play();
				_mouthSprite.play("blurp");
			}
		}
		
		public function get boostAmmount():Number
		{
			var game:Game = (FP.world as Game);
			if (game != null) {
				return game.boostBar.boostAmmount;
			}
			else return -1;
		}
		
		public function set boostAmmount(value:Number):void
		{
			var game:Game = (FP.world as Game);
			if (game != null) {
				game.boostBar.boostAmmount = value;
			}
		}
		
		public function get boost():Boolean { return _boost; }
		public function get vx():Number { return _vx; }
		public function get vy():Number { return _vy; }
		public function get totalTimeUsingBoost():Number { return _totalTimeUsingBoost; }
	}

}