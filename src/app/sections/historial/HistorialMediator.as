package app.sections.historial
{
	import app.AppSectionTypes;
	import app.commands.GetSetRutinaCommand;
	import app.data.rutinas.DataIdRutinaBase;
	import app.datatransferences.AppTokenDataTransferenceData;
	import app.datatransferences.DataTransferenceTypes;
	import app.events.AppEvents;
	import app.model.Model;
	import app.sections.AppSectionMediator;
	import app.sections.rutina.msg.SalirMsg;
	
	import flash.events.Event;
	
	import sm.utils.events.CustomEvent;
	
	public class HistorialMediator extends AppSectionMediator
	{
		private var currentDuplicar:String;
		
		public function HistorialMediator()
		{
			super();
		}
				
		/*override protected function onPageInit(e:Event=null):void{
			
			this.eventDispatcher.dispatchEvent(new CustomEvent(AppEvents.GET_FAKE_USER,onLoadPage));
			//onLoadPage();
		}*/
		
		private function onLoadPage():void{			
			this.doTransference(new AppTokenDataTransferenceData(DataTransferenceTypes.RECUPERAR_MENU_RUTINA_BASE,[]),super.onPageInit);
		}
	
		
		override public function onRegister():void{
			super.onRegister();			
			page.addEventListener(AppEvents.HISTORIAL_MAIN_EVENT,onHistorialEvent);
		}
		
		
		override protected function onPageDetroyed(e:Event):void{
			page.removeEventListener(AppEvents.HISTORIAL_MAIN_EVENT,onHistorialEvent);
			super.onPageDetroyed(e);
		}
		
		protected function onHistorialEvent(event:CustomEvent):void
		{
			switch(event.params.action){
				
				case AppEvents.HISTORIAL_ACTUALIZAR_EMAIL:
					actualizarEmail(event.params.email);
					break;
				case AppEvents.HISTORIAL_COPIAR_RUTINA:
					copiarRutina(event.params);
					break;
				case AppEvents.HISTORIAL_EDITAR_RUTINA:
					editarRutina(event.params);
					break;
				case AppEvents.HISTORIAL_CREAR_NUEVA_RUTINA:
					loadRutinaBaseTemplate(event.params.dataIdRutina);
					break;
				
			}
			
		}
		
		private function loadRutinaBaseTemplate(dataIdRutina:DataIdRutinaBase):void
		{			
			dataIdRutina.setActionToTemplate();
			dataIdRutina.cb = crearRutina;			
			
			this.dispatch(new CustomEvent(AppEvents.SETGET_RUTINA_COMMAND,dataIdRutina));			
		}	
		
		private function actualizarEmail(email:String):void
		{
			this.doTransference(new AppTokenDataTransferenceData(DataTransferenceTypes.ACTUALIZAR_EMAIL,[Model.socio.idSocio,email]));			
		}
		
		private function copiarRutina(param:Object):void
		{
			currentDuplicar = param.sid;		
			msgDuplicar();
		}
		
		private function msgDuplicar():void
		{
			var msgCancel:SalirMsg = new SalirMsg(3);
			page.stage.addChild(msgCancel);
			msgCancel.initMsg();			
			msgCancel.addEventListener(Event.COMPLETE,onDuplicar);
		}
		
		protected function onCartelEliminarRemoved(event:Event):void
		{
			var msg:SalirMsg = event.target as SalirMsg;			
			msg.removeEventListener(Event.COMPLETE,onDuplicar);
		}
		
		private function onDuplicar(e:Event):void
		{
			var msg:SalirMsg = e.target as SalirMsg;
			msg.close();
			Model.copyRutina(Model.socio.rutinas.getRutinaById(currentDuplicar));
			var params:Object = {};
			params.action = GetSetRutinaCommand.GET_COPY_RUTINA;
			params.sid = currentDuplicar;	
			params.cb = crearRutina;
			
			this.dispatch(new CustomEvent(AppEvents.SETGET_RUTINA_COMMAND,params));				
		}
		
		private function editarRutina(params:Object):void
		{
			trace("editarRutina");
			this.dispatch(new CustomEvent(AppEvents.SETGET_RUTINA_COMMAND,{action:GetSetRutinaCommand.GET_RUTINA_USUARIO,sid:params.sid,cb:onEditarRutina}));
		}
		
		private function onEditarRutina():void{
			Model.currentDataRutina = Model.socio.rutinas.selectedRutina;
			content.showRutina();
		}
		
		private function crearRutina():void
		{
			trace("crearRutina()");
			this.dispatch(new CustomEvent(AppEvents.SETGET_RUTINA_COMMAND,{action:GetSetRutinaCommand.SET_EJERCICIOS_NUEVOS,cb:content.showRutina}));					
		}
		
		override protected function onPageCompleted(e:Event=null):void{
			Model.cleanSocio();
			
			this.changeSection(AppSectionTypes.PERFIL_PROFE);
		}

		private function get content():HistorialSection{return page as HistorialSection;}
	}
}