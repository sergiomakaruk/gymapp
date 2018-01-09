package app.data.ejercicios
{
	import app.model.Model;
	import app.sections.rutina.ejercicios.AgregarEjercicioView;
	import app.sections.rutina.ejercicios.EjercicioPrint;
	import app.sections.rutina.ejercicios.EjercicioView;
	import app.sections.rutina.ejercicios.EjercicioViewMini;
	import app.sections.rutina.ejercicios.IEjercicioView;
	
	import flash.display.DisplayObject;
	
	import sm.fmwk.Fmwk;
	import sm.fmwk.data.core.Data;
	import sm.utils.display.GetImage;
	import sm.utils.number.NumberUtils;
	
	public class DataEjercicio extends Data
	{
		/*template*/
		public var grupoMuscular:uint;
		public var nombregrupoMuscular:String;		
		public var nombre:String;
		public var search_nombre:String;
		public var video:String;//id de youtube
		
		
		public var semana:uint;
		public var serie:uint;
		public var carga:Number=0;
		public var repeticion:uint;
		public var descanso:uint;
		public var orden:uint;
		public var dia:uint;
		public var superseries:uint;
		
		public var memory:Object;
		public var isTemplate:Boolean = false;
		
		public function DataEjercicio()
		{
			super();			
		}
		
		override public function set sid(str:String):void{
			super.sid = str;
			_image = GetImage.getImage(Fmwk.appConfig('kiosko')+'images/'+sid+'.jpg',null);
		}
		
		public function saveMemory():void{
			memory = {
				semana:semana,
				serie:serie,
				carga:carga,
				repeticion:repeticion,
				descanso:descanso,
				orden:orden,
				dia:dia,
				superseries:superseries
			}
		}
		
		public function reset():void{
			//trace("RESET");
			//trace(orden);
			semana = memory.semana;
			serie = memory.serie;
			carga = memory.carga;
			repeticion = memory.repeticion;
			descanso = memory.descanso;
			orden = memory.orden;
			dia = memory.dia;
			superseries = memory.superseries;
			//trace(orden);
			//trace("--------");
		}
		
		private var _foto:AgregarEjercicioView;		

	

		public function get defaultView():AgregarEjercicioView{
			if(!_foto){
				_foto = new AgregarEjercicioView(this);
			}
			return _foto;
		}
		
		private var _view:EjercicioView;		
		public function get view():EjercicioView{
			if(!_view){
				_view = new EjercicioView(this);
			}
			_currentToOrder = _view;
			return _view;
		}
		
		private var _viewMini:EjercicioViewMini;		
		public function get viewMini():EjercicioViewMini{
			if(!_viewMini){
				_viewMini = new EjercicioViewMini(this);
			}
			_currentToOrder = _viewMini;
			return _viewMini;
		}
		
		private var _currentToOrder:IEjercicioView;		
		public function get currentToOrder():IEjercicioView{			
			return _currentToOrder;
		}
				
		private var _print:EjercicioPrint;		
		public function get print():EjercicioPrint{
			if(!_print){
				_print = new EjercicioPrint(this);
			}
			return _print;
		}
		
	/*	public function get video():String{
			return "";
		}*/
		
		public function get serieToString():String{///pasa serie con ' de minuto para simular unidad de tiempo
			return this.serie + "'";
		}
		
		
		public function get descansoToString():String{			
			
			var $seconds:uint = this.descanso;
			var s:Number = $seconds % 60;
			var m:Number = Math.floor(($seconds % 3600 ) / 60);
			var h:Number = Math.floor($seconds / (60 *60));
			m = m+(h*60);
			
			/*var hourStr:String = (h == 0) ? "" : doubleDigitFormat(h) + ":";
			var minuteStr:String = doubleDigitFormat(m) + ":";
			var secondsStr:String = doubleDigitFormat(s);*/
			
			//var hourStr:String = (h == 0) ? "" : h + ":";
			var minuteStr:String = m + "' ";
			var secondsStr:String = s+"''";
			if(m == 0) return secondsStr;
			else if(s == 0) return minuteStr;
			
			return  minuteStr + secondsStr;		
		}
		
		public function get descansoToOriginal():uint{
			return this.descanso / 60;
		}
		
		public function toString():String{
			return this.sid +"/" + dia +"/" + orden +" - " + semana +" - " + this.nombre;
		}
		
		private var _toSave:Boolean;
		public function get toSave():Boolean{return _toSave;}		
		public function set toSave(value:Boolean):void{_toSave = value;}
		
		public function getEjParamsToSave():Array{
			return [Model.currentDataRutina.sid,this.sid,this.semana,this.serie,this.repeticion,this.carga,this.descanso,this.orden,this.dia,this.superseries];
		}
	}
}