package app.sections.loginProfe
{
	import app.AppSectionTypes;
	import app.datatransferences.AppDataTransference;
	import app.datatransferences.DataTransferenceTypes;
	import app.model.Model;
	import app.sections.AppSectionMediator;
	
	import flash.events.Event;
	
	import sm.fmwk.net.transferences.AssetTransferenceData;
	import sm.fmwk.net.transferences.DataTransferenceData;
	import sm.fmwk.net.transferences.SequenceTransferenceData;
	import sm.utils.loader.LoaderData;
	
	public class LoginProfeMediator extends AppSectionMediator
	{
		public function LoginProfeMediator()
		{
			super();
		}
		
		override protected function onPageInit(e:Event=null):void{
			super.onPageInit();
			Model.clean();
		}
		
		override protected function onPageChanged(e:Event):void{
			this.changeSection(AppSectionTypes.LOGIN_USUARIO);
		}
		
		override protected function onPageCompleted(e:Event=null):void{
			this.doTransference(new DataTransferenceData(DataTransferenceTypes.VALIDAR_PROFE,content.login),onInit);
		}
		
		private function onInit():void
		{
			if(!Model.profe.logued){
				trace("Login error: show msg");
				content.showError();
			}
			else{
				this.changeSection(AppSectionTypes.PERFIL_PROFE);
			}			
		}
		
		private function get content():LoginProfe{
			return LoginProfe(this.page);
		}	

		
	}
}