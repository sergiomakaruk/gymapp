package app.sections.perfilUsuario
{
	import app.AppSectionTypes;
	import app.events.AppEvents;
	import app.sections.AppSectionMediator;
	import app.sections.restricted.RestrictedSection;
	
	import flash.events.Event;
	
	import sm.utils.events.CustomEvent;
	
	public class PerfilUsuarioMediator extends AppSectionMediator
	{
		public function PerfilUsuarioMediator()
		{
			super();
		}
		
		/*override protected function onPageInit(e:Event=null):void{
			this.eventDispatcher.dispatchEvent(new CustomEvent(AppEvents.GET_USER,super.onPageInit));
		}*/
		
		override protected function onPageCompleted(e:Event=null):void{
			this.changeSection(AppSectionTypes.LOGIN_USUARIO);
		}
		
	}
}