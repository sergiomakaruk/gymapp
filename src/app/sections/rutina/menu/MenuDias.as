package app.sections.rutina.menu
{
	import app.events.AppEvents;
	import app.sections.componentes.TecladoButton;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import sm.fmwk.ui.button.events.ButtonEvent;
	import sm.utils.display.GetButton;
	import sm.utils.events.CustomEvent;
	
	public class MenuDias extends AbsMenu
	{
		private var _currentBtn:TecladoButton;

		private var content:_menuEditarDiasSP;

		private var _selected:uint;
		public function MenuDias()
		{
			super();
			
			content = new _menuEditarDiasSP();
			addChild(content);
			
			addButton(content._btnCancelar);
			addButton(content._btnGuardarTodos);
			
			var numeros:Array = [0,1,2,3,4,5,6];
			//mcs = [];
			
			for each(var n:uint in numeros){
				var ch:MovieClip = content.getChildByName('_'+n) as MovieClip;
				ch.gotoAndStop(n);				
				var btn:TecladoButton = GetButton.button(ch,TecladoButton) as TecladoButton;				
				btn.value = n;
				btn.unlockeable = true;				
				
				btn.addEventListener(ButtonEvent.onDOWN,onClick);
				
				//mcs.push(btn);
			}			
		}
		
		protected function onClick(event:ButtonEvent=null):void
		{	
			_selected = uint(TecladoButton(event.target).value.toString());
			content._selected.text = _selected.toString();	
			this.dispatchEvent(new CustomEvent(AppEvents.EDITAR_RUTINA_MAIN_EVENT,{action:AppEvents.SELECTED_DIA_BUTTON,selected:_selected}));
		}
		
		override protected function onDonwn(event:Event):void
		{
			var params:Object = {};						
			
			switch(event.target.face.name){				
				
				case '_btnCancelar': params.action = AppEvents.CANCELAR_EDICION_DIAS_EVENT;break;	
				case '_btnGuardarTodos': params.action = AppEvents.GUARDAR_DIAS;break;	
			}
			
			dispatchEvent(new CustomEvent(AppEvents.EDITAR_RUTINA_MAIN_EVENT,params));//RutinaMediator
		}
		
		public function destroy():void
		{
			// TODO Auto Generated method stub
			
		}
	}
}