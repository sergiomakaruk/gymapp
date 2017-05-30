package com.sam.form
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class InputTelefonoMultiText extends Sprite implements IInputForm
	{
		private var error:FormErrorClip;		
		private var hasToValidate:Boolean;
		private var codigo:TextField;
		private var telefono:TextField;
		private var face:MovieClip;
		private var _tabIndex:uint;
		
		public function InputTelefonoMultiText(_face:MovieClip,hasToValidate:Boolean=true)
		{		
			this.face = _face;
			this.hasToValidate = hasToValidate;
		
			error = new FormErrorClip(_face.errorClip);		
			
			codigo = _face.input_2;
			telefono = _face.input_4;
			
			codigo.maxChars = 6;
			codigo.restrict = "0-9";	
			codigo.text = "";
			
			telefono.maxChars = 8;
			telefono.restrict = "0-9";
			telefono.text = "";
		}
		
		public function get label():String
		{
			return face.name;
		}
		
		public function get campo():Array
		{
			return [face.input_1.text + face.input_2.text , face.input_3.text + face.input_4.text];
		}
		
		public function get isReady():Boolean
		{
			if(telefono.length < 8) return false;
			if(telefono.text == "" || codigo.text == "") return false;
			
			quitIndicador();
			return true;
		}
		
		public function set campoMsg(str:String):void{}		
		public function setTabIndex(n:uint):void
		{
			this._tabIndex = n;
			codigo.tabEnabled = true;
			codigo.tabIndex = n;
			telefono.tabEnabled = true;
			telefono.tabIndex = n++;
		}
		
		public function getTabIndex():uint{return _tabIndex+2;}		
		public function putIndicador():void{error.show()}		
		public function quitIndicador():void{error.hide()}	
		
		public function addDefaultValue(str:String):void{}
		
		public function destroy():void
		{
		}		
	}
}