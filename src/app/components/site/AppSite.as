package app.components.site
{

	import app.components.menu.Menu;
	
	import flash.desktop.NativeApplication;
	import flash.display.DisplayObject;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	
	import sm.fmwk.site.core.Site;
	
	public class AppSite extends Site
	{
		
		
		public function AppSite()
		{
			super();			
		}
		
		override protected function addContainers():void
		{
			addChild(_sectionManager);
			//back.content.addChildAt(this._sectionManager,1);	
			var menu:Menu = new Menu();			
			addChild(menu);
			menu.init();
			
		}	
		
		
	}
}