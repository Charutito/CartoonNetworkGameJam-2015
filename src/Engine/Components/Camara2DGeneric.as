package Engine.Components
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	/**
	 * Clase encargada de manejar la camara 2D.<br /> 
	 * <b>Propiedades:</b><br />
	 * <ul>
	 * 	<li><code>public spVista:Sprite</code></li>
	 * </ul>	 
	 * El constructor instancia la vista como un nuevo Sprite.<br />
	 * <p>
	 * 		<b>Utilizacion:</b><br />
	 * 		La clase que la extienda deberá implementar los metodos 'on' y 'off' que consisten en agregar al MainStage la propiedad spView.<br />
	 * 		<b style='color:green'>Ejemplo de metodos de la clase extendida</b><br />
	 * 		<pre style='margin-left:-160px;'>
	 * 			public function on():void
	 * 			{
	 * 				Main.mainStage.addChild(this.spView);
	 * 			}
	 * 			public function off():void
	 * 			{
	 * 				Main.mainStage.removeChild(this.spView);
	 * 			}
	 * 		</pre>
	 * </p>
	 * <p>
	 * 		<b>Opcional:</b><br />
	 * 		Se puede implementar el método set 'smoothZoom' para alcanzar un zoom deseado con un efecto suave.<br />
	 * 		Para lograrlo, la clase extendida debe tener una propiedad <code>public targetZoom:Number</code> y escuchar el evento ENTER_FRAME del Main Stage.<br />
	 * 		<b style='color:green'>Ejemplo de metodos de la clase extendida</b><br />
	 * 		<pre style='margin-left:-160px;'>
	 * 		public function set smoothZoom(value:Number):void
	 *		{
	 *			Main.mainStage.addEventListener(Event.ENTER_FRAME, evRefreshZoom);
	 *			targetZoom = value;
	 *		}
	 *		protected function evRefreshZoom(event:Event):void
	 *		{
	 *			var distance:Number = (targetZoom - zoom) / 100;
	 *			zoom += distance;
	 *		
	 *			if(Math.abs(distance) < 0.001)
	 *				Main.mainStage.removeEventListener(Event.ENTER_FRAME, evRefreshZoom);
	 *		}
	 * 		</pre>
	 * </p>
	 */
	public class Camara2DGeneric
	{
		public var spView:Sprite;
		
		public function Camara2DGeneric()
		{
			this.spView = new Sprite();
		}
		
		/**
		 * Agrega un MovieClip a la vista de la camara.
		 * @param mcObj El objeto MovieClip para agregar a la vista de la camara.
		 */
		public function addToView(mcObj:MovieClip):void
		{
			this.spView.addChild(mcObj);
		}
		
		/**
		 * Remueve de la vista de la camara un objeto MovieClip.
		 * @param mcObj El objeto MovieClip para remover a la vista de la camara.
		 */
		public function removeFromView(mcObj:MovieClip):void
		{
			this.spView.removeChild(mcObj);
		}
		
		/**
		 * Indica la escala en X la vista de la camara
		 */		
		public function get zoom():Number
		{
			return spView.scaleX;
		}		
		
		/**
		 * @private
		 */				
		public function set zoom(value:Number):void
		{
			if(value > 0)
				spView.scaleX = spView.scaleY = value;
			else
				throw new Error("EL ZOOM NO PUEDE SER NEGATIVO"); 
		}		
		
		/**
		 * Indica el punto X de la vista de la camara
		 */
		public function get x():Number
		{
			return -spView.x;
		}
		
		/**
		 * @private
		 */		
		public function set x(value:Number):void
		{
			spView.x = -value;
		}		
		
		/**
		 * Indica el punto Y de la vista de la camara
		 */
		public function get y():Number
		{
			return -spView.y;
		}
		
		/**
		 * @private
		 */
		public function set y(value:Number):void
		{
			spView.y = -value;
		}	
		
		/**
		 * Fija la camara hacia un objeto de tipo MovieClip.
		 * @param target El MovieClip a mirar.
		 * @param stageWidth El ancho del stage donde se encuentra el MovieClip.
		 * @param stageHeight El alto del stage donde se encuentra el MovieClip.
		 */		
		public function lookAt(target:MovieClip, stageWidth:Number, stageHeight:Number):void
		{
			var area:Rectangle = target.getRect(spView);
			x = ((area.x + area.width / 2) * zoom) - stageWidth / 2;
			y = ((area.y + area.height / 2) * zoom) - stageHeight / 2;			
		}
		
		/**
		 * Fija la camara hacia un objeto de tipo MovieClip con un efecto suave.
		 * @param target El MovieClip a mirar.
		 * @param stageWidth El ancho del stage donde se encuentra el MovieClip.
		 * @param stageHeight El alto del stage donde se encuentra el MovieClip.
		 */
		public function smoothLookAt(target:MovieClip, stageWidth:Number, stageHeight:Number):void
		{
			var area:Rectangle = target.getRect(spView);
			var distanceX:Number = ((area.x + area.width / 2) * zoom - x);
			var distanceY:Number = ((area.y + area.height / 2) * zoom - y);
			x += (distanceX - stageWidth / 2) / 100;
			y += (distanceY - stageHeight / 2) / 100;
		}
	}
}