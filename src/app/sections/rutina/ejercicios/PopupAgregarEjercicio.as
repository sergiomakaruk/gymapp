package app.sections.rutina.ejercicios
{
	import app.data.ejercicios.DataEjercicio;
	import app.data.rutinas.DataRutina;
	import app.model.Model;
	import app.sections.rutina.TapScroller;
	
	import com.greensock.TweenMax;
	import com.sam.ui.scroll.GetScrollview;
	import com.sam.ui.scroll.ScrollView;
	
	import sm.utils.animation.Timeline;

	Timeline
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	
	import sm.fmwk.Fmwk;
	import sm.utils.display.DPUtils;
	import sm.utils.display.GetImage;
	import com.greensock.easing.Back;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import nid.ui.controls.VirtualKeyBoardEjercicio;
	import nid.ui.controls.vkb.KeyBoardTypes;
	import nid.ui.controls.vkb.KeyBoardEvent;
	import flash.text.TextField;
	
	public class PopupAgregarEjercicio extends Sprite
	{
		
		private var content:_agregarEjercicioPopupSP;
		private var _filtro:uint;
		private var tapScroll:TapScroller;
		//private var scroll:ScrollView;

		private var currentViews:Array;

		private var viewsMiniRutina:Array;

		private var containerMiniRutina:Sprite;

		private var _currentDia:int = -1;

		private var currentBtnDia:MovieClip;

		private var container:Sprite;

		private var ejBusqueda:TextField;

		public function isReady():Boolean{return _currentDia>=0}
		public function get filtro():uint{return _filtro;}		
		public function set filtro(value:uint):void{_filtro = value;init();}
		
		public function set txt(_txt:String):void{
			content._ejercicios.text = _txt;
		}
		
		public function PopupAgregarEjercicio()
		{
			super();			
			
			this._filtro = filtro;
			
			content = new _agregarEjercicioPopupSP();
			content._contenedor.addChild(content.mascara);
			content.mascara.alpha = 0.5;
			content.mascara.x = content.mascara.y = 0;
			content.backscroll.x = 0;
			content.removeChild(content.backscroll);
			//content.scrollClip.alpha = 0;
			addChild(content);	
			content._alerta1.visible = false;
			while(content._contenedor.numChildren)content._contenedor.removeChildAt(0);
			while(content._minirutina.numChildren)content._minirutina.removeChildAt(0);
			
			addButton(content.dia_0);
			addButton(content.dia_1);
			addButton(content.dia_2);
			addButton(content.dia_3);
			addButton(content.dia_4);
			addButton(content.dia_5);
			addButton(content.dia_6);
		}
		
		private function addButton(mc:MovieClip):void
		{
			mc.buttonMode = true;
			mc._over.alpha = 0;
			mc.addEventListener(MouseEvent.MOUSE_DOWN,onDia);
			mc.index = mc.name.substr(4,1);
			mc._txt.text = mc.index;
		}		
		
		protected function onDia(event:MouseEvent):void
		{
			if(currentBtnDia){
				currentBtnDia.addEventListener(MouseEvent.MOUSE_DOWN,onDia);
				TweenMax.to(currentBtnDia._over,1,{alpha:0});
			}
			currentBtnDia = event.currentTarget as MovieClip;
			TweenMax.to(currentBtnDia._over,1,{alpha:1});
			currentBtnDia.removeEventListener(MouseEvent.MOUSE_DOWN,onDia);
			_currentDia = currentBtnDia.index;
			content._dia._txt.text = (currentBtnDia.index == 0) ? "Entrada en calor" : "Día " + _currentDia;
			Model.currentDataRutina.sectedDia = _currentDia;
			init();
			if(filtro == 0)renderMiniRutina();//por si no renderea en init
		}
		
		public function showAlarm():void{
			TweenMax.to(content._alerta1,0.3,{x:"20",ease:Back.easeInOut,yoyo:true,repeat:3});
		}
		
		public function setDefaultAs0():void{
			content.dia_0.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));			
			
		}

		public function init():void{
			
			
			//if(filtro == 0)return;///para la primera vez que no tiene un filtro especifico(menu principal)
			if(filtro == 100){
				//show teclado
				VirtualKeyBoardEjercicio.getInstance().init(this);					
				VirtualKeyBoardEjercicio.getInstance().addEventListener(KeyBoardEvent.UPDATE,onUpdateBusqueda);
				if(!ejBusqueda)ejBusqueda = new TextField();
				
				onUpdateBusqueda();
				
				//ejBusqueda.text = "";
				VirtualKeyBoardEjercicio.getInstance().target = { field:ejBusqueda, fieldName:"",keyboardType:KeyBoardTypes.ALPHABETS_LOWER };
				
			}else
			{
				VirtualKeyBoardEjercicio.getInstance().hide();
				filtrar();
				createScroll();
			}
			
			renderMiniRutina();			
			
		}
		
		protected function onUpdateBusqueda(event:Event=null):void
		{
			txt = "Búsqueda: " + ejBusqueda.text;
			currentViews = [];
			if(ejBusqueda.text == ""){
				createScroll();
				return;
			}
			
			for each(var ej:DataEjercicio in Model.templates.data){
				if(buscar(ej.search_nombre)){
					
					for each(var ej2:DataEjercicio in Model.currentDataRutina.ejercicios.dias[_currentDia]){
						var estaAgregado:Boolean=false;
						var isNuevo:Boolean=false;
						if(ej2.sid == ej.sid){
							estaAgregado = true;
							isNuevo = ej2.toSave;
							trace(_currentDia,ej.sid,ej.nombre,ej.grupoMuscular);
							break;
						}
					}
					currentViews.push(ej.defaultView);
					ej.defaultView.render(estaAgregado,isNuevo);
				}
			}
			createScroll();
			
		}
		
		
		private function buscar(name:String):Boolean{
			//trace(name,ejBusqueda.text,name.indexOf(ejBusqueda.text)!= -1);
			return name.indexOf(ejBusqueda.text) != -1;			
		}
		
		private function filtrar():void{
			currentViews = [];
			for each(var ej:DataEjercicio in Model.templates.data){
				if(ej.grupoMuscular == filtro){
					
					for each(var ej2:DataEjercicio in Model.currentDataRutina.ejercicios.dias[_currentDia]){
						var estaAgregado:Boolean=false;
						var isNuevo:Boolean=false;
						if(ej2.sid == ej.sid){
							estaAgregado = true;
							isNuevo = ej2.toSave;
							trace(_currentDia,ej.sid,ej.nombre,ej.grupoMuscular);
							break;
						}
					}
					currentViews.push(ej.defaultView);
					ej.defaultView.render(estaAgregado,isNuevo);
				}
			}
		}
		
		private function createScroll():void
		{
			if(container)content._contenedor.removeChild(container);
			container = DPUtils.getColumnsContainer(currentViews,10,10,5);	
			container.x = 10;
			content._contenedor.addChild(container);
			container.mask = content.mascara;
			
			content.backscroll.height = container.height + 20;
			
			content._contenedor.addChild(content.mascara);
						
			
			if(tapScroll){
				content._contenedor.removeChild(tapScroll);
				tapScroll = null;
			}
			
			if(container.height > content.mascara.height){
				content.backscroll.y = 0;
				tapScroll = new TapScroller(content.backscroll,100,content.mascara.height);	
				tapScroll.addEventListener(TapScroller.UPDATE,onScroll);
				tapScroll.x = 720;//960;
				content._contenedor.addChild(tapScroll);	
			}
			
		}
		
		protected function onScroll(event:Event):void
		{
			container.y = content.backscroll.y;			
		}
		
		public function renderMiniRutina():void
		{
			viewsMiniRutina = [];
			for each(var ej:DataEjercicio in Model.currentDataRutina.ejercicios.dias[_currentDia]){
				viewsMiniRutina.push(getImage(ej));
			}
			if(containerMiniRutina)content._minirutina.removeChild(containerMiniRutina);
			containerMiniRutina = DPUtils.getColumnsContainer(viewsMiniRutina,30,30,2);			
			//containerMiniRutina.scaleX = containerMiniRutina.scaleY = 0.4;
			content._minirutina.addChild(containerMiniRutina);
		}

		private function getImage(data:DataEjercicio):Sprite{
			return GetImage.getLoadingImageWithoutPreloader(Fmwk.appConfig('kiosko')+'images/'+data.sid+'.jpg',null,179,178,0,0.5);
		}
		
		public function updateView():void
		{		
			init();			
		}
		
		public function destroy():void
		{
			// TODO Auto Generated method stub
			
		}
	}
}