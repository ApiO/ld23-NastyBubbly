package objects 
{
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Spritemap;
	import util.EntitySpawner;
	
	/**
	 * ...
	 * @author Drs
	 */
	public class TreasureChest extends Entity 
	{
		private static const HEIGHT:int = 142;
		private static const WIDTH:int = 109;
		
		private static const MIN_WAVE_DELAY:Number = 2;
		private static const MAX_WAVE_DELAY:Number = 3;
		private static const MIN_WAVE_COUNT:int = 2;
		private static const MAX_WAVE_COUNT:int = 5;
		private static const BUBBLE_MARGIN:int = LittleBubble.HEIGHT;
		
		private static const INNER_WAVE_DELAY:Number = BUBBLE_MARGIN / LittleBubble.SPEED;
		
		private var _treasureChest:Spritemap = new Spritemap(Assets.SPRITE_TREASURECHEST, HEIGHT, WIDTH);
		
		private var _waveElasped:Number = 0;
		private var _innerWaveElapsed:Number = 0;
		private var _waitingNextWave:Boolean = true;
		private var _creatingWave:Boolean = false;
		private var _nextWaveDelay:Number = 0;
		private var _waveCountTarget:int = 0;
		private var _waveCount:int = 0;
		
		private var _createdBubbles:Vector.<LittleBubble>;
		
		public function TreasureChest(x:int, y:int) 
		{
			layer = 2;
			
			this.x = x;
			this.y = y;
			type = "treasurchest";
			
			setHitbox(HEIGHT, WIDTH)
			_treasureChest.add("stand", [0, 1, 2, 3, 4], 4, true);
			
			graphic = new Graphiclist(_treasureChest);
			
			_treasureChest.play("stand", true);
			
			_nextWaveDelay = EntitySpawner.randomMinMax(MIN_WAVE_DELAY, MAX_WAVE_DELAY);
			_waveCountTarget = EntitySpawner.randomMinMax(MIN_WAVE_COUNT, MAX_WAVE_COUNT + 1);
			
			_createdBubbles = new Vector.<LittleBubble>();
		}
		
		override public function added():void 
		{
			super.added();
			
			//simulate 4 second bubble creation to fill the screen
			for (var simulatedTime:Number = 0; simulatedTime < 4; simulatedTime += 0.1) 
			{
				createBubble(simulatedTime, true);
			}
		}
		
		override public function update():void 
		{
			super.update();
			createBubble(FP.elapsed);
		}
		
		private function createBubble(elapsedTime:Number, simulation:Boolean = false):void 
		{
			_waveElasped += elapsedTime;
			_innerWaveElapsed += elapsedTime;
			
			if (_waveElasped >= _nextWaveDelay) 
			{
				_creatingWave = true;
				_waveElasped = 0;
				_waveCount = 0;
				_nextWaveDelay = EntitySpawner.randomMinMax(MIN_WAVE_DELAY, MAX_WAVE_DELAY);
				_waveCountTarget = EntitySpawner.randomMinMax(MIN_WAVE_COUNT, MAX_WAVE_COUNT + 1);
			}
			
			if (_creatingWave) {
				if (_innerWaveElapsed >= INNER_WAVE_DELAY)
				{
					_innerWaveElapsed = 0;
					
					var littleBubble:LittleBubble = new LittleBubble();
					littleBubble.x = x + WIDTH / 2;
					littleBubble.y = y;
					FP.world.add(littleBubble);
					_waveCount++;
					
					if( simulation ) _createdBubbles.push(littleBubble);
				}
				
				if (_waveCount >= _waveCountTarget) _creatingWave = false;
			}
			
			if (simulation)
			{
				for each(var bubble:Bubble in _createdBubbles)
				{
					bubble.y -= LittleBubble.SPEED * elapsedTime;
				}
			}
		}
	}
}