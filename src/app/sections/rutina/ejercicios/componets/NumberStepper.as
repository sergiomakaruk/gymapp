package app.sections.rutina.ejercicios.componets
{
	import app.events.AppEvents;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import sm.utils.events.CustomEvent;
	
	public class NumberStepper extends Sprite
	{
		public var _decena:_numberSlider;
		public var _unidad:_numberSlider;
		public var _txt:TextField;
		
		protected var timerValues:Timer;
		
		public var variable:String;
		protected var _currentVar:String;
		protected var _currentSteeper:_numberSlider;
		
		public function set value(val:uint):void{
			//trace(val," - ",this.name," - ", this._centena);
			if(val>9){				
				_decena._txt.text = String(val).substr(0,1);
				_unidad._txt.text = String(val).substr(1,1);			
			}else {
				_decena._txt.text = String(val);
				_unidad._txt.text = "-";				
			}				
		}
		
		public function NumberStepper()
		{
			super();
			addButtons();				
		}
		
		public function addButtons():void{
			addBtn(_decena._mas);
			addBtn(_decena._menos);
			addBtn(_unidad._mas);
			addBtn(_unidad._menos);	
		}
		
		public function init(txt:String):void{			
			_txt.text = txt;
			stage.addEventListener(MouseEvent.MOUSE_UP,onUp);
		}
		
		protected function onUp(event:MouseEvent):void
		{
			if(timerValues){
				//trace("onUpMenu() removing timer");
				timerValues.stop();
				timerValues.removeEventListener(TimerEvent.TIMER,calculate);
				timerValues = null;
			}			
		}
		
		protected function addBtn(face:MovieClip):void
		{
			face.buttonMode = true;
			face.addEventListener(MouseEvent.MOUSE_DOWN,onClick);			
		}
		
		protected function removeBtn(face:MovieClip):void
		{			
			face.removeEventListener(MouseEvent.MOUSE_DOWN,onClick);			
		}
		
		protected function destroy():void{
			removeBtn(_decena._mas);
			removeBtn(_decena._menos);
			removeBtn(_unidad._mas);
			removeBtn(_unidad._menos);			
			stage.removeEventListener(MouseEvent.MOUSE_UP,onUp);
		}
		
		protected function onClick(event:MouseEvent):void
		{
			_currentVar = event.currentTarget.name ;
			_currentSteeper = event.currentTarget.parent as _numberSlider;
			
			timerValues = new Timer(150);
			timerValues.addEventListener(TimerEvent.TIMER,calculate);
			timerValues.start();
			calculate();			
		}
		
		protected function calculate(e:TimerEvent=null):void
		{
			var amount:int;
			if(_currentVar == "_mas")amount = 1;
			else amount = -1;
			
			//var current:_numberSlider = e.currentTarget.parent as _numberSlider;
			var n:int = (_currentSteeper._txt.text == "-") ? -1:uint(_currentSteeper._txt.text);
			n+=amount;
			if(n >9) n = 9;
			else if(n<0 && _currentSteeper.name == "_decena") n = 0;			
			
			_currentSteeper._txt.text = (n<0)?"-":String(n);
			//trace("value",values);
			
			propagate();
		}
		
		protected function propagate():void
		{
			this.dispatchEvent(new CustomEvent(AppEvents.UPDATE_VALUES_EVENT,values));		
		}
		
		protected function get values():Number{			
			if(_unidad._txt.text == "-"){
				return uint(_decena._txt.text);
			}
			
			return uint(_decena._txt.text+_unidad._txt.text);				
		}
	}
}