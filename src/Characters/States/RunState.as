package Characters.States
{
	import com.greensock.TweenLite;
	
	import flash.display.MovieClip;
	
	import Characters.MainCharacter;
	
	import Engine.EntryPoint;
	import Engine.Input.InputHandler;
	
	import Screens.Level_1;
	
	public final class RunState implements IState
	{
		private var _mainCharacter:MainCharacter;
		private var _speed:Number;
		private var _friction:int;
		private var _loseModel:MovieClip;
		private var _statusFace:MovieClip;
		
		private static const TIME_TO_REMOVE_FACE:Number = 1500;
		private var _currentTimeToRemove:Number;
	
		public function RunState(mainCharacter:MainCharacter, speed:Number = 8)
		{
			this._mainCharacter = mainCharacter;
			this._speed = speed;			
			this._mainCharacter.model.foot.alpha = 0;
			this._friction = 1;
			this._currentTimeToRemove = TIME_TO_REMOVE_FACE;
		}
		
		public function enter():void
		{			
			this._loseModel = EntryPoint.instance.assetsManager.getMovieClip("MC_LOSE");
			this._loseModel.x = EntryPoint.instance.stage.stageWidth/2-200;
			this._loseModel.y = EntryPoint.instance.stage.stageHeight+500;
			
			//caritas
			this._statusFace = EntryPoint.instance.assetsManager.getMovieClip("MC_Caritas");
		}
		
		public function update(inputHandler:InputHandler):void
		{	
			
			if(EntryPoint.instance.stage.contains(_statusFace))
			{
				this._currentTimeToRemove -= 1000/EntryPoint.instance.stage.frameRate;
				if(this._currentTimeToRemove <= 0)
				{					
					this._currentTimeToRemove = TIME_TO_REMOVE_FACE;
					EntryPoint.instance.stage.removeChild(_statusFace);
				}
			}
			
			if(this._friction == 1)
			{
				this._mainCharacter.model.x += this._speed;			
				this._speed -= 0.0006;	
				if(this._speed <= 2.6)
					this._speed = 2.6;
			}
			
			var staminaBar:MovieClip = Level_1._containerGUI.getChildAt(0) as MovieClip;						
			staminaBar.gotoAndStop(Math.round(this._speed) - 1);			
			
			//Transiciones
			if(inputHandler.getKeyValue("Arriba") || inputHandler.getKeyValue("ArribaW") )
			{
				if( (!this._mainCharacter.model.hitbox.hitTestObject(EntryPoint.instance.screenManager.model.hitbox_UP) ||
					EntryPoint.instance.screenManager.model.parent == null)					
					&& 
					(!this._mainCharacter.model.hitbox.hitTestObject(EntryPoint.instance.screenManager.extendedModel.hitbox_UP) ||
						EntryPoint.instance.screenManager.extendedModel.parent == null))
					this._mainCharacter.model.y += -5;
			}
			
			if(inputHandler.getKeyValue("Abajo") || inputHandler.getKeyValue("AbajoS"))
			{		
				if( (!this._mainCharacter.model.hitbox.hitTestObject(EntryPoint.instance.screenManager.model.hitbox_DOWN) ||
					EntryPoint.instance.screenManager.model.parent == null)					
					&&					
					(!this._mainCharacter.model.hitbox.hitTestObject(EntryPoint.instance.screenManager.extendedModel.hitbox_DOWN) ||
					EntryPoint.instance.screenManager.extendedModel.parent == null))
					this._mainCharacter.model.y += 5;				
			}		
			
			checkCollision();
			
			if(this._mainCharacter.model.currentLabel != "Correr")
				this._mainCharacter.model.gotoAndPlay("Correr");
		}
		
		public function checkCollision():void
		{				
			for (var i:int = Level_1._containerPlayer.numChildren - 1; i >= 0; i--) 
			{
				var temp:MovieClip = Level_1._containerPlayer.getChildAt(i) as MovieClip;
				
				if(temp.name.indexOf("Item") != -1 && this._mainCharacter.model.hitbox.hitTestObject(temp.hitbox))
					onCollisionItem(temp.name, i);
				
				if((temp.name == "Pozo" || temp.name == "Percy") && (temp.x - this._mainCharacter.model.x) < -256)
					Level_1._containerPlayer.removeChildAt(i);
				
				if((temp.name.indexOf("Item") && (temp.x - this._mainCharacter.model.x) < -256))
					Level_1._containerPlayer.removeChildAt(i);
				
				if(temp.name == "Pozo" && this._mainCharacter.model.foot.hitTestObject(temp.hitbox))
				{
						//Level_1._containerPlayer.removeChild(this._mainCharacter.model);
						this._mainCharacter.model.alpha = 0;
						this._speed = 0;
						
						if(!EntryPoint.instance.stage.contains( this._loseModel ) )
						{
							EntryPoint.instance.stage.addChild(this._loseModel );
							tweenLose();							
						}
						EntryPoint.instance.updateManager.die();
				}
				
				if(temp.name == "Percy") 
				{					
					if(this._mainCharacter.model.hitbox.hitTestObject(temp.hitbox))
						this._friction = 0;
					else
						this._friction = 1;		
				}
				
				if(temp.name == "Belson" && this._mainCharacter.model.hitbox.hitTestObject(temp))
				{
					EntryPoint.instance.updateManager.die();
					this._mainCharacter.model.gotoAndPlay("Win");
					this._loseModel = EntryPoint.instance.assetsManager.getMovieClip("MC_Ganaste");
					if(!EntryPoint.instance.stage.contains( this._loseModel ) )
					{
						EntryPoint.instance.stage.addChild(this._loseModel );
						tweenLose();												
					}					
				}
			}
		}			
				
		public function tweenLose():void
		{
			TweenLite.to(this._loseModel, 0.5, {x:EntryPoint.instance.stage.stageWidth/2, y:EntryPoint.instance.stage.stageHeight/2, motionBlur:true});
		}
		
		public function tweenFaces():void
		{
			TweenLite.to(this._statusFace, 0.5, {x:800, y:600, motionBlur:true});
		}
		
		public function onCollisionItem(name:String, index:Number):void
		{
			
			switch(name)
			{
				case "Item Candy":					
					this._mainCharacter.addCandy();
					this._speed += 0.43;
					Level_1._containerPlayer.removeChildAt(index);
					EntryPoint.instance.fxController.snd = EntryPoint.instance.assetsManager.getSound("CandySound");
					EntryPoint.instance.fxController.snd.play();
					if(randomNumber() < 0.4)
					{
						EntryPoint.instance.stage.addChild(this._statusFace);
						this._statusFace.gotoAndStop("golozo");
						this._statusFace.x = 1500; 
						tweenFaces();
					}
					break;
				
				case "Item Food":
					this._speed += 1.22;
					if(this._speed >= 10.7)
						this._speed = 10.7;
					Level_1._containerPlayer.removeChildAt(index);
					EntryPoint.instance.fxController.snd = EntryPoint.instance.assetsManager.getSound("FoodSound");
					EntryPoint.instance.fxController.snd.play(400);
					if(randomNumber() < 0.4)
					{
						EntryPoint.instance.stage.addChild(this._statusFace);
						this._statusFace.gotoAndStop("duro");
						this._statusFace.x = 1500; 
						tweenFaces();
					}
					break;
				
				case "Item Damage":
					this._speed -= 0.78;
					if(this._speed <= 2.6)
						this._speed = 2.6;
					Level_1._containerPlayer.removeChildAt(index);
					EntryPoint.instance.fxController.snd = EntryPoint.instance.assetsManager.getSound("SlowSound");
					EntryPoint.instance.fxController.snd.play();
					if(randomNumber() < 0.4)
					{
						EntryPoint.instance.stage.addChild(this._statusFace);
						this._statusFace.gotoAndStop("lastimado");
						this._statusFace.x = 1500; 
						tweenFaces();
					}
					break;
			}
		}
		
		public function randomNumber():Number
		{
			return Math.random();
		}
				
		public function exit():void
		{
			//No hago nada
		}
	}
}