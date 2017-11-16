package Screens
{
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import Characters.Belson;
	import Characters.MainCharacter;
	
	import Controllers.UserController;
	
	import Engine.EntryPoint;
	import Engine.Screens.Screen;
	
	public final class Level_1 extends Screen
	{		
		private var _belson:Belson;
		private var _player:UserController;				
		private var _needToLoad:Boolean;
		private var _loadTimes:int;	
		private var _loseModel:MovieClip;
		
		public static var _containerLevel:Sprite = new Sprite();
		public static var _containerPlayer:Sprite = new Sprite();		
		public static var _containerGUI:Sprite = new Sprite();
		
		private var playerRef:MovieClip;
		private var belsonRef:MovieClip;
		
		public function Level_1()
		{
			super("MC_Level1");
			this._model.x = -200;
			this._model.y = this._extendedModel.y = -8;
			this._model.name = "Level";
			this._model.hitbox_UP.alpha = this._model.hitbox_DOWN.alpha = this._model.startlevel.alpha = this._model.endlevel.alpha = this._extendedModel.hitbox_UP.alpha = this._extendedModel.hitbox_DOWN.alpha = this._extendedModel.startlevel.alpha = this._extendedModel.endlevel.alpha = 0;
			
			this._needToLoad = true;
			this._loadTimes = 1;
						
			this._belson = new Belson();
			this._player = new UserController(new MainCharacter());			
		}
		
		override public function enter():void
		{
			//Inicializar lo que respecta al nivel 1
			_containerLevel.addChild(this._model);			
			this._player.init();
			this._belson.init();
								
			EntryPoint.instance.camara.on();			
			EntryPoint.instance.camara.addContainerToView(_containerLevel); //Player
			EntryPoint.instance.camara.addContainerToView(_containerPlayer); //Player
						
			var stamina:MovieClip = EntryPoint.instance.assetsManager.getMovieClip("MC_Estamina");
			stamina.scaleX = stamina.scaleY = 0.7;  
			stamina.gotoAndStop(1);
			stamina.x = EntryPoint.instance.camara.x + 640;
			stamina.y = EntryPoint.instance.camara.y - 365;			
			_containerGUI.addChild(stamina);
			
			var candyCounter:MovieClip = EntryPoint.instance.assetsManager.getMovieClip("MC_CandyCounter");
			candyCounter.scaleX = candyCounter.scaleY = 0.3;
			candyCounter.gotoAndStop(1);
			candyCounter.x = EntryPoint.instance.camara.x + 24;
			candyCounter.y = EntryPoint.instance.camara.y - 304;
			candyCounter.CandyCounter.text = "0";
			_containerGUI.addChild(candyCounter);
			
			playerRef = EntryPoint.instance.assetsManager.getMovieClip("MC_ClarenceBarra");
			playerRef.x = EntryPoint.instance.camara.x + 324;
			playerRef.y = EntryPoint.instance.camara.y - 304;
			
			belsonRef = EntryPoint.instance.assetsManager.getMovieClip("MC_BelsonBarra");
			belsonRef.x = EntryPoint.instance.camara.x + 554;
			belsonRef.y = EntryPoint.instance.camara.y - 304;
			
			playerRef.scaleX = playerRef.scaleY = 0.3; 
			belsonRef.scaleX = belsonRef.scaleY = 0.4;  
			
			_containerGUI.addChild(playerRef);
			_containerGUI.addChild(belsonRef);
			
			EntryPoint.instance.camara.addContainerToView(_containerGUI);			
			
			EntryPoint.instance.updateManager.add(update);
			EntryPoint.instance.updateManager.init();	
			
			EntryPoint.instance.stage.focus = _containerLevel;
			
			this._loseModel = EntryPoint.instance.assetsManager.getMovieClip("MC_LOSE");
			this._loseModel.x = EntryPoint.instance.stage.stageWidth/2;
			this._loseModel.y = EntryPoint.instance.stage.stageHeight/2-600;
			
			EntryPoint.instance.musicController.snd = EntryPoint.instance.assetsManager.getSound("LevelMusic");			
			EntryPoint.instance.musicController.play();
		}
		
		private function update():void
		{			
			EntryPoint.instance.camara.lookAt(this._player.mainCharacter.model.hitbox, EntryPoint.instance.stage.stageWidth, EntryPoint.instance.stage.stageHeight);			
			_containerGUI.x = this._player.mainCharacter.model.x;
			
			
			if(this._needToLoad && this._player.mainCharacter.model.hitbox.hitTestObject(this._model.endlevel))
				loadExtendedLevel(1);
			if(this._needToLoad && this._player.mainCharacter.model.hitbox.hitTestObject(this._extendedModel.endlevel))
				loadExtendedLevel(2);
			
			if(!this._needToLoad && this._player.mainCharacter.model.hitbox.hitTestObject(this._model.startlevel))
			{
				_containerLevel.removeChild(this._extendedModel);
				this._needToLoad = true;
			}
							
			if(!this._needToLoad && this._player.mainCharacter.model.hitbox.hitTestObject(this._extendedModel.startlevel))
			{
				_containerLevel.removeChild(this._model);
				this._needToLoad = true;
			}
			
			var candyCounter:MovieClip = _containerGUI.getChildAt(1) as MovieClip;
			candyCounter.CandyCounter.text = this._player.mainCharacter.totalCandy;	
			
			drawDistances();
			
		}
		
		private function drawDistances():void
		{
			this.playerRef.x = this.belsonRef.x - (this._belson.model.x - this._player.mainCharacter.model.x)/10;
			if((this._belson.model.x - this._player.mainCharacter.model.x) >= 4000)
			{
				this._player.mainCharacter.model.alpha = 0;				
				
				if(!EntryPoint.instance.stage.contains( this._loseModel ) )
				{
					EntryPoint.instance.stage.addChild(this._loseModel );
					tweenLose();
				}
				EntryPoint.instance.updateManager.die();
			}		
		}
		
		public function tweenLose():void
		{
			TweenLite.to(this._loseModel, 0.5, {x:EntryPoint.instance.stage.stageWidth/2, y:EntryPoint.instance.stage.stageHeight/2, motionBlur:true});
		}
			
		private function loadExtendedLevel(param:int):void
		{			
			this._needToLoad = false;
			switch(param)
			{
				case 1: 
						this._extendedModel.x = (this._model.width - 207) * this._loadTimes;
						_containerLevel.addChildAt(this._extendedModel,0);
						break;
				case 2:
						this._model.x = (this._extendedModel.width - 207) * this._loadTimes;
						_containerLevel.addChildAt(this._model,0);
						break;
			}
			this._loadTimes++;
		}			
		
		private function randomRange(minNum:Number, maxNum:Number):Number 
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
			}
}