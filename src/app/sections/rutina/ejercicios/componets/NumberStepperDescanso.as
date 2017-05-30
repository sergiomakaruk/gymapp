package app.sections.rutina.ejercicios.componets
{
	import app.data.ejercicios.DataEjercicio;
	import app.events.AppEvents;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import sm.utils.events.CustomEvent;
	import sm.utils.number.NumberUtils;
	
	public class NumberStepperDescanso extends Sprite
	{	
		public var _decena:_numberSlider;
		public var _unidad:_numberSlider;
		public var _txt:TextField;

		private var timerValues:Timer;
		
		public var variable:String;
		private var _currentVar:String;
		private var _currentSteeper:_numberSlider;
		
		public var _chSegundos:MovieClip;
		private var _chState:Boolean;
		
		public function set value(val:uint):void{
			trace(val,val>99,'+99 segundos false');
			if(val > 99){
				_chState = false;
				_chSegundos._ch.gotoAndStop(1);
				
				var arr:Array = convertToHHMMSS(val);
				//trace(val," - ",this.name," - ", this._centena);
				
				_decena._txt.text = String(arr[0]).substr(0,1);
				/*if(arr[1]>0)*/_unidad._txt.text = String(arr[1]).substr(0,1);	
				/*else _unidad._txt.text = "-";*/
				
			}else{
				_chState = true;
				_chSegundos._ch.gotoAndPlay(1);
				_decena._txt.text = String(val).substr(0,1);
				_unidad._txt.text = String(val).substr(1,1);					
			}			
							
		}
		
		private function convertToHHMMSS($seconds:Number):Array
		{
			var s:Number = $seconds % 60;
			var m:Number = Math.floor(($seconds % 3600 ) / 60);
			var h:Number = Math.floor($seconds / (60 * 60));		
			
			return  [m+(h*60) , s];
		}
		
		
		public function NumberStepperDescanso()
		{
			super();
			
			addBtn(_decena._mas);
			addBtn(_decena._menos);
			addBtn(_unidad._mas);
			addBtn(_unidad._menos);			
			
			_chSegundos.addEventListener(MouseEvent.MOUSE_DOWN,onChangeChState);
		}
		
		protected function onChangeChState(event:MouseEvent):void
		{
			_chState = !_chState;
			if(_chState)_chSegundos._ch.gotoAndPlay(1);
			else _chSegundos._ch.gotoAndStop(1);	
			propagate();
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
		
		private function addBtn(face:MovieClip):void
		{
			face.buttonMode = true;
			face.addEventListener(MouseEvent.MOUSE_DOWN,onClick);			
		}
		
		private function removeBtn(face:MovieClip):void
		{			
			face.removeEventListener(MouseEvent.MOUSE_DOWN,onClick);			
		}
		
		public function destroy():void{
			removeBtn(_decena._mas);
			removeBtn(_decena._menos);
			removeBtn(_unidad._mas);
			removeBtn(_unidad._menos);
			
			stage.removeEventListener(MouseEvent.MOUSE_UP,onUp);
			_chSegundos.removeEventListener(MouseEvent.MOUSE_DOWN,onChangeChState);
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
		
		private function calculate(e:TimerEvent=null):void
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
		
		private function propagate():void
		{
			this.dispatchEvent(new CustomEvent(AppEvents.UPDATE_VALUES_EVENT,values));		
		}
		
		protected function get values():uint{			
			if(_unidad._txt.text == "-"){
				return toSeconds(uint(_decena._txt.text));
			}
			
			return toSeconds(uint(_decena._txt.text+_unidad._txt.text));				
		}
		
		private function toSeconds(val:uint):uint{
			if(_chState) return val;
			
			return val*60;
		}
	}
}