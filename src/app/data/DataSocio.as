package app.data
{
	import app.data.rutinas.ManagerRutinas;
	
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	import sm.fmwk.data.core.Data;
	import sm.utils.bytearray.GetByteArray;
	import sm.utils.display.GetImage;
	
	public class DataSocio extends Data
	{
		public var nombre:String;
		public var apellido:String;
		public var idSocio:String="";
		public var numero:String;
		public var email:String;
		public var dni:String;
		public var sexo:uint = 1;
		public var hasPlanEntrenamiento:Boolean = false;
		
		private var _rutinas:ManagerRutinas;
		public var foto:Sprite;
		public var hasFoto:Boolean = false;
		
		public function get rutinas():ManagerRutinas
		{
			if(!_rutinas)_rutinas = new ManagerRutinas();
			return _rutinas;
		}
				
		public function DataSocio()
		{
			super();
		}
		
		public function get exists():Boolean{
			return idSocio != "";
		}
		
		public function parsePhoto(data:XML):void{
			//trace('parsePhoto',data..*::foto);
			this.foto = new Sprite();
			var str:String = data..*::foto;
			if(str && str.length){
				this.hasFoto = true;
				var ba:ByteArray = GetByteArray.getByteArray(data..*::foto);
				this.foto.addChild(GetImage.getImageFromBytes(ba,null));
			}
			
			//
		}
		
		
		public function parseData(obj:Object,dni:String):void{
			var xml:XML = obj as XML;
			this.dni = dni;
			
			/*
			<id_socio>737869762954824940</id_socio>
			<nombre>Sergio</nombre>
			<apellido>Makaruk</apellido>
			<numero>8650</numero>
			<email>sergiomakaruk@gmail.com</email>
			*/
			
			this.nombre = xml..*::nombre;
			this.apellido = xml..*::apellido;
			this.numero = xml..*::numero;
			this.email = xml..*::email;
			this.idSocio = xml..*::id_socio;
			this.hasPlanEntrenamiento = true;
			
			trace("NOMBRE: ",nombre);
			trace("APELLIDO: ",apellido);
			trace("hasPlanEntrenamiento: ",hasPlanEntrenamiento);
		}
		
		public function datajson():Object{
			if(!exists) return null;
			var obj:Object = {};			
			obj.nombre = nombre;
			obj.apellido = apellido;
			obj.dni = dni;
			obj.socio = idSocio;
			
			return obj;
		}
	}
}