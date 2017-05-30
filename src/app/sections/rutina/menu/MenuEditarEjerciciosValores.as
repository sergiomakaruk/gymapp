package app.sections.rutina.menu
{
	import app.events.AppEvents;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import sm.utils.events.CustomEvent;
	
	public class MenuEditarEjerciciosValores extends AbsMenu
	{
		
		public function MenuEditarEjerciciosValores()
		{
			super();
			
			var _endButtons:_menuEditarEjerciciosValoresSP = new _menuEditarEjerciciosValoresSP();
			addChild(_endButtons);
			
			addButton(_endButtons._btnCancelar);
			addButton(_endButtons._btnGuardarTodos);
			
		}
		
		
		override protected function onDonwn(event:Event):void
		{
			var params:Object = {};						
			
			switch(event.target.face.name){				
				
				case '_btnCancelar': params.action = AppEvents.CANCELAR_EDICION_EVENT;break;	
				case '_btnGuardarTodos': params.action = AppEvents.GUARDAR_CAMBIOS_VALORES;break;	
			}
			
			dispatchEvent(new CustomEvent(AppEvents.EDITAR_RUTINA_MAIN_EVENT,params));//RutinaMediator
		}
		
		public function destroy():void
		{
			// TODO Auto Generated method stub
			
		}
	}
}