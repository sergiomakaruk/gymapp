package app.sections.rutina.menu
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import sm.fmwk.ui.button.Button;
	import sm.fmwk.ui.button.events.ButtonEvent;
	import sm.utils.display.GetButton;
	
	public class AbsMenu extends Sprite
	{
		protected var buttons:Array;
		
		public function AbsMenu()
		{
			super();
			buttons = [];
		}
		
		protected function addButton(face:MovieClip):Button
		{
			var btn:Button = GetButton.button(face);
			btn.addEventListener(ButtonEvent.onDOWN,onDonwn);			
			buttons.push(btn);
			btn.delayTime = 500;
			return btn;
		}
		
		protected function onDonwn(event:Event):void
		{
			trace("OVERRIDE!!: AbsMenu->onDonwn");
		}
		
		/*public function destroy():void{
			for each(var
		}*/
	}
}