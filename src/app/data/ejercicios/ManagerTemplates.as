package app.data.ejercicios
{
	import sm.fmwk.data.core.ManagerDatas;
	
	public class ManagerTemplates extends ManagerDatas
	{
		
		
		public function ManagerTemplates()
		{
			super();
		}
		
		private var sdiakA:Array;
		private var bdiakA:Array;
		private function initReplaceDiacritic():void{
			var sdiak:String = "áäčďéěíĺľňóôöŕšťúůüýřžÁÄČĎÉĚÍĹĽŇÓÔÖŔŠŤÚŮÜÝŘŽ";
			var bdiak:String  = "aacdeeillnooorstuuuyrzAACDEEILLNOOORSTUUUYRZ";
			sdiakA = new Array();
			bdiakA = new Array();
			
			for (var i:uint=0;i<sdiak.length;i++)
				sdiakA.push(new RegExp(sdiak.charAt(i), "g"))
			for (i=0;i<sdiak.length;i++)
				bdiakA.push(bdiak.charAt(i))
		}
		private function replaceDiacritic(string:String):String{               
			for (var i:int = 0; i < sdiakA.length; i++)
				string = string.replace(sdiakA[i], bdiakA[i]);
			return (string)
		}
		
	
		
		override public function parseData(data:*):void{
			initReplaceDiacritic();
			var xml:Array = data as Array;		
			
			var obj:DataEjercicio;	
			var item:Array;
			
			for each(var ejercicio:String in xml){	
				item = ejercicio.split(";");
				if(item[0] == '' || item[5] == false)continue;
				obj = new DataEjercicio();
				obj.sid = item[0];	
				obj.nombre = item[2];
				obj.search_nombre = String(item[2]).toLowerCase();
				obj.search_nombre = replaceDiacritic(obj.search_nombre);
				obj.grupoMuscular = item[1];
				obj.nombregrupoMuscular =item[3];
				obj.video =item[4];
				obj.isTemplate = true;				
				_data.push(obj);				
			}
			
			
			
			
			/*var xml:XML = data as XML;		
			
			var obj:DataEjercicio;			
			
			for each(var ejercicio:XML in xml.Record.Row){				
				obj = new DataEjercicio();
				obj.sid = ejercicio.@A;	
				obj.nombre = ejercicio.@C;
				obj.grupoMuscular = ejercicio.@B;
				obj.nombregrupoMuscular = ejercicio.@D;
				obj.isTemplate = true;
				
				_data.push(obj);				
			}*/
		}
		
		public function getEjercicio(id:String):DataEjercicio{
			for each(var ej:DataEjercicio in _data){
				if(ej.sid == id)return ej;
			}
			trace("No se encontro ejercicio con ese ID en ManagerTemplates->getEjercicio("+id+")");
			
			ej = new DataEjercicio();
			ej.sid = id;
			ej.nombre = "Ejercicio no encontrado " + id;
			_data.push(ej);
			
			return ej;
		}
		
		public function copy(id:String):DataEjercicio{
			var ej1:DataEjercicio = new DataEjercicio();
			for each(var ej:DataEjercicio in _data){
				if(ej.sid == id){					
					ej1.sid = ej.sid;	
					ej1.nombre = ej.nombre;
					ej1.grupoMuscular = ej.grupoMuscular;
					ej1.nombregrupoMuscular = ej.nombregrupoMuscular;
					ej1.video = ej.video;
					ej1.saveMemory();
					return ej1;
				}
			}
			
			//ej1.sid = id;	
			/*ej1.nombre = ej.nombre;
			ej1.grupoMuscular = ej.grupoMuscular;
			ej1.nombregrupoMuscular = ej.nombregrupoMuscular;	*/		
			
			return ej1;
		}
	}
}