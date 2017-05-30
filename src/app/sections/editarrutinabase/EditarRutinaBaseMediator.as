package app.sections.editarrutinabase
{
	import app.commands.GetSetRutinaCommand;
	import app.data.rutinas.DataIdRutinaBase;
	import app.datatransferences.AppTokenDataTransferenceData;
	import app.datatransferences.DataTransferenceTypes;
	import app.events.AppEvents;
	import app.model.Model;
	import app.sections.AppSectionMediator;
	
	import flash.events.Event;
	
	import sm.fmwk.net.transferences.DataTransferenceData;
	import sm.fmwk.net.transferences.TokenTransferenceData;
	import sm.fmwk.rblegs.events.transference.FinishTransferenceEvent;
	import sm.utils.events.CustomEvent;
	
	public class EditarRutinaBaseMediator extends AppSectionMediator
	{
		public function EditarRutinaBaseMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			super.onRegister();			
			view.addEventListener(AppEvents.RECUPERAR_RUTINA_BASE_EVENT,onRecuperarRutinaBase);
		//	this.addEventListener(
			this.eventDispatcher.addEventListener(FinishTransferenceEvent.TRANSFERENCE_COMPLETE,onNombreEditado);
		}
		
		/*override public function preRemove():void{
			view.removeEventListener(AppEvents.RECUPERAR_RUTINA_BASE_EVENT,onRecuperarRutinaBase);
			this.eventDispatcher.removeEventListener(DataTransferenceTypes.EDITAR_NOMBRE_RUTINA_DEFAULT,onNombreEditado);
			super.onRemove();
		}*/
		
		private function onNombreEditado(e:FinishTransferenceEvent):void
		{
			if(e.msg == DataTransferenceTypes.EDITAR_NOMBRE_RUTINA_DEFAULT){
				trace('onNombreEditado');
				content.selectedBtn._txt.text = Model.currentDataRutina.dataIDRutinaBase.nombre;
			}
			
		}
		
		override protected function onPageInit(e:Event=null):void{
			
			//this.eventDispatcher.dispatchEvent(new CustomEvent(AppEvents.GET_FAKE_USER,onLoadPage));
			onLoadPage();
		}
		
		private function onLoadPage():void{			
			this.doTransference(new AppTokenDataTransferenceData(DataTransferenceTypes.RECUPERAR_MENU_RUTINA_BASE,[]),super.onPageInit);
		}
		
		protected function onRecuperarRutinaBase(event:CustomEvent):void
		{
			/*trace("event.params",event.params);
			var level:uint = event.params[0];
			var sexo:uint = event.params[1];
			Model.profe.rutinaBase.populateAsRutinaBase(level,sexo);*/
			//event.params.action = GetSetRutinaCommand.GET_RUTINA_BASE;
			DataIdRutinaBase(event.params).cb = onRutinaRecuperada;
			DataIdRutinaBase(event.params).defineAction();
			
			this.dispatch(new CustomEvent(AppEvents.SETGET_RUTINA_COMMAND,event.params));
			
			//this.doTransference(new AppTokenDataTransferenceData(DataTransferenceTypes.RECUPERAR_RUTINA_BASE,[1,level,sexo]),onRutinaRecuperada);			
		}
		
		private function onRutinaRecuperada():void
		{
			content.showrutinaBase();			
		}
		
		private function get content():EditarRutinaBaseSection{
			return view as EditarRutinaBaseSection;
		}
	}
}