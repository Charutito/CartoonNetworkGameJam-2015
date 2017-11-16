package Items
{
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import Engine.EntryPoint;
	import Engine.Components.IUpdateable;
	
	import Screens.Level_1;
	
	public class BaseItem implements IUpdateable
	{
		protected var _model:MovieClip;
		protected var _health:Number;
		
		protected var _currentTimeToStop:Number;
		protected var _speed:Number;
		protected var _scaleValue:Number = 0.2;
		
		protected static const MIN_TIME_TO_STOP:Number = 900;
		protected static const MAX_TIME_TO_STOP:Number = 2800;
		
		public function BaseItem(itemX:int, itemY:int)
		{
			this._model = drawModel();
			this._model.x = itemX;
			this._model.y = itemY;
			this._model.scaleX = this._model.scaleY = this._scaleValue;  
		}
		
		public function init():void
		{
			this._currentTimeToStop = randomRange(MIN_TIME_TO_STOP, MAX_TIME_TO_STOP);			
			Level_1._containerPlayer.addChildAt(this._model,1);
			EntryPoint.instance.updateManager.add(update);
		}
		
		public function update(ev:Event = null):void
		{
			this._model.x -= randomRange(1.3, 4.2);
			this._model.rotation += 4.7;
			this._currentTimeToStop -= 1000/EntryPoint.instance.stage.frameRate;
			if(this._currentTimeToStop <= 0)
				EntryPoint.instance.updateManager.remove(update);
		}
		
		public function die():void
		{
			throw new Error("Implementar die!");
		}
		
		protected function drawModel():MovieClip
		{
			throw new Error("Implementar model!");			
		}
		
		private function randomRange(minNum:Number, maxNum:Number):Number 
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		public function get model():MovieClip
		{
			return this._model;
		}				
	}
}