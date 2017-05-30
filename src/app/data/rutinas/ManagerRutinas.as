package app.data.rutinas
{
	import sm.fmwk.data.core.ManagerDatas;
	
	public class ManagerRutinas extends ManagerDatas
	{
		private var _selected:DataRutina;
		
		public function ManagerRutinas()
		{
			super();
		}
		
		override public function parseData(data:*):void{
			
			var xml:XML = data as XML;
			
			
			/*
			<tabla diffgr:id="tabla2" msdata:rowOrder="1" xmlns:msdata="urn:schemas-microsoft-com:xml-msdata" xmlns:diffgr="urn:schemas-microsoft-com:xml-diffgram-v1" xmlns="http://tempuri.org/WebServiceAS/Service1" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema">
			<fecha_inicio>2015-01-27T16:47:03.6900000-03:00</fecha_inicio>
			<fecha_renovacion>2015-02-26T16:47:03.6900000-03:00</fecha_renovacion>
			<ID_Rutina_Tonificacion>1844674407371179082</ID_Rutina_Tonificacion>
			<ID_Rutina_Cardio>0</ID_Rutina_Cardio>
			<ID_Rutina_Natacion>0</ID_Rutina_Natacion>
			<Profesor>Gonzalo Torres</Profesor>
			</tabla>
			*/
		
			var obj:DataRutina;
			var f:Array;
			var f1:Array;
			var f2:Array;
			var rutinas:Array = [];
			for each(var rutina:XML in xml..*::tabla){				
				obj = new DataRutina();
				obj.profesor = rutina..*::Profesor;
				
				f = rutina..*::fecha_inicio.split('.')[0].split('T');
				f1 = f[0].split('-');
				f2 = f[1].split(':');
				
				obj.fechaInicio = new Date(f1[0],(f1[1]-1),f1[2],f2[0],f2[1],f2[2]);
				//trace(f1,obj.fechaInicio);
				f = rutina..*::fecha_renovacion.split('.')[0].split('T');
				f1 = f[0].split('-');
				f2 = f[1].split(':');
				obj.fechaRenovacion = new Date(f1[0],f1[1]-1,f1[2],f2[0],f2[1],f2[2]);
				obj.renovacionms = obj.fechaRenovacion.time;
				//trace(obj.fechaInicio,rutina..*::fecha_inicio,rutina..*::fecha_renovacion);
					
				obj.sid = rutina..*::ID_Rutina_Tonificacion;
				rutinas.push(obj);
				
				//trace(obj);
			}
			
			rutinas.sortOn("renovacionms", Array.DESCENDING | Array.NUMERIC);
			
			for each(obj in rutinas)this._data.push(obj);			
			//trace("xml..*::tabla--",xml..*::tabla.length);
		}
		
		public function get lastRutina():String{
			if(!this.data.length) return null;
			return this.data[0].sid;
		}
		
		public function getRutinaById(idRutina:String):DataRutina{
			//_selected = idRutina;
			for each(var datar:DataRutina in this._data){
				if(datar.sid == idRutina){
					return datar;
				}
			}
			trace('No se encontro el id de rutina.');
			return null;
		}
		
		public function populateRutina(data:Object,idRutina:String):void{
			//_selected = idRutina;
			for each(var datar:DataRutina in this._data){
				if(datar.sid == idRutina){
					datar.populate(data);
					_selected = datar;	
					return;
				}
			}
			trace('No se encontro el id de rutina.');
		}
		
		public function get selectedRutina():DataRutina{
			return _selected;
		}
	}
}