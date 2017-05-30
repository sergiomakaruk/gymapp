package com.sam.ui.selectpicture.components.facebookbuscadoramigos.view.buscador
{
	import com.greensock.TweenMax;
	import com.sam.events.ButtonEvent;
	import com.sam.ui.button.Button;
	import com.sam.utils.getDisplayObjects.GetDrawedObjects;
	import com.sam.utils.getDisplayObjects.GetImage;
	import com.sam.utils.graphics.GetGraphics;
	
	import flash.display.*;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class ResultFriends extends Button
	{
		private const ANCHO:uint = 500;		
		private const ALTO:uint = 60;	
		private const OVER_COLOR:uint = 0xcccccc;
		private var _textResult:TextField;
		private var _back:Shape;
		
		private var _uid:String;
		private var _friendName:String;
		private var _picturePath:String;	
		private var image:Sprite;
		
		public function get uid():String{return _uid;}
		public function get friendName():String{return _friendName;}
		public function set uid(value:String):void{_uid = value;}
		public function set friendName(value:String):void{_friendName = value;}
		public function set picturePath(value:String):void{_picturePath = value;}
		
		public function ResultFriends()
		{
			this.unlock();			
			listeners();
		}	
		public function init():void
		{
			_textResult = new TextField();
			_textResult.defaultTextFormat = new TextFormat("Arial",20,0x4c4c4c,false);
			_textResult.x = 60;
			_textResult.y = 15;
			_textResult.width = ANCHO - 60;
			_textResult.height = 30;
			_textResult.selectable = false;
			_textResult.multiline = false;
			_textResult.text = _friendName;
			addChild(_textResult);
			
			GetGraphics.drawRect(this,null,ANCHO,ALTO,0,0);
						
			_back = GetDrawedObjects.getShape(ANCHO,ALTO,OVER_COLOR,1);		
			_back.alpha = 0;
			addChildAt(_back,0);
			
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}
		private function onAdded(e:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			image = GetImage.getLoadingImage(_picturePath,50,50,onComplete);
			image.x = 5;
			image.y = 5;
			addChild(image);			
		}
		private function onComplete():void
		{
			//Debug.traceDebug("complete",image);
			//addChild(new Bitmap(GetImage.getBitmapDataFromDisplayObject(image,50,50)));
		}
		
		private function listeners():void
		{		
			this.addEventListener(ButtonEvent.onCLICK,onClick);	
			this.addEventListener(ButtonEvent.onOVER,onOver);	
			this.addEventListener(ButtonEvent.onOUT,onOut);	
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		private function onRemoved(event:Event=null):void
		{
			active = true;
		}
		private function onOver(event:Event=null):void
		{			
			TweenMax.to(_back,0.3,{alpha:1});
		}
		private function onOut(event:Event=null):void
		{		
			TweenMax.to(_back,0.3,{alpha:0});
		}
		override protected function setAsActive():void
		{
			this.unlock();
			onOut();
		}
		override protected function setAsInactive():void
		{
			this.lock();
			onOver();
		}
		override public function destroy():void
		{
			_back = null;
			this.removeEventListener(ButtonEvent.onCLICK,onClick);		
			super.destroy();
		}
		private function onClick(event:Event):void
		{			
			dispatchEvent(new Event(Event.SELECT,true));			
		}		
	}
}