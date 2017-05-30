package app.data.rutinas
{
	import app.data.ejercicios.DataEjercicio;
	import app.data.ejercicios.ManagerEjercicios;
	import app.model.Model;
	import app.sections.rutina.ejercicios.EjercicioView;
	import app.sections.rutina.ordenar.OrderManager;
	
	import com.hurlant.util.Base64;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import hx.fmwk.serialization.Json;
	
	import sm.fmwk.data.core.Data;
	import sm.utils.display.DPUtils;
	import sm.utils.number.NumberUtils;
	
	public class DataRutina extends Data
	{
		/*
		<fecha_inicio>2015-01-27T16:47:03.6900000-03:00</fecha_inicio>
			<fecha_renovacion>2015-02-26T16:47:03.6900000-03:00</fecha_renovacion>
			<ID_Rutina_Tonificacion>1844674407371179082</ID_Rutina_Tonificacion>
			<ID_Rutina_Cardio>0</ID_Rutina_Cardio>
			<ID_Rutina_Natacion>0</ID_Rutina_Natacion>
			<Profesor>Gonzalo Torres</Profesor>
		*/
		
		/*DATOS GENERALES*/
		public var fechaInicio:Date;
		public var fechaRenovacion:Date;	
		public var profesor:String;
		public var renovacionms:Number;
		
		/*RUTINA BASE*/
		//public var sexo:uint;
		//public var level:uint;
		public var dataIDRutinaBase:DataIdRutinaBase;
		
		/*DATOS DE POPULATE*/
		private var _ejercicios:ManagerEjercicios;
		public var objetivos:String;
		public var observaciones:String;
		
		private var _sectedDia:uint;
		
		public var rutinaBaseNoCreada:Boolean;
		public var madeFromTemplate:Boolean;
		public var madeFromCopy:Boolean;
		

		public function get sectedDia():uint{return _sectedDia;}		
		public function set sectedDia(value:uint):void{_sectedDia = value;}
		
		private var _orderManager:OrderManager;
		
		
		public function get orderManager():OrderManager
		{
			if(!_orderManager)_orderManager = new OrderManager();
			return _orderManager;
		}
		
		public function renderObjetivos():String{			
			if(objetivos == null || objetivos == "") return "";
			var str:String="";
			var n:Array = objetivos.split(',');
			for each(var i:uint in n)str+=Model.objetivos[i] + "\n";			
			return str;
		}
		public function renderObservaciones():String{
			if(observaciones == null || observaciones == "") return "";
			var str:String="";
			var n:Array = observaciones.split(',');
			for each(var i:uint in n)str+=Model.observaciones[i] + "\n";			
			return str;
		}
		
		
		public function checkHeader(index:uint,isObservaciones:Boolean):Boolean{
			var i:uint; 
			var n:Array;
			if(isObservaciones){
				n = observaciones.split(',');
				for each(i in n){
					if(i == index)return true;
				}
				return false;
			}
			else {
				n = objetivos.split(',');
				for each(i in n){
					if(i == index)return true;
				}
				return false;
			}
			return false;
		}
		
			
		public function DataRutina()
		{
			super();
		}
		
		

		public function get ejercicios():ManagerEjercicios
		{
			return _ejercicios;
		}

		public function toString():String{
			var str:String="";
			str+="RUTINA: " + sid + "\n";
			str+="FECHA: " + showFechaInicio() +" -- " + showFechaRenovacion() +"\n";
			str+="PROFESOR: " + profesor + "\n";
			str+="-------------------------\n";
			return str;
		}
		
		public function showFechaInicioHS():String{
			//trace(fechaInicio);
			return fechaInicio.fullYear + " - " + NumberUtils.zeroinFirst(fechaInicio.month+1,2) + " - " + NumberUtils.zeroinFirst(fechaInicio.date,2) + "  " + NumberUtils.zeroinFirst(fechaInicio.hours,2) + ":" + fechaInicio.minutes + "hs";
		}
		
		public function showFechaInicio():String{
			return fechaInicio.fullYear + " - " + NumberUtils.zeroinFirst(fechaInicio.month+1,2) + " - " + NumberUtils.zeroinFirst(fechaInicio.date,2);// + "  " + NumberUtils.zeroinFirst(fechaInicio.hours,2) + ":" + fechaInicio.minutes + "hs";
		}
		public function showFechaRenovacion():String{
			return fechaRenovacion.fullYear + " - " + NumberUtils.zeroinFirst(fechaRenovacion.month+1,2) + " - " + NumberUtils.zeroinFirst(fechaRenovacion.date,2);
		}
		
		public function populateAsNew(data:Object):void{
			trace("NUEVA CREADA");			
			var xml:XML = data as XML;
			
			trace("xml..*::CrearRutinaResult",xml..*::CrearRutinaResult == undefined);
			if(xml..*::CrearRutinaResult != undefined)this.sid = xml..*::CrearRutinaResult;
		}
		
		public function populateAsRutinaBase(dataIdRutinaBase:DataIdRutinaBase):void{
			
			/*
			A XXX N S
			A : área (1: tonificación, 2: cardio, 3:natación)
			XXX: número de 3 digitos de profesor. Si fuera de menos de 2 dígitos se completará con ceros
			N: nivel (1: principiante, 2: intermedio, 3:avanzada)
			sexo: (0: Femenino / 1:Masculino)
			Ejemplo, la rutina de tonificación del profe 672, nivel principiante para el sexo masculino será:
			167211
			*/
			
			this.dataIDRutinaBase = dataIdRutinaBase;
			
			this.sid = '1' + Model.profe.sid + dataIdRutinaBase.getStringID()
			trace('populateAsRutinaBase(): ',this.sid);			
		}
		
		public function populate(data:Object,ejToSave:Boolean = false):void
		{
			var xml:XML = data as XML;
			if(!_ejercicios)_ejercicios = new ManagerEjercicios();
			//tomas los datos de un ejercicio cualquiera
			trace("xml..*::tabla",xml..*::tabla == undefined);
			if(xml..*::tabla != undefined){
				
				if(!madeFromTemplate){
					observaciones = xml..*::tabla[0]..*::observaciones;
					objetivos = xml..*::tabla[0]..*::objetivos;	
				}
						
				
				trace("llenando ejercicios");
				
				_ejercicios.parseDataEjs(data,ejToSave);
			}else{
				_ejercicios.parseDataEjs(null,false);
			}
			
		}
		
		public function getPrintPages(alto:uint):Array{
			var pages:Array = [];
			
			var dias:Array = ejercicios.dias.concat();
			var realDias:Array = [];
			for(var i:uint=0;i<dias.length;i++){
				if(dias[i]==null || dias[i].length == 0) continue;
				realDias.push({dia:i,ejs:dias[i].concat()});
			}
			pages.push(getPrintPage(true,realDias,alto,1));
			while(realDias.length){
				//trace("while dias.length",realDias.length);
				pages.push(getPrintPage(false,realDias,alto,pages.length+1));
			}
			
			//barra final
			var last:Sprite = pages[pages.length-1];
			var fin:_separadordeejerciciosSP =  new _separadordeejerciciosSP();
			fin._txt.text = "";
			fin.y = last.height + 20;
			last.addChild(fin);
			
			var page:Sprite;
			var shape:Shape;
			var npagesp:_npageSP;
			for(i=0;i<pages.length;i++){
				page = pages[i];
				shape = new Shape();				
				shape.graphics.beginFill(0xFFFFFF,1);
				shape.graphics.drawRect(0,0,952,1390);
				page.addChildAt(shape,0);	
				shape = new Shape();
				shape.graphics.lineStyle(2,0XFF0000);				
				shape.graphics.drawRect(0,0,952,1390);
				page.addChild(shape);
				npagesp = new _npageSP();
				npagesp._pagina.text = (i+1).toString();
				npagesp.x = page.width;
				npagesp.y = page.height;
				page.addChild(npagesp);
			}
			//trace("pagen L",pages.length);
			//trace(pages);
			return pages;	
		}
		
		private function getPrintPage(isFirst:Boolean,dias:Array,alto:uint,nPage:uint):Sprite{
			var ej:DataEjercicio;
			var sp:Sprite;
			var header:_separadordeejerciciosSP;
			var views:Array;
			var ejs:Sprite;
			//var alto:uint = 1355;
			var page:Sprite = new Sprite();
			
			if(isFirst){
				var _content:_A4IMPRIMIR = new _A4IMPRIMIR();	
				completeHeader(_content);
				completeSubHeader(_content);
				page.addChild(_content);
			}
			else if(!NumberUtils.isPar(nPage)){
				var _content2:_headerMiniSP = new _headerMiniSP();	
				completeHeader(_content2);				
				page.addChild(_content2);
			}
			
			while(dias.length){
				var obj:Object = dias[0];			
				
				sp = new Sprite();
				sp.y = page.height;
				page.addChild(sp);
				header = new _separadordeejerciciosSP();
				views = [];
				switch(obj.dia){
					case 0:header._txt.text = "Entrada en calor";break;
					case 10:header._txt.text = "Día no asignado";break;
					default:header._txt.text = "Día " + obj.dia;break;
				}				
				
				while(obj.ejs.length){
					trace("while ",obj.ejs.length);
					if((page.height + 240) > alto) return page; //200 es el alto de ejercicios
					if(!header.stage)sp.addChild(header);
					
					var s1:* = DataEjercicio(obj.ejs.shift()).print;	
					var h:Number =  sp.height + 10;
					s1.y = h;
					//s1.x = 10;					
					sp.addChild(s1);
					
					if(obj.ejs.length){
						var s2:* = DataEjercicio(obj.ejs.shift()).print;	
						s2.y = h;						
						s2.x = s1.width + 20;						
						sp.addChild(s2);
					}
					
					if(obj.ejs.length == 0){
						//dias.splice(i,1);
						//i--;
						dias.shift();
						//continue;
					}
					
				}
								
			}
			
			
			return page;
		}
		
		public function completeHeader(_content:*):void{
			_content._datos1.text = "Socio N°: " + Model.socio.numero;			
			_content._datos1.appendText("\n");
			_content._datos1.appendText("Nombre y Apellido:" + Model.socio.nombre + " " + Model.socio.apellido);
			_content._datos1.appendText("\n");
			_content._datos1.appendText("Profesor: " + this.profesor);
			
			_content._datos2.text = "DNI: " + Model.socio.dni;	
			_content._datos2.appendText("\n");
			_content._datos2.appendText("Fecha Inicio: " + this.showFechaInicio());
		}
		
		public function completeHeaderAsBase(_content:*):void{
			_content._datos1.text = "Socio N°: ";			
			_content._datos1.appendText("\n");
			_content._datos1.appendText("Nombre y Apellido:");
			_content._datos1.appendText("\n");
			_content._datos1.appendText("Profesor: " + Model.profe.nombre);
			
			_content._datos2.text = "DNI: ";	
			_content._datos2.appendText("\n");
			_content._datos2.appendText( "Fecha Inicio: ");
		}
		
		public function completeSubHeader(_content:*):void{
			_content._objetivos._objetivos.text = this.renderObjetivos();
			TextField(_content._objetivos._objetivos).autoSize = TextFieldAutoSize.CENTER;
			_content._objetivos._objetivos.y += (90 - _content._objetivos._objetivos.height) * .5;
			_content._observaciones._observaciones.text = this.renderObservaciones();
			TextField(_content._observaciones._observaciones).autoSize = TextFieldAutoSize.CENTER;
			_content._observaciones._observaciones.y += (90 - _content._observaciones._observaciones.height) * .5;
		}
		
		public function getDataForEmail():Object{
			var obj:Object = new Object();
			obj.id = this.sid;
			obj.nombre = Model.socio.nombre + " " + Model.socio.apellido;
			obj.email = Model.socio.email;
			obj.nsocio = Model.socio.numero;
			obj.dni = Model.socio.dni;
			obj.profesor = Model.profe.nombre;
			obj.fechaInicio = this.showFechaInicio();
			
			var e_observaciones:Array = [];
			var e_objetivos:Array = [];
			var n:Array;
			var i:uint;
			if(objetivos != null || objetivos != ""){
				n = objetivos.split(',');
				for each(i in n)e_objetivos.push(Model.objetivos[i]);
			}	
			
			if(observaciones != null || observaciones != ""){
				n = observaciones.split(',');
				for each(i in n)e_observaciones.push(Model.observaciones[i]);
			}			
			
			obj.objetivos = e_objetivos;
			obj.observaciones = e_observaciones;
			
			obj.precalentamiento = renderMailEj(0);
			obj.dia_1 = renderMailEj(1);
			obj.dia_2 = renderMailEj(2);
			obj.dia_3 = renderMailEj(3);
			obj.dia_4 = renderMailEj(4);
			obj.dia_5 = renderMailEj(5);
			obj.dia_6 = renderMailEj(6);
			obj.getdata = renderGetEmailData();
			return obj;
			//return Base64.encode(Json.encode(obj));
		}
		
		private function renderGetEmailData():Object
		{
			var obj:Object = {};
			obj.idRutina = this.sid;
			obj.dni = Model.socio.dni;
			obj.fechaInicio = this.showFechaInicio();
			obj.profesor = Model.profe.nombre;
			return Base64.encode(Json.encode(obj));
		}
		
		private function renderMailEj(dia:int):Array
		{
			var values:Array = [];
			if(ejercicios.dias[dia] == null) return values;
			
			for each(var ej:DataEjercicio in ejercicios.dias[dia]){
				var ejm:Object = {};
				ejm.nombre = ej.nombre;
				ejm.id = ej.sid;
				ejm.serie = ej.serie;
				ejm.carga = ej.carga;
				ejm.repeticion = ej.repeticion;
				ejm.descanso = ej.descansoToString;
				ejm.superseries = ej.superseries;
				ejm.video = ej.video;			
				values.push(ejm);
				//trace(ejm);
			}
			return values;
		}
	}
}