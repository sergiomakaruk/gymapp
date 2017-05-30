package com.sam.ui.crop
{
	import com.senocular.display.transform.ControlSetScaleCorners;
	import com.senocular.display.transform.ControlSetScaleSides;
	import com.senocular.display.transform.ControlSetStandard;
	import com.senocular.display.transform.ControlsSetScaleUniform;
	import com.senocular.display.transform.TransformTool;
	import com.senocular.display.transform.custom.CustomControlsSetScaleUniform;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import sm.utils.backgrounds.PhotoshopBackground;
	import sm.utils.display.GetDrawedObjects;
	import sm.utils.display.imagedata.GetImageData;

	public class Crop extends Sprite
	{
		public static const RENDER:String="render";
		
		private var _page:Stage;
		private var _anchoCanvas:Number;
		private var _altoCanvas:Number;
		private var _ancho:Number;
		private var _alto:Number;
		private var _proportion:Number;
		private var _targetToDraw:Bitmap;
		private var _tool:TransformTool;
		private var _renderPreview:CropPreview;
		private var _toolClip:Sprite;
		private var _canvas:Sprite;
		private var _preview:Sprite;
		private var _outPutsValue:Array;
		private var _previewValue:Array;
		
		public function set targetToDraw(value:Bitmap):void{_targetToDraw = value;}
		public function set dimensionsValue(value:Array):void{_ancho = value[0];_alto = value[1];}
		public function set canvasDimensions(value:Array):void{_anchoCanvas = value[0];_altoCanvas = value[1];}
		public function set outPutsValue(value:Array):void{_outPutsValue = value;}
		public function set previewValue(value:Array):void{_previewValue=value;}
		public function set proportion(value:Number):void{_proportion = value;}
		
		public function get ancho():Number{return _ancho;}
		public function get alto():Number{return _alto;}
		public function get proportion():Number{return _proportion;}

		public function get preview():Sprite{return _preview;}
		public function get canvas():Sprite{return _canvas;}
		public function get outPut():BitmapData{return _renderPreview.bmd;}
		
		public function Crop()
		{
			_preview = new Sprite();
			_canvas = new Sprite();
		}
		public function init(cropColor:uint=0xFF0000,cropAlpha:Number=0.3):void
		{
			validarImagen();			
			_renderPreview = new CropPreview();
			_renderPreview.outPutsValue = _outPutsValue;
			_renderPreview.previewValue = _previewValue;
			_toolClip = GetDrawedObjects.getSprite(_outPutsValue[0] * _proportion,_outPutsValue[1] * _proportion,cropColor,cropAlpha);				
				
			_canvas.addChild(new PhotoshopBackground(_anchoCanvas,_altoCanvas));
			_canvas.addChild(_targetToDraw);
			createTransFormTool();
			
			centerTargetAndMaxMinScalesAndLimits();	
			startCrop();
		}
		public function addTarget(target:Bitmap,hasToPixelate:Boolean=false,forceAncho:Number=0,forceAlto:Number=0):void
		{
			if(!hasToPixelate)
			{
				targetToDraw =  target;
				return;
			}	
			
			var redraw:Boolean;
			if(target.width < forceAncho)
			{
				target.width = forceAncho;
				target.scaleY = target.scaleX;	
				redraw = true;
			}
			
			if(target.height < forceAlto)
			{
				target.height = forceAlto;
				target.scaleX = target.scaleY;
				redraw = true;
			}
			
			if(!redraw)
			{
				targetToDraw =  target;
				return;
			}			 
			
			var container:Sprite = new Sprite();
			container.addChild(target);
			
			var bmp:Bitmap = new Bitmap(GetImageData.bitmapdata(container,true));
			targetToDraw =  bmp;
		}
		private function createTransFormTool():void
		{			
			var controls:Array = new CustomControlsSetScaleUniform();
			_tool = new TransformTool(controls);			
			_canvas.addChild(_tool);
			_canvas.addChild(_toolClip);	
					
			_tool.target = _toolClip;			
			_tool.restrictScale(true);			
			_tool.negativeScaling = false;	
			_tool.enforseLimits = true;
			_tool.autoRaise = true;			
		}		
		private function startCrop():void
		{
			///tool al medio del canvas
			_toolClip.x  = _targetToDraw.x + ((_targetToDraw.width - _toolClip.width)/2);
			_toolClip.y  = _targetToDraw.y + ((_targetToDraw.height - _toolClip.height)/2);
			
			_tool.registrationManager.defaultXY =  new Point(_toolClip.width/2,_toolClip.height/2);
			
			_tool.fitToTarget();
			_page = _canvas.stage;
			_page.addEventListener(MouseEvent.MOUSE_UP,onUp);
			this.addEventListener(Event.ENTER_FRAME,onEf);		
		}
		private function onUp(e:MouseEvent):void
		{
			check();
		}
		private function onEf(e:Event):void
		{	
			_renderPreview.render(_preview,_toolClip,_targetToDraw,proportion);	
		}
		private function check():void
		{
			var n:uint = 0;
			var hasToUpdate:Boolean;			
			
			var p1:Point = _toolClip.localToGlobal(new Point());
			var p2:Point = new Point(p1.x , p1.y + _toolClip.height);
			var p3:Point =  new Point(p1.x + _toolClip.width, p1.y + _toolClip.height);
			var p4:Point =  new Point(p1.x + _toolClip.width, p1.y);
			
			var t1:Point = _targetToDraw.localToGlobal(new Point());
			var t2:Point = new Point(t1.x , t1.y + _targetToDraw.height);
			//var t3:Point =  new Point(t1.x + _targetToDraw.width, t1.y + _targetToDraw.height);
			var t4:Point =  new Point(t1.x + _targetToDraw.width, t1.y);
			
			if(p1.x && p2.x < t1.x)
			{
				_toolClip.x = _targetToDraw.x  + n;
				hasToUpdate = true;
			}
			if(p3.x && p4.x > t4.x)
			{
				_toolClip.x = _targetToDraw.x + _targetToDraw.width - _toolClip.width - n;
				hasToUpdate = true;
			}
			if(p1.y && p4.y < t1.y)
			{
				_toolClip.y = _targetToDraw.y + n;
				hasToUpdate = true;
			}
			if(p2.y && p3.y > t2.y)
			{
				_toolClip.y = _targetToDraw.y + _targetToDraw.height - _toolClip.height - n;
				hasToUpdate = true;
			}	
			
			if(hasToUpdate)
			{	
				_tool.target = null;
				_tool.target = _toolClip;				
			}			
		}
		private function validarImagen():void
		{
			if(_targetToDraw.width < _ancho || _targetToDraw.height < _alto)
			{
				trace("ancho:",_targetToDraw.width,_ancho,"alto:",_targetToDraw.height,_alto);
				throw new Error("La imagen no tiene las mínimas dimensiones deseadas");
			}			
		}
		private function centerTargetAndMaxMinScalesAndLimits():void
		{	
			var maxScale:Number;
			var minScale:Number;
			if(_targetToDraw.width >_anchoCanvas)
			{
				_targetToDraw.width = _anchoCanvas;
				_targetToDraw.scaleY = _targetToDraw.scaleX;				
			}
			
			if(_targetToDraw.height > _altoCanvas)
			{
				_targetToDraw.height = _altoCanvas;
				_targetToDraw.scaleX = _targetToDraw.scaleY;									
			}
			
			maxScale = _targetToDraw.width / _toolClip.width;	
			if(_targetToDraw.height / _toolClip.height < maxScale ) maxScale = _targetToDraw.height / _toolClip.height;	
			
			//maxScale = _outPutsValue[1] / _toolClip.height;// _targetToDraw.height / _toolClip.height;	
			//maxScale = Math.min(maxScale,_outPutsValue[1] / _toolClip.height);
			//trace(_targetToDraw.height,"maxScale",maxScale);
			
			
			minScale = _targetToDraw.scaleX;
			_targetToDraw.x = Math.ceil((_anchoCanvas - _targetToDraw.width) / 2);
			_targetToDraw.y = Math.ceil((_altoCanvas - _targetToDraw.height) / 2);
			
			_tool.maxScaleX = _tool.maxScaleY = maxScale;
			_tool.minScaleX = _tool.minScaleY = minScale / proportion;
			
			var limits:Object = {left:_targetToDraw.x,
				right:_targetToDraw.x + _targetToDraw.width,
			top:_targetToDraw.y,
			button:_targetToDraw.y + _targetToDraw.height}
				
			_tool.limits = limits;
		}
		public function destroy():void
		{
			_page.removeEventListener(MouseEvent.MOUSE_UP,onUp);
			_page = null;
			this.removeEventListener(Event.ENTER_FRAME,onEf);
			_tool.target = null;
			_tool.registrationManager.clear();
			_tool = null;
			_toolClip = null;
			_targetToDraw = null;	
			_renderPreview.destroy();
		}
	}
}