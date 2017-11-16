package Engine.Components
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	
	import Engine.EntryPoint;
	
	public class Camara extends Camara2DGeneric
	{
		public function Camara()
		{
			super();
		}
		
		public function on():void
		{
			EntryPoint.instance.stage.addChild(this.spView);
		}
		
		public function off():void
		{
			EntryPoint.instance.stage.removeChild(this.spView);
			trace("LALALAL");
		}		
		
		public function addContainerToView(container:Sprite):void
		{
			this.spView.addChild(container);
		}
		
		public function removeContainerFromView(container:Sprite):void
		{
			this.spView.removeChild(container);
		}
		
		/**
		 * Fija la camara hacia un objeto de tipo MovieClip.
		 * @param target El MovieClip a mirar.
		 * @param stage El stage donde se encuentra el MovieClip.
		 */		
		override public function lookAt(target:MovieClip, stageWidth:Number, stageHeight:Number):void
		{
			var area:Rectangle = target.getRect(spView);
			x = ((area.x + area.width / 2) * zoom) - stageWidth / 8;
			y = (area.height/2 * zoom) - stageHeight/2 - 52;			
		}
		
		/**
		 * Fija la camara hacia un objeto de tipo MovieClip con un efecto suave
		 * @param target El MovieClip a mirar
		 * @param stage El stage donde se encuentra el MovieClip
		 */
		override public function smoothLookAt(target:MovieClip, stageWidth:Number, stageHeight:Number):void
		{
			var area:Rectangle = target.getRect(spView);
			var distanceX:Number = ((area.x + area.width / 2) * zoom - x);
			var distanceY:Number = ((area.height / 2) * zoom - y);
			x += (distanceX - stageWidth / 2) / 100;			
			y += (distanceY - stageHeight / 2) / 100;
		}		
		
	}
}