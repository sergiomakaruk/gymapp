package app.datatransferences
{
	import hx.fmwk.serialization.Json;
	
	import sm.fmwk.net.parseData.ParseData;
	import sm.fmwk.net.parseData.ParseJSON;
	import sm.utils.object.GetObject;
	
	public class AppParseJSON extends ParseJSON
	{
		public function AppParseJSON()
		{
			super();
		}
		
		override protected function parseError():void
		{
			if(this._data.error == 1) _type = ParseData.TYPE_ERROR;	
			else _type = ParseData.TYPE_SUCCESS;		
				
		}
	}
}