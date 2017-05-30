package app.data.rutinas
{
	import app.model.Model;
	
	import sm.fmwk.data.core.ManagerDatas;

	public class DataMenuRutinaBase extends ManagerDatas
	{
		
		public function DataMenuRutinaBase()
		{
			/*tipo: (1:fuerza / 2:volumen / 3:potencia / 4:resistencia)			
			dias:(1: 1 dias / 2: 2 dias, etc etc)			
			opcion:(1: opcion1, 2:opcion2, etc etc).*/
			var rbase:DataIdRutinaBase;
			for(var g:uint=0;g<2;g++){
			for(var t:uint=1;t<5;t++){				
				for(var d:uint=1;d<5;d++){					
					for(var o:uint=1;o<6;o++){
						rbase = new DataIdRutinaBase();
						this._data.push(rbase);
						rbase.genero = g;
						rbase.opcion = o;		
						rbase.tipo = t;
						rbase.dias = d;
						//trace(rbase);
					}
				}				
			}
		}
		}
		
		public function init(data:XML):void{
			
			
			//manejarlo por index de array, crear			
			//[5 tipos[4dias x tipo[5 opciones por dia]]]
			
			//for each rutinasbase[item[tipo]][item[dias]][item[opcion]].push(item); // en este caso, cada opcion es un array con un item. si el array esta vacio, no existe esa opcion todavia, por ende debería
			//crear el objeto id rutina con el numero de opcion, para que devuelva opcionN si no tiene nombre
			
			//var rbase:DataIdRutinaBase;
			var genero:uint;
			for each(var rutina:XML in data..*::tabla){		
				genero = Number(String(rutina..*::id_rutina).substr(5,1));
				for each(var id:DataIdRutinaBase in _data){
					//if(rutina..*::nombre == 'Opción 1hhhh') trace(genero);
					if(id.tipo == rutina..*::tipo && id.dias == rutina..*::dias && id.opcion == rutina..*::opcion && id.genero == genero){
						id.nombre = rutina..*::nombre;
						id.exist = true;
					}
				}
				
				/*rbase = new DataIdRutinaBase();
				rbase.tipo = rutina..*::tipo;
				rbase.dias = rutina..*::dias;
				rbase.opcion = rutina..*::opcion;
				rbase.nombre = rutina..*::nombre;
				//this._data.push(rbase);*/
				
				
			}	
			for each(id in _data)	trace("RUTINA :",id);
		}
		
		public function exists(rutina:DataIdRutinaBase):Boolean{
			for each(var id:DataIdRutinaBase in _data){
				//if(rutina..*::nombre == 'Opción 1hhhh') trace(genero);
				if(id.tipo == rutina.tipo && id.dias == rutina.dias && id.opcion == rutina.opcion && id.genero == rutina.genero && id.exist){
					return true;
				}
			}
			return false;
		}
		
		public function update():void{
			var idRutina:DataIdRutinaBase = Model.currentDataRutina.dataIDRutinaBase;
			var data:DataIdRutinaBase;
			for each(data in _data){
				if(data.tipo == idRutina.tipo && data.dias == idRutina.dias && data.opcion == idRutina.opcion){
					data.nombre = idRutina.nombre;	
					data.exist = true;
				}
			}	
		}
	}
}