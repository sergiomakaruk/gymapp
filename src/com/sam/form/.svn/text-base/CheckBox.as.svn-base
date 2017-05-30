package com.sam.form
{
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	import sm.fmwk.ui.button.Button;
	import sm.fmwk.ui.button.events.ButtonEvent;
	
	public class CheckBox extends Button implements IInputForm
	{
		private var _tab:uint;
		
		private var _selected:Boolean;
		public function get selected():Boolean{return _selected;}		
		public function set selected(value:Boolean):void
		{
			_selected = value;
			var movie:MovieClip = face as MovieClip;			
			(selected) ? movie.gotoAndStop(2) : movie.gotoAndStop(1);	
			if(selected)quitIndicador();
		}
		
		public function get label():String{return face.name}
		
		public function setTabIndex(n:uint):void
		{
			this._tab = n;	
		}
		public function getTabIndex():uint
		{
			///los combos no tienen tabIndex, por lo q devuelve lo mismo q recibio
			return _tab;
		}
		
		private var _statusTxt:TextField;
		public function set statusTxt(value:TextField):void{_statusTxt = value;}

		override public function set  face(val:DisplayObject):void
		{
			super.face = val;
			init();
		}
		public function CheckBox()
		{
			super();			
		}
		
		private function init():void
		{
			var movie:MovieClip = face as MovieClip;
			movie.gotoAndStop(1);
			this.unlockeable = true;
			this.addEventListener(ButtonEvent.onCLICK,onClick);
		}		
		
		protected function onClick(event:Event=null):void
		{
			//trace(event);
			var movie:MovieClip = face as MovieClip;
			selected = !selected;
			(selected) ? movie.gotoAndStop(2) : movie.gotoAndStop(1);	
			if(selected)quitIndicador();
		}
		
		public function get campo():Array
		{
			return null;
		}
		
		public function set campoMsg(str:String):void
		{
		}
		
		public function get isReady():Boolean
		{
			return selected;
		}		
		
		public function addDefaultValue(str:String):void{}
		public function putIndicador():void{if(_statusTxt)_statusTxt.text = "Debes aceptar las bases y condiciones"}		
		public function quitIndicador():void{if(_statusTxt)_statusTxt.text =""}
	}
}