package util 
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	/**
	 * ...
	 * @author Mathieu Capdegelle
	 */
	public class EntitySpawner 
	{
		public static function RandomSpawn( 
			minX:int, minY:int, maxX:int, maxY:int, 
			minCount:int, maxCount:int, 
			entityFactory:Function ) : Vector.<Entity>
		{
			var createdEntities:Vector.<Entity> = new Vector.<Entity>();
			var entitiesCount:int = randomMinMax(minCount, maxCount);
			
			for (var i:int = 0; i < entitiesCount; i++) 
			{
				var entity:Entity = entityFactory();
				entity.x = randomMinMax(minX, maxX);
				entity.y = randomMinMax(minY, maxY);
				createdEntities.push(entity);
				FP.world.add(entity);
			}
			
			return createdEntities;
		}
		
		public static function randomMinMax( min:Number, max:Number ):Number
		{
			return min + (max - min) * Math.random();
		}
	}

}