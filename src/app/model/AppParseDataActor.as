package app.model
{
	import app.datatransferences.DataTransferenceTypes;
	
	import flash.events.Event;
	import flash.external.ExternalInterface;
	
	import org.robotlegs.mvcs.Actor;
	
	import sm.fmwk.Fmwk;
	import sm.fmwk.data.facebook.FBSession;
	import sm.fmwk.net.transferences.DataTransferenceData;
	import sm.fmwk.rblegs.actors.ParseDataActor;
	
	public class AppParseDataActor extends ParseDataActor
	{
				
		public function AppParseDataActor()
		{
			super();
		}
		
		override public function parseData(data:DataTransferenceData):void
		{
			super.parseData(data);			
			
			switch(data.type)
			{
				case DataTransferenceTypes.GET_VERSION_UPDATE_INFO:					
					Model.datakiosco.setUpdateInfo(data.data as Array);
					break;
				
				case DataTransferenceTypes.GET_ALL_EXERCISES:					
					Model.templates.parseData(data.data);
					break;
				
				case DataTransferenceTypes.GET_ALL_USERS:					
					Model.users.parseData(data.data);
					break;
				
				case DataTransferenceTypes.GET_INIT:
					Model.observaciones = data.data.observaciones;
					Model.objetivos = data.data.objetivos;
					break;
				
				case DataTransferenceTypes.VALIDAR_PROFE:
					Model.profe.parseData(data.data,data.args[0]);
					break;
				
				case DataTransferenceTypes.GET_USER_PHOTO:
					Model.socio.parsePhoto(data.data as XML);
					break;
				
				case DataTransferenceTypes.BUSCA_SOCIO:
					Model.socio.parseData(data.data,data.args[0]);
					break;
				
				case DataTransferenceTypes.HISTORIAL_RUTINAS:
					Model.socio.rutinas.parseData(data.data);
					break;
				
				case DataTransferenceTypes.GET_RUTINA:
					Model.socio.rutinas.populateRutina(data.data,data.args[0]);
					break
				case DataTransferenceTypes.GET_COPY_RUTINA:
					Model.currentDataRutina.populate(data.data,true);
					break
			
				case DataTransferenceTypes.CREAR_RUTINA:										
					Model.socio.rutinas.selectedRutina.populateAsNew(data.data);
					break
				
				case DataTransferenceTypes.RECUPERAR_RUTINA_BASE:
				case DataTransferenceTypes.RECUPERAR_RUTINA_BASE_2:
					Model.profe.rutinaBase.populate(data.data);
					trace('Model.profe.menuRutinaBase.exists(Model.profe.rutinaBase.dataIDRutinaBase)',Model.profe.menuRutinaBase.exists(Model.profe.rutinaBase.dataIDRutinaBase));
					if(Model.profe.rutinaBase.ejercicios.ejercicios.length == 0 && !Model.profe.menuRutinaBase.exists(Model.profe.rutinaBase.dataIDRutinaBase))Model.profe.rutinaBase.rutinaBaseNoCreada = true;
					break
				
				case DataTransferenceTypes.RECUPERAR_MENU_RUTINA_BASE:
					Model.profe.menuRutinaBase.init(data.data as XML);					
					break
				
				case DataTransferenceTypes.RECUPERAR_RUTINA_BASE_PARA_TEMPLATE:	
				case DataTransferenceTypes.RECUPERAR_RUTINA_BASE_PARA_TEMPLATE_2:	
					Model.currentDataRutina.populate(data.data,true);					
					break
				case DataTransferenceTypes.ACTUALIZAR_EMAIL:
					Model.socio.email = data.args[1];
					break
				case DataTransferenceTypes.EDITAR_NOMBRE_RUTINA_DEFAULT:
					Model.profe.menuRutinaBase.update();
					break
			}
		}
		override public function parseError(data:DataTransferenceData):void
		{
			super.parseError(data);			
		}
	}
}