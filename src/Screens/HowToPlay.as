package Screens
{
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	
	import Engine.EntryPoint;
	import Engine.Screens.Screen;
	
	public class HowToPlay extends Screen
	{
		public function HowToPlay()
		{
			super("MC_HowToPlay");
			this._model.x = EntryPoint.instance.stage.stageWidth/2;
			this._model.y = EntryPoint.instance.stage.stageHeight/2;
			EntryPoint.instance.stage.addChild(this._model);
		}
		
		override public function enter():void
		{
			this._model.BTN_Back.addEventListener(MouseEvent.CLICK, volver);			
		}
		
		private function volver(ev:MouseEvent):void
		{
			change("MainMenu");
		}
				
		override public function exit():void
		{
			this._model.BTN_Back.removeEventListener(MouseEvent.CLICK, volver);
			EntryPoint.instance.stage.removeChild(this._model);
		}

	}
}