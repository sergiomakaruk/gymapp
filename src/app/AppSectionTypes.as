package app
{
	
	import app.sections.editarRutina.EditarRutinaMediator;
	import app.sections.editarRutina.EditarRutinaSection;
	import app.sections.editarrutinabase.EditarRutinaBaseMediator;
	import app.sections.editarrutinabase.EditarRutinaBaseSection;
	import app.sections.historial.HistorialMediator;
	import app.sections.historial.HistorialSection;
	import app.sections.loginProfe.LoginProfe;
	import app.sections.loginProfe.LoginProfeMediator;
	import app.sections.loginUsuario.LoginUsuario;
	import app.sections.loginUsuario.LoginUsuarioMediator;
	import app.sections.mainMenu.MainMenu;
	import app.sections.mainMenu.MainMenuMediator;
	import app.sections.perfilUsuario.PerfilUsuario;
	import app.sections.perfilUsuario.PerfilUsuarioMediator;
	import app.sections.perfilprofesor.PerfilProfesor;
	import app.sections.perfilprofesor.PerfilProfesorMediator;
	import app.sections.promos.PromosMediator;
	import app.sections.promos.PromosSection;
	import app.sections.staticsProfe.StaticsProfeMediator;
	import app.sections.staticsProfe.StaticsProfeSection;
	import app.sections.versionupdateinfo.VersionUpdatesInfoMediator;
	import app.sections.versionupdateinfo.VersionUpdatesInfoSection;
	
	import sm.fmwk.site.core.DataPage;
	import sm.fmwk.site.section.SectionTypes;

	public class AppSectionTypes extends SectionTypes
	{
		public static const MAIN_MENU:String = "mainMenu";
		public static const LOGIN_PROFE:String = "loginProfe";
		public static const LOGIN_USUARIO:String = "loginUsuario";
		public static const PERFIL_PROFE:String = "perfilProfe";
		public static const STATICS_PROFE:String = "staticsProfe";
		public static const VERSION_UPDATES_INFO:String = "versionUpdatesInfo";
		public static const PERFIL_USUARIO:String = "perfilUsuario";
		public static const PROMOS:String = "promos";
		
		
		//public static const VIEW_RUTINA:String = "viewRutina";
		public static const EDIT_RUTINA:String = "editRutina";
		public static const HISTORIAL_USUARIO:String = "historialUsuario";
		
		public static const EDIT_RUTINAS_BASE:String = "editRutinasBase";
		
		public static const CV:String = "cvSection";
		
		public function AppSectionTypes()
		{	
			super();	
			
			section = new DataPage(MAIN_MENU,MainMenu,MainMenuMediator);
			section = new DataPage(LOGIN_PROFE,LoginProfe,LoginProfeMediator);
			section = new DataPage(LOGIN_USUARIO,LoginUsuario,LoginUsuarioMediator);
			section = new DataPage(PERFIL_PROFE,PerfilProfesor,PerfilProfesorMediator);
			section = new DataPage(PERFIL_USUARIO,PerfilUsuario,PerfilUsuarioMediator);
			section = new DataPage(EDIT_RUTINA,EditarRutinaSection,EditarRutinaMediator);
			section = new DataPage(EDIT_RUTINAS_BASE,EditarRutinaBaseSection,EditarRutinaBaseMediator);
			section = new DataPage(HISTORIAL_USUARIO,HistorialSection,HistorialMediator);
			section = new DataPage(PROMOS,PromosSection,PromosMediator);
			section = new DataPage(STATICS_PROFE,StaticsProfeSection,StaticsProfeMediator);
			section = new DataPage(VERSION_UPDATES_INFO,VersionUpdatesInfoSection,VersionUpdatesInfoMediator);
		}
	}
}