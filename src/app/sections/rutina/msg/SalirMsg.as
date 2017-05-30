package app.sections.rutina.msg
{
	import app.data.ejercicios.DataEjercicio;
	
	import flash.desktop.NativeApplication;
	import flash.events.Event;
	
	import nid.ui.controls.VirtualKeyBoard2;
	import nid.ui.controls.vkb.KeyBoardEvent;
	import nid.ui.controls.vkb.KeyBoardTypes;
	
	import sm.fmwk.Fmwk;
	import sm.ui.ligthbox.Lightbox;
	import sm.utils.display.GetButton;
	
	public class SalirMsg extends Lightbox
	{
		public var content:_cartelSeguroSP;
		public function SalirMsg(frame:uint=1)
		{
			super();
			
			content = new _cartelSeguroSP();
			content.gotoAndStop(frame);	
			addChild(content);				
		}
		
		public function configKeyBoard():void
		{
			content._input.text = "";
			super.init(0,0.8,false);
			_timeline.from(content,{scaleX:0,scaleY:0});
			content.x = stage.stageWidth * .5;
			content.y = 300;
			
			VirtualKeyBoard2.getInstance().init(this);		
			//VirtualKeyBoard2.getInstance().addEventListener(KeyBoardEvent.UPDATE,onEmailChange);
			VirtualKeyBoard2.getInstance().addEventListener(KeyBoardEvent.SAVE,noExit);
			VirtualKeyBoard2.getInstance().addEventListener(Event.CLOSE,OnKeyboardClose);
			VirtualKeyBoard2.getInstance().target = { field:content._input, fieldName:"Clave",keyboardType:KeyBoardTypes.ALPHABETS_LOWER };
		}
		
		protected function OnKeyboardClose(event:Event):void
		{
			VirtualKeyBoard2.getInstance().removeEventListener(KeyBoardEvent.SAVE,noExit);
			VirtualKeyBoard2.getInstance().removeEventListener(Event.CLOSE,OnKeyboardClose);
			close();
		}
		
		protected function noExit(event:Event):void
		{
			//trace("content._input.text",content._input.text=="ggg");
			if(content._input.text == Fmwk.appKey('exit') as String){
				NativeApplication.nativeApplication.exit();  
			}else {				
				VirtualKeyBoard2.getInstance().hide();				
			}			
		}
		
		public function initMsg():void{
			super.init(0,0.8,false);
			_timeline.from(content,{scaleX:0,scaleY:0});
			content.x = stage.stageWidth * .5;
			content.y = stage.stageHeight * .5;
			
			GetButton.pressButton(content._btnCancel,this.onClose).alpha = 0;
			GetButton.pressButton(content._btnOk,onEliminarEjercicio).alpha = 0;
		}
		
		private function onEliminarEjercicio():void
		{
			this.dispatchEvent(new Event(Event.COMPLETE));
			//this.onClose();
		}
	}
}