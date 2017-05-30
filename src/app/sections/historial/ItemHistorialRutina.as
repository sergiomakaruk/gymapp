package app.sections.historial
{
	import app.data.rutinas.DataRutina;
	import app.events.AppEvents;
	import app.sections.rutina.menu.AbsMenu;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import sm.utils.events.CustomEvent;
	
	public class ItemHistorialRutina extends AbsMenu
	{
		private var data:DataRutina;
		
		public function ItemHistorialRutina(data:DataRutina)
		{
			super();
			this.data = data;
			
			var content:_itemRutinaSP = new _itemRutinaSP();
			addChild(content);
			
			content._inicio.text = data.showFechaInicio();
			content._renovacion.text = data.showFechaRenovacion();
			content._profe.text = data.profesor;
			//content._profe.text = data.sid;
			
			addButton(content._btnDuplicar);
			addButton(content._btnEditar);
		}
		
		override protected function onDonwn(event:Event):void
		{
			var params:Object = {};						
			params.sid = data.sid;
			
			switch(event.target.face.name){				
				
				case '_btnDuplicar': params.action = AppEvents.HISTORIAL_COPIAR_RUTINA;break;	
				case '_btnEditar': params.action = AppEvents.HISTORIAL_EDITAR_RUTINA;break;	
			}
			
			dispatchEvent(new CustomEvent(AppEvents.HISTORIAL_MAIN_EVENT,params));//RutinaMediator
		}
	}
}