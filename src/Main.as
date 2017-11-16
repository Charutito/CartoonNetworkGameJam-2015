package
{
	import flash.display.StageDisplayState;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	
	
	
	import Engine.EntryPoint;
	
	import Screens.Creditos;
	import Screens.HowToPlay;
	import Screens.Level_1;
	import Screens.MainMenu;
	
	[SWF(width="1024",height="768",frameRate="60")]
	public class Main extends EntryPoint
	{
		public function Main()
		{
			EntryPoint.instance.assetsManager.tooglePreloader();
			EntryPoint.instance.assetsManager.loadLinks("AllAssets.txt");
			EntryPoint.instance.assetsManager.addEventListener(Event.COMPLETE, loadLinksComplete);	
			
			EntryPoint.instance.stage.displayState = StageDisplayState.FULL_SCREEN_INTERACTIVE;
			EntryPoint.instance.stage.scaleMode = StageScaleMode.SHOW_ALL;
			
		}
		
		private function loadLinksComplete(event:Event):void
		{
			//Recursos listos
			EntryPoint.instance.assetsManager.tooglePreloader();
			EntryPoint.instance.assetsManager.removeEventListener(Event.COMPLETE, loadLinksComplete);
			//Registro pantallas
			EntryPoint.instance.screenManager.registerScreen("MainMenu",Screens.MainMenu);
			EntryPoint.instance.screenManager.registerScreen("Creditos",Screens.Creditos);
			EntryPoint.instance.screenManager.registerScreen("HowToPlay",Screens.HowToPlay);
			EntryPoint.instance.screenManager.registerScreen("Level_1",Screens.Level_1);
			//Cargo Nivel
			EntryPoint.instance.screenManager.loadScreen("MainMenu");
		}

	}
}