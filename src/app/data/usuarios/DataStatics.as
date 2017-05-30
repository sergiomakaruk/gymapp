package app.data.usuarios
{
	import sm.fmwk.data.core.Data;
	
	public class DataStatics extends Data
	{
		
		public var users:Vector.<DataUsuario>;
		
		public var activos:Vector.<DataUsuario>;
		public var inactivos:Vector.<DataUsuario>;
		public var nuevos:Vector.<DataUsuario>;
		public var vencidos:Vector.<DataUsuario>;
		
		public var retencion:int;
		
		
		public function DataStatics()
		{
			super();
		}
		
		public function getByType(type:uint):Vector.<DataUsuario>{
			switch(type){
				case 0:return inactivos;
				case 1:return activos;
				case 2:return nuevos;
				case 3:return vencidos;
			}
			return null;
		}
	}
}