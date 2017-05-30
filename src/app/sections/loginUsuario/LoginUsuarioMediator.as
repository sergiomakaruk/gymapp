package app.sections.loginUsuario
{
	import app.AppSectionTypes;
	import app.datatransferences.AppDataTransference;
	import app.datatransferences.DataTransferenceTypes;
	import app.events.AppEvents;
	import app.model.Model;
	import app.sections.AppSectionMediator;
	import app.sections.rutina.msg.SinRutinaMsg;
	
	import flash.events.Event;
	
	import sm.fmwk.net.transferences.AssetTransferenceData;
	import sm.fmwk.net.transferences.DataTransferenceData;
	import sm.fmwk.net.transferences.SequenceTransferenceData;
	import sm.utils.events.CustomEvent;
	import sm.utils.loader.LoaderData;
	
	public class LoginUsuarioMediator extends AppSectionMediator
	{
		public function LoginUsuarioMediator()
		{
			super();
		}
		
		override protected function onPageInit(e:Event=null):void{
			super.onPageInit();
			Model.clean();
		}
		
		override protected function onPageChanged(e:Event):void{
			this.changeSection(AppSectionTypes.LOGIN_PROFE);
		}
		
		override protected function onPageCompleted(e:Event=null):void{
			//token hardcode porque no hay servicio para login usuario
			//this.doTransference(new DataTransferenceData(DataTransferenceTypes.BUSCA_SOCIO,[content.login,'368934881474680855']),onInit);
			this.dispatch(new CustomEvent(AppEvents.GET_USER,{dni:content.login,cb:onLogin}));
		}
		
		
		private function onLogin():void{
			if(!Model.socio.exists){
				trace("Login error: show msg");
				content.showError();
			}
			else if(!Model.socio.rutinas.lastRutina){
				var msg:SinRutinaMsg = new SinRutinaMsg();
				content.addChild(msg);
				msg.initMsg();
				content.relogin();
			}
			else{
				//trace("USER LOGUED");
				this.changeSection(AppSectionTypes.PERFIL_USUARIO);
			}
			
		}
		
		private function get content():LoginUsuario{
			return LoginUsuario(this.page);
		}	

		
	}
}