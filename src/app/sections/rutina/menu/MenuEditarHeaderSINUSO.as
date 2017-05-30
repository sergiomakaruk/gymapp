package app.sections.rutina.menu
{
	import app.events.AppEvents;
	import app.sections.componentes.TecladoButton;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Back;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import sm.fmwk.ui.button.events.ButtonEvent;
	import sm.utils.display.GetButton;
	import sm.utils.events.CustomEvent;
	
	public class MenuEditarHeaderSINUSO extends AbsMenu
	{
		private var _selected:uint;
		private var content:_menuEditarEjerciciosValoresSP;
		
		public function MenuEditarHeaderSINUSO()
		{
			super();
			
			content = new _menuEditarEjerciciosValoresSP();
			addChild(content);
			
			addButton(content._btnCancelar);
			addButton(content._btnGuardarTodos);					
		}
				
		override protected function onDonwn(event:Event):void
		{
			var params:Object = {};						
			
			switch(event.target.face.name){				
				
				//case '_btnCancelar': params.action = AppEvents.CANCELAR_EDICION_HEADER_EVENT;break;	
				//case '_btnGuardarTodos': params.action = AppEvents.GUARDAR_CAMBIOS_HEADER;break;	
			}
			
			dispatchEvent(new CustomEvent(AppEvents.EDITAR_RUTINA_MAIN_EVENT,params));//RutinaMediator
		}
		
		public function destroy():void
		{
			// TODO Auto Generated method stub
			
		}
	}
}