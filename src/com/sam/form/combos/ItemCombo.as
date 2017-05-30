package com.sam.form.combos
{
	import com.greensock.TweenMax;
	
	import flash.display.*;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import sm.fmwk.ui.button.Button;
	import sm.fmwk.ui.button.events.ButtonEvent;
	
	public class ItemCombo extends Button
	{
		public static const COMBO_SELECTED:String="comboSelected";
		private const OVER_COLOR:uint = 0xcccccc;
		protected var _textResult:TextField;
		private var _back:Shape;
		private var content:*;
			
		private var _data:DataCombo;
		public function get data():DataCombo{return _data;}
		public function set data(dataCombo:DataCombo):void
		{
			_data = dataCombo;
			_textResult.text = dataCombo.id;
		}
		
		public function ItemCombo(ancho:Number)
		{
			this.unlockeable = true;
			
			init(ancho);
			listeners();
		}	
		private function init(ancho:Number):void
		{
			content = new itemComboSP();
			addChild(content);
			_textResult = content.valueText;
			this.graphics.beginFill(0xFF0000,0);
			this.graphics.drawRect(0,0,ancho,content.height);
			this.graphics.endFill();
			
			_back = new Shape();
			_back.graphics.beginFill(OVER_COLOR);
			_back.graphics.drawRect(1,1,ancho,content.height);
			_back.graphics.endFill();
			_back.alpha = 0;
			addChildAt(_back,0);
		}
		private function listeners():void
		{		
			this.addEventListener(ButtonEvent.onCLICK,onClick);	
			this.addEventListener(ButtonEvent.onOVER,onOver);	
			this.addEventListener(ButtonEvent.onOUT,onOut);				
		}
		private function onOver(event:Event):void
		{			
			TweenMax.to(_back,0.3,{alpha:1});
		}
		private function onOut(event:Event):void
		{		
			TweenMax.to(_back,0.3,{alpha:0});
		}
		override public function destroy():void
		{
			content = null;
			
			this.removeEventListener(ButtonEvent.onOVER,onOver);
			this.removeEventListener(ButtonEvent.onOUT,onOut);	
			this.removeEventListener(ButtonEvent.onCLICK,onClick);	
			super.destroy();
		}
		private function onClick(event:Event):void
		{				
			dispatchEvent(new Event(COMBO_SELECTED,true));			
		}		
	}
}