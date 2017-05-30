package app.sections.rutina.menu
{
	import app.data.rutinas.DataRutina;
	import app.events.AppEvents;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import sm.fmwk.ui.button.Button;
	import sm.fmwk.ui.button.events.ButtonEvent;
	import sm.utils.animation.Timeline;
	import sm.utils.display.DPUtils;
	import sm.utils.display.GetButton;
	import sm.utils.events.CustomEvent;

	public class MenuRutina extends AbsMenu
	{		
		public static const DEFAULT:String = "default";
		public static const EDITAR_EJERCICIOS_POPUP:String = "editarEjerciciosPoup";
		public static const EDITAR_EJERCICIOS_VALORES:String = "editarEjerciciosValores";	
		public static const EDITAR_DIAS_STATE:String = "editarDiasState";
		public static const ORDEN_STATE:String = "ordenState";	
		public static const EDIT_HEADER_STATE:String = "editHeaderState";	
		
		private var content:_menuEditarRutinaSP;
		private var menuEjercicios:MenuEjercicios;
	

		private var timeline:Timeline;

		private var menuEditarValores:MenuEditarEjerciciosValores;
		private var menuDias:MenuDias;
		private var menuOrden:MenuEditarOrden;
		private var menuEditarHeader:MenuEditarHeaderSINUSO;
		
		
		public function MenuRutina(isRutinaBase:Boolean=true)
		{
			super();			
					
			content = new _menuEditarRutinaSP();
			addChild(content);
			
			//content._menuEditarEjercicios.visible = false;
			
			content._btnEditarEjercicios.gotoAndStop(1);
			addButton(content._btnVolver);
			if(!isRutinaBase){
				addButton(content._btnImprimir);
				//addButton(content._btnEditarObservaciones);
				//addButton(content._btnEditarObjetivos);
			}
			
			addButton(content._btnAgregarEjercicio);
			addButton(content._btnEditarEjercicios);
			
			
			addButton(content._btnDias);
			addButton(content._btnOrden);
			if(!isRutinaBase)addButton(content._btnEnviarEmail);
			else addButton(content._btnEditarNombreRutinaBase);
					
			var container:Sprite = DPUtils.getColumnsContainer(buttons,0,5,1);
			container.y+=50;
			content.addChild(container);			
		}		
		

		override protected function onDonwn(event:Event):void
		{
			var params:Object = {};
			switch(event.target.face.name){
				case '_btnEditarEjercicios':params.action = AppEvents.EDITAR_EJERCICIOS_EVENT;break;
				case '_btnAgregarEjercicio':params.action = AppEvents.AGREGAR_EJERCICIOS_POPUP_EVENT;break;
				case '_btnOrden':params.action = AppEvents.ORDENAR_EJERCICIOS_POPUP_EVENT;break;
				case '_btnDias':params.action = AppEvents.EDITAR_DIAS;break;
				case '_btnVolver':params.action = AppEvents.VOLVER;break;
				case '_btnImprimir':params.action = AppEvents.IMPRIMIR;break;
				case '_btnEnviarEmail':params.action = AppEvents.ENVIAR_EMAIL;break;
				case '_btnEditarNombreRutinaBase':params.action = AppEvents.EDITAR_NOMBRE_DE_RUTINA_BASE;break;
				//case '_btnEditarObservaciones':params.action = AppEvents.EDITAR_OBSERVACIONES;break;
				//case '_btnEditarObjetivos':params.action = AppEvents.EDITAR_OBJETIVOS;break;
			}
			
			dispatchEvent(new CustomEvent(AppEvents.EDITAR_RUTINA_MAIN_EVENT,params));
		}
		
		public function showMenuEjercicios():void
		{
			if(!menuEjercicios){
				menuEjercicios = new MenuEjercicios();
			//	menuEjercicios.addEventListener(AppEvents.FINALIZAR_EDICION_EVENT,onCerrarMenuEjercicios);
				
				timeline = new Timeline(null,onReverseComplete,Timeline.EXPO);	
				timeline.to(content,{x:-300});
				timeline.from(menuEjercicios,{x:-300});
				
				addChild(menuEjercicios);
			}						
			timeline.play();
		}
		
		public function renderAsDefault():void
		{
			timeline.reverse();			
		}
		
		public function render(state:String):void
		{
			switch(state){
				case DEFAULT:renderAsDefault();break;
				case EDITAR_EJERCICIOS_POPUP:showMenuEjercicios();break;
				case EDITAR_EJERCICIOS_VALORES:showMenuEditarEjerciciosValores();break;
				case EDITAR_DIAS_STATE:showMenuDias();break;
				case ORDEN_STATE:showMenuOrden();break;
				//case EDIT_HEADER_STATE:showMenuEditHeader();break;
			}
			
		}
		
		private function showMenuEditHeader():void
		{
			if(!menuEditarHeader){
				menuEditarHeader = new MenuEditarHeaderSINUSO();				
				timeline = new Timeline(null,onReverseComplete,Timeline.EXPO);		
				timeline.to(content,{x:-300});
				timeline.from(menuEditarHeader,{x:-300});				
				addChild(menuEditarHeader);
			}						
			timeline.play();	
			
		}
		
		private function showMenuOrden():void
		{			
			if(!menuOrden){
				menuOrden = new MenuEditarOrden();				
				timeline = new Timeline(null,onReverseComplete,Timeline.EXPO);		
				timeline.to(content,{x:-300});
				timeline.from(menuOrden,{x:-300});				
				addChild(menuOrden);
			}						
			timeline.play();			
		}
		
		private function showMenuDias():void
		{			
			if(!menuDias){
				menuDias = new MenuDias();				
				timeline = new Timeline(null,onReverseComplete,Timeline.EXPO);		
				timeline.to(content,{x:-300});
				timeline.from(menuDias,{x:-300});				
				addChild(menuDias);
			}						
			timeline.play();			
		}
		
		private function showMenuEditarEjerciciosValores():void
		{			
			if(!menuEditarValores){
				menuEditarValores = new MenuEditarEjerciciosValores();	
				addChild(menuEditarValores);				
				timeline = new Timeline(null,onReverseComplete,Timeline.EXPO);	
				timeline.to(content,{x:-300});
				timeline.from(menuEditarValores,{x:-300});				
			}						
			timeline.play();			
		}
		
		private function onReverseComplete():void
		{
			//trace('onReverseComplete',onReverseComplete);
			if(menuEditarValores){
				removeChild(menuEditarValores);
				menuEditarValores.destroy();
				menuEditarValores = null;
			}
			
			if(menuEjercicios){
				removeChild(menuEjercicios);
				menuEjercicios.destroy();
				menuEjercicios = null;
			}
			
			if(menuDias){
				removeChild(menuDias);
				menuDias.destroy();
				menuDias = null;
			}
			
			if(menuOrden){
				removeChild(menuOrden);
				menuOrden.destroy();
				menuOrden = null;
			}
			
			if(menuEditarHeader){
				removeChild(menuEditarHeader);
				menuEditarHeader.destroy();
				menuEditarHeader = null;
			}
			
		}
	}
}