package app.sections.rutina.ejercicios
{
	import app.data.ejercicios.DataEjercicio;
	import app.events.AppEvents;
	import app.model.Model;
	
	import flash.events.Event;
	
	import sm.fmwk.site.mediators.FmwkMediator;
	import sm.utils.events.CustomEvent;
	
	public class PopupAgregarEjercicioMediator extends FmwkMediator
	{
		private var _ejerciciosAAgregar:Array;
		
		public function PopupAgregarEjercicioMediator()
		{
			super();
		}
		
		override public function onRegister():void{
			super.onRegister();
			view.addEventListener(AppEvents.AGREGAR_ESTE_EJERCICIO_EVENT,onAgregarEjercicio);//desde EjercicioView
			//view.addEventListener(AppEvents.GUARDAR_CAMBIOS_AGREGAR_EJERCICIOS_A_RUTINA,onGuardarEjerciciosAgregados);
		}
	
		
		override public function onRemove():void{
			super.onRemove();
			view.removeEventListener(AppEvents.AGREGAR_ESTE_EJERCICIO_EVENT,onAgregarEjercicio);
			//view.removeEventListener(AppEvents.GUARDAR_CAMBIOS_AGREGAR_EJERCICIOS_A_RUTINA,onGuardarEjerciciosAgregados);
		}
		
		protected function onAgregarEjercicio(event:CustomEvent):void
		{	
			var miniEj:AgregarEjercicioView = event.target as AgregarEjercicioView;
			miniEj.showEditBtn();
			var data:DataEjercicio = event.params as DataEjercicio;	
			data.defaultView.render(true,true);
			data = Model.templates.copy(data.sid);///COPIA UN EJERCICIO
			Model.currentDataRutina.ejercicios.agregar(data);
			content.renderMiniRutina();
			//data.defaultView.render(true);
			///la rutina se actualiza cuando se graban los ejercicios
		}
		
		private function get content():PopupAgregarEjercicio{return view as PopupAgregarEjercicio;}
	}
}