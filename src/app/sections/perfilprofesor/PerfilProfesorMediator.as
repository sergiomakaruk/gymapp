package app.sections.perfilprofesor
{
	import app.AppSectionTypes;
	import app.datatransferences.AppTokenDataTransferenceData;
	import app.datatransferences.DataTransferenceTypes;
	import app.events.AppEvents;
	import app.model.Model;
	import app.sections.AppSectionMediator;
	import app.sections.restricted.RestrictedSection;
	
	import flash.events.Event;
	
	import sm.fmwk.net.transferences.DataTransferenceData;
	import sm.utils.events.CustomEvent;
	
	public class PerfilProfesorMediator extends AppSectionMediator
	{
		public function PerfilProfesorMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			super.onRegister();
			content.addEventListener("backBtn",onPrevSection);
			content.addEventListener("verStatics",onStatics);
			content.addEventListener("verVersionUpdates",onverVersionUpdates);
		}
	
		
		protected function onStatics(event:Event):void
		{	
			content.removeEventListener("verStatics",onStatics);
			content.removeEventListener("backBtn",onPrevSection);
			content.removeEventListener("verVersionUpdates",onverVersionUpdates);
			this.changeSection(AppSectionTypes.STATICS_PROFE);
		}
		
		protected function onPrevSection(event:Event):void
		{
			content.removeEventListener("verStatics",onStatics);
			content.removeEventListener("backBtn",onPrevSection);
			content.removeEventListener("verVersionUpdates",onverVersionUpdates);
			//this.previousSection();	
			this.changeSection(AppSectionTypes.LOGIN_PROFE);
		}
		protected function onverVersionUpdates(event:Event):void
		{
			content.removeEventListener("verStatics",onStatics);
			content.removeEventListener("backBtn",onPrevSection);
			content.removeEventListener("verVersionUpdates",onverVersionUpdates);
			//this.previousSection();	
			this.changeSection(AppSectionTypes.VERSION_UPDATES_INFO);
		}
		
		/*override protected function onPageInit(e:Event=null):void{
			this.eventDispatcher.dispatchEvent(new CustomEvent(AppEvents.GET_FAKE_USER,super.onPageInit));
		}*/
		
		override protected function onPageChanged(e:Event):void{
			//login usuario1
			//this.doTransference(new AppTokenDataTransferenceData(DataTransferenceTypes.BUSCA_SOCIO,content.login),onSocio);
			this.dispatch(new CustomEvent(AppEvents.GET_PROFE_USER,{dni:content.login,cb:onSocio}));
		}
		
		private function onSocio():void
		{
			if(!Model.socio.exists){
				trace("Login error: show msg");
				content.showError();
			}
			else if(!Model.socio.hasPlanEntrenamiento){
				content.showNoPlanDeEntrenamiento();
			}
			else{
				this.changeSection(AppSectionTypes.HISTORIAL_USUARIO);			
			}				
		}
		
		private function onHistorial():void
		{
			// TODO Auto Generated method stub
			
			/*
			HACER COMANDO PARA BUSCAR USUARIO Y CARGAR RUTINAS
			
			1-Escucho evento USER_FULL para carcar las cosas
			1-b-Escucho evento USER_ERROR
			2-Disparo evento para activar comando
			3-Cargo usuario
			4-Usuario Error, disparo evento USER_ERROR, cierra comando, vuelve a empezar la rueda
			5-Usuario,ok, cargo rutinas
			6-Cargo ultima rutina
			7-Disparo evento USER_FULL			
			
			*/
			
		}
		
		
		
		override protected function onPageCompleted(e:Event=null):void{
			changeSection(AppSectionTypes.EDIT_RUTINAS_BASE);			
		}
		
		public function get content():PerfilProfesor{
			return page as PerfilProfesor;
		}
	}
}