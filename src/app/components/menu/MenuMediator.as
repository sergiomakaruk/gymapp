package app.components.menu
{
	import app.AppMessagesTypes;
	import app.AppSectionTypes;
	import app.datatransferences.DataTransferenceTypes;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sm.fmwk.rblegs.events.message.MessageEvent;
	import sm.fmwk.rblegs.events.page.PageEvent;
	import sm.fmwk.rblegs.events.section.SectionEvent;
	import sm.fmwk.rblegs.events.transference.StartTransferenceEvent;
	import sm.fmwk.site.core.SectionManager;
	import sm.fmwk.site.interfases.IAnimationFlowComponent;
	import sm.fmwk.ui.button.Button;
	
	public class MenuMediator extends Mediator
	{
		[Inject]
		public var sectionManager:SectionManager;
		
		public function MenuMediator()
		{
			super();
		}
		override public function onRegister():void
		{			
			sectionManager.addEventListener(SectionEvent.SECTION_ADDED,onSectionAdded);			
		}
		
		
		
		protected function onSectionAdded(e:SectionEvent):void
		{
			content.sectionAdded = e.sectionName;			
		}
	

		private function get content():Menu
		{
			return this.viewComponent as Menu;
		}
	}
}