package app.sections.rutina.ejercicios
{
	import app.components.button.AppButton;
	import app.components.button.AppButton_2;
	import app.data.ejercicios.DataEjercicio;
	import app.events.AppEvents;
	import app.model.Model;
	import app.sections.rutina.Rutina;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	
	import sm.fmwk.Fmwk;
	import sm.fmwk.ui.button.Button;
	import sm.utils.display.DPUtils;
	import sm.utils.display.GetButton;
	import sm.utils.display.GetImage;
	import sm.utils.events.CustomEvent;
	
	public class EjercicioView extends AbsEjercicioView
	{		
		private var image:DisplayObject;

		private var content:_ejercicioSP;

		private var _menuCreated:Boolean;		

		private var btFoto:Button;

		private var edit:Button;

		private var eliminar:Button;

		private var clickPoint:Point;
		private var fotoPoint:Point = new Point(8,33);
		private var _showEditionState:Boolean;
				
		override public function get thehitarea():DisplayObject{
			return content._hitAreaDrag;
		}
		

		public function EjercicioView(data:DataEjercicio)
		{
			this._data = data;
			super();
			content = new _ejercicioSP();			
			addChild(content);
			
			content._nombre.text = 	getName();	
			content._hitAreaDrag.alpha = 0;
			content._menu.visible = false;
			content._backDragMode.mouseChildren = false;
			content._backDragMode.alpha = 0;
			content._backDragMode.visible = false;
						
			content._dia.visible = false;
			
									
			//image = DPUtils.swap(GetImage.getImage(Fmwk.appConfig('kiosko')+'images/8.jpg',onFoto),content._foto);
			//image = DPUtils.swap(GetImage.getImage(Fmwk.appConfig('kiosko')+'images/'+data.sid+'.jpg',onFoto),content._foto); 	
			onFoto();
			renderValues();
		}
						
		private function getName():String{
			return _data.nombre;
			return _data.nombre + "/"+this._data.sid+"/"+this._data.dia+"/"+this._data.orden ;	
		}
		
		public function updateView():void{
			renderValues();
		}

		public function destroy():void{
			if(eliminar)eliminar.destroy();
			if(edit)edit.destroy();
			if(btFoto)btFoto.destroy();
			if(this.parent)this.parent.removeChild(this);
		}

		public function renderValues():void
		{
			content._nombre.text = 	getName();		

			content._serie.text = data.serie.toString();
			content._carga.text = data.carga.toString();
			content._repeticion.text = data.repeticion.toString();
			content._descanso.text = data.descansoToString;	
			
			if(this._data.grupoMuscular == 8){
				content._var1.text = "Tiempo";	
				content._var2.text = "Velocidad";	
				content._var3.text = "Inclinación";
				content._var4.text = "Nivel";
				content._serie.text = data.serieToString;	
				content._descanso.text = data.descansoToOriginal.toString();	
			}
			
			
			
			content._dia._dia.text = "Día: " + data.dia.toString();
			
			content._superseries._triangulo.visible = false;
			content._superseries._equis.visible = false;
			content._superseries._cuadrado.visible = false;
			content._superseries._circulo.visible = false;
			
			var clip:DisplayObject;
			switch(data.superseries){
				case 1:clip = content._superseries._triangulo;break;
				case 2:clip = content._superseries._equis;break;
				case 3:clip = content._superseries._cuadrado;break;
				case 4:clip = content._superseries._circulo;break;
				default: clip = null;
			}
			if(clip)clip.visible = true;
			
		}
		
		private function onFoto():void
		{
			content._foto.addChild(data.image);
			btFoto = GetButton.pressButton(content._foto,onClick,AppButton_2);
			btFoto.unlockeable = true;	
			btFoto.autoDestroy = false;
		}
		
		private function onClick():void
		{
			trace("Show Video: ","pathvideo");
			dispatchEvent(new CustomEvent(AppEvents.SHOW_VIDEO,data));
			
		}
		
		public function renderAsDiaEdition():void{
			_showEditionState = true;
			content._dia.visible = true;		
			content._dia.y = 65;
			//content._dia.y = 483;
			content._dia._btnOk.addEventListener(MouseEvent.CLICK,onDiaClick);
		}
		
		public function renderAsEditOrder():void{
			_showEditionState = false;
			//para que actualice
			content._backDragMode.mouseChildren = false;
			content._backDragMode.alpha = 0;
			content._backDragMode.visible = false;
			content._hitAreaDrag.alpha = 0;
			
			//stage.invalidate();
			
			
			btFoto.unlockeable = false;
			btFoto.lock();
			
			TweenMax.to(content._backDragMode,0.3,{autoAlpha:1});
			content._backDragMode.removeEventListener(MouseEvent.MOUSE_DOWN,onDownDrag);
			content._backDragMode.addEventListener(MouseEvent.MOUSE_DOWN,onDownDrag);
			content._backDragMode.buttonMode = true;
		}		
		
		/*public function get realheight():uint{
			if(content.currentFrame == 2) return 100;
			
			return 218;
		}*/
		
		override public function get height():Number{
			if(_showEditionState) return 290;
			return 218;
		}
		
		protected function onDownDrag(event:MouseEvent):void
		{
			clickPoint = new Point(event.localX,event.localY);
			this.parent.addChild(this);
			Model.currentDataRutina.orderManager.addTarget(this.data);
			TweenMax.to(content._backDragMode._dragIcon,0.3,{tint:0xCCFF00,repeat:-1,yoyo:true,ease:Expo.easeInOut});
			stage.addEventListener(MouseEvent.MOUSE_MOVE,onDragMouseMove);
			stage.addEventListener(Event.ENTER_FRAME,onUpdateOrder);
			stage.addEventListener(MouseEvent.MOUSE_UP,onDragEnd);			
		}
		
		protected function onUpdateOrder(event:Event):void
		{			
			Model.currentDataRutina.orderManager.update();
			//this.dispatchEvent(new Event(AppEvents.ORDEN_UPDATE));			
		}
		
		protected function onDragEnd(event:MouseEvent):void
		{
			TweenMax.killTweensOf(content._backDragMode._dragIcon);
			TweenMax.to(content._backDragMode._dragIcon,0.1,{tint:0xFFFFFF});
			stage.removeEventListener(MouseEvent.MOUSE_MOVE,onDragMouseMove);
			stage.removeEventListener(Event.ENTER_FRAME,onUpdateOrder);
			stage.removeEventListener(MouseEvent.MOUSE_UP,onDragEnd);
			Model.currentDataRutina.orderManager.animatetarget();
			Model.currentDataRutina.orderManager.reset();
		}
		
		protected function onDragMouseMove(event:MouseEvent):void
		{
			//var pos:Point = globalToLocal(new Point(this.parent.x,this.parent.y));
			var pos:Point = this.parent.globalToLocal(new Point(event.stageX,event.stageY));
			pos.x = pos.x - clickPoint.x;
			pos.y = pos.y - clickPoint.y;
			//this.x = pos.x;
			//this.y = pos.y;
			var responsiveness:Number = 0.25;
			this.x += responsiveness*(pos.x - this.x);
			this.y += responsiveness*(pos.y - this.y);			
		}
		
		protected function onDiaClick(event:MouseEvent):void
		{
			this.data.dia = Model.currentDataRutina.sectedDia;
			this.data.toSave = true;
			this.renderValues();						
		}
		
		public function renderAsEdition():void
		{
			_showEditionState = true;
			content._menu.visible = true;
			content._menu.y = 65;			
					
			if(!_menuCreated){
				_menuCreated = true;
				
				eliminar = GetButton.pressButton(content._menu._btnEliminar,onEliminar,AppButton);
				eliminar.autoDestroy = false;
				eliminar.delayTime = 2000;
				
				content._menu._btnGuardar.visible = false;
			
				edit = GetButton.pressButton(content._menu._btnEditar,onEditar,AppButton);
				edit.autoDestroy = false;
				edit.delayTime = 2000;
				
			}
		}		
		
		
		public function renderAsDefault():void
		{	
			_showEditionState = false;
			content._menu.visible = false;			
			content._dia.visible = false;
			content._menu.y = 0;
			content._dia.y = 0;
			
			content._dia._btnOk.removeEventListener(MouseEvent.CLICK,onDiaClick);
			
			content._foto.addChild(data.image);
			if(btFoto){
				btFoto.unlock();
				btFoto.unlockeable = true;
			}
			
			content._hitAreaDrag.alpha = 0;
			TweenMax.to(content._backDragMode,0.3,{autoAlpha:0});
			content._backDragMode.removeEventListener(MouseEvent.MOUSE_DOWN,onDownDrag);
			content._backDragMode.buttonMode = false;
			
			renderValues();
		}		
		
		
		private function onEliminar():void
		{
			this.dispatchEvent(new CustomEvent(AppEvents.EDITAR_RUTINA_MAIN_EVENT,{action:AppEvents.ELIMINAR_EJERCICIO_DE_RUTINA_EVENT}));			
		}

		private function onEditar():void
		{
			this.dispatchEvent(new CustomEvent(AppEvents.EDITAR_RUTINA_MAIN_EVENT,{action:AppEvents.EDITAR_ESTE_EJERCICIO_EVENT}));	
		}
		
		
	}
}