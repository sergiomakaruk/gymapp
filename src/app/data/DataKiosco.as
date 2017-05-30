package app.data
{
	import sm.fmwk.Fmwk;
	import sm.fmwk.data.core.Data;
	
	public class DataKiosco extends Data
	{
		//5;0;1;9
		//[0] id sede: 1charcas
						//2flores
						//3caballito
						//4quilmes
						//5sergio
		//[1]piso
		//[2]kiosco por piso
		//[3]ID KIOSKO
		
		public var id_kiosco:String;
		public var id_sede:String;
		public var kiosco_por_piso:String;
		public var piso:String;
		public var version:String;
		public var textVersion:String;
		
		public function getSedeNombre():String{
			var str:String;
			switch(id_sede){
				case '1':str='Charcas';break;
				case '2':str='Flores';break;
				case '3':str='Caballito';break;
				case '4':str='Quilmes';break;
				case '5':str='Sergio';break;
			}
			return str;
		}
		
		public function DataKiosco()
		{
			super();
		}
		
		public function setUpdateInfo(csv:Array):void{
			//trace(csv);
			this.version = csv[0].split(';')[1];
			var str:String = 'Versión ' + this.version + '\n';
			var a:Array;
			for(var i:uint=1;i<csv.length;i++){
				a = csv[i].split(';');
				if(a[1])str+= a[1] + '\n';
			}
			this.textVersion = str;
			//trace(this.textVersion);
		}
	}
}