package app.sections.rutina.msg
{

	import flash.events.Event;
	
	import sm.ui.ligthbox.Lightbox;
	import sm.utils.display.GetButton;
	
	public class SinRutinaMsg extends Lightbox
	{
		public var content:_cartelSeguroSP;
		public function SinRutinaMsg()
		{
			super();
			
			content = new _cartelSeguroSP();
			content.gotoAndStop(6);	
			addChild(content);				
		}
			
		public function initMsg():void{
			super.init(0,0.8,false);
			_timeline.from(content,{scaleX:0,scaleY:0});
			content.x = stage.stageWidth * .5;
			content.y = stage.stageHeight * .5;
			
			//GetButton.pressButton(content._btnCancel,this.onClose).alpha = 0;
			GetButton.pressButton(content._btnOk,onEliminarEjercicio).alpha = 0;
		}
		
		private function onEliminarEjercicio():void
		{
			//this.dispatchEvent(new Event(Event.COMPLETE));
			this.onClose();
		}
	}
}