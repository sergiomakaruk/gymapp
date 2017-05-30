package app.data.rutinas
{
	import app.commands.GetSetRutinaCommand;
	import app.datatransferences.DataTransferenceTypes;
	
	import sm.fmwk.data.core.Data;

	public class DataIdRutinaBase extends Data
	{
		/*tipo: (1:fuerza / 2:volumen / 3:potencia / 4:resistencia)			
		dias:(1: 1 dias / 2: 2 dias, etc etc)			
		opcion:(1: opcion1, 2:opcion2, etc etc).*/
		
		public var genero:uint;
		public var level:uint;
		public var tipo:uint;//potencia, resistencia, etc
		public var dias:uint;
		public var opcion:uint;
		private var _nombreOpcion:String;
		
		

		public function get nombre():String{
			if(_nombreOpcion == null) return "Opción " + opcion;
			return _nombreOpcion;
		}
		public function set nombre(str:String):void{
			_exist = false;
			_nombreOpcion = str;
		}
		private var _exist:Boolean;
		public function get exist():Boolean{
			return _exist;
		}
	
		private var _action:String;
		public function get action():String
		{
			return _action;
		}
		public function set exist(value:Boolean):void
		{
			_exist = value;
		}

		public var cb:Function;//callback
		
		
		
		public function DataIdRutinaBase()
		{
			//cada vez que le ponemos el verdadero nombre, hay que rectificar que la rutina existe. BETAs
		}
		
		public function setActionToTemplate():void{
			_action = GetSetRutinaCommand.GET_TEMPLATE;
		}
		
		public function defineAction():void{
			if(level>0) _action =  GetSetRutinaCommand.GET_RUTINA_BASE;
			else _action = GetSetRutinaCommand.GET_RUTINA_BASE_2;
		}
		
		public function isNewTipeComplex():Boolean{
			return level == 0;
		}
		
		public function getStringID():String{
			if(isNewTipeComplex()) return '0'+ String(genero) + String(tipo) + String(dias) + String(opcion);
			else return String(level) + String(genero);	
		}
		
		public function defineCreationAction():String{
			if(level == 0) return DataTransferenceTypes.CREAR_RUTINA_DEFAULT_2;
			else return DataTransferenceTypes.CREAR_RUTINA_DEFAULT;
		}
		
		public function defineCreationParams():Array{
			if(level == 0) return [1,0,genero,tipo,dias,opcion];
			else return [1,level,genero];
		}
		
		public function defineCreationTemplateAction():String
		{
			if(level == 0) return DataTransferenceTypes.RECUPERAR_RUTINA_BASE_PARA_TEMPLATE_2;
			else return DataTransferenceTypes.RECUPERAR_RUTINA_BASE_PARA_TEMPLATE;
		}
		
		public function toString():String{
			return genero + " - " + tipo + " - " + dias + " - " +opcion+ " - " +nombre;
		}
		
		public function getTipoStr():String
		{
			var str:String = "";
			switch(tipo){
				case 1:str='Fuerza';break;
				case 2:str='Volumen';break;
				case 3:str='Potencia';break;
				case 4:str='Resistencia';break;			
			}
			return str;
		}
		
		public function getGeneroStr():String
		{
			if(genero == 1) return "Hombre";
			else return "Mujer";
		}
	}
}