package app.model
{
	import app.data.DataKiosco;
	import app.data.DataProfesorLoguedIn;
	import app.data.DataSocio;
	import app.data.ejercicios.ManagerEjercicios;
	import app.data.ejercicios.ManagerTemplates;
	import app.data.rutinas.DataRutina;
	import app.data.rutinas.ManagerRutinas;
	import app.data.usuarios.ManagerUsers;
	import app.sections.staticsProfe.WSAssetManager;
	
	import sm.fmwk.data.core.Data;
	
	public class Model
	{	
		public static var app:uint;//ID
		public static var datakiosco:DataKiosco = new DataKiosco();
		
		public static var promos:Array = [];
		public static var promosToGallery:Array = [];
		
		public static var observaciones:Array;
		public static var objetivos:Array;
		
		public static var wsassets:WSAssetManager = new WSAssetManager();
		
		private static var _users:ManagerUsers;
		public static function get users():ManagerUsers
		{
			if(!_users)_users = new ManagerUsers();
			return _users;
		}
		
		private static var _ejerciciosTemplate:ManagerTemplates;
		public static function get templates():ManagerTemplates
		{
			if(!_ejerciciosTemplate)_ejerciciosTemplate = new ManagerTemplates();
			return _ejerciciosTemplate;
		}
				
		private static var _profe:DataProfesorLoguedIn;
		public static function get profe():DataProfesorLoguedIn
		{
			if(!_profe)_profe = new DataProfesorLoguedIn();
			return _profe;
		}
		
		private static var _socio:DataSocio;
		public static function get socio():DataSocio
		{
			if(!_socio)_socio = new DataSocio();
			return _socio;
		}
		
		private static var _currentDataRutina:DataRutina;
		public static var update:Boolean = false;
		
		public static function get currentDataRutina():DataRutina
		{			
			return _currentDataRutina;
		}
		public static function set currentDataRutina(value:DataRutina):void
		{
			_currentDataRutina = value;
		}
		
		
		public static function cleanSocio():void
		{
			_socio = new DataSocio();
			Model.currentDataRutina = null;
		}

		public static function clean():void
		{
			_socio = new DataSocio();
			_profe = new DataProfesorLoguedIn();
			Model.currentDataRutina = null;
		}
		
		public static function crearRutina():void
		{
			var newData:DataRutina = new DataRutina();
			
			newData.fechaInicio  = new Date(); 
			newData.fechaInicio.month = newData.fechaInicio.month;
			newData.fechaRenovacion  = new Date();
			newData.fechaRenovacion.month = newData.fechaRenovacion.month + 1;
			newData.profesor = Model.profe.nombre;
			newData.objetivos = "";
			newData.observaciones = "";
			newData.sid = "NUEVA";
			newData.madeFromTemplate = true;
			Model.socio.rutinas.data.unshift(newData);
			Model.socio.rutinas.populateRutina(new XML(),"NUEVA");
			//newData.populate(new XML());
			//
			Model.currentDataRutina = newData;
		}
		
		public static function copyRutina(dataRutina:DataRutina):void
		{
			var newData:DataRutina = new DataRutina();
			
			newData.fechaInicio  = new Date(); 
			newData.fechaInicio.month = newData.fechaInicio.month ;
			newData.fechaRenovacion  = new Date();
			newData.fechaRenovacion.month = newData.fechaRenovacion.month + 1;
			newData.profesor = Model.profe.nombre;
			newData.objetivos = dataRutina.objetivos;
			newData.observaciones = dataRutina.observaciones;
			newData.sid = "NUEVA";
			newData.madeFromCopy = true;
			Model.socio.rutinas.data.unshift(newData);
			Model.socio.rutinas.populateRutina(new XML(),"NUEVA");
			//newData.populate(new XML());
			//
			Model.currentDataRutina = newData;
		}
	}
}