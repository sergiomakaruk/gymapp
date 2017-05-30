package app.sections.rutina
{
	import app.data.ejercicios.DataEjercicio;
	import app.data.rutinas.DataIdRutinaBase;
	import app.data.rutinas.DataRutina;
	import app.events.AppEvents;
	import app.model.Model;
	import app.sections.rutina.ejercicios.EjercicioView;
	import app.sections.rutina.ejercicios.PopupAgregarEjercicio;
	import app.sections.rutina.ejercicios.PopupEditarHeader;
	import app.sections.rutina.ejercicios.PopupOrdenarEjercicios;
	import app.sections.rutina.menu.MenuRutina;
	
	import com.apdevblog.events.video.VideoControlsEvent;
	import com.apdevblog.ui.video.ApdevVideoPlayer;
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	import com.sam.ui.scroll.GetScrollview;
	import com.sam.ui.scroll.ScrollView;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import nid.ui.controls.VirtualKeyBoard;
	import nid.ui.controls.vkb.KeyBoardEvent;
	import nid.ui.controls.vkb.KeyBoardTypes;
	
	import sm.fmwk.Fmwk;
	import sm.utils.display.DPUtils;
	import sm.utils.display.GetButton;
	import sm.utils.events.CustomEvent;
	
	public class Rutina extends Sprite
	{
		
		private static const USUARIO:String = "Usuario";
		private static const TEMPLATE:String = "Template";
		private static const EDICION:String = "Edicion";
		
		//public static const SCALEFACTOR:Number = 0.4;
		
		protected var _content:_A4;
		private var video:VideoPlayer;

		private var tapScroll:TapScroller;//usuario
		private var scroll:ScrollView;//edicion
		
		private var popupEjercicios:PopupAgregarEjercicio;

		private var menu:MenuRutina;
		private var _type:String;

		private var container:Sprite;
		private var popupOrden:PopupOrdenarEjercicios;

		private var popupEditarHeader:PopupEditarHeader;

		private var txtNombreRutinaBase:TextField;
		
		
		public function Rutina()
		{
			super();
			
		}		

		public function render():void{
			_type = USUARIO;
			_content = new _A4();		
			while(_content._contenedorEjercicios.numChildren)_content._contenedorEjercicios.removeChildAt(0);
			_content.removeChild(_content.backgroundClip);
			_content.removeChild(_content.mascara);
			//_content.scaleX = _content.scaleY = SCALEFACTOR;
			addChild(_content);
			
			Model.currentDataRutina = Model.socio.rutinas.selectedRutina;
			Model.currentDataRutina.completeHeader(_content);
			Model.currentDataRutina.completeSubHeader(_content);
			
			showEjercicios();
			addListeners();
			
		}
		
		public function toggleKeyboard():void 
		{
			var idRutina:DataIdRutinaBase = Model.currentDataRutina.dataIDRutinaBase;
			trace(idRutina);
			trace(txtNombreRutinaBase);
			txtNombreRutinaBase.text = idRutina.nombre;
			//addChild(txt);
			VirtualKeyBoard.getInstance().init(this);	
			VirtualKeyBoard.getInstance().target = { field:txtNombreRutinaBase, fieldName:"Editar Nombre de Rutina Base - Género: " + idRutina.getGeneroStr()+" - Tipo: " + idRutina.getTipoStr() + " - Días: " +idRutina.dias + " - Opción: " + idRutina.opcion ,keyboardType:KeyBoardTypes.ALPHABETS_LOWER };
		}
		
		protected function onNombreRutinaBaseSave(event:Event):void
		{
			Model.currentDataRutina.dataIDRutinaBase.nombre = txtNombreRutinaBase.text;
			dispatchEvent(new CustomEvent(AppEvents.EDITAR_RUTINA_MAIN_EVENT,{action:AppEvents.SAVE_EDITAR_NOMBRE_DE_RUTINA_BASE}));			
		}
		
		public function renderasEditarRutina():void{
			_type = EDICION;
			_content = new _A4();		
			while(_content._contenedorEjercicios.numChildren)_content._contenedorEjercicios.removeChildAt(0);
			
			//_content.scaleX = _content.scaleY = SCALEFACTOR;
			addChild(_content);
			_content.mascara.x =_content.mascara.y = 0;		
			_content.backgroundClip.x = 0;
			_content._contenedorEjercicios.addChild(_content.mascara);
			Model.currentDataRutina.completeHeader(_content);
			Model.currentDataRutina.completeSubHeader(_content);						
			showEjerciciosAsEdicion();
			addListeners();
			addMenu(false);
		}
		
		public function renderasRutinaBase():void{
			_type = TEMPLATE;
			_content = new _A4();
			while(_content._contenedorEjercicios.numChildren)_content._contenedorEjercicios.removeChildAt(0);
		
			//_content.scaleX = _content.scaleY = SCALEFACTOR;
			addChild(_content);
			_content._objetivos.visible = false;
			_content._observaciones.visible = false;
			_content._ejerciciostitulo.y -= 100; 
			_content._contenedorEjercicios.y -= 100; 
			Model.currentDataRutina = Model.profe.rutinaBase;
			Model.currentDataRutina.completeHeaderAsBase(_content);
			
			_content.mascara.x =_content.mascara.y = 0;		
			_content.backgroundClip.x = 0;
			_content._contenedorEjercicios.addChild(_content.mascara);
			//completeSubHeader();
			
			showEjerciciosAsEdicion();
			addListeners();
			addMenu(true);			
			
			
			//VirtualKeyBoard.getInstance().addEventListener(KeyBoardEvent.UPDATE,onEmailChange);
			txtNombreRutinaBase = new TextField();
			VirtualKeyBoard.getInstance().addEventListener(KeyBoardEvent.SAVE,onNombreRutinaBaseSave);
		}
		
		/*
		///para cuando se agregan ejercicios
		public function restarRender():void{
			showEjerciciosAsEdicion(Model.currentDataRutina.ejercicios.ejercicios);
		}
		*/
		
		private function addMenu(isRutinaBase:Boolean=false):void
		{
			menu = new MenuRutina(isRutinaBase);
			addChild(menu);
			menu.x = -270;
			//menu.addEventListener(AppEvents.EDITAR_RUTINA_POPUP_EJERCICIOS_EVENT,onEditarRutina);
		}
		
		
		public function showAsdefaultStateEdition():void{
			trace("showAsdefaultStateEdition");
			if(popupEjercicios){
				removeChild(popupEjercicios);
				popupEjercicios.destroy();
				popupEjercicios = null;
			}
			showEjerciciosAsDefault();
		}
		public function mostrarPopupEjercicios(params:Object):void{
			if(!popupEjercicios){
				popupEjercicios = new PopupAgregarEjercicio();
				addChild(popupEjercicios);
				
				popupEjercicios.setDefaultAs0();
				}else{
				/*if(!popupEjercicios.isReady()){
					popupEjercicios.showAlarm();
					return;
				}*/
				popupEjercicios.txt = params.text;
				popupEjercicios.filtro = params.filter;
				
				
			}			
		}
		
		public function mostrarPopupOrdenarEjercicios(dia:uint):void{
			if(!popupOrden){
				popupOrden = new PopupOrdenarEjercicios();
				addChild(popupOrden);
				TweenMax.from(popupOrden,0.3,{x:stage.stageWidth,ease:Expo.easeOut});
			}
			
			Model.currentDataRutina.orderManager.currentDia = dia;
			popupOrden.change(dia);				
		}
		
		private function showEjerciciosAsDefault():void
		{
			for each(var ej:EjercicioView in Model.currentDataRutina.ejercicios.views)ej.renderAsDefault();
			updateView();	
			
			if(popupEjercicios){
				TweenMax.to(popupEjercicios,0.3,{x:stage.stageWidth,ease:Expo.easeIn,onComplete:onCompletePopup});				
			}			
			if(popupOrden){
				TweenMax.to(popupOrden,0.3,{x:stage.stageWidth,ease:Expo.easeIn,onComplete:onCompletePopup});
			}
			if(popupEditarHeader){
				TweenMax.to(popupEditarHeader,0.3,{x:stage.stageWidth,ease:Expo.easeIn,onComplete:onCompletePopup});
			}
		}
		
		private function onCompletePopup():void{
			if(popupEjercicios){				
				removeChild(popupEjercicios);
				popupEjercicios.destroy();
				popupEjercicios = null;
			}
			
			if(popupOrden){
				removeChild(popupOrden);
				popupOrden.destroy();
				popupOrden = null;
			}
			
			if(popupEditarHeader){
				removeChild(popupEditarHeader);
				popupEditarHeader.destroy();
				popupEditarHeader = null;
			}			
			
		}
		public function showEditarEjercicios():void
		{
			for each(var ej:EjercicioView in Model.currentDataRutina.ejercicios.views)ej.renderAsEdition();
			updateView();			
		}
		
		public function renderAsEditarDias():void{
			for each(var ej:EjercicioView in Model.currentDataRutina.ejercicios.views)ej.renderAsDiaEdition();
			updateView();	
		}
		
		public function mostrarPopupdeHeader(isObservaciones:Boolean):void
		{
			if(!popupEditarHeader){
				popupEditarHeader = new PopupEditarHeader(isObservaciones);
				addChild(popupEditarHeader);
				TweenMax.from(popupEditarHeader,0.3,{x:stage.stageWidth,ease:Expo.easeOut});
			}
			
		}
		
		public function updateView():void{
			
			/*var n:uint;
			var rows:uint;
			var margenX:uint = 20;
			var margenY:uint = 20;
			var columns:uint = 2;
			for each(var ej:EjercicioView in Model.currentDataRutina.ejercicios.views)
			{
				ej.y = (ej.height + margenY ) * rows;
				ej.x = (ej.width + margenX ) * n;
				
				n++;
				if(n == columns)
				{
					n=0;
					rows++;
				}					
			}*/
			if(_type == USUARIO)showEjercicios();
			else if(_type == TEMPLATE)showEjerciciosAsEdicion();
			else if(_type == EDICION)showEjerciciosAsEdicion();
		}
		
		private function addListeners():void
		{
			this.addEventListener(AppEvents.SHOW_VIDEO,onShowVideo);			
		}
		
		protected function onShowVideo(event:CustomEvent):void
		{
			if(!video){
				video = new VideoPlayer();
				video.init();
			}
			
			video.show(event.params as DataEjercicio);
			stage.addChild(video);
		}		
		
		
		
		
		protected function showEjercicios():void{
			//var container:Sprite = DPUtils.getColumnsContainer(Model.currentDataRutina.ejercicios.views,20,0,2);
			var container:Sprite = Model.currentDataRutina.ejercicios.daysBlocks;
		
			if(tapScroll) _content._contenedorEjercicios.removeChild(tapScroll);
			tapScroll = new TapScroller(container,968,740);
			_content._contenedorEjercicios.addChild(tapScroll);;		
		}
		
		protected function showEjerciciosAsEdicion():void{
			//var container:Sprite = DPUtils.getColumnsContainer(Model.currentDataRutina.ejercicios.daysBlocks,0,0,1);
			if(container)_content._contenedorEjercicios.removeChild(container);
			container = Model.currentDataRutina.ejercicios.daysBlocks;
			//trace("HERE");
			container.scaleX =  container.scaleY = 0.94;
			container.mask = _content.mascara;
			_content.backgroundClip.y = 0;
			_content._contenedorEjercicios.addChild(container);
			_content.backgroundClip.height = container.height + 20;
			/*if(!scroll)scroll = GetScrollview.getScroll(_content.scrollClip,true,false,true);
			scroll.addContent(container);	*/	
			
			if(tapScroll){
				_content._contenedorEjercicios.removeChild(tapScroll);
				tapScroll.removeEventListener(TapScroller.UPDATE,onScroll);
			}
			tapScroll = new TapScroller(_content.backgroundClip,100,_content.mascara.height-70);
			tapScroll.x = 900;
			tapScroll.addEventListener(TapScroller.UPDATE,onScroll);
			_content._contenedorEjercicios.addChild(tapScroll);			
			
		}
		
		protected function onScroll(event:Event):void
		{
			container.y = _content.backgroundClip.y;
			
		}		
		
		
		public function showAsLoading():void
		{
			this.alpha = 0.5;			
		}
		public function showAsNOLoading():void
		{
			this.alpha = 1;			
		}
		
		public function updatePopupEjercicios():void
		{
			//ejercicioEliminado
			if(popupEjercicios)popupEjercicios.updateView();			
		}
		
		//MENU
		
		public function renderMenu(state:String):void
		{
			menu.render(state);			
		}		
		
		public function destroy():void
		{
			// TODO Auto Generated method stub
			trace("DESTROY RUTINA");
			VirtualKeyBoard.getInstance().removeEventListener(KeyBoardEvent.SAVE,onNombreRutinaBaseSave);
			
		}
		
		
	}
}