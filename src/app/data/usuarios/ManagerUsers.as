package app.data.usuarios
{
	import sm.fmwk.data.core.ManagerDatas;
	import sm.fmwk.data.user.DataUser;
	
	public class ManagerUsers extends ManagerDatas
	{
		public function ManagerUsers()
		{
			super();
		}
		
		override public function parseData(data:*):void{
			var xml:Array = data as Array;		
						
			var obj:DataUsuario;	
			var item:Array;
			
			var d:Date = new Date();			
			var globalDate:Number = d.getTime();
			
			var nuevos:uint;
			var activos:uint;
			var inactivos:uint;
			var vencidas:uint;
			
			var cnuevos:uint;
			var cactivos:uint;
			var cinactivos:uint;
			var total:uint;
			
			for each(var user:String in xml){	
				item = user.split(";");				
				if(item[11] == "" || item[11] == undefined)continue;
				
				obj = new DataUsuario();
				obj.token = item[11];
				obj.sid = item[2];	
				obj.nombre = item[3];
				obj.apellido = item[4];
				obj.sede = item[5];
				//obj.fecha_alta = item[6];
				//obj.fecha_molinete = item[7];
				obj.email = item[8];
				obj.dni = item[9];
				
				/*Estado	token	Profe Asignado	numero	nombre	apellido	Sede	Fecha de Alta	Ultimo Ingreso	email	numero_doc	fecha
				
				0 - Estado;
				1 - Profe Asignado;
				2 - numero;
				3 - nombre;
				4 - apellido;
				5 - Sede;
				6 - Fecha de Alta;
				7 - Ultimo Ingreso;
				8 - email;
				9 - numero_doc;
				10 - fecha;
				11 - token*/
				
				
				
				total++;
				switch(item[0]){
					case "Nuevo":obj.estado = 2;
						nuevos++;
						if(item[10] != "")cnuevos++;
						else obj.nuevoSinRutina = true;
						break;
					case "Activo":obj.estado = 1;
						activos++;
						if(item[10] != "")cactivos++;
						break;
					case "Inactivo":obj.estado = 0;
						inactivos++;
						if(item[10] != "")cinactivos++;
						break;
				}
					
				//if(item[11] == "" || item[11] == undefined)continue;
				if(item[10] != ""){
					var fecha:Array = item[10].split('/');
					//trace(fecha);
					fecha[2] = fecha[2].split(' ')[0];
					obj.fecha_rutina = new Date(fecha[2],fecha[0]-1,fecha[1]);
					obj.fecha_rutina.time = obj.fecha_rutina.getTime() + (1000 * 60 * 60 * 24 * 30); // + milisegundos por dia
					obj.isVencido(globalDate);
					if(obj.rutinaVencida)vencidas++;
					//obj.fecha_rutina
				}
				
				if(item[7] != ""){
					var fecha2:Array = item[7].split('/');
					//trace(fecha);
					fecha2[2] = fecha2[2].split(' ')[0];
					obj.fecha_molinete = new Date(fecha2[2],fecha2[0]-1,fecha2[1]);
				}
				if(item[6] != ""){
					var fecha3:Array = item[6].split('/');
					//trace(fecha);
					fecha3[2] = fecha3[2].split(' ')[0];
					obj.fecha_alta= new Date(fecha3[2],fecha3[0]-1,fecha3[1]);
				}
				
				_data.push(obj);
				//if(obj.fecha_rutina)trace(obj);
				//if(obj.token == '368934881474680855')trace(obj);
			}	
			
			trace("TOTAL > ",total);
			trace("NUEVOS > ",nuevos);
			trace("NUEVOS CON RUTINA > ",cnuevos);
			trace("ACTIVOS > ",activos);
			trace("ACTIVOS CON RUTINA > ",cactivos);
			trace("INACTIVOS > ",inactivos);
			trace("INACTIVOS CON RUTINA > ",cinactivos);
			trace("RUTINAS VENCIDAS > ",vencidas);	

		}
		
		
		public function getUSersByProfe(token:String):DataStatics{
			
			var statics:DataStatics = new DataStatics();
			var users:Vector.<DataUsuario> = new Vector.<DataUsuario>();
			
			var nuevos:Vector.<DataUsuario> = new Vector.<DataUsuario>();
			var activos:Vector.<DataUsuario> = new Vector.<DataUsuario>();
			var inactivos:Vector.<DataUsuario> = new Vector.<DataUsuario>();
			var vencidos:Vector.<DataUsuario> = new Vector.<DataUsuario>();
			
			for each(var item:DataUsuario in _data){
				//trace("T" , token ,  "I" , item.token);
				if(item.token == token){
					users.push(item);
					
					switch(item.estado){
						case 0:inactivos.push(item);break;
						case 1:activos.push(item);
							if(item.rutinaVencida)vencidos.push(item);//ACTIVOS con rutina vencida
							break;
						case 2:nuevos.push(item);break;
					}					
					
				}
			}			
			
			statics.users = users;
			statics.nuevos = nuevos;
			statics.inactivos = inactivos;
			statics.activos = activos;
			statics.vencidos = vencidos;
			statics.retencion = activos.length - nuevos.length;
			
			return statics;
		}
	}
}