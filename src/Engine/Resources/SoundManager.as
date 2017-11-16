package Engine.Resources
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	import flash.media.SoundTransform;
	
	public class SoundManager
	{
		public var snd:Sound;
		public var settings:SoundTransform;
		public var channel:SoundChannel;
		public var currentTime:int;
		
		public function SoundManager(snd:Sound)
		{
			this.snd = snd;			
			settings = new SoundTransform(1, 0);
		}
		
		public function play(startTime:Number=0,loops:int=1):void
		{			
			channel = snd.play(startTime,loops,settings);
			channel.addEventListener(Event.SOUND_COMPLETE, evSoundComplete,false,0,true);
		}
		
		protected function evSoundComplete(event:Event):void
		{		
			channel.removeEventListener(Event.SOUND_COMPLETE, evSoundComplete);
		}
		
		public function stop():void
		{
			channel.stop();
		}
		
		public function pause():void
		{
			currentTime = channel.position;
			channel.stop();
		}
		
		public function resume():void
		{
			channel = snd.play(currentTime, 0, settings);
		}
		
		public function setVolume(value:Number):void
		{
			if(channel != null)
			{
				settings.volume = value;
				channel.soundTransform = settings;
			}
		}
		
		public function setPan(value:Number):void
		{
			if(channel != null)
			{
				settings.pan = value;
				channel.soundTransform = settings;
			}
		}
	}
}