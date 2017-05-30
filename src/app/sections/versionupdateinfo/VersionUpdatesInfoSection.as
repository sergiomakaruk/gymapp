package app.sections.versionupdateinfo
{
	import app.components.button.AppButton;
	import app.model.Model;
	import app.sections.AppSection;
	import app.sections.rutina.TapScroller;
	
	import flash.display.Shape;
	import flash.events.Event;
	
	public class VersionUpdatesInfoSection extends AppSection
	{

		private var content:_versionUpdateSP;
		private var tapScroll:TapScroller;

		
		public function VersionUpdatesInfoSection(name:String, tracker:Boolean)
		{
			super(name, tracker);
		}
		
		override public function show(event:Event=null):void{
			
			
			content = new _versionUpdateSP();
			addChild(content);
			
			content._txt.text = Model.datakiosco.textVersion;	
			
			tapScroll = new TapScroller(content._txt,content._txt.width,800);
			tapScroll.y = content._txt.y;
			addChild(tapScroll);
			
			
			this.previousAction(content._flechaVolver,AppButton);
			
			super.show();
		}
	
		
	}
}