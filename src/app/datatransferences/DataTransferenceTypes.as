package app.datatransferences
{
	public class DataTransferenceTypes
	{
		public static const SEQUENCE:String = "sequence";
		
		
		//-------------------- APP TRANSFERENCES --------------------// xml "transferences" nodes
		
		public static const GET_WEBS:String = "getWebs";		
		public static const VALIDAR_PROFE:String = "validarProfe";
		public static const BUSCA_SOCIO:String = "buscaSocio";
		public static const HISTORIAL_RUTINAS:String = "historialRutinas";
		public static const GET_RUTINA:String = "getRutina";
		public static const GET_COPY_RUTINA:String = "getCopyRutina";
		public static const GET_ALL_EXERCISES:String = "getAllExercises";
		public static const GET_INIT:String = "getInit";
		public static const GET_ALL_USERS:String = "getAllUsers";
		public static const GET_VERSION_UPDATE_INFO:String = "getVersionUpdateInfo";
		
		public static const RECUPERAR_RUTINA_BASE_PARA_TEMPLATE:String = "RecuperarRutinaBaseParaTemplate";
		public static const RECUPERAR_RUTINA_BASE_PARA_TEMPLATE_2:String = "RecuperarRutinaBaseParaTemplate2";
		public static const RECUPERAR_RUTINA_BASE:String = "RecuperarRutinaBase";
		public static const RECUPERAR_RUTINA_BASE_2:String = "RecuperarRutinaBase_2";
		public static const RECUPERAR_MENU_RUTINA_BASE:String = "RecuperarMenuRutinaBase";
		public static const EDITAR_NOMBRE_RUTINA_DEFAULT:String = "EditarNombreRutinaDefault";
		public static const CREAR_RUTINA_DEFAULT:String = "CrearRutinaDefault";
		public static const CREAR_RUTINA_DEFAULT_2:String = "CrearRutinaDefault2";
		
		public static const ELIMINAR_EJERCICIO_RUTINA:String = "EliminarEjercicioRutina";
		public static const AGREAGA_EJERCIO_A_RUTINA:String = "AgregaEjercicioARutina";
		public static const CREAR_RUTINA:String = "CrearRutina";
		public static const ELIMINAR_RUTINA:String = "EliminarRutina";
		
		public static const ACTUALIZAR_EMAIL:String = "ActualizarEmail";
		public static const FUERZO_ENVIO_EMAIL:String = "FuerzaEnvioEmail";
		
		public static const ENVIAR_EMAIL_USUARIO:String = "EnviarEmailUsuario";
		
		public static const GET_USER_PHOTO:String = "GetUserPhoto";

	}
}

/*Nombre del servicio:
RecuperarRutinaBase
Breve explicación de su funcionalidad:
Presenta la información una rutina estandar que se usará como base para armar la rutina a medida del
socio.
Parametros de entrada:
token: string
area: int (1: tonificación, 2: cardio, 3:natación)
nivel: int (1: principiante, 2: intermedio, 3:avanzada)
sexo: int (0: Femenino / 1:Masculino) 
*/

/*
Nombre del servicio:
CrearRutina
Breve explicación de su funcionalidad:
Crea una nueva rutina de ejercicios
Parametros de entrada:
token: string
Observaciones: string
Objectivos:string
area: int (1: tonificación, 2: cardio, 3:natación)
Id socio: string 
*/

/*
Nombre del servicio:
EliminarEjercioRutina
Breve explicación de su funcionalidad:
Este método es utilizado para eleminar un ejercio de la rutina.
Parametros de entrada:
token: string
ID_rutina: string
Semana: int
Ejercicio: int
Parametros de salida:
Resultado de la operación: int (1: ok, 0:error)
*/

/*
Nombre del servicio:
EliminarRutina
Breve explicación de su funcionalidad:
Este método es utilizado para eleminar una rutina.
Parametros de entrada:
token: string
ID_rutina: string
Parametros de salida:
Resultado de la operación: int (1: ok, 0:error) 
*/

/*
Nombre del servicio:
CrearRutinaDefault
Breve explicación de su funcionalidad:
Método que permite a cada profesor crear sus propias rutinas default
Parametros de entrada:
area: int (1: tonificación, 2: cardio, 3:natación)
nivel: int (1: principiante, 2: intermedio, 3:avanzada)
sexo: int (0: Femenino / 1:Masculino)
token: string 

*/

/*
AgregaEjercioARutina
Breve explicación de su funcionalidad:
Este método es utilizado para actualizar la información de una determinada rutina agregando o
modificando un ejercio
Parametros de entrada:
token: string
ID_rutina: string
ID_Ejercicio: int
Semana: int
Serie: int
Repeticion: int
Carga: decimal
Descanso: int
Orden: int
Día: int
Parametros de salida:
Resultado de la operación: int (1: ok, 0:error)
*/