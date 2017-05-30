package app.sections.rutina.menu
{
	import app.events.AppEvents;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import sm.fmwk.ui.button.Button;
	import sm.fmwk.ui.button.events.ButtonEvent;
	import sm.utils.display.GetButton;
	import sm.utils.events.CustomEvent;
	
	public class MenuEjercicios extends AbsMenu
	{		
		
		public function MenuEjercicios()
		{
			super();
			
			var content:_menuEditarEjerciciosSP = new _menuEditarEjerciciosSP();
			addChild(content);	
			
			//addButton(content._btnFinalizar).delayTime = 2000;
			
			//addButton(content._btnTrenSuperior);
			//addButton(content._btnTrenInferior);
			addButton(content._btnCardio);
			addButton(content._btnBiceps);
			addButton(content._btnHombros);
			addButton(content._btnTriceps);
			addButton(content._btnDorsales);
			addButton(content._btnPectorales);
			addButton(content._btnAbdominales);
			addButton(content._btnAbec);
			addButton(content._btnCuadriceps);
			addButton(content._btnIsquiotibiales);
			addButton(content._btnGemelos);
			addButton(content._btnGluteos);
			addButton(content._btnBuscarEj);
			
			addButton(content._btnGuardarCambios);
			addButton(content._btnCancelar);
		}

		override protected function onDonwn(event:Event):void
		{
			/*
			//8 - cardio
			7 - adominales
			//6 - Triceps
			//5 - Biceps
		//	4 - Hombros
			3 - Piernas
			//2 - Espalda
			//1 - Pecho			
			*/
				
			
			var params:Object = {};
			params.action = AppEvents.AGREGAR_EJERCICIOS_POPUP_EVENT;			
		
			switch(event.target.face.name){
				
				case AppEvents.CARDIO: params.filter = 8;params.text = "CARDIO";break;
				case AppEvents.BICEPS: params.filter = 5;params.text = "Tren Superior: BICEPS";break;
				case AppEvents.HOMBROS: params.filter = 4;params.text = "Tren Superior: HOMBROS";break;
				case AppEvents.TRICEPS: params.filter = 6;params.text = "Tren Superior: TRICEPS";break;
				case AppEvents.DORSALES: params.filter = 2;params.text = "Tren Superior: DORSALES";break;
				case AppEvents.PECTORALES: params.filter = 1;params.text = "Tren Superior: PECTORALES";break;
				case AppEvents.ABDOMINALES: params.filter = 7;params.text = "Zona Media: ABDOMINALES";break;
				case AppEvents.ABEDUCTORES: params.filter = 3;params.text = "Tren Inferior: ABDUCTOES Y ADUTORES";break;
				case AppEvents.CUADRICEPS: params.filter = 9;params.text = "Tren Inferior: CUÁDRICEPS";break;
				case AppEvents.ISQUITIBIALES: params.filter = 10;params.text = "Tren Inferior: ISQUIOTIBIALES";break;
				case AppEvents.GEMELOS: params.filter = 11;params.text = "Tren Inferior: GEMELOS";break;
				case AppEvents.GLUTEOS: params.filter = 12;params.text = "Tren Inferior: GLÚTEOS";break;
				case '_btnBuscarEj':  params.filter = 100;params.text = "Búsqueda";break;
				
				case '_btnCancelar': params.action = AppEvents.CANCELAR_AGREGAR_POPUP_EVENT;break;	
				case '_btnGuardarCambios': params.action = AppEvents.GUARDAR_CAMBIOS_AGREGAR_EJERCICIOS_A_RUTINA;break;	
				//default: evt = 
			}
			
			dispatchEvent(new CustomEvent(AppEvents.EDITAR_RUTINA_MAIN_EVENT,params));//RutinaMediator
		}
		
		public function destroy():void
		{
			// TODO Auto Generated method stub
			
		}
	}
}