package app.sections.promos
{
	import app.AppSectionTypes;
	import app.model.Model;
	import app.sections.AppSection;
	import app.sections.AppSectionMediator;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.filesystem.File;
	import flash.utils.Timer;
	
	import sm.fmwk.Fmwk;
	import sm.utils.display.GetImage;
	
	public class PromosMediator extends AppSectionMediator
	{

		private var count:uint;

		private var files:Array;

		private var timerreload:Timer;
		public function PromosMediator()
		{
			super();
		}
		
		override protected function onPageInit(e:Event=null):void{
			if(Model.promos.length == 0){
				var dir:File = File.applicationDirectory.resolvePath(Fmwk.appConfig('kiosko')+'promos');
				files = dir.getDirectoryListing();
				var images:Array = [];
				for each(var file:File in files){
					if(file.extension.toLowerCase() == 'jpg' || file.extension.toLowerCase() == 'png' || file.extension.toLowerCase() == 'gif'){
						Model.promos.push(GetImage.getImage(file.nativePath,onComplete));
					}				
				}
			}
			else super.onPageInit();	
			
			content.addEventListener(MouseEvent.MOUSE_DOWN,doChange);
			
			timerreload = new Timer(1000 * 60 * 30);
			timerreload.addEventListener(TimerEvent.TIMER,onReload);
			timerreload.start();
		}
		
		protected function onReload(event:TimerEvent):void
		{
			content.reload();			
		}
		
		protected function doChange(event:MouseEvent):void
		{
			content.removeEventListener(MouseEvent.MOUSE_DOWN,doChange);
			timerreload.stop();
			this.changeSection(AppSectionTypes.LOGIN_USUARIO);
		}
		
		private function onComplete():void{
			count++;
			if(count == files.length){
				for each(var image:DisplayObject in Model.promos){
					GetImage.cover(image,content.stage.stageWidth,content.stage.stageHeight);
				}
				super.onPageInit();	
			}
		}
		
		private function get content():PromosSection{
			return PromosSection(this.page);
		}
	}
}