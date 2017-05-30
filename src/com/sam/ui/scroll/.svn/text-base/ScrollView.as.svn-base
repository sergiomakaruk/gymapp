package com.sam.ui.scroll
{
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import sm.fmwk.ui.button.Button;
	import sm.utils.display.GetButton;
	
	public class ScrollView extends Sprite
	{
		//page:Stage, dragged:DisplayObject, maskclip:DisplayObject, ruler:DisplayObject, background:DisplayObject, hitarea:DisplayObject
		//upScrollButton:SimpleButton=null,downScrollButton:SimpleButton=null
		
		//USE ------>
		/*
			assetScroll = new ScrollView();
			assetScroll.backGroundColor = 0x999999;
			assetScroll.rulerColor = 0xFF0000;
			assetScroll.hasButtons = true;
			assetScroll.init();
			assetScroll.addText(str);	
		*/
		
		private var _dragged:Sprite;
		private var _maskclip:DisplayObject;
		private var _ruler:Sprite;
		private var _background:DisplayObject;
		private var _hitarea:DisplayObject;
		private var _upScrollButton:Button;
		private var _downScrollButton:Button;
		
		private var _width:uint = 250;
		private var _height:uint = 250;
		private var _scrollWidth:uint = 20;
		private var _backGroundColor:uint;
		private var _rulerColor:uint;
		
		private var _hasButtons:Boolean;
		private var _hasRuller:Boolean;

		private var _autoRemoved:Boolean = true;	
		private var scroll:IScroll;
		private var _drawBack:Boolean;
		private var _hasAssets:Boolean;
		private var _alphaBack:Number;
		private var isVerticalScroll:Boolean;
		
		public function get dragged():Sprite{return _dragged;}
		public function get maskclip():DisplayObject{return _maskclip;}
		public function get ruler():Sprite{return _ruler;}
		public function get background():DisplayObject{return _background;}
		public function get hitareaClip():DisplayObject{return _hitarea;}
		public function get upScrollButton():Button{return _upScrollButton;}
		public function get downScrollButton():Button{return _downScrollButton;}
		public function get hasButtons():Boolean{return _hasButtons;}
		public function get hasRuller():Boolean{return _hasRuller;}
		public function get page():Stage{return stage;}
		
		public function set widthAsset(value:uint):void{_width = value;}
		public function set heightAsset(value:uint):void{_height = value;}
		public function set scrollWidth(value:uint):void{_scrollWidth = value;}
		public function set alphaBack(value:Number):void{_alphaBack = value;}
		public function set backGroundColor(value:uint):void{_backGroundColor = value;}
		public function set rulerColor(value:uint):void{_rulerColor = value;}
		public function set hasButtons(value:Boolean):void{_hasButtons = value;}
		public function set hasRuller(value:Boolean):void{_hasRuller = value;}
		public function set drawBack(value:Boolean):void{_drawBack = value;}
		public function set autoRemoved(value:Boolean):void{_autoRemoved = value;}
			
		public function ScrollView(isVerticalScroll:Boolean=true)
		{
			this.isVerticalScroll = isVerticalScroll;
			super();
		}	
		public function init():void
		{	
			if(!_hasAssets)
			{
				drawAssets();
				createDragButton();	
				if(hasButtons) createButtons();	
			}			
			
			scroll = (isVerticalScroll) ? new Scrollbar() : new ScrollbarHorizontal();
			scroll.addView(this);	
			
			listeners();
		}		
		private function listeners():void
		{			
			if(_autoRemoved)addEventListener(Event.REMOVED_FROM_STAGE,onAssetRemoved);
			if(!stage)addEventListener(Event.ADDED_TO_STAGE,onAssetAdded);
			else onAssetAdded();				
		}		
		private function onAssetAdded(event:Event=null):void
		{
			if(event)removeEventListener(Event.ADDED_TO_STAGE,onAssetAdded);	
			update();
			scroll.init();
		}
		private function onAssetRemoved(event:Event):void
		{			
			removeEventListener(Event.REMOVED_FROM_STAGE,onAssetRemoved);
			scroll.destroy();
		}
		public function addAssets(assets:ScrollAssets):void
		{				
			addChild(assets);
			_hasAssets = true;
			_dragged = assets.dragged; 
			_maskclip = assets.maskclip; 
			_ruler = assets.ruler; 
			_background = assets.background; 
			_hitarea = assets.hitareaClip;
			_hitarea.alpha = 0;					
			
			//_background.height = _maskclip.height;
			
			if(assets.hasButtons)
			{			
				_upScrollButton = createButtonFromFace(assets.upScrollButton,true);
				_downScrollButton =  createButtonFromFace(assets.downScrollButton,false);
			}			
			
			addChild(_hitarea);
			addChild(_maskclip);
			addChild(_background);
			addChild(_ruler);
			addChild(_dragged);
			if(assets.hasButtons)
			{
				addChild(_upScrollButton);
				addChild(_downScrollButton);
			}			
			
			//if(_dragged)update();
		}
		public function addContent(display:DisplayObject):void
		{			
			if(_dragged.numChildren > 0)
			{				
				for(var i:int=_dragged.numChildren-1;i>-1;i--) 
				{					
					_dragged.removeChildAt(i);
				}
			}
			_dragged.addChild(display);
			update();
		}
		public function update():void
		{
			var alto:Number = 0; 
			var ancho:Number = 0;
			draw(_dragged,0,0,0,0);	
			alto = _dragged.height + ((_dragged.height * 5) / 100);
			ancho = _dragged.width + ((_dragged.width * 5) / 100);
			if(_drawBack)draw(_dragged,ancho,alto,0,_alphaBack);			
			scroll.reset();
		}
		public function addText(str:String):void
		{
			var text:TextField = new TextField();
			text.width = _width - 20;
			text.height = _height - 20;
			text.multiline = true;
			text.wordWrap = true;
			text.autoSize = TextFieldAutoSize.LEFT; 
			text.text = str;
			text.selectable = false;
			text.x = text.y = 10;
			addContent(text);			
		}
		private function drawAssets():void
		{
			_maskclip = new Shape();
			draw(_maskclip,_width,_height);
			
			_hitarea = new Shape();
			draw(_hitarea,_width,_height);
			_hitarea.alpha = 0;
			
			_dragged = new Sprite();
			
			addChild(_dragged);
			addChild(_hitarea);
			addChild(_maskclip);
		}		
		private function draw(clip:*,ancho:uint,alto:uint,color:uint=0,alpha:Number=1):void 
		{
			var g:Graphics = clip.graphics;
				g.clear();
				g.beginFill(color,alpha);
				g.drawRect(0,0,ancho,alto);
				g.endFill();			
		}
		private function createDragButton():void
		{
			_background = new Shape();
			draw(_background,_scrollWidth,_height,_backGroundColor);
			
			_ruler = new Sprite();
			draw(_ruler,_scrollWidth,20,_rulerColor);
			
			_background.x = this.width + 5;
			_ruler.x = _background.x;
			
			addChild(_background);
			addChild(_ruler);		
		}
		private function createButtons():void
		{
			_downScrollButton = getButton();
			_downScrollButton.scaleY = -1;
			_downScrollButton.name = "scrollDown";
			
			_upScrollButton = getButton();
			_upScrollButton.x = this.width + 5;
			_upScrollButton.name = "scrollUp";
			_downScrollButton.x = _upScrollButton.x
			_downScrollButton.y = this.height;
			
			addChild(_upScrollButton);
			addChild(_downScrollButton);
		}		
		private function getButton():Button
		{
			var button:Button = new Button();
			button.graphics.beginFill(_rulerColor);
			button.graphics.drawCircle(5,5,10);
			button.graphics.endFill();
			button.unlockeable = true;
			return button;
		}
		private function createButtonFromFace(face:DisplayObject,isUp:Boolean):Button
		{
			var button:Button = GetButton.button(face);
			if(!isUp)button.name = "scrollDown";			
			else button.name = "scrollUp";
			//button.face = face;
			//button.getFaceCoords();
			button.unlockeable = true;
			return button;
		}
	}
}