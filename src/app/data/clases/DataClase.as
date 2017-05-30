package app.data.clases
{
	import sm.fmwk.data.core.Data;
	
	public class DataClase extends Data
	{
		public var horaStr:String;
		public var hora:uint;
		public var minutos:uint;
		public var descripcion:String;
		
		public function DataClase(data:Object)
		{
			super();
			//trace('D',data);
			data = data.split(';');
			//if(data[0]=='')Array(data).shift();
			horaStr = data[0];
			var horas:Array = data[0].split(':');
			hora = horas[0];
			minutos = horas[1];
			descripcion = data[1];
			
			//trace(toString());
		}
		
		public function toString():String{
			return horaStr + '-' + descripcion ;
		}
	}
}