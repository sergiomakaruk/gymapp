package app.datatransferences
{
	import hx.fmwk.serialization.Json;
	
	import sm.fmwk.net.parseData.ParseData;
	import sm.fmwk.net.parseData.ParseJSON;
	import sm.utils.object.GetObject;
	
	public class AppParseCSV extends ParseJSON
	{
		public function AppParseCSV()
		{
			super();
		}
		
		override public function parseData(dataJson:Object):void{
			parseError();
			_data = String(dataJson).split("\r\n");
			_data = _data.slice(1,_data.length);
			//_data = String(dataJson);
		}
		
		override protected function parseError():void
		{
			_type = ParseData.TYPE_SUCCESS;		
				
		}
	}
}