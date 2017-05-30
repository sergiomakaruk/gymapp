package app.sections.restricted
{
	import app.datatransferences.DataTransferenceTypes;
	import app.model.Model;
	import app.sections.AppSectionMediator;
	
	import flash.events.Event;
	
	import sm.fmwk.net.transferences.DataTransferenceData;
	
	public class RestrictedSection extends AppSectionMediator
	{
		public function RestrictedSection()
		{
			super();
		}
		
		override protected function onPageInit(e:Event=null):void{
			//trace(Model.profe.logued);
			if(Model.templates.data.length == 0){
				this.doTransference(new DataTransferenceData(DataTransferenceTypes.GET_ALL_EXERCISES),onInit);
			}else	super.onPageInit();
		}
		
		private function onInit():void
		{
			if(!Model.profe.logued){
				trace("RestrictedProfe Login error: show msg");				
			}
			else{
				super.onPageInit();
			}			
		}
	}
}