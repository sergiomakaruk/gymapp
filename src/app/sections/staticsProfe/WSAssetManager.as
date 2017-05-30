package app.sections.staticsProfe
{
	import alducente.services.WebService;
	
	import app.model.Model;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import sm.fmwk.Fmwk;
	import sm.fmwk.data.core.AssetManager;

	public class WSAssetManager
	{
		private var assets:Array;
		private var ws:WebService;

		private var index:uint;
		private var conected:Boolean;
		private var timer:Timer;
		private var loading:Boolean;
		
		public function WSAssetManager()
		{
			assets = [];
			ws = new WebService();
			ws.addEventListener(Event.CONNECT, connected);
			ws.connect(Fmwk.appConfig('url'));
			ws.cacheResults = false;
		}
		
		public function add(data:Object):void{
			//trace("D", data);
			var isLoaded:Boolean;
			for each(var asset:Object in assets)
			{
				if(asset.sid== data.sid)isLoaded = true;				
			}
			
			if(!isLoaded) assets.push(data);			
			start();
		}
		
		public function start():void{
			if(conected){
				if(index<assets.length)load();
			}
			else if(!timer){
				timer = new Timer(1000);
				timer.addEventListener(TimerEvent.TIMER,onTimer);
				timer.start();
			}
		}
		
		protected function onTimer(event:TimerEvent):void
		{
			if(conected){
				timer.removeEventListener(TimerEvent.TIMER,onTimer);
				timer = null;
			}
			
		}
		
		private function load():void{
			trace('load');
			if(!loading){
				loading = true;
				ws['FotoSocio'](done,[assets[index].dni,assets[index].sid,0,Model.profe.token]);
			}
		}
		
		protected function connected(evt:Event=null):void{
			//initTime = getTimer();
			//ws.ResolveIP(done, "192.123.0.200", 0);
			//ws.ResolveIP(done2, "192.123.0.200", 0);
			//var dataTypeSplit:Array = DataTransferenceTypes.GET_USER_PHOTO.split("|");
			//trace('dataTypeSplit[1]',dataTypeSplit[1]);
			conected = true;
		}
		
		protected function done(serviceRespone:XML):void{
			assets[index].parsePhoto(serviceRespone);
			index++;
			loading = false;
			trace(assets.length,index);
			trace("SS",serviceRespone..*::foto);
			if(index<assets.length)load();
			
		}
		
		
	}
}