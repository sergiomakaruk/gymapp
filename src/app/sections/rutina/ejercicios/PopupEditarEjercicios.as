package app.sections.rutina.ejercicios
{
	import app.components.button.AppButton;
	import app.components.button.ScaleUpButton;
	import app.data.ejercicios.DataEjercicio;
	import app.events.AppEvents;
	import app.model.Model;
	
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import org.osmf.events.TimeEvent;
	
	import sm.fmwk.Fmwk;
	import sm.fmwk.ui.button.Button;
	import sm.fmwk.ui.button.events.ButtonEvent;
	import sm.fmwk.ui.custombutton.ScaleButton;
	import sm.utils.animation.Timeline;
	import sm.utils.display.DPUtils;
	import sm.utils.display.GetButton;
	import sm.utils.display.GetDrawedObjects;
	import sm.utils.display.GetImage;
	import sm.utils.events.CustomEvent;
	
	public class PopupEditarEjercicios extends Sprite
	{
		private var data:DataEjercicio;

		private var timeline:Timeline;

		private var content:_ejercicioSP_editar;
		private var _stage:Stage;
		private var timerValues:Timer;		
		private var currentVar:String;

		private var image:DisplayObject;
		private var hideButtons:Boolean;

		private var _isSegundos:Boolean;
		private var triangulo:ScaleUpButton;
		private var equis:ScaleUpButton;
		private var cuadrado:ScaleUpButton;
		private var circulo:ScaleUpButton;
		private var borrar:ScaleUpButton;
		private var currentSuperseriesButton:ScaleUpButton;
		
		
		public function PopupEditarEjercicios(data:DataEjercicio,hideButtons:Boolean)
		{
			super();
			
			this.data = data;
			this.hideButtons = hideButtons;
		}
		
		/*public function set isSegundos(value:Boolean):void
		{
			_isSegundos = value;
			if(!_isSegundos)content._chSegundos._ch.gotoAndStop(0);
			else content._chSegundos._ch.play();
			
			this.data.descanso = this.data.descanso.split("'")[0] + getMinutesOrSeconds();
			renderValues();	
		}*/

		public function init():void
		{
			var shape:Shape = GetDrawedObjects.getShape(stage.stageWidth,stage.stageHeight,0,0.9);
			addChild(shape);
			
			content = new _ejercicioSP_editar();
			addChild(content);
			content.x = (stage.stageWidth) * .5;
			content.y = (stage.stageHeight) * .5;
			
			content._nombre.text = 	getName();	
			
			addBtn(content._btnCancel,onCancel);
			addBtn(content._btnOk,onOk);
			addBtn(content._btnNext,onDataReload);
			addBtn(content._btnPrev,onDataReload);
			
			content._btnNext.visible = !this.hideButtons;
			content._btnPrev.visible = !this.hideButtons;
			
			content._serie_.value = data.serie;
			content._carga_.value = data.carga;
			content._repeticion_.value = data.repeticion;
			content._descanso_.value = data.descanso;
			
			triangulo = GetButton.clickButton(content.superseries.btnTriangulo,onSuperseriesTriangulo,ScaleUpButton) as ScaleUpButton;
			equis = GetButton.clickButton(content.superseries.btnEquis,onSuperseriesEquis,ScaleUpButton) as ScaleUpButton;
			cuadrado = GetButton.clickButton(content.superseries.btnCuadrado,onSuperseriesCuadrado,ScaleUpButton) as ScaleUpButton;
			circulo = GetButton.clickButton(content.superseries.btnCirculo,onSuperseriesCirculo,ScaleUpButton) as ScaleUpButton;
			borrar = GetButton.clickButton(content.superseries.btnEliminar,onSuperseriesEliminar,ScaleUpButton) as ScaleUpButton;
			triangulo.toScale = equis.toScale = cuadrado.toScale =  circulo.toScale = borrar.toScale = 1.4;
			borrar.unlockeable = true;
			triangulo.autoDestroy = equis.autoDestroy = cuadrado.autoDestroy =  circulo.autoDestroy = borrar.autoDestroy = false;
			
			/*content._descanso_.value = Number(data.descanso.split("'")[0]);
			isSegundos = data.descanso.indexOf("''") != -1;*/
			
			content._serie_.init("Serie");
			content._carga_.init("carga");
			content._repeticion_.init("Repetición");
			content._descanso_.init("Descanso");
			
			this.addEventListener(AppEvents.UPDATE_VALUES_EVENT,onUpdate);
			
			//GetButton.pressButton(content._chSegundos,onSegundos).unlockeable = true;
			
			image = DPUtils.swap(GetImage.getImage(Fmwk.appConfig('kiosko')+'images/'+data.sid+'.jpg',null),content._foto); 
			
			timeline = new Timeline(null,onReverse,Timeline.EXPO);
			timeline.from(shape,{alpha:0});
			timeline.from(content,{scaleX:0,scaleY:0});
			timeline.play();			
			
			renderValues();			
		}
		
		private function onSuperseriesEliminar():void
		{
			if(currentSuperseriesButton)currentSuperseriesButton.active = true;		
			currentSuperseriesButton = null;
			data.superseries = 0;			
		}
		
		private function onSuperseriesCirculo():void
		{
			if(currentSuperseriesButton)currentSuperseriesButton.active = true;				
			currentSuperseriesButton = circulo;
			currentSuperseriesButton.active = false;
			data.superseries = 4;
		}
		
		private function onSuperseriesCuadrado():void
		{
			if(currentSuperseriesButton)currentSuperseriesButton.active = true;				
			currentSuperseriesButton = cuadrado;
			currentSuperseriesButton.active = false;	
			data.superseries = 3;
		}
		
		private function onSuperseriesEquis():void
		{
			if(currentSuperseriesButton)currentSuperseriesButton.active = true;				
			currentSuperseriesButton = equis;
			currentSuperseriesButton.active = false;
			data.superseries = 2;
		}
		
		private function onSuperseriesTriangulo():void
		{
			if(currentSuperseriesButton)currentSuperseriesButton.active = true;				
			currentSuperseriesButton = triangulo;
			currentSuperseriesButton.active = false;	
			data.superseries = 1;
		}
		
		/*protected function onSegundos():void
		{
			isSegundos = !_isSegundos;			
		}*/
		
		private function onDataReload(e:MouseEvent):void
		{
			if(e.currentTarget.name == "_btnPrev")this.setData(Model.currentDataRutina.ejercicios.getPrev(this.data),false);
			else this.setData(Model.currentDataRutina.ejercicios.getNext(this.data),false);
		}
		
		private function addBtn(face:MovieClip,handler:Function):void{
			face.buttonMode = true;
			face.addEventListener(MouseEvent.MOUSE_DOWN,handler);
		}
		
		public function setData(data:DataEjercicio,hideButtons:Boolean):void{
			if(data === null){
				onOk();
				return;///"grabo" los datos y cierro el popup
			}
			
			content._btnNext.visible = !hideButtons;
			content._btnPrev.visible = !hideButtons;
			
			this.data.toSave = true;
			this.data.view.renderValues();///"grabo" los datos y muestro otro valor
			
			this.data = data;
			image = DPUtils.swap(GetImage.getImage(Fmwk.appConfig('kiosko')+'images/'+data.sid+'.jpg',null),image); 
			
			content._serie_.value = data.serie;
			content._carga_.value = data.carga;
			content._repeticion_.value = data.repeticion;
			content._descanso_.value = data.descanso;
			
			//content._descanso_.value =  Number(data.descanso.split("'")[0]);
			
			content._nombre.text = 	getName();	
			
			renderValues();	
			timeline.play();
		}
		
		protected function onUpdate(event:CustomEvent):void
		{
			this.data.toSave = true;
			//trace("updateValues(): ",currentVar);
			switch(event.target.name){
				case '_serie_':this.data.serie = uint(event.params);break;
				case '_carga_':this.data.carga = Number(event.params);break;
				case '_descanso_':this.data.descanso = uint(event.params);break;
				case '_repeticion_':this.data.repeticion = uint(event.params);break;
			}
			renderValues();
			
		}
		
		private function getMinutesOrSeconds():String{
			return "";
			if(_isSegundos) return "''";
			return "'";
		}
		
		public function renderValues():void
		{
			content._serie.text = data.serie.toString();
			content._carga.text = data.carga.toString();
			content._repeticion.text = data.repeticion.toString();
			content._descanso.text = data.descansoToString;
	
			var clip:ScaleUpButton;
			switch(data.superseries)
			{
				case 1: clip = triangulo;break;
				case 2: clip = equis;break;
				case 3: clip = cuadrado;break;
				case 4: clip = circulo;break;
				default: clip = null;break;
			}


			if(currentSuperseriesButton)currentSuperseriesButton.active = true;				
			
			currentSuperseriesButton = clip;
			if(currentSuperseriesButton)currentSuperseriesButton.active = false;
			
			
			//content._dia.text = "Día: " + data.dia.toString();
			//content._nombre.text = 	getName();	
		}
		
		public function destroy():void{
						
		}
		
		private function onOk(e:Event=null):void
		{
			this.data.toSave = true;
			this.data.view.renderValues();
			//this.dispatchEvent(new CustomEvent(AppEvents.EDITAR_RUTINA_MAIN_EVENT,{action:AppEvents.U}));
			timeline.reverse();			
		}
		
		private function onReverse():void
		{
			destroy();
			stage.removeChild(this);			
		}
		
		private function onCancel(e:Event):void
		{
			data.reset();
			timeline.reverse();
		}
		
		private function getName():String{
			return data.nombre;// + "/"+this.data.sid+"/"+this.data.dia+"/"+this.data.orden ;	
		}	
		
		
	}
}