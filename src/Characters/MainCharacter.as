package Characters
{	
	import flash.display.MovieClip;
	
	import Characters.States.RunState;
	import Characters.States.StateMachine;
	
	import Engine.EntryPoint;
	
	import Screens.Level_1;
	
	public class MainCharacter
	{		
		private var _model:MovieClip;				
		private var _fsm:StateMachine;
		private var _scaleValue:Number = 0.5;
		public var totalCandy:Number = 0;
		public function MainCharacter()
		{
			this._model = EntryPoint.instance.assetsManager.getMovieClip("MC_Clarence");					
			this._fsm = new StateMachine();
			this._model.hitbox.alpha = 0;
			this._model.scaleX = this._model.scaleY = this._scaleValue;
		}
				
		/*GETTERS*/
		
		public function get model():MovieClip
		{
			return this._model;
		}
		
		public function get fsm():StateMachine
		{
			return this._fsm;
		}

		/*METODOS PUBLICOS*/		
		public function spawn(posX:int, posY:int):void
		{					
			Level_1._containerPlayer.addChild(this._model);
			this._fsm.changeState(new RunState(this));			
		}
		
		public function addCandy():void
		{
			totalCandy++;
		}
		
		public function addStamina(value:Number):void
		{
			//Agrega Stamina
		}
	
		public function changeAnimation(label:String):void
		{
			/*if(this._model.currentLabel != label)
				this._model.gotoAndPlay(label);*/
		}		
	}
}