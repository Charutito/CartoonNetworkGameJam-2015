package Items
{
	import flash.display.MovieClip;
	
	import Engine.EntryPoint;

	public class FoodItem extends BaseItem
	{	
		public function FoodItem(itemX:Number, itemY:Number)
		{
			super(itemX, itemY);
			this._health = 10;
			this._model.name = "Item Food";
			this._model.hitbox.alpha = 0;
		}		
		
		override protected function drawModel():MovieClip
		{
			var chance:Number = Math.random();
			if(chance < 0.5)
				this._model = EntryPoint.instance.assetsManager.getMovieClip("MC_Poio");
			else if(chance < 1)
				this._model = EntryPoint.instance.assetsManager.getMovieClip("MC_Burger");	
			return this._model;
		}	
	}
}