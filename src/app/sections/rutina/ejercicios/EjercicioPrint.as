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
	
	public class EjercicioPrint extends AbsEjercicioView
	{		
		private var image:DisplayObject;
		private var content:_ejercicioPRINT;

		public function EjercicioPrint(data:DataEjercicio)
		{
			this._data = data;
			super();
			content = new _ejercicioPRINT();			
			addChild(content);
						
			//image = DPUtils.swap(GetImage.getImage(Fmwk.appConfig('kiosko')+'images/'+data.sid+'.jpg',null),content._foto); 			
			renderValues();
			
			this.addEventListener(Event.ADDED,onAdded);
		}
		
		protected function onAdded(event:Event):void
		{
			content._foto.addChild(data.image);			
		}
		
		private function getName():String{
			return _data.nombre;
			return _data.nombre + "/"+this._data.sid+"/"+this._data.dia+"/"+this._data.orden ;	
		}
		

		public function destroy():void{
			
		}

		public function renderValues():void
		{
			content._serie.text = data.serie.toString();
			content._carga.text = data.carga.toString();
			content._repeticion.text = data.repeticion.toString();
			content._descanso.text = data.descansoToString;	
			
			content._nombre.text = 	getName();	
			
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
			
		}

		
	}
}