package com.formulario
{
	import com.greensock.*;
	import com.sam.events.ButtonEvent;
	import com.sam.ui.button.Button;
	import com.sam.utils.graphics.GetGraphics;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Lightbox extends Sprite
	{
		protected var _background:Button;
		protected var _timeline:TimelineMax;
		
		private var _alpha:Number;
		private var _color:uint;		
		private var _isBackInteractive:Boolean;
		
		public function Lightbox()
		{
			super();				
		}
		public function init(color:uint,alpha:Number,isBackInteractive:Boolean):void
		{
			_color = color;
			_alpha = alpha;
			_isBackInteractive = isBackInteractive;	
			
			_background = new Button();
			addChildAt(_background,0);
			_timeline = new TimelineMax({onReverseComplete:onReverseComplete});
			_timeline.paused = true;
			_timeline.append(TweenMax.from(_background,0.3,{alpha:0}));
						
			doAnimationIn();
			addListeners();			
		}
		private function addListeners():void
		{
			if(this._isBackInteractive)
			{
				_background.unlock();
				_background.addEventListener(ButtonEvent.onCLICK,onClose);
			}
			if(!stage)this.addEventListener(Event.ADDED_TO_STAGE,onLightboxAdded);
			else onLightboxAdded();
		}
		protected function onClose(e:Event=null):void
		{
			_timeline.reverse();
		}
		protected function onLightboxAdded(e:Event=null):void
		{
			drawBack();			
			_timeline.restart();
		}
		private function onReverseComplete():void
		{
			this.parent.removeChild(this);
			destroy();
		}
		private function drawBack():void
		{
			GetGraphics.drawRect(_background,null,stage.stageWidth,stage.stageHeight,_alpha,_color);
		}
		protected function doAnimationIn():void
		{
			_timeline.restart();
			//throw new Error("doAnimationIn() must be override in Lightbox Class");
		}
		public function destroy():void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onLightboxAdded);
			if(this._isBackInteractive)_background.removeEventListener(ButtonEvent.onCLICK,onClose);
			_background = null;
			_timeline = null;
		}
	}
}