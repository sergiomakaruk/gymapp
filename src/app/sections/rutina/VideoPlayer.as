package app.sections.rutina
{
	import app.data.ejercicios.DataEjercicio;
	
	import com.apdevblog.events.video.VideoControlsEvent;
	import com.apdevblog.ui.video.ApdevVideoPlayer;
	import com.apdevblog.ui.video.ApdevVideoState;
	import com.greensock.TweenMax;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import sm.fmwk.Fmwk;
	import sm.fmwk.ui.button.Button;
	import sm.utils.animation.Timeline;
	import sm.utils.display.GetButton;
	import sm.utils.display.GetDrawedObjects;
	
	public class VideoPlayer extends Sprite
	{

		private var video:ApdevVideoPlayer;
		private var back:Shape;

		private var cerrarBtn:Button;

		private var timeline:Timeline;
		private var margen:uint = 5;

		private var white:Shape;

		private var fondo:Sprite;
		private var data:DataEjercicio;

		private var _cerrar:_cerrarBtn;
		
		public function VideoPlayer()
		{
			super();
		}
		
		public function init():void{
			
			fondo = new Sprite();
			
			back = GetDrawedObjects.getShape(1000,1000,0,0.8);
			fondo.addChild(back);
			
			white = GetDrawedObjects.getShape(640 + margen*2,480+margen*2,0xFFFFFF,1);
			fondo.addChild(white);
			addChild(fondo);
			// create videoplayer
			video = new ApdevVideoPlayer(640, 480);
			
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			addChild(video);
			
			_cerrar = new _cerrarBtn();
			addChild(_cerrar);
			//_cerrar.addEventListener(MouseEvent.MOUSE_DOWN,onCerrar);
			/*cerrarBtn = GetButton.pressButton(_cerrar,onCerrar);
			cerrarBtn.autoDestroy = false;
			cerrarBtn.delayTime = 2000;*/
			
			// add eventlistener
			video.addEventListener(VideoControlsEvent.STATE_UPDATE, onStateUpdate, false, 0, true);
			
			// position the videoplayer's controls at the bottom of the video
			video.controlsOverVideo = false;
			// controls should not fade out (when not in fullscreen mode)
			video.controlsAutoHide = true;
			
			// load preview image
			//video.videostill = "videostill.jpg";
			// set video's autoplay to false
			video.autoPlay = true;		
			video.volume = 0;
		}
		
		private function onCerrar(e:Event):void
		{//trace("CERRAR VIDEO");
			video.pause();
			timeline.reverse();
		}
		
		protected function onAdded(event:Event):void
		{
			back.width = stage.stageWidth;
			back.height = stage.stageHeight;			
			
			// position videoplayer on stage
			video.x = (stage.stageWidth -video.width ) *.5;
			video.y = (stage.stageHeight-video.height ) *.5;
			
			white.x = video.x - margen;
			white.y = video.y - margen;
			
			_cerrar.x = video.x + video.width;
			_cerrar.y = video.y;
			// add videoplayer to stage			
		}
		
		public function show(data:DataEjercicio):void{
			this.data = data;
			// load video
			if(!timeline){
				timeline = new Timeline(onTimelineComplete,onReverseComplete);
				timeline.from(fondo,{alpha:0});
				timeline.from(video,{alpha:0});
				timeline.from(_cerrar,{scaleX:0,scaleY:0});	
			}
			timeline.play();	
			_cerrar.addEventListener(MouseEvent.MOUSE_DOWN,onCerrar);
		}
		
		private function onReverseComplete():void
		{
			this.parent.removeChild(this);	
			video.clear();
			_cerrar.removeEventListener(MouseEvent.MOUSE_DOWN,onCerrar);
		}
		
		private function onTimelineComplete():void
		{
			video.load(Fmwk.appConfig('kiosko')+'videos/'+data.sid+'.f4v');
			video.videoState = ApdevVideoState.VIDEO_STATE_PLAYING;
			//cerrarBtn.active = true;
			//cerrarBtn.unlock();
		}
		
		private function onStateUpdate(event:VideoControlsEvent):void
		{
			trace("onStateUpdate() >>> " + event.data);
		}
	}
}