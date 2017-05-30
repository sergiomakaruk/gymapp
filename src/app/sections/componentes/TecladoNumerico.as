package app.sections.componentes
{
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import sm.fmwk.ui.button.Button;
	import sm.fmwk.ui.button.events.ButtonEvent;
	import sm.utils.display.GetButton;
	import sm.utils.events.CustomEvent;
	
	public class TecladoNumerico extends Sprite
	{
		public static const KEY_NUMBER_EVENT:String = "keyNumberEvent";
		public static const KEY_ENTER:String = "keyEnter";
	
		private var mcs:Array;
		private var content:_tecladoNumericoSP;
		private var _focus:TextField;
		
		public function get focus():TextField
		{
			return _focus;
		}
		
		public function set focus(value:TextField):void
		{
			if(_focus)_focus.removeEventListener(Event.CHANGE,onChange);
			_focus = value;
			_focus.stage.focus = _focus;
			_focus.setSelection(_focus.length,_focus.length);
			_focus.addEventListener(Event.CHANGE,onChange);
		}
		
		
		
		public function TecladoNumerico()
		{
			super();
			content = new _tecladoNumericoSP();
			addChild(content);
			
			var numeros:Array = [0,1,2,3,4,5,6,7,8,9];
			mcs = [];
			
			for each(var n:uint in numeros){
				var ch:MovieClip = content.getChildByName('_'+n) as MovieClip;
				ch.gotoAndStop(n+1);				
				var btn:TecladoButton = GetButton.button(ch,TecladoButton) as TecladoButton;				
				btn.value = n;
				btn.unlockeable = true;				
				
				btn.addEventListener(ButtonEvent.onDOWN,onClick);
				
				mcs.push(btn);
			}
			
			var enter:Button = GetButton.button(content.getChildByName('_enter'),TecladoButton);
			enter.addEventListener(ButtonEvent.onDOWN,onEnter);
			mcs.push(enter);
			
			var del:Button = GetButton.button(content.getChildByName('_delete'),TecladoButton);
			del.unlockeable = true;
			del.addEventListener(ButtonEvent.onDOWN,onDelete);
			mcs.push(del);
		}	
		
		private function onChange(e:Event):void
		{
			onClick();			
		}		

		protected function onClick(event:ButtonEvent=null):void
		{	
			if(focus.length < focus.maxChars){				
				var caretIndex:uint = focus.caretIndex;
				var str:String = focus.text;
				if(event){
					focus.text = str.substring(0,caretIndex) + TecladoButton(event.target).value.toString() + str.substring(caretIndex);
					focus.stage.focus = focus;
				}
				
				focus.setSelection(caretIndex+1,caretIndex+1);
				this.dispatchEvent(new Event(KEY_NUMBER_EVENT));				
			}
			
			if(focus.length == focus.maxChars){
				dispatchEvent(new Event(Event.COMPLETE));
			}
		}
		
		protected function onEnter(event:ButtonEvent):void
		{			
			this.dispatchEvent(new Event(KEY_ENTER));			
		}
		
		protected function onDelete(event:ButtonEvent):void
		{	
			//trace("focus.caretIndex",focus.caretIndex);
			var caretIndex:uint = focus.caretIndex;
			var str:String = focus.text;
			focus.text = str.substring(0,caretIndex-1) + str.substring(caretIndex);
			focus.setSelection(caretIndex-1,caretIndex-1);
			focus.stage.focus = focus;						
		}
		
		public function lock():void{
			for each(var n:Button in mcs){
				n.unlockeable = false;
				n.lock();
				n.active = false;
			}
		}
		public function unlock():void{
			for each(var n:Button in mcs){
				n.unlockeable = true;
				n.unlock();
				n.active = true;
			}
		}
		
		public function loseStageFocus():void
		{
			focus.stage.focus = null;			
		}
		
	}
}