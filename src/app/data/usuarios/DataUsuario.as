package app.data.usuarios
{
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.ByteArray;
	
	import sm.fmwk.data.core.Data;
	import sm.utils.bytearray.GetByteArray;
	import sm.utils.display.GetImage;
	
	public class DataUsuario extends Data
	{
		
		public var nombre:String;
		public var apellido:String;
		public var dni:uint;
		public var email:String;
		public var fecha_alta:Date;
		public var fecha_molinete:Date;
		public var fecha_rutina:Date;
		public var sede:String;
		public var token:String;
		public var estado:uint;//nuevo 2,activo 1, inactivo 0
		//public var id_socio:uint;
		public var rutinaVencida:Boolean;
		public var nuevoSinRutina:Boolean;
		public var foto:Sprite;
		public var cb:Function;
		
		public var txtRenovar:String;
		
		public function parsePhoto(data:XML):void{
			//trace('parsePhoto',data..*::foto);
			
			var str:String = data..*::foto;
			if(str && str.length){
				//this.hasFoto = true;
				var ba:ByteArray = GetByteArray.getByteArray(data..*::foto);
				this.foto.addChild(GetImage.getImageFromBytes(ba,cb));		
				
			}	
			
			//GetImage.centerAndScale(GetImage.getImageFromBytes(ba,null),50,50);
		}
		
	
		
		public function isVencido(globalDateTimestamp:Number):Boolean{			
			var date2Timestamp : Number = fecha_rutina.getTime ();
			//var dd:Date = new Date();
			//globalDateTimestamp = dd.getTime ();
			//trace(dd ,"-----",  fecha_rutina);
		//	trace(globalDateTimestamp ,"-----", date2Timestamp);
			if(globalDateTimestamp > date2Timestamp) rutinaVencida = true;
			return rutinaVencida;			
		}
		
		public function DataUsuario()
		{
			super();
			this.foto = new Sprite();
		}
		
		public function toString():String{
			return  "\n" + "---> id: " + sid + " nombre: " + nombre + " " + apellido+ " estado: " + estado + " token: " + token + " fecha_rutina: " + fecha_rutina + " sede: :" + sede;
		}
	}
}