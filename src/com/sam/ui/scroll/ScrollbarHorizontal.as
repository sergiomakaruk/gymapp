package com.sam.ui.scroll
{
	import sm.fmwk.ui.button.Button;
	
	import flash.display.DisplayObject;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.filters.BlurFilter;
	import flash.geom.Rectangle;
	
	public class ScrollbarHorizontal extends Sprite implements IScroll
	{		
		public static const SCROLL_TO_START_END:String = "scrollToStartEnd";
		
		private var _page:Stage
		
		private var _dragged:DisplayObject; 
		private var _mask:DisplayObject; 
		private var _ruler:Sprite; 
		private var _background:DisplayObject; 
		private var _hitarea:DisplayObject;
		private var _upScrollButton:Button;
		private var _downScrollButton:Button;
		private var _blurred:Boolean;		
		private var _YFactor:Number;
		
		//Flags
		private var _isScrolling:Boolean = false;
		private var _scrollToStart:Boolean = false;
		
		private var rulerConstMove:Number = 0;
		private var minX:Number;
		private var maxX:Number;
		private var percentuale:uint;
		private var contentstartx:Number=0; 
		private var bf:BlurFilter;
		private var marginError:uint;
		
		private var initialized:Boolean = false; 
		private var _asset:ScrollView;
		
		public function ScrollbarHorizontal(blurred:Boolean = false, yfactor:Number = 4)
		{
			_blurred = blurred; 
			_YFactor = yfactor; 
		}	
		public function addView(asset:ScrollView):void
		{	
			_asset = asset;
			_dragged = asset.dragged;			
			_mask = asset.maskclip; 			
			_background = asset.background; 
			_hitarea = asset.hitareaClip;	
			_ruler = asset.ruler; 
			
			if(asset.hasButtons)
			{
				_upScrollButton = asset.upScrollButton;
				_downScrollButton = asset.downScrollButton;		
			}					
		}		
		public function destroy():void
		{				
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandle);
			if(!_asset.hasButtons)
			{
				_ruler.removeEventListener(MouseEvent.MOUSE_DOWN, clickHandle); 
			}
			else
			{
				_downScrollButton.removeEventListener(MouseEvent.MOUSE_DOWN, buttonEventHandler);
				_downScrollButton.removeEventListener(MouseEvent.MOUSE_UP, buttonEventHandler);
				_upScrollButton.removeEventListener(MouseEvent.MOUSE_DOWN, buttonEventHandler);
				_upScrollButton.removeEventListener(MouseEvent.MOUSE_UP, buttonEventHandler);
				
				//this._downScrollButton.tabEnabled = false;
				//this._upScrollButton.tabEnabled = false;
			}
			
			_page.removeEventListener(MouseEvent.MOUSE_UP, releaseHandle);
			_asset = null;
			_page = null;			
			_dragged = null;
			_mask = null;			
			_background = null;
			_hitarea = null;	
			_ruler = null;	
			_upScrollButton = null;	
			_downScrollButton = null;	
		}
		public function scrollToStart():void
		{			
			if (this.percentuale != 0)
			{				
				this.rulerConstMove = -10;
				this._scrollToStart = true;
				
				this.addEventListener(Event.ENTER_FRAME, enterFrameHandle);		
			}
			else
			{
				this.dispatchEvent(new Event(SCROLL_TO_START_END, true));
			}
		}
		
		public function init():void 
		{
			
			_page = _asset.page;
			
			if (checkPieces() == false) {
				trace("SCROLLBAR: CANNOT INITIALIZE"); 
			}
			else 
			{
				/*if (initialized == true) {
					reset();
				}*/
				
				bf = new BlurFilter(0, 0, 1); 
				this._dragged.filters = new Array(bf); 
				this._dragged.mask = this._mask; 
				this._dragged.cacheAsBitmap = true; 
				
				this.minX = _background.x;
				this.maxX = this._background.width - this._ruler.width;
				
				this._ruler.buttonMode = true;
				this._ruler.tabEnabled = false;
				
				this.contentstartx = _dragged.x;
				
				if(_asset.hasRuller)
				{					
					_ruler.addEventListener(MouseEvent.MOUSE_DOWN, clickHandle); 
				}
				if(_asset.hasButtons)
				{
					this._downScrollButton.addEventListener(MouseEvent.MOUSE_DOWN, buttonEventHandler);
					this._downScrollButton.addEventListener(MouseEvent.MOUSE_UP, buttonEventHandler);
					this._upScrollButton.addEventListener(MouseEvent.MOUSE_DOWN, buttonEventHandler);
					this._upScrollButton.addEventListener(MouseEvent.MOUSE_UP, buttonEventHandler);
					
					//this._downScrollButton.tabEnabled = false;
					//this._upScrollButton.tabEnabled = false;
				}
				
				this._page.addEventListener(MouseEvent.MOUSE_UP, releaseHandle); 
				//this._page.addEventListener(MouseEvent.MOUSE_WHEEL, wheelHandle, true);
				
				
				reset();
				initialized = true; 
			}
		}
			private function checkPieces():Boolean 
		{
			var ok:Boolean = true; 
			if (_dragged == null) 
			{
				trace("SCROLLBAR: DRAGGED not set"); 
				ok = false; 	
			}
			
			if (_mask == null) 
			{
				trace("SCROLLBAR: MASK not set"); 
				ok = false; 	
			}
			
			if (_ruler == null) 
			{
				trace("SCROLLBAR: RULER not set"); 	
				ok = false; 
			}
			
			if (_background == null) 
			{
				trace("SCROLLBAR: BACKGROUND not set"); 	
				ok = false; 
			}
			
			if (_hitarea == null) 
			{
				trace("SCROLLBAR: HITAREA not set"); 	
				ok = false; 
			}
			return ok; 
		}
		
		private function clickHandle(e:MouseEvent):void
		{				
			var rect:Rectangle = new Rectangle(minX, _background.y, maxX, 0);	
			_ruler.startDrag(false, rect);
			
			this._isScrolling = true;
			
			if (!this.hasEventListener(Event.ENTER_FRAME)) this.addEventListener(Event.ENTER_FRAME, enterFrameHandle);
		}
		
		private function releaseHandle(e:MouseEvent):void 
		{
			_ruler.stopDrag();
			this._isScrolling = false;
		}
		
		private function wheelHandle(e:MouseEvent):void
		{
			if (this._hitarea.hitTestPoint(this._page.mouseX, this._page.mouseY, false))
			{
				scrollData(e.delta);		
			}
		}
		
		private function buttonEventHandler(event:MouseEvent):void
		{			
			//trace(event);
			if (!this._scrollToStart)
			{
				if (event.type == "mouseDown")
				{				
					this._isScrolling = true;
					
					if (event.target.name == "scrollUp")
					{
						this.rulerConstMove = -10;
					}
					else if (event.target.name == "scrollDown")
					{
						this.rulerConstMove = 10;
					}			
					if (!this.hasEventListener(Event.ENTER_FRAME)) this.addEventListener(Event.ENTER_FRAME, enterFrameHandle);				
				}
				else if (event.type == "mouseUp")
				{
					this._isScrolling = false;
					this.rulerConstMove = 0;
				}
			}
		}
		
		private function enterFrameHandle(event:Event):void
		{			
			if (this.rulerConstMove != 0)
			{
				var nextPos:Number = this._ruler.x + this.rulerConstMove;
				
				if (this.rulerConstMove < 0)
				{
					if (nextPos < this.minX)
					{
						this._ruler.x = this.minX;
					} 
					else
					{
						this._ruler.x += this.rulerConstMove;
					}
				}
				else
				{
					this._ruler.x += this.rulerConstMove;
				}
			}
			
			positionContent();
		}
		
		private function scrollData(q:int):void
		{
			var d:Number;
			var rulerX:Number; 
			
			var quantity:Number = this._ruler.width; 
			
			d = -q * Math.abs(quantity); 
			
			if (d > 0) {
				rulerX = Math.min(maxX, _ruler.x + d);
			}
			if (d < 0) {
				rulerX = Math.max(minX, _ruler.x + d);
			}
			
			_ruler.x = rulerX;
			
			positionContent();
		}
		
		public function positionContent():void 
		{			
			var downX:Number;
			var curX:Number;				
			var limit:Number = this._background. x + this._background.width - this._ruler.width; 
			
			if (this._ruler.x > limit) {
				this._ruler.x = limit; 
			} 
			
			checkContentLength();		
			
			if (this._ruler.x == this._background.width - this._ruler.width)
			{
				percentuale = 100;
			}
			else
			{
				percentuale = (100 / maxX) * (_ruler.x - this._background.x);
			}
			
			downX = _dragged.width - (_mask.width / 2);
			
			var fx:Number = contentstartx - (((downX - (_mask.width / 2)) / 100) * percentuale);			
			var curry:Number = _dragged.x; 
			var finalx:Number = fx;
			
			if (curry != finalx) 
			{
				var diff:Number = finalx-curry;
				curry += diff / _YFactor; 
				
				var bfactor:Number = Math.abs(diff)/8; 
				bf.blurX = bfactor/2; 
				if (_blurred == true) 
				{
					_dragged.filters = new Array(bf);
				}
			}
			
			if (Math.round(_dragged.x) - 1 == Math.round(finalx) || Math.round(finalx) + 1 == Math.round(finalx)) this.marginError++;
			
			if (Math.round(_dragged.x) == Math.round(finalx))
			{				
				this.marginError = 0;
				
				if (!this._isScrolling && !this._scrollToStart)
				{				
					this.removeEventListener(Event.ENTER_FRAME, enterFrameHandle);
				}
				
				if (this.percentuale == 0 && this._scrollToStart) 
				{
					this._scrollToStart = false;
					this.rulerConstMove = 0;
					this.dispatchEvent(new Event(SCROLL_TO_START_END, true));
					
					this.removeEventListener(Event.ENTER_FRAME, enterFrameHandle);
				}
			}
			
			_dragged.x = curry;
		}
		
		public function checkContentLength():Boolean
		{
			if (_dragged.width < _mask.width) {
				_ruler.visible = false;
				_mask.visible = false;
				_hitarea.visible = false;
				_background.visible = false;
				if(_asset.hasButtons)_downScrollButton.visible = false;
				if(_asset.hasButtons)_upScrollButton.visible = false;			
				
				return false;
			} else {				
				_mask.visible = true;
				_hitarea.visible = true;
				if(!_asset.hasRuller)_ruler.visible = false;
				else _ruler.visible = true;
				if(!_asset.hasRuller)_background.visible = false;
				else _background.visible = true;
				if(_asset.hasButtons)_downScrollButton.visible = true;
				if(_asset.hasButtons)_upScrollButton.visible = true;
				
				return true;
			}
		}		
		public function reset():void 
		{
			//return;
			this.removeEventListener(Event.ENTER_FRAME, enterFrameHandle);
			if(contentstartx != 0) _dragged.x = contentstartx; 
			_ruler.x = this._background.x; 	
			checkContentLength();
		}		
	}
}