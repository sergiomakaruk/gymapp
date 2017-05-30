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
	
	public class NumberStepperCarga extends Sprite
	{
		public var _decena:_numberSlider;
		public var _unidad:_numberSlider;
		public var _txt:TextField;
		
		protected var timerValues:Timer;
		
		public var variable:String;
		protected var _currentVar:String;
		protected var _currentSteeper:_numberSlider;
		/*-------------------------------*/
		
		public var _centena:_numberSlider;	
		public var _chPeso:MovieClip;
		private var _chState:Boolean;
		
		public function set value(val:Number):void{
			trace(val,val is uint );
			if(val is uint == false){
				_chState = true;
				_chPeso._ch.gotoAndPlay(1);
			}else{
				_chState = false;
				_chPeso._ch.gotoAndStop(1);
			}
			//trace(val," - ",this.name," - ", this._centena);
			if(val>99){
				_centena._txt.text = String(val).substr(0,1);
				_decena._txt.text = String(val).substr(1,1);
				_unidad._txt.text = String(val).substr(2,1);
			}else if(val>9 && _centena != null){
				_centena._txt.text = String(val).substr(0,1);
				_decena._txt.text = String(val).substr(1,1);
				_unidad._txt.text = "-";			
			}else if(val>9){				
				_decena._txt.text = String(val).substr(0,1);
				_unidad._txt.text = String(val).substr(1,1);			
			}else if(_centena != null){
				_centena._txt.text = String(val);
				_decena._txt.text = "-";
				_unidad._txt.text = "-";				
			}else {
				_decena._txt.text = String(val);
				_unidad._txt.text = "-";				
			}				
		}
		
		public function NumberStepperCarga()
		{
			super();			
			addButtons();
			addBtn(_centena._mas);
			addBtn(_centena._menos);
			
			
			_chPeso.addEventListener(MouseEvent.MOUSE_DOWN,onChangeChState);
		}
		
		protected function onChangeChState(event:MouseEvent):void
		{
			_chState = !_chState;
			if(_chState)_chPeso._ch.gotoAndPlay(1);
			else _chPeso._ch.gotoAndStop(1);	
			propagate();
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
			
			removeBtn(_centena._mas);
			removeBtn(_centena._menos);	
			_chPeso.removeEventListener(MouseEvent.MOUSE_DOWN,onChangeChState);
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
			else if(n<0 && _currentSteeper.name == "_centena") n = 0;
			
			_currentSteeper._txt.text = (n<0)?"-":String(n);
			//trace("value",values);
			
			propagate();
		}	
		
		protected function get values():Number{
			
			if(_decena._txt.text == "-" && _unidad._txt.text == "-"){
				return Number(uint(_centena._txt.text)) + getChState();
			}
			else if(_unidad._txt.text == "-"){
				return Number(_centena._txt.text + _decena._txt.text) + getChState();
			}
			else if(_decena._txt.text == "-"){
				return Number(_centena._txt.text + _unidad._txt.text) + getChState();
			}
			
			return Number(_centena._txt.text+_decena._txt.text+_unidad._txt.text) + getChState();
						
		}
		
		private function getChState():Number
		{
			if(_chState)return 0.5;
			return 0;
		}
		
		protected function propagate():void
		{
			trace("values",values);
			this.dispatchEvent(new CustomEvent(AppEvents.UPDATE_VALUES_EVENT,values));		
		}
		
		
	}
}