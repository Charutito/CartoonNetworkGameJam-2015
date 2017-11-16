package Engine
{
	import Engine.Components.Camara;
	import Engine.Components.UpdateManager;
	import Engine.Resources.AssetsManager;
	import Engine.Resources.SoundManager;
	import Engine.Screens.Screen;
	import Engine.Screens.ScreenManager;
	
	import Screens.Level_1;
	
	import flash.display.Sprite;

	public class EntryPoint extends Sprite
	{
		private static var _instance:EntryPoint;
		private var _assetsManager:AssetsManager;
		private var _screenManager:ScreenManager;
		private var _updateManager:UpdateManager;
		private var _camara:Camara;
		private var _currentLevel:Screen;
		private var _fxController:SoundManager;
		private var _musicController:SoundManager;
		
		public function EntryPoint()
		{
			if(!_instance)
			{
				_instance = this;				
				this._assetsManager = new AssetsManager(new MC_Preloader(),stage.stageWidth/4,stage.stageHeight/2);
				this._screenManager = new ScreenManager();				
				this._updateManager = new UpdateManager(this.stage);
				this._camara = new Camara();
				this._fxController = new SoundManager(null);
				this._musicController = new SoundManager(null);
				
			}
			else
				throw new Error("Ya existe la instancia.");			
		}
		
		public static function get instance():EntryPoint
		{
			if(!_instance)
				_instance = new EntryPoint();
			return _instance;
		}
		
		public function get assetsManager():AssetsManager
		{
			return this._assetsManager;
		}
		
		public function get screenManager():ScreenManager
		{
			return this._screenManager;
		}
		
		public function get camara():Camara
		{
			return this._camara;
		}
				
		public function get updateManager():UpdateManager
		{
			return this._updateManager;
		}
		
		public function get fxController():SoundManager
		{
			return this._fxController;
		}
		
		public function get musicController():SoundManager
		{
			return this._musicController;
		}
	}
}