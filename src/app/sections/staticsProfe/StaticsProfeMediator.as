package app.sections.staticsProfe
{
	import app.AppSectionTypes;
	import app.data.usuarios.DataUsuario;
	import app.datatransferences.AppTokenDataTransferenceData;
	import app.datatransferences.DataTransferenceTypes;
	import app.events.AppEvents;
	import app.model.Model;
	import app.sections.AppSectionMediator;
	
	import flash.events.Event;
	
	import sm.fmwk.Fmwk;
	import sm.fmwk.data.core.AssetManager;
	import sm.fmwk.net.transferences.AssetTransferenceData;
	import sm.fmwk.net.transferences.DataTransferenceData;
	import sm.utils.events.CustomEvent;
	import sm.utils.loader.AssetLoader;
	
	public class StaticsProfeMediator extends AppSectionMediator
	{
		public function StaticsProfeMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			content.addEventListener(ItemUsuario.MANDAR_MAIL_USUARIO_AUSENCIA,onMandarMailUsuarioAusencia);
			content.addEventListener(ItemUsuario.MANDAR_MAIL_USUARIO_RENOVACION,onRenovarDesdeStatics);
			
			super.onRegister();
		}
		
		/*override protected function onPageInit(e:Event=null):void{
		this.eventDispatcher.dispatchEvent(new CustomEvent(AppEvents.GET_FAKE_USER,super.onPageInit));		
		
		}*/
	
		
		private function onPhoto():void
		{
			var data:Object = staker.lastTransference.data;
			//trace(data);
			
		}
		
		override protected function onPageDetroyed(e:Event):void{
			content.removeEventListener(ItemUsuario.MANDAR_MAIL_USUARIO_AUSENCIA,onMandarMailUsuarioAusencia);
			content.removeEventListener(ItemUsuario.MANDAR_MAIL_USUARIO_RENOVACION,onRenovarDesdeStatics);
			super.onPageDetroyed(e);
		}
		
		protected function onMandarMailUsuarioAusencia(event:CustomEvent):void
		{
			var data:DataUsuario = event.params as DataUsuario;
			this.doTransference(new DataTransferenceData(DataTransferenceTypes.ENVIAR_EMAIL_USUARIO,{txt:data.txtRenovar,asunto:2,email:data.email}));	
			//this.doTransference(new DataTransferenceData(DataTransferenceTypes.ENVIAR_EMAIL_USUARIO,{nombre:data.nombre,apellido:data.apellido,email:data.email}));			
		}
		
		protected function onRenovarDesdeStatics(event:CustomEvent):void{
			//login usuario1
			//this.doTransference(new AppTokenDataTransferenceData(DataTransferenceTypes.BUSCA_SOCIO,content.login),onSocio);
			var data:DataUsuario = event.params as DataUsuario;
			this.doTransference(new DataTransferenceData(DataTransferenceTypes.ENVIAR_EMAIL_USUARIO,{txt:data.txtRenovar,asunto:1,email:data.email}));	
			//this.dispatch(new CustomEvent(AppEvents.GET_PROFE_USER,{dni:data.dni,cb:onSocio}));
		}
		
		private function onSocio():void
		{
			this.changeSection(AppSectionTypes.HISTORIAL_USUARIO);	//no hay posibilidad de que el socio no exista, por eso logue directamente								
		}
		
		protected function onPrevSection(event:Event):void
		{
			this.changeSection(AppSectionTypes.PERFIL_PROFE);
		}
		
		override protected function onPageCompleted(e:Event=null):void{
			
			this.changeSection(AppSectionTypes.PERFIL_PROFE);
		}
		
		public function get content():StaticsProfeSection{
			return page as StaticsProfeSection;
		}
	}
}