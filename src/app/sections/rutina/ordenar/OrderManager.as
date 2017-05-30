package app.sections.rutina.ordenar
{
	import app.data.ejercicios.DataEjercicio;
	import app.model.Model;
	import app.sections.rutina.ejercicios.EjercicioView;
	import app.sections.rutina.ejercicios.IEjercicioView;
	
	import com.greensock.easing.Expo;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import sm.utils.animation.Timeline;
	import sm.utils.display.DPUtils;

	public class OrderManager
	{
		private var _currentDia:uint = 0;
		private var target:DataEjercicio;
		private var toNointeract:String;

		private var animating:Boolean;

		private var timer:Timer;
		private var secureId:String;
		private var securetimer:Boolean;

		private var timersecurity:Timer;
		
		public function OrderManager()
		{
		}
		
		public function set currentDia(value:uint):void
		{
			_currentDia = value;
		}

		public function addTarget(ej:DataEjercicio):void{
			target = ej;
			var orden:uint=1;
			resetTimer(true);
			for each(var ejd:DataEjercicio in Model.currentDataRutina.ejercicios.dias[_currentDia]){
				ejd.orden = orden++;
				//ejd.view.updateView();
			}
		}
		
		public function update():void{
			
			if(animating)return;
			//if(!securetimer)return;
			
			for each(var ej:DataEjercicio in Model.currentDataRutina.ejercicios.dias[_currentDia]){
				if(target.sid != ej.sid && ej.sid != toNointeract && target.currentToOrder.thehitarea.hitTestObject(ej.currentToOrder.thehitarea)){
					if(secureId && securetimer){
						
						toNointeract = ej.sid;
						resetTimer();
						trace("hitTest from: ",target.orden," to: ",ej.orden);
						var toOrden:uint = ej.orden;
						if(target.orden < toOrden) orderAsBack(ej);
						else orderAsNext(ej);
						secureId = null;
						securetimer = false;
					}else if(secureId == null || secureId != ej.sid){
						securetimer = false;
						if(timersecurity){
							timersecurity.stop();
							timersecurity.removeEventListener(TimerEvent.TIMER,ontimersecurity);
						}
						timersecurity = new Timer(300,1);
						timersecurity.addEventListener(TimerEvent.TIMER,ontimersecurity);
						timersecurity.start();
						secureId = ej.sid;
						return;
					}	
					
					
				}
			}
		}
		
		protected function ontimersecurity(event:TimerEvent):void
		{
			securetimer = true;
		}
		
		private function resetTimer(onlyReset:Boolean=false):void
		{
			if(timer){
				timer.stop();
				timer.removeEventListener(TimerEvent.TIMER,onResetNoInteraction);
				onResetNoInteraction();
			}
			
			if(!onlyReset){
				timer = new Timer(2000,1);
				timer.addEventListener(TimerEvent.TIMER,onResetNoInteraction);
				timer.start();	
			}					
		}
		
		public function reset():void{
			securetimer = false;
			secureId = null;
		}
		
		private function onResetNoInteraction(e:Event=null):void
		{
			toNointeract = "";			
		}
		
		private function orderAsNext(ej:DataEjercicio):void
		{
			trace('orderAsNext target:',target.sid," to: ",ej.sid);
			var to:uint = ej.orden;
			var actue:Boolean = false;
			for each(var ejd:DataEjercicio in Model.currentDataRutina.ejercicios.dias[_currentDia]){
				if(ejd.sid == ej.sid){
					actue = true;					
				}
				
				 if(actue && ejd.orden < target.orden){
					 ejd.orden++;
					 ejd.toSave = true;
					// ejd.view.updateView();
				 }
			}
			target.orden = to;
			target.toSave = true;
			animate();
		}
		
		private function orderAsBack(ej:DataEjercicio):void
		{		
			trace('orderAsBack target:',target.sid," to: ",ej.sid);
			target.orden = ej.orden;
			target.toSave = true;			
			//target.view.updateView();
			var actue:Boolean;
			for each(var ejd:DataEjercicio in Model.currentDataRutina.ejercicios.dias[_currentDia]){
				
				if(ejd.sid == target.sid)actue = true;
				else if(actue){
					ejd.orden--;
					ejd.toSave = true;
					//ejd.view.updateView();
				}
				
				if(ejd.sid == ej.sid){
					//ejd.orden--;
					//ejd.view.updateView();
					animate();
					return;					
				}				
				
			}			
		}
		
		public function animatetarget():void{
			animating = true;
			var timeline:Timeline = new Timeline(onAnimationComplete,null,Timeline.EXPO);
			//Model.currentDataRutina.ejercicios.ordenar();
			var x:Number;
			var y:Number;
			var columns:uint = 2;
			var margenX:uint = 20;
			var margenY:uint = 20;
			var n:uint;
			var rows:uint;
			for each(var ejd:DataEjercicio in Model.currentDataRutina.ejercicios.dias[_currentDia]){
				x = (ejd.currentToOrder.width + margenX ) * n;
				y = (ejd.currentToOrder.height + margenY ) * rows;				
				n++;
				if(n == columns)
				{
					n=0;
					rows++;
				}
				if(ejd.sid == target.sid)timeline.to(DisplayObject(ejd.currentToOrder),{x:x,y:y});				
			}
			timeline.play();
		}
		
		private function animate():void
		{
			animating = true;
			var timeline:Timeline = new Timeline(onAnimationComplete,null);
			Model.currentDataRutina.ejercicios.ordenar();
			var x:Number;
			var y:Number;
			var columns:uint = 2;
			var margenX:uint = 20;
			var margenY:uint = 20;
			var n:uint;
			var rows:uint;
			for each(var ejd:DataEjercicio in Model.currentDataRutina.ejercicios.dias[_currentDia]){
				x = (ejd.currentToOrder.width + margenX ) * n;
				y = (ejd.currentToOrder.height + margenY ) * rows;				
				n++;
				if(n == columns)
				{
					n=0;
					rows++;
				}
				if(ejd.sid != target.sid && ( ejd.currentToOrder.x !=x || ejd.currentToOrder.y != y))timeline.to(DisplayObject(ejd.currentToOrder),{x:x,y:y,ease:Expo.easeOut,delay:-0.2});				
			}
			timeline.play();
		}
		
		private function onAnimationComplete():void
		{
			animating = false;			
		}
		
	}
}