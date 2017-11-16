package Items
{
	import flash.display.MovieClip;
	
	import Engine.EntryPoint;

	public class CandyItem extends BaseItem
	{		
		public function CandyItem(itemX:int, itemY:int)
		{
			super(itemX, itemY);
			this._health = 0;
			this._model.name = "Item Candy";
			this._model.hitbox.alpha = 0;
		}
		
		override protected function drawModel():MovieClip
		{
			var chance:Number = Math.random();
			if(chance < 0.3)
				this._model = EntryPoint.instance.assetsManager.getMovieClip("MC_Chupelupe");
			else if(chance < 0.6)
				this._model = EntryPoint.instance.assetsManager.getMovieClip("MC_ElDelMillo");
			else
				this._model = EntryPoint.instance.assetsManager.getMovieClip("MC_Memelo");		
			return this._model;
		}	
	}
}