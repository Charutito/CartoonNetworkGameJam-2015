package Controllers
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import Characters.MainCharacter;
	
	import Engine.EntryPoint;
	import Engine.Components.IUpdateable;
	import Engine.Input.InputHandler;

	public final class UserController implements IUpdateable
	{
		private var _inputHandler:InputHandler;
		private var _mainCharacter:MainCharacter;		
		
		public function UserController(mainCharacter:MainCharacter)
		{
			this._inputHandler = new InputHandler();
			this._inputHandler.addRelationKey(Keyboard.W, "ArribaW");
			this._inputHandler.addRelationKey(Keyboard.S, "AbajoS");	
			this._inputHandler.addRelationKey(Keyboard.UP, "Arriba");
			this._inputHandler.addRelationKey(Keyboard.DOWN, "Abajo");
			this._mainCharacter = mainCharacter;			
							
			EntryPoint.instance.stage.addEventListener(KeyboardEvent.KEY_DOWN, this._inputHandler.evKeyDown);
			EntryPoint.instance.stage.addEventListener(KeyboardEvent.KEY_UP, this._inputHandler.evKeyUp);
			//Suscribir el update del userController al updateManager						
		}
		
		public function get mainCharacter():MainCharacter
		{
			return this._mainCharacter;
		}
		
		//IUpdateable
		public function init():void
		{
			this._mainCharacter.spawn(EntryPoint.instance.stage.stageWidth/2, EntryPoint.instance.stage.stageHeight/2-256);	
			EntryPoint.instance.updateManager.add(update);
		}
		
		/**
		 * Ejecuta el update del currentState
		 */
		public function update(ev:Event = null):void
		{					
			//Correr el update del currentState. Las transiciones las define el inputHandler 
			this._mainCharacter.fsm.update(this._inputHandler);						
		}
		
		public function die():void
		{
			trace("UserController die");
		}
	}
}