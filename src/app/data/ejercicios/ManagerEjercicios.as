package app.data.ejercicios
{
	import app.model.Model;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import sm.fmwk.data.core.ManagerDatas;
	import sm.utils.display.DPUtils;
	//import sm.utils.display.DebugSprite;
	
	public class ManagerEjercicios extends ManagerDatas
	{
		private var _ejerciciosAAgregar:Array;
		private var _ejerciciosTemp:Array;
		
		private var _ejercicios:Array;
		private var _views:Array;	
		private var _orderTemp:uint = 500;

		private var _dias:Array;		
		public function get dias():Array{return _dias;}

		public function get daysBlocks():Sprite{
			
			var c:Sprite = new Sprite();
			
			var ej:DataEjercicio;
			var sp:Sprite;
			var header:_separadordeejerciciosSP;
			var views:Array;
			var ejs:Sprite;
			for(var i:uint=0;i<dias.length;i++){
				if(dias[i]==null || dias[i].length == 0) continue;
				sp = new Sprite();
				header = new _separadordeejerciciosSP();
				views = [];
				switch(i){
					case 0:header._txt.text = "Entrada en calor";break;
					case 10:header._txt.text = "Día no asignado";break;
					default:header._txt.text = "Día " + i;break;
				}
					
				sp.addChild(header);
				for each(ej in dias[i]){
					trace(ej.nombre,ej.orden)
					views.push(ej.view);
				}
				ejs = DPUtils.getColumnsContainer(views,20,20,2);
				ejs.y = sp.height + 10;
				sp.addChild(ejs);
				sp.y = c.height;
				sp.y +=(i==0) ? 0 : 20;
				c.addChild(sp);				
			}				
			
			return c;
		}
		
		
	
		public function get views():Array{
			_views = [];			
			for each(var ej:DataEjercicio in _ejerciciosTemp)_views.push(ej.view);
			return _views;		
		}
		
		public function get toSave():Array{			
			return _ejerciciosAAgregar;			
		}
		
		public function get toSaveonEdit():Array{			
			var toSave__:Array = [];			
			for each(var ej:DataEjercicio in _ejerciciosTemp){				
				if(ej.toSave)toSave__.push(ej);
			}
			return toSave__;		
		}
		
		public function get ejercicios():Array{
			//trace("_ejerciciosTemp",_ejerciciosTemp);
			return _ejerciciosTemp;
		}
		
		public function ManagerEjercicios()
		{
			super();
		}
		
		public function parseDataEjs(data:*,ejToSave:Boolean):void{
			var xml:XML = data as XML;
			
			
			/*
			<tabla diffgr:id="tabla1" msdata:rowOrder="0">
			<observaciones>6,</observaciones>
			<objetivos>6,</objetivos>
			<id_ejercicio>34</id_ejercicio>
			<semana>0</semana>
			<serie>0</serie>
			<repeticion>0</repeticion>
			<carga>0</carga>
			<descanso>0</descanso>
			<NumeroSocio>8650</NumeroSocio>
			<Sede>Charcas</Sede>
			<orden>0</orden>
			<dia>0</dia>
			</tabla>
			*/
			
			var repetidos:Array = [];
			
			var obj:DataEjercicio;			
			_ejercicios = [];
			_ejerciciosAAgregar = [];
			if(data != null){
				
				for each(var ejercicio:XML in xml..*::tabla){				
					obj = Model.templates.copy(ejercicio..*::id_ejercicio);
					trace(obj);
					if(obj.sid == null)continue;
					for each(var rep:Object in repetidos){
						if(rep.sid == obj.sid && rep.dia == ejercicio..*::dia ) continue;
					}
					
					//trace(ejercicio);
					//obj.sid = ejercicio..*::id_ejercicio;
					obj.semana = ejercicio..*::semana;
					obj.carga = ejercicio..*::carga;
					obj.orden = ejercicio..*::orden;
					obj.serie = ejercicio..*::serie;
					obj.dia = ejercicio..*::dia;
					//obj.superseries = randomRange(0,4);
					obj.superseries = ejercicio..*::superseries;
					//si el descanso es menor a 10, entiendo que son minutos y los paso internamente
					if(uint(ejercicio..*::descanso)<10) obj.descanso = uint(ejercicio..*::descanso) * 60;
					else obj.descanso = ejercicio..*::descanso;
					//if(obj.descanso.indexOf("'") == -1) obj.descanso = obj.descanso + "'";
					obj.repeticion = ejercicio..*::repeticion;
					obj.toSave = ejToSave;
					obj.saveMemory();
					
					repetidos.push({sid:obj.sid,dia:obj.dia});
					
					if(ejToSave)_ejerciciosAAgregar.push(obj);
					else _ejercicios.push(obj);
					
					_orderTemp = Math.max(_orderTemp,obj.orden);
					
					//trace(obj);
				}
			}
			
			_ejerciciosTemp = _ejercicios.concat();
			
			ordenar();
			//_ejercicios.sortOn("orden", Array.DESCENDING | Array.NUMERIC);					
		}
		
		public function randomRange(minNum:Number, maxNum:Number):Number 
		{
			return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
		}
		
		public function ordenar():void{
			_dias = new Array();
			for(var i:uint=0;i<7;i++){
				_dias[i] = [];
			}
			
			for each(var ej:DataEjercicio in _ejerciciosTemp){
				//if(dias[ej.dia] == null)dias[ej.dia] = [];
				dias[ej.dia].push(ej);
			}		
			//trace("1",dias);
			for each(var arr:Array in dias)arr.sortOn("orden", Array.NUMERIC);	
			//trace("2",dias);
			var ordenados:Array = [];
			for each(arr in dias)ordenados = ordenados.concat(arr);
			
			_ejerciciosTemp = ordenados;
			//trace("_ejercicios",_ejerciciosTemp);
		}
		
		public function agregar(dataEjercicio:DataEjercicio):void{
			dataEjercicio.orden = _orderTemp++;
			dataEjercicio.dia = Model.currentDataRutina.sectedDia;
			dataEjercicio.semana = Model.currentDataRutina.sectedDia;
			dataEjercicio.toSave = true;
			_ejerciciosAAgregar.push(dataEjercicio);
			_dias[Model.currentDataRutina.sectedDia].push(dataEjercicio);
			//dataEjercicio.defaultView.render(false);
			_ejerciciosTemp =  _ejercicios.concat(_ejerciciosAAgregar);
			//ordenar();
			
		}
		
		public function eliminar(ej:DataEjercicio,dia:uint):void{
			trace("Eliminar EJ ",ej.sid);
			trace("Eliminar ",_ejercicios.length);
			for (var i:uint=0;i<_ejercicios.length;i++){
				if(_ejercicios[i].sid == ej.sid && _ejercicios[i].dia == dia)_ejercicios.splice(i,1);
			}
			trace("Eliminar ",_ejercicios.length);
			trace("Eliminar ",_ejerciciosAAgregar.length);
			for (i=0;i<_ejerciciosAAgregar.length;i++){
				if(_ejerciciosAAgregar[i].sid == ej.sid && _ejerciciosAAgregar[i].dia == dia){
					_ejerciciosAAgregar.splice(i,1);
					ej.toSave = false;
				}
			}
			trace("Eliminar ",_ejerciciosAAgregar.length);
			_ejerciciosTemp =  _ejercicios.concat(_ejerciciosAAgregar);
			ordenar();
			ej.view.destroy();
			/*trace("Eliminar ",_views.length);
			for (i=0;i<_views.length;i++){
				if(_views[i].data.sid == ej.sid){
					_views[i].destroy();
					_views.splice(i,1);
				}
			}
			trace("Eliminar ",_views.length);*/
		}
		
		public function getNext(data:DataEjercicio):DataEjercicio{
			
			for(var i:uint=0;i<_ejerciciosTemp.length;i++){
				if(_ejerciciosTemp[i].sid == data.sid && _ejerciciosTemp[i].dia == data.dia){
					if(i<_ejerciciosTemp.length)return _ejerciciosTemp[i+1];
				}
			}
			return null;
		}
		public function getPrev(data:DataEjercicio):DataEjercicio{
			
			for(var i:uint=0;i<_ejerciciosTemp.length;i++){
				if(_ejerciciosTemp[i].sid == data.sid && _ejerciciosTemp[i].dia == data.dia){
					if(i>0)return _ejerciciosTemp[i-1];
				}
			}
			return null;
		}
		
		public function setAsSaved():void{
			_ejercicios =  _ejercicios.concat(_ejerciciosAAgregar);
			for each(var ej:DataEjercicio in _ejercicios){
				ej.toSave = false;
				ej.saveMemory();
			}
			_ejerciciosTemp = _ejercicios.concat();
			_ejerciciosAAgregar = [];	
			ordenar();
		}
		
		public function cancelEdition():void{			
			for each(var ej:DataEjercicio in _ejercicios){				
				ej.reset();
				ej.toSave = false;
				ej.view.renderValues();
			}
			ordenar();
		}
		
		public function cancelSave():void{			
			for each(var ej:DataEjercicio in _ejerciciosAAgregar)ej.toSave = false;			
			
			_ejerciciosTemp = _ejercicios.concat();
			_ejerciciosAAgregar = [];
			ordenar();
		}
		
		public function find(ejid:String,dia:uint):DataEjercicio{
			for each(var ej:DataEjercicio in _dias[dia]){
				if(ej.sid == ejid) return ej;
			}
			
			return null;
		}
	
		
	}
}