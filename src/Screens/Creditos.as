package Screens
{
	import flash.events.KeyboardEvent;
	
	import Engine.EntryPoint;
	import Engine.Screens.Screen;
	
	public class Creditos extends Screen
	{
		public function Creditos()
		{
			super("MC_Creditos");
			this._model.x = EntryPoint.instance.stage.stageWidth/2;
			this._model.y = EntryPoint.instance.stage.stageHeight/2;
			EntryPoint.instance.stage.addChild(this._model);
		}
		
		override public function enter():void
		{
			this._model.addEventListener(KeyboardEvent.KEY_DOWN, evKeyDown);	
		}
		
		private function evKeyDown(ev:KeyboardEvent):void
		{
			change("MainMenu");
		}
			
		
		override public function exit():void
		{
			this._model.removeEventListener(KeyboardEvent.KEY_DOWN, evKeyDown);
			EntryPoint.instance.stage.removeChild(this._model);
		}
	}
}