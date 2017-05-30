package app.commands
{
	import app.context.AppContext;
	import app.data.ejercicios.DataEjercicio;
	import app.data.rutinas.DataIdRutinaBase;
	import app.datatransferences.AppTokenDataTransferenceData;
	import app.datatransferences.DataTransferenceTypes;
	import app.model.Model;
	
	import org.robotlegs.mvcs.Command;
	
	import sm.fmwk.net.transferences.DataTransferenceData;
	import sm.fmwk.net.transferences.SequenceTransferenceData;
	import sm.fmwk.rblegs.events.message.MessageEvent;
	import sm.fmwk.rblegs.events.transference.FinishTransferenceEvent;
	import sm.fmwk.rblegs.proxys.SequenceStaker;
	import sm.utils.events.CustomEvent;

	
	public class GetSetRutinaCommand extends Command
	{
		[Inject]
		public var staker:SequenceStaker;
		
		[Inject]
		public var theevent:CustomEvent;
		
		private const TOKEN:String = "368934881474680855";
		
		public static const GET_RUTINA_BASE:String = "getRutinaBase";
		public static const GET_RUTINA_BASE_2:String = "getRutinaBase_2";
		public static const GET_TEMPLATE:String = "getTemplate";///para usuario
		public static const GET_COPY_RUTINA:String = "getCopyRutina";///para usuario
		public static const GET_RUTINA_USUARIO:String = "getRutinaUsuario";
		public static const SET_EJERCICIOS_NUEVOS:String = "setEjerciciosNuevos";
		public static const SET_EJERCICIOS_EDITADOS:String = "setEjerciciosEditados";
		public static const ELIMINAR_EJERCICIO:String = "eliminarEjercicio";
		public static const SAVE_NAME:String = "guardarNombreRutinaB";
				
		public function GetSetRutinaCommand()
		{
			super();
		}
		
		override public function execute():void
		{	
			trace("execute()",AppContext(theevent.target).contextView,theevent.params.action);
			this.eventDispatcher.addEventListener(FinishTransferenceEvent.TRANSFERENCE_COMPLETE,onTransferenceComplete);
			this.eventDispatcher.addEventListener(MessageEvent.MESSAGE_REMOVED,onMessageRemoved);

			this.commandMap.detain(this);
			
			var dataIdRutinaBase:DataIdRutinaBase;
			switch(theevent.params.action){
				
				case GET_COPY_RUTINA:					
					staker.add(new AppTokenDataTransferenceData(DataTransferenceTypes.GET_COPY_RUTINA,[theevent.params.sid]));
					staker.start();
					break;
				
				case GET_RUTINA_USUARIO:					
					staker.add(new AppTokenDataTransferenceData(DataTransferenceTypes.GET_RUTINA,[theevent.params.sid]));
					staker.start();
					break;
				
				case GET_TEMPLATE:
					dataIdRutinaBase = DataIdRutinaBase(theevent.params);		
					staker.add(new AppTokenDataTransferenceData(dataIdRutinaBase.defineCreationTemplateAction(),dataIdRutinaBase.defineCreationParams()));
					//staker.add(new AppTokenDataTransferenceData(DataTransferenceTypes.RECUPERAR_RUTINA_BASE_PARA_TEMPLATE,[1,level2,sexo2]));
					staker.start();
					break;
				
				case GET_RUTINA_BASE:					
					dataIdRutinaBase = DataIdRutinaBase(theevent.params);	
					Model.profe.rutinaBase.populateAsRutinaBase(dataIdRutinaBase);
					staker.add(new AppTokenDataTransferenceData(DataTransferenceTypes.RECUPERAR_RUTINA_BASE,[1,dataIdRutinaBase.level,dataIdRutinaBase.genero]));
					staker.start();
					break;
				
				case GET_RUTINA_BASE_2:
					dataIdRutinaBase = DataIdRutinaBase(theevent.params);					
					Model.profe.rutinaBase.populateAsRutinaBase(dataIdRutinaBase);
					//staker.add(new AppTokenDataTransferenceData(DataTransferenceTypes.EDITAR_NOMBRE_RUTINA_DEFAULT,[1,dataIdRutinaBase.level,dataIdRutinaBase.genero,dataIdRutinaBase.tipo,dataIdRutinaBase.dias,dataIdRutinaBase.opcion,'Nombre de OP 1']));
					staker.add(new AppTokenDataTransferenceData(DataTransferenceTypes.RECUPERAR_RUTINA_BASE_2,[1,dataIdRutinaBase.level,dataIdRutinaBase.genero,dataIdRutinaBase.tipo,dataIdRutinaBase.dias,dataIdRutinaBase.opcion]));
					staker.start();
					break;
			
				case SET_EJERCICIOS_NUEVOS:
					guardarEjerciciosNuevos();
					break;
				
				case SET_EJERCICIOS_EDITADOS:
					guardarEjerciciosEditados();
					break;
				
				case ELIMINAR_EJERCICIO:
					eliminarEjercicio(theevent.params.data);
					break;
				
				case ELIMINAR_EJERCICIO:
					eliminarEjercicio(theevent.params.data);
					break;
				
				case SAVE_NAME:
					guardarNombre();
					break;
				
			}			
			
		}
		
		private function guardarNombre():void{
			var dataIdRutinaBase:DataIdRutinaBase = Model.currentDataRutina.dataIDRutinaBase;
			var data:Array = [1,dataIdRutinaBase.level,dataIdRutinaBase.genero,dataIdRutinaBase.tipo,dataIdRutinaBase.dias,dataIdRutinaBase.opcion,dataIdRutinaBase.nombre];
			if(Model.currentDataRutina.rutinaBaseNoCreada)staker.add(new AppTokenDataTransferenceData(Model.currentDataRutina.dataIDRutinaBase.defineCreationAction(),Model.currentDataRutina.dataIDRutinaBase.defineCreationParams()));
			staker.add(new AppTokenDataTransferenceData(DataTransferenceTypes.EDITAR_NOMBRE_RUTINA_DEFAULT,data));	
			staker.start();			
		}
		
		private function eliminarEjercicio(ej:DataEjercicio):void
		{			
			if(ej.toSave){
				onMessageRemoved();
				return;
			}			
			
			var params:Array = [Model.currentDataRutina.sid,resolveSemana(ej),ej.sid];
			staker.add(new AppTokenDataTransferenceData(DataTransferenceTypes.ELIMINAR_EJERCICIO_RUTINA,params));	
			staker.start();
		}
		
		private function resolveSemana(ej:DataEjercicio):uint{
			return (ej.isTemplate) ? Model.currentDataRutina.sectedDia : ej.semana;
		}
		
		private function guardarEjerciciosNuevos():void
		{						
			trace("Model.currentDataRutina.ejercicios.toSave",Model.currentDataRutina.ejercicios.toSave);
			trace("Model.currentDataRutina.observaciones,Model.currentDataRutina.objetivos",Model.currentDataRutina.observaciones,"--",Model.currentDataRutina.objetivos);
			//return;
			if(Model.currentDataRutina.ejercicios.toSave.length == 0){
				onMessageRemoved();
				return;
			}
			else if(Model.currentDataRutina.rutinaBaseNoCreada){
				trace('Model.currentDataRutina',Model.currentDataRutina.rutinaBaseNoCreada,Model.currentDataRutina.dataIDRutinaBase.defineCreationParams());
				//sModel.currentDataRutina.dataIDRutinaBase.
				staker.add(new AppTokenDataTransferenceData(Model.currentDataRutina.dataIDRutinaBase.defineCreationAction(),Model.currentDataRutina.dataIDRutinaBase.defineCreationParams()));
			}
			else if(Model.currentDataRutina.madeFromTemplate){
				staker.add(new AppTokenDataTransferenceData(DataTransferenceTypes.CREAR_RUTINA,[Model.currentDataRutina.observaciones,Model.currentDataRutina.objetivos,1,Model.socio.idSocio]));
			}
			else if(Model.currentDataRutina.madeFromCopy){
				staker.add(new AppTokenDataTransferenceData(DataTransferenceTypes.CREAR_RUTINA,[Model.currentDataRutina.observaciones,Model.currentDataRutina.objetivos,1,Model.socio.idSocio]));
			}
			else{
				addEjsToSAve();
			}
			
			staker.start();	//se le da dos veces el start
		}
		
		private function addEjsToSAve():void{
			trace("addEjsToSAve");
			trace("Model.currentDataRutina.ejercicios.toSave",Model.currentDataRutina.ejercicios.toSave);
			var data:SequenceTransferenceData = new SequenceTransferenceData();
			
			for each(var ej:DataEjercicio in Model.currentDataRutina.ejercicios.toSave)
			{
				data.add(new AppTokenDataTransferenceData(DataTransferenceTypes.AGREAGA_EJERCIO_A_RUTINA,ej.getEjParamsToSave()));
			}
			Model.currentDataRutina.ejercicios.setAsSaved();
			staker.add(data);	
		}
		
		private function guardarEjerciciosEditados():void///se llama de varios eventos
		{	
			//si no hay nada poara guardar, se cierra
			//si la rutina no esta creada, la creada
			//sino guarda los ejercicios
			
			trace("Model.currentDataRutina.ejercicios.toSaveonEdit",Model.currentDataRutina.ejercicios.toSaveonEdit);
			if(Model.currentDataRutina.ejercicios.toSaveonEdit.length == 0){
				onMessageRemoved();
				return;
			}			
			else{
				var data:SequenceTransferenceData = new SequenceTransferenceData();
				
				for each(var ej:DataEjercicio in Model.currentDataRutina.ejercicios.toSaveonEdit)
				{
					data.add(new AppTokenDataTransferenceData(DataTransferenceTypes.AGREAGA_EJERCIO_A_RUTINA,ej.getEjParamsToSave()));
				}
				Model.currentDataRutina.ejercicios.setAsSaved();
				staker.add(data);
				staker.start();
			}						
		}
					
		
		private function onMessageRemoved(e:MessageEvent=null):void
		{
			trace("REMOVED");
			this.eventDispatcher.removeEventListener(FinishTransferenceEvent.TRANSFERENCE_COMPLETE,onTransferenceComplete);
			this.eventDispatcher.removeEventListener(MessageEvent.MESSAGE_REMOVED,onMessageRemoved);
			end();	
		}
		
		private function end():void
		{
			trace("END",this.theevent.currentTarget);
			theevent.params.cb();//ejecuta el callback
			this.commandMap.release(this);				
		}
		
		private function onTransferenceComplete(e:FinishTransferenceEvent):void
		{
			switch(e.msg)
			{
				/*case DataTransferenceTypes.VALIDAR_PROFE:
					staker.add(new AppTokenDataTransferenceData(DataTransferenceTypes.BUSCA_SOCIO,['32392290','','']));				
					break;	*/
					
				case DataTransferenceTypes.CREAR_RUTINA_DEFAULT_2:
				case DataTransferenceTypes.CREAR_RUTINA_DEFAULT:	
					Model.currentDataRutina.rutinaBaseNoCreada = false;
					guardarEjerciciosNuevos();
					break;
				case DataTransferenceTypes.CREAR_RUTINA:
					Model.currentDataRutina.madeFromCopy = false;
					Model.currentDataRutina.madeFromTemplate = false;
					addEjsToSAve();		
					break;
				
				/*
				//PARA ENVIAR EMAIL ????				
				case DataTransferenceTypes.AGREAGA_EJERCIO_A_RUTINA:
					if(!staker.hasData){
						staker.add(new AppTokenDataTransferenceData(DataTransferenceTypes.FUERZO_ENVIO_EMAIL,[Model.socio.idSocio]));						
					}
					break;
				*/
			}
			
			/*if(!staker.hasData())
			{
				getJuegoEvent.callback();
				this.commandMap.release(this);
			}	*/	
		}
	}
}