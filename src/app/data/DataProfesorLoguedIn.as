package app.data
{
	
	import app.data.rutinas.DataMenuRutinaBase;
	import app.data.rutinas.DataRutina;
	import app.data.usuarios.DataStatics;
	import app.model.Model;
	
	import sm.fmwk.data.core.Data;
	import sm.utils.number.NumberUtils;
	
	public class DataProfesorLoguedIn extends Data
	{
		
		public var nombre:String;
		public var token:String = "";
		
		private var _rutina:DataRutina;
		public var statics:DataStatics;
		
		private var _menuRutinaBase:DataMenuRutinaBase;
		public function get menuRutinaBase():DataMenuRutinaBase{
			if(!_menuRutinaBase)_menuRutinaBase = new DataMenuRutinaBase();
			return _menuRutinaBase;
		}
		
		
		public function get rutinaBase():DataRutina
		{
			if(!_rutina)_rutina = new DataRutina();
			return _rutina;
		}
		
		public function DataProfesorLoguedIn()
		{
			super();
		}
		
		public function get logued():Boolean{
			return token != "";
		}
		
		
		public function parseData(obj:Object,codigo:String):void{
			var xml:XML = obj as XML;
			
			this.sid = String(NumberUtils.zeroinFirst(uint(codigo),3));
			this.token = xml..*::token;
			this.nombre = xml..*::nombre;
			trace("TOKEN: ",token," - NOMBRE: ",nombre);
			
			this.statics = Model.users.getUSersByProfe(this.token);
		}
		
		public function datajson():Object{
			if(!logued) return null;
			var obj:Object = {};			
			obj.nombre = nombre;
			obj.token = token;		
			
			return obj;
		}
		
		
	}
}