package app.datatransferences
{
	import flash.net.URLVariables;
	
	import hx.fmwk.encriptacion.Encriptar;
	import hx.fmwk.serialization.Base64;
	import hx.fmwk.serialization.Json;
	
	import sm.fmwk.Fmwk;
	import sm.fmwk.net.DataTransference;
	import sm.fmwk.net.core.ContextPath;
	import sm.fmwk.net.parseData.ParseData;
	import sm.fmwk.net.parseData.ParseJSON;
	import sm.fmwk.net.transferences.DataTransferenceData;
	
	public class TestDataTransference extends DataTransference
	{
		public function TestDataTransference()
		{
			super();
		}
		
		override protected function parseData(data:Object):ParseData
		{
			var parseJson:AppParseXML = new AppParseXML();
			parseJson.parseData(data);
			return parseJson;					
		}
		
		override public function loadData(dataTranferenceData:DataTransferenceData, hasToEncode:Boolean=false, forseToken:Boolean=false):void
		{		
			super.loadData(dataTranferenceData);
		}
		
		override protected function formatData(data:Object):Object
		{
			//trace(data);
			return data;
		}
		
		override protected function encodeVariables(variables:Object,hasToEncode:Boolean):URLVariables
		{
			var urlVariables:URLVariables = new URLVariables();		
			var json:String = Json.encode(variables);			
			
			if(hasToEncode)
			{
				urlVariables.data = Base64.encode(json);//Encriptar.encrypt(json);
			}
			else
			{				
				urlVariables.data = Base64.encode(json);
				//for(var key:String in variables)newURLVars[key]=variables[key];
			}
			return urlVariables;
		}
	}
}