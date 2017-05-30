package app.datatransferences
{
	import app.model.Model;
	
	import sm.fmwk.net.transferences.DataTransferenceData;
	
	public class AppTokenDataTransferenceData extends DataTransferenceData
	{
		public function AppTokenDataTransferenceData(type:String, args:Object=null,appendToken:Boolean=false)
		{			
			super(type, args);
			if(!appendToken)this.args.push(Model.profe.token);
			else this.args.unshift(Model.profe.token);		
		}
	}
}