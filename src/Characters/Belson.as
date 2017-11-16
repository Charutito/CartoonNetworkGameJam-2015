package Characters
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import Engine.EntryPoint;
	import Engine.Components.IUpdateable;
	
	import Items.BaseItem;
	import Items.CandyItem;
	import Items.DamageItem;
	import Items.FoodItem;
	
	import Screens.Level_1;
	
	public class Belson implements IUpdateable
	{
		private var _model:MovieClip;
		private var _direction:int;
		private var _currentTimeToSpawnItem:Number;
		private var _currentTimeToChangeDir:Number;
		private var _currentTimeToSpawnObstacle:Number;
		
		private static const SPEED:Number = 4.2;
		private static const MIN_TIME_TO_SPAWN_ITEM:Number = 500;
		private static const MAX_TIME_TO_SPAWN_ITEM:Number = 1500;
		
		private static const MIN_TIME_TO_CHANGE_DIR:Number = 1450;
		private static const MAX_TIME_TO_CHANGE_DIR:Number = 4450;
		
		private static const MIN_TIME_TO_SPAWN_OBSTACLE:Number = 1300;
		private static const MAX_TIME_TO_SPAWN_OBSTACLE:Number = 2600;
		
		public function Belson()
		{
			this._model = EntryPoint.instance.assetsManager.getMovieClip("MC_Belson");
			this._model.name = "Belson";
			this._direction = 1;
			this._currentTimeToSpawnItem = randomRange(MIN_TIME_TO_SPAWN_ITEM, MAX_TIME_TO_SPAWN_ITEM);
			this._currentTimeToChangeDir = randomRange(MIN_TIME_TO_CHANGE_DIR, MAX_TIME_TO_CHANGE_DIR);
			this._currentTimeToSpawnObstacle = randomRange(MIN_TIME_TO_SPAWN_OBSTACLE, MAX_TIME_TO_SPAWN_OBSTACLE);
			this._model.scaleX = this._model.scaleY = 0.6;
			
		}
		
		public function init():void
		{
			this._model.x = EntryPoint.instance.camara.spView.x + 474;
			this._model.y = EntryPoint.instance.camara.spView.y;
			
			Level_1._containerPlayer.addChildAt(this._model,0);
			EntryPoint.instance.updateManager.add(this.update);
		}		
		
		public function update(ev:Event=null):void
		{
			Move();
			
			this._currentTimeToSpawnItem -= 1000/EntryPoint.instance.stage.frameRate;
			if(this._currentTimeToSpawnItem <= 0)
			{
				this._currentTimeToSpawnItem = randomRange(MIN_TIME_TO_SPAWN_ITEM,MAX_TIME_TO_SPAWN_ITEM);
				spawnItem();
			}
			
			this._currentTimeToChangeDir -= 1000/EntryPoint.instance.stage.frameRate;
			if(this._currentTimeToChangeDir <= 0)
			{
				this._currentTimeToChangeDir = randomRange(MIN_TIME_TO_CHANGE_DIR, MAX_TIME_TO_CHANGE_DIR);
				this._direction *= -1;
			}
			
			this._currentTimeToSpawnObstacle -= 1000/EntryPoint.instance.stage.frameRate;
			if(this._currentTimeToSpawnObstacle <= 0)
			{
				this._currentTimeToSpawnObstacle = randomRange(MIN_TIME_TO_SPAWN_OBSTACLE, MAX_TIME_TO_SPAWN_OBSTACLE);
				spawnObstacle();
			}
		}
		
		private function spawnItem():void
		{
			var cantSpawn:Boolean = this._model.x > EntryPoint.instance.screenManager.model.startlevel || this._model.x > EntryPoint.instance.screenManager.extendedModel.startlevel;							
			if(!cantSpawn)
			{
				var tmpItem:BaseItem;
				var probabilidad:Number = Math.random();
				if(probabilidad <= 0.22)
					tmpItem = new FoodItem(this._model.x, this._model.y + 24);								
				else if(probabilidad <= 0.55)
					tmpItem = new CandyItem(this._model.x, this._model.y + 24);
				else
					tmpItem = new DamageItem(this._model.x, this._model.y + 24);
				
				tmpItem.init();	
			}
		}
		
		private function spawnObstacle():void
		{
			var cantSpawn:Boolean = this._model.x > EntryPoint.instance.screenManager.model.startlevel || this._model.x > EntryPoint.instance.screenManager.extendedModel.startlevel;
			if(!cantSpawn)
			{
				var tmpObstacle:MovieClip;
				var chance:Number = Math.random();
				if(chance <= 0.33)
				{
					tmpObstacle = EntryPoint.instance.assetsManager.getMovieClip("MC_Pozo")
					tmpObstacle.name = "Pozo";
					tmpObstacle.scaleX = tmpObstacle.scaleY = 0.5;
				}
				else if(chance <= 0.66)
				{
					tmpObstacle = EntryPoint.instance.assetsManager.getMovieClip("MC_Percy")
					tmpObstacle.name = "Percy";
					tmpObstacle.scaleX = tmpObstacle.scaleY = 0.5;
				}
				else
				{
					tmpObstacle = EntryPoint.instance.assetsManager.getMovieClip("MC_Goma");
					tmpObstacle.name = "Percy";
					tmpObstacle.scaleX = tmpObstacle.scaleY = 0.8;
				}
				
				var yaHayPercy:Boolean = false;
				for (var i:int = 0; i < Level_1._containerPlayer.numChildren; i++)
				{
					if(Level_1._containerPlayer.getChildAt(i).name == "Percy")
					{
						yaHayPercy = true;
						break;
					}
				}
				if(yaHayPercy)
				{
					tmpObstacle = EntryPoint.instance.assetsManager.getMovieClip("MC_Pozo")
					tmpObstacle.name = "Pozo";	
					tmpObstacle.scaleX = tmpObstacle.scaleY = 0.5;
				}
				
				tmpObstacle.x = this._model.x + 800;
				tmpObstacle.y = this._model.y + 24;
				tmpObstacle.hitbox.alpha = 0;
				Level_1._containerPlayer.addChildAt(tmpObstacle,0);
				
			}
		}
		
		private function Move():void
		{
			if(this._model.y <= -132 && this._direction == -1)
				this._direction = 1;
			if(this._model.y >= 332 && this._direction == 1)
				this._direction = -1;
			
			this._model.y += this._direction * SPEED; 
			this._model.x += 9.6;
		}
		
		private function randomRange(minNum:Number, maxNum:Number):Number 
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		public function get model():MovieClip
		{
			return this._model;
		}		
		
		public function die():void
		{
			//
		}
	}
}