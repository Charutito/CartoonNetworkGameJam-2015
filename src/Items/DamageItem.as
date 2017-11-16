package Items
{
	import flash.display.MovieClip;
	
	import Engine.EntryPoint;

	public class DamageItem extends BaseItem
	{
		public function DamageItem(itemX:int, itemY:int)
		{
			super(itemX, itemY);
			this._health = -10;
			this._model.name = "Item Damage";
			this._model.scaleX = this._model.scaleY = 0.45;  
			this._model.hitbox.alpha = 0;
		}
		
		override protected function drawModel():MovieClip
		{
			var chance:Number = Math.random();
			if(chance < 0.33)
				this._model = EntryPoint.instance.assetsManager.getMovieClip("MC_Ball");
			else if(chance < 0.66)
				this._model = EntryPoint.instance.assetsManager.getMovieClip("MC_Lata");
			else
				this._model = EntryPoint.instance.assetsManager.getMovieClip("MC_TRex");
			return this._model;
		}	
	}
}