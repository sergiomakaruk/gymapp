package com.sam.ui.paginador.perciana
{
	import com.greensock.*;
	import com.greensock.easing.*;
	import com.sam.events.ButtonEvent;
	import com.sam.ui.paginador.ButtonPaginador;
	import com.sam.utils.getDisplayObjects.GetButton;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.events.Event;

	public class PaginadorPerciana
	{
		private var currentContainer:Sprite;
		private var counter:uint;
		private var maxItems:uint;
		private var items:Vector.<DisplayObject>;
		private var _target:DisplayObjectContainer;
		private var btnLeft:ButtonPaginador;
		private var btnRight:ButtonPaginador;

		private var currentBtn:ButtonPaginador;
		
		public function PaginadorPerciana()
		{
		}
		public function init(target:DisplayObjectContainer,
							 items:Vector.<DisplayObject>,
							 btnLeft:DisplayObject,
							 btnRight:DisplayObject,
							maxItems:uint):void
		{
			this._target = target;
			this.items = items;			
			this.maxItems = maxItems;
			
			this.btnLeft = GetButton.getCustomButtonFromFace(btnLeft,ButtonPaginador);
			this.btnRight = GetButton.getCustomButtonFromFace(btnRight,ButtonPaginador);
			this.btnLeft.drawHitArea(btnLeft.width,btnLeft.height-10);
			this.btnRight.drawHitArea(btnRight.width,btnRight.height-10);
			this.btnLeft.active = false;
			this.btnRight.active = true;
			//this.btnLeft.unlockeable = true;
			//this.btnRight.unlockeable = true;
						
			listeners(true);
			show();
		}		
		private function listeners(hasToAdd:Boolean):void
		{
			if(hasToAdd)
			{
				btnLeft.addEventListener(ButtonEvent.onCLICK,onClick);			
				btnRight.addEventListener(ButtonEvent.onCLICK,onClick);
			}
			else
			{
				btnLeft.removeEventListener(ButtonEvent.onCLICK,onClick);			
				btnRight.removeEventListener(ButtonEvent.onCLICK,onClick);
			}			
		}
		
		private function onClick(event:Event):void
		{
			currentBtn = event.target as ButtonPaginador;
			if(currentBtn == btnLeft)counter-=maxItems;
			else counter+=maxItems;
			show();
		}
		
		private function show():void
		{
			listeners(false);
			
			if(currentContainer)_target.removeChild(currentContainer);
			currentContainer = new Sprite();
			var tweens:Array = [];
			
			for(var i:uint=counter;i<counter+maxItems;i++)
			{
				if(i<items.length)
				{
					items[i].filters = null;
					items[i].alpha = 1;
					items[i].y = currentContainer.height;
					currentContainer.addChild(items[i]);
					tweens.push(items[i]);
				}				
			}
			
			var timeline:TimelineMax = new TimelineMax({onComplete:checkButtons});
			timeline.prependMultiple(TweenMax.allFrom(tweens,0.3,{alpha:0,blurFilter:{blurY:10},y:"-20"},0.05));
			_target.addChild(currentContainer);
		}
		private function checkButtons():void
		{	
			if(currentBtn && currentBtn.locked)currentBtn.unlock();
			//trace("checkButtons",counter,items.length - maxItems - 1);
			if(counter == 0 ) btnLeft.active = false;
			else if(!btnLeft.active) btnLeft.active=true;
			if(counter > (items.length - maxItems - 1)) btnRight.active = false;	
			else if(!btnRight.active) btnRight.active=true;	
			
			listeners(true);
		}		
		
		public function destroy():void
		{
			listeners(false);
			currentContainer=null;
			items=null;
			_target=null;
			btnLeft=null;
			btnRight=null;
		}
	}
}