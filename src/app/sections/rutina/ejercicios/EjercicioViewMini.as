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
	
	public class EjercicioViewMini extends AbsEjercicioView
	{		
		private var content:_ejercicioSPMini;
		private var clickPoint:Point;

				
		override public function get thehitarea():DisplayObject{
			return content._hitAreaDrag;
		}
		

		public function EjercicioViewMini(data:DataEjercicio)
		{
			this._data = data;
			super();
			content = new _ejercicioSPMini();			
			addChild(content);
			
			content._nombre.text = 	getName();	
			
			content._backDragMode.mouseChildren = false;
			//content._backDragMode.alpha = 0;
			//content._backDragMode.visible = false;
			content._hitAreaDrag.alpha = 0;
			
			content._foto.addChild(data.image);		
			
			content._backDragMode.removeEventListener(MouseEvent.MOUSE_DOWN,onDownDrag);
			content._backDragMode.addEventListener(MouseEvent.MOUSE_DOWN,onDownDrag);
			content._backDragMode.buttonMode = true;
			
			this.addEventListener(Event.ADDED,onAdded);
		}
		
		protected function onAdded(event:Event):void
		{
			content._foto.addChild(data.image);				
		}
		
		private function getName():String{
			return _data.nombre;			
		}

		public function destroy():void{		
			if(this.parent)this.parent.removeChild(this);
			this.removeEventListener(Event.ADDED,onAdded);
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
		
	}
}