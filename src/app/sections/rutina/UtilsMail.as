package app.sections.rutina
{
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.net.URLRequestMethod;
	import flash.net.URLVariables;
	
	public class UtilsMail
	{
		public function UtilsMail()
		{
		}
		
		public static function sendRutinaUpdate(email:String,dni:String):void{
			var url:String = "http://americansport.com.ar/phpMailer/sendMailRutinas.php";
			var request:URLRequest = new URLRequest(url);
			var requestVars:URLVariables = new URLVariables();
			requestVars.email = email;
			requestVars.dni = dni;
			request.data = requestVars;
			request.method = URLRequestMethod.POST;
			
			
			var urlLoader:URLLoader = new URLLoader();
			urlLoader = new URLLoader();
			urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
			urlLoader.addEventListener(Event.COMPLETE, emailEnviado, false, 0, true);
			//urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, httpStatusHandler, false, 0, true);
			//urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler, false, 0, true);
			//urlLoader.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler, false, 0, true);
			/*for (var prop:String in requestVars) {
			//trace("Sent: " + prop + " is: " + requestVars[prop]);
			}*/
			try {
				urlLoader.load(request);
			} catch (e:Error) {
				trace(e);
			}
		}
		
		public static function emailEnviado(ev:Event):void{
			trace(ev.target.data);
		}
	}
}