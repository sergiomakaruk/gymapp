package app.sections.mainMenu
{
	import app.components.button.AppButton;
	import app.sections.AppSection;
	
	import flash.events.Event;
	
	public class MainMenu extends AppSection
	{
		public function MainMenu(name:String, tracker:Boolean)
		{
			super(name, tracker);
		}
		
		override public function show(event:Event=null):void{
			
			var content:_mainMenuSP = new _mainMenuSP();
			addChild(content);
			
			completeAction(content._profe,AppButton);
			changeAction(content._user,AppButton);
			super.show();
		}
	}
}