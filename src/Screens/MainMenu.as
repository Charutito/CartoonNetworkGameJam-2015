package Screens
{
	import flash.events.MouseEvent;
	
	import Engine.EntryPoint;
	import Engine.Screens.Screen;
	
	public class MainMenu extends Screen
	{
		public function MainMenu()
		{
			super("MC_Menu");
			this._model.x = EntryPoint.instance.stage.stageWidth/2 - 90;
			this._model.y = EntryPoint.instance.stage.stageHeight/2;
		}
		
		override public function enter():void
		{
			//Inicializar lo que respecta al menu
			EntryPoint.instance.stage.addChild(this._model);
			EntryPoint.instance.musicController.snd = EntryPoint.instance.assetsManager.getSound("MenuMusic");
			EntryPoint.instance.musicController.play();
			this._model.BTN_ComoJugar.addEventListener(MouseEvent.CLICK, howToPlay);
			this._model.BTN_Jugar.addEventListener(MouseEvent.CLICK, startGame);		
			this._model.BTN_Creditos.addEventListener(MouseEvent.CLICK, credits);
		}
		
		private function startGame(ev:MouseEvent):void
		{
			
			this._model.BTN_Jugar.removeEventListener(MouseEvent.CLICK, startGame)
			this.change("Level_1");
		}
		
		private function howToPlay(ev:MouseEvent):void
		{
			change("HowToPlay");
			this._model.BTN_ComoJugar.removeEventListener(MouseEvent.CLICK, howToPlay)
		}
		
		private function credits(ev:MouseEvent):void
		{
			trace("Mostrar pantalla de creditos");
			this._model.BTN_Creditos.removeEventListener(MouseEvent.CLICK, credits);
			this.change("Creditos");
		}		
		
		override public function exit():void
		{
			EntryPoint.instance.musicController.stop();
			this._model.BTN_ComoJugar.removeEventListener(MouseEvent.CLICK, howToPlay);
			this._model.BTN_Jugar.removeEventListener(MouseEvent.CLICK, startGame);		
			this._model.BTN_Creditos.removeEventListener(MouseEvent.CLICK, credits);						
			EntryPoint.instance.stage.removeChild(this._model);			
		}
	}
}