package app.datatransferences
{
	import alducente.services.WebService;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.TimerEvent;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	import hx.fmwk.encriptacion.Encriptar;
	import hx.fmwk.serialization.Base64;
	import hx.fmwk.serialization.Json;
	
	import sm.fmwk.Fmwk;
	import sm.fmwk.net.DataTransference;
	import sm.fmwk.net.core.ContextPath;
	import sm.fmwk.net.parseData.ParseData;
	import sm.fmwk.net.parseData.ParseJSON;
	import sm.fmwk.net.transferences.DataTransferenceData;
	import sm.utils.loader.LoaderData;
	
	public class AppDataTransference extends DataTransference
	{

		private var ws:WebService;
		private var initTime:Number;

		private var timer:Timer;
		
		public function AppDataTransference()
		{	
			
			super();
			
			this.currentURLRequestMethod = URLRequestMethod.GET;
		}
		
		override public function loadData(dataTranferenceData:DataTransferenceData,hasToEncode:Boolean=false,forseToken:Boolean=false):void
		{		
			this.dtd = dataTranferenceData;
			if(dtd.forceNotHasToEncode){
				if(dtd.type != DataTransferenceTypes.FUERZO_ENVIO_EMAIL && dtd.type != DataTransferenceTypes.ENVIAR_EMAIL_USUARIO ){					
					new LoaderData(onLoadData,Fmwk.appConfig('kiosko') + dtd.service.split("|")[0] + dtd.extension);
				}
				else {
					this.currentURLRequestMethod = URLRequestMethod.POST;					
					super.loadData(dataTranferenceData);
				}
			}else{
				this.currentURLRequestMethod = URLRequestMethod.GET;
				ws = new WebService();
				ws.addEventListener(Event.CONNECT, connected);
				ws.addEventListener(IOErrorEvent.IO_ERROR, onError);
				ws.connect(Fmwk.appConfig('url'));
				ws.cacheResults = false;	
				
				/*timer = new Timer(10000,0);
				timer.addEventListener(TimerEvent.TIMER,onTimer);
				timer.start();*/
			}
								
		}	
		
		protected function onError(event:Event):void
		{
			trace("E",event);
			this._hasError = true;		
			sendComplete();
			
		}
		
		override protected function encodeVariables(variables:Object,hasToEncode:Boolean):URLVariables
		{
			var urlVariables:URLVariables = new URLVariables();		
			var json:String = Base64.encode(Json.encode(variables));			
			
			if(hasToEncode)
			{
				urlVariables.data = Encriptar.encrypt(json);
			}
			else
			{				
				urlVariables.data = json;
				//for(var key:String in variables)newURLVars[key]=variables[key];
			}
			return urlVariables;
		}
		
		protected function onTimer(event:TimerEvent):void
		{
			timer.removeEventListener(TimerEvent.TIMER,onTimer);
			loadData(this.dtd);
		}
		
		private function onLoadData(data:Object):void
		{
			var paseDataClass:ParseData = parseData(data);			
			this.checkError(paseDataClass);
			
		}
		
		protected function connected(evt:Event):void{
			initTime = getTimer();
			//ws.ResolveIP(done, "192.123.0.200", 0);
			//ws.ResolveIP(done2, "192.123.0.200", 0);
			var dataTypeSplit:Array = dtd.service.split("|");
			trace('dataTypeSplit[1]',dataTypeSplit[1]);
			ws[dataTypeSplit[1]](done,dtd.args);
		}
		
		protected function done(serviceRespone:XML):void{
			if(timer)timer.removeEventListener(TimerEvent.TIMER,onTimer);
			trace("\nWeb Service Result: ");
			var time:Number = getTimer();
			trace("Call duration: "+(time - initTime)+" milliseconds");
			initTime = time;
			trace(serviceRespone);
			
			var paseDataClass:ParseData = parseData(serviceRespone);			
			this.checkError(paseDataClass);
		}	
		
		override protected function parseData(data:Object):ParseData
		{	
			
			if(dtd.extension == ".php")
			{
				var parseJson:AppParseJSON = new AppParseJSON();
				parseJson.parseData(data);
				return parseJson;	
			}
			else if(dtd.extension == ".csv")
			{				
				var parseCsv:AppParseCSV = new AppParseCSV();
				parseCsv.parseData(data);
				return parseCsv;	
			}
			else if(dtd.extension == ".txt" && dtd.type == DataTransferenceTypes.GET_ALL_USERS)
			{				
				var parseCsv2:AppParseCSV = new AppParseCSV();
				parseCsv2.parseData(data);
				return parseCsv2;	
			}
			
			var parseXml:AppParseXML = new AppParseXML();
			parseXml.parseData(data);
			return parseXml;							
		}

	}
}