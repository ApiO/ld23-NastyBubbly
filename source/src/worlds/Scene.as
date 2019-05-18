package worlds 
{
	import net.flashpunk.graphics.Image;
	import objects.Pillar;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Backdrop;
	import net.flashpunk.World;
	import net.flashpunk.FP;
	import objects.Coral;
	import objects.TreasureChest;
	
	/**
	 * ...
	 * @author Mathieu Capdegelle
	 */
	public class Scene extends World 
	{
		private var _entityGrid:Vector.<Vector.<Entity>>;
		private var _entityGridSequence:int;
		private var _entityGridLoopCount:int;
		
		private var _xmlScene:XML;
		private var _sceneWidth:int;
		private var _sceneHeight:int;
		
		public function Scene(source:*) 
		{
			_xmlScene = FP.getXML(source);
			_sceneWidth = FP.width;
			_sceneHeight = FP.height;
			
			_entityGrid = new Vector.<Vector.<Entity>>();
		}
		
		override public function begin():void 
		{
			_entityGridSequence = 0;
			_entityGridLoopCount = 0;
			load();
			
			var entity:Entity;
			for each (entity in _entityGrid[0]) add(entity);
			for each (entity in _entityGrid[1]) add(entity);
		}
		
		override public function update():void 
		{
			super.update();
			
			if (FP.width % ((FP.camera.x + FP.width)- _entityGridSequence * FP.width) >= FP.width) {
				// grid cell changed !!!
				_entityGridSequence++;
				
				var entity:Entity;
				var gridIndex:int;
				
				// remove entities from index - 2
				if (_entityGridSequence >= 2)
				{
					gridIndex = (_entityGridSequence - 2) % _entityGrid.length;
					for each (entity in _entityGrid[gridIndex])
					{
						remove(entity);
					}
					OnEntitiesRemovedFromGrid(gridIndex, FP.width * (_entityGridSequence - 2));
				}
				
				// add entities from index + 1
				gridIndex = (_entityGridSequence + 1) % _entityGrid.length;
				for each (entity in _entityGrid[gridIndex])
				{
					if (_entityGridSequence >= _entityGrid.length - 1) entity.x += FP.width * _entityGrid.length;
					add(entity);
				}
				OnEntitiesAddedFromGrid(gridIndex, FP.width * (_entityGridSequence + 1));
			}
		}
		
		public function load():void
		{
			var node:XML, o:XML;
			
			// load scene properties
			node = _xmlScene.width[0];
			if (node != null) {
				var width:int = node[0];
				//get nearest FP.width multiple
				while (_sceneWidth < width) _sceneWidth += FP.width;
			}
			
			node = _xmlScene.height[0];
			if (node != null) _sceneHeight = node[0];
			
			// load backdrops
			node = _xmlScene.backdrops[0];
			if (node != null)
			{
				for each(o in node.backdrop)
				{
					var texture:Class;
					switch (String(o.@texture)) 
					{
						case "aquarium-background":
							texture = Assets.BACKDROP_AQUARIUM_BACKGROUND;
							break;
						case "aquarium-ground":
							texture = Assets.BACKDROP_AQUARIUM_GROUND;
							break;
						case "aquarium-horizon":
							texture = Assets.BACKDROP_AQUARIUM_HORIZON;
							break;
					}
					
					var repeatX:Boolean = true;
					var repeatY:Boolean = true;
					
					if (o.@repeatX != undefined) repeatX = (o.@repeatX == "true");
					if (o.@repeatY != undefined) repeatY = (o.@repeatY == "true");
					
					var backdrop:Backdrop = new Backdrop(texture, repeatX, repeatY);
					
					if (o.@x != undefined) backdrop.x = o.@x;
					if (o.@y != undefined) backdrop.y = o.@y;
					
					if (o.@scrollX != undefined) backdrop.scrollX = o.@scrollX;
					if (o.@scrollY != undefined) backdrop.scrollY = o.@scrollY;
					
					addGraphic(backdrop, 99);
				}
			}
			
			// initialize entity grid
			for (var i:int = 0; i < _sceneWidth; i += FP.width)
			{
				_entityGrid.push(new Vector.<Entity>());
			}
			
			// load entities
			node = _xmlScene.objects[0];
			if (node != null)
			{
				var x:int;
				var y:int;
				
				for each(o in node.coral)
				{
					var color:uint = Coral.YELLOW;
					if (o.@color != undefined)
					{
						switch(String(o.@color))
						{
							case "yellow":
								color = Coral.YELLOW;
								break;
							case "red":
								color = Coral.RED;
								break;
							case "magenta":
								color = Coral.MAGENTA;
								break;
							case "violet":
								color = Coral.VIOLET;
								break;
							case "blue":
								color = Coral.BLUE;
								break;
							case "green":
								color = Coral.GREEN;
								break;
							case "black":
								color = Coral.BLACK;
								break;
						}
					}
					
					var scale:Number = 1.0;
					if (o.@scale != undefined) scale = o.@scale;
					
					var flipped:Boolean = false;
					if (o.@flipped != undefined) flipped = o.@flipped;
					
					addInEntityGrid(new Coral(o.@x, o.@y, color, scale, flipped));
				}
				
				for each(o in node.pillar)
				{	
					var difficulty:Number = 0.5;
					if (o.@difficulty != undefined) difficulty = o.@difficulty;
					
					var top:Boolean = false;
					if (o.@top != undefined) top = (o.@top == "true");
					
					var capped:Boolean = true;
					if (o.@capped != undefined) capped = (o.@capped == "true");
					
					addInEntityGrid(new Pillar(o.@x, difficulty, top, capped));
				}
				
				for each(o in node.treasure)
				{
					addInEntityGrid(new TreasureChest(o.@x, o.@y));
				}
				
				for each(o in node.sign)
				{
					var sign:Entity = new Entity(o.@x, o.@y, new Image(Assets.IMAGE_SIGN));
					sign.layer = 3; 
					addInEntityGrid(sign);
				}
			}
		}
		
		public function addInEntityGrid(entity:Entity):void 
		{
			_entityGrid[Math.floor(entity.x / FP.width)].push(entity);
		}
		
		// for override purpose only
		protected function OnEntitiesRemovedFromGrid(index:int, x:int):void { }
		protected function OnEntitiesAddedFromGrid(index:int, x:int):void { }
	}

}