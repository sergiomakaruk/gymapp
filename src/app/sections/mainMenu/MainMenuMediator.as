package app.sections.mainMenu
{
	import app.AppSectionTypes;
	import app.sections.AppSectionMediator;
	
	import flash.events.Event;
	
	public class MainMenuMediator extends AppSectionMediator
	{
		public function MainMenuMediator()
		{
			super();
		}
		
		override protected function onPageCompleted(e:Event=null):void{
			this.changeSection(AppSectionTypes.LOGIN_PROFE);
		}
		
		override protected function onPageChanged(e:Event):void{
			this.changeSection(AppSectionTypes.LOGIN_USUARIO);
		}
	}
}