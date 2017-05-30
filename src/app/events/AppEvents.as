package app.events
{
	import flash.events.Event;
	
	public class AppEvents extends Event
	{
		public static const SETGET_RUTINA_COMMAND:String = "setgetRutinaCommand";
		
		public static const GET_FAKE_USER:String = "getFakeUser";
		public static const GET_USER:String = "getUser";
		public static const GET_PROFE_USER:String = "getProfeUser";
		public static const SHOW_VIDEO:String = "showVideo";
		public static const RECUPERAR_RUTINA_BASE_EVENT:String = "recuperarRutinaBaseEvent";
		
		public static const EDITAR_RUTINA_MAIN_EVENT:String = "editarRutinaMainEvent";//para Rutina Mediator
		public static const EDITAR_RUTINA_POPUP_EJERCICIOS_EVENT:String = "editarRutinaPopupEjerciciosEvent";//disparados de MenuEjercicios, escucha Rutina y MenuEjerciciosMediator
		
		public static const EDITAR_ESTE_EJERCICIO_EVENT:String = "editarEsteEjercicioEvent";
		public static const UPDATE_VALUES_EVENT:String = "updateValuesEvent";
		
		public static const EDITAR_EJERCICIOS_EVENT:String = "editarEjerciciosEvent";
		public static const ELIMINAR_EJERCICIO_DE_RUTINA_EVENT:String = "eliminarEjercicioDeRutinaEvent";
		
		public static const AGREGAR_EJERCICIOS_POPUP_EVENT:String = "agregarEjerciciosPopupEvent";
		public static const AGREGAR_ESTE_EJERCICIO_EVENT:String = "agregarEsteEjercicioEvent";
		public static const CANCELAR_AGREGAR_POPUP_EVENT:String = "cancelarAgregarPopupEvent";
		
		public static const SELECTED_DIA_ORDEN_BUTTON:String = "selectedDiaOrdenButton";
		public static const ORDENAR_EJERCICIOS_POPUP_EVENT:String = "ordenarEjerciciosPopupEvent";
		public static const GUARDAR_CAMBIOS_ORDEN:String = "guardarCambiosOrden";		
		public static const CANCELAR_EDICION_ORDEN_EVENT:String = "cancelarEdicionOrdenEvent";
		
		public static const HISTORIAL_MAIN_EVENT:String = "historialMainEvent";
		public static const HISTORIAL_COPIAR_RUTINA:String = "historialCopiarRutina";
		public static const HISTORIAL_EDITAR_RUTINA:String = "historialEditarRutina";		;
		public static const HISTORIAL_ACTUALIZAR_EMAIL:String = "historialActualizarEmail";
		public static const HISTORIAL_CREAR_NUEVA_RUTINA:String = "historialCrearNuevaRutina";
		
		//public static const EDITAR_OBSERVACIONES:String = "editarObservaciones";
		//public static const EDITAR_OBJETIVOS:String = "editarObjetivos";
		//public static const CANCELAR_EDICION_HEADER_EVENT:String = "cancelarEdicionHeaderEvent";
		//public static const GUARDAR_CAMBIOS_HEADER:String = "guardarCambiosHeaderEvent";
		
		
		public static const IMPRIMIR:String = "imprimir";
		public static const ENVIAR_EMAIL:String = "enviarEmail";
		public static const EDITAR_NOMBRE_DE_RUTINA_BASE:String = "_btnEditarNombreRutinaBase";
		public static const SAVE_EDITAR_NOMBRE_DE_RUTINA_BASE:String = "SAVE_btnEditarNombreRutinaBase";
		
		
		
		/*
		NO SE PUEDE EDITAR, SOLO CUANDO SE CREA LA RUTINA SE DEFINEN
		public static const EDITAR_OBJETIVOS_EVENT:String = "editarObjetivosEvent";
		public static const EDITAR_OBSERVACIONES_EVENT:String = "editarObservacionesEvent";*/
		
		public static const VOLVER:String = "volver";
		
		public static const GUARDAR_CAMBIOS_VALORES:String = "guardarCambiosValores";
		public static const GUARDAR_CAMBIOS_AGREGAR_EJERCICIOS_A_RUTINA:String = "guardarCambiosAgregarEjerciciosaRutina";
		public static const CANCELAR_EDICION_EVENT:String = "cancelarEdicionEvent";
		
		public static const EDITAR_DIAS:String = "editarDias";
		public static const GUARDAR_DIAS:String = "guardarDias";
		public static const CANCELAR_EDICION_DIAS_EVENT:String = "cancelarEdicionDiasEvent";		
		public static const SELECTED_DIA_BUTTON:String = "selectedDiaButton";
		
		public static const UPDATE_SUBMENU:String = 'updateSubMenu';
		
		public static const CARDIO:String = '_btnCardio';
		//public static const TREN_SUPERIOR:String = '_btnTrenSuperior';
		//public static const ZONA_MEDIA:String = '_btnZonaMedia';
		//public static const TREN_INFERIOR:String = '_btnTrenInferior';
		
		public static const BICEPS:String = '_btnBiceps';
		public static const HOMBROS:String = '_btnHombros';
		public static const TRICEPS:String = '_btnTriceps';
		public static const DORSALES:String = '_btnDorsales';
		public static const PECTORALES:String = '_btnPectorales';
		public static const ABDOMINALES:String = '_btnAbdominales';
		public static const ABEDUCTORES:String = '_btnAbec';
		public static const CUADRICEPS:String = '_btnCuadriceps';
		public static const ISQUITIBIALES:String = '_btnIsquiotibiales';
		public static const GEMELOS:String = '_btnGemelos';
		public static const GLUTEOS:String = '_btnGluteos';
		
		
		public function AppEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
	}
}