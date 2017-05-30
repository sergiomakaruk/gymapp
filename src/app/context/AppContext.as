package app.context
{

	import app.commands.GetFakeUserCommand;
	import app.commands.GetProfeUserCommand;
	import app.commands.GetSetRutinaCommand;
	import app.commands.GetUserCommand;
	import app.components.button.fbLogin.FBLoginButtonMediator;
	import app.components.button.fbLogin.FbLoginButton;
	import app.components.menu.Menu;
	import app.components.menu.MenuMediator;
	import app.components.site.AppSite;
	import app.events.AppEvents;
	import app.mediators.AppSiteMediator;
	import app.model.AppParseDataActor;
	import app.sections.rutina.Rutina;
	import app.sections.rutina.RutinaMediator;
	import app.sections.rutina.ejercicios.PopupAgregarEjercicio;
	import app.sections.rutina.ejercicios.PopupAgregarEjercicioMediator;
	import app.sections.rutina.menu.MenuRutina;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	
	import sm.fmwk.rblegs.context.CoreContext;
	import sm.fmwk.rblegs.events.site.SiteEvent;
	import sm.fmwk.site.core.Site;
	import sm.utils.events.CustomEvent;

	//import sm.fmwk.site.stagerezise.AddStageResize;
	
	public class AppContext extends CoreContext
	{
		public function AppContext(contextView:DisplayObjectContainer, autoStartUp:Boolean=true)
		{
			super(contextView, autoStartUp);
		}
		override public function init():void
		{			
			super.init();
			
			addAppComponets();
		}
		
		private function addAppComponets():void
		{
			trace("AppContext.addAppComponets() se inicializan los componentes de la aplicacion: ");
			trace("Se registra el mediador de Site");
			trace("Se añaden los componentes del site y se registran sus mediadores");
			
		
	//		new AddStageResize(this.commandMap,this.injector);
			
			//this.mediatorMap.mapView(FbLoginButton,FBLoginButtonMediator,FbLoginButton);
			
				
			var site:AppSite = new AppSite();
			this.mediatorMap.mapView(AppSite,AppSiteMediator,AppSite);
			this.mediatorMap.mapView(Menu,MenuMediator,Menu);
			
			this.mediatorMap.mapView(Rutina,RutinaMediator,Rutina);
			this.mediatorMap.mapView(PopupAgregarEjercicio,PopupAgregarEjercicioMediator,PopupAgregarEjercicio);

		
			this.commandMap.mapEvent(AppEvents.GET_FAKE_USER,GetFakeUserCommand,Event);	
			this.commandMap.mapEvent(AppEvents.GET_USER,GetUserCommand,CustomEvent);	
			this.commandMap.mapEvent(AppEvents.GET_PROFE_USER,GetProfeUserCommand,CustomEvent);	
			this.commandMap.mapEvent(AppEvents.SETGET_RUTINA_COMMAND,GetSetRutinaCommand,CustomEvent);	
			
			this.contextView.addChild(site);
			//site.init();
			
			this.eventDispatcher.dispatchEvent(new SiteEvent(SiteEvent.START_SITE));
				//.dispatch(new SiteEvent(SiteEvent.START_SITE));
		}
	}
}