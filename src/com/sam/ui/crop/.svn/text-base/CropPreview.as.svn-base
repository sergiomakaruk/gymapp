package com.sam.ui.crop
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	
	public class CropPreview extends Sprite
	{
		private var _outputAncho:Number;
		private var _outputAlto:Number;
		private var _previewAncho:Number;
		private var _previewAlto:Number;
		
		private var _bmd:BitmapData;		
		private var _ant:Bitmap;
		
		public function set outPutsValue(value:Array):void{_outputAncho = value[0];_outputAlto = value[1];}
		public function set previewValue(value:Array):void{_previewAncho = value[0];_previewAlto = value[1];}
		
		public function get bmd():BitmapData{return _bmd;}
		
		public function CropPreview()
		{			
			super();
		}
		
		public function render(target:Sprite,
								toolClip:DisplayObject,
								targetToDraw:DisplayObject,
								proportion:Number):void
		{		
			var x:Number = (toolClip.x - targetToDraw.x)  / targetToDraw.scaleX;
			var y:Number = (toolClip.y - targetToDraw.y)  / targetToDraw.scaleX;
			
			var sx:Number = targetToDraw.scaleX / toolClip.scaleY;
			var sy:Number = targetToDraw.scaleY / toolClip.scaleY;
			sx/= proportion;
			sy/= proportion;
			
			//translada las coordenadar p dibujar el BitmapData
			var matrix:Matrix = new Matrix();
			matrix.translate(-x,-y);		
			matrix.scale(sx,sy);	
			
			_bmd = new BitmapData(_outputAncho,_outputAlto,true,0x0000000);			
			_bmd.draw(targetToDraw,matrix);		
			var bmp:Bitmap = new Bitmap(_bmd);
			
			bmp.width = _previewAncho;
			bmp.height = _previewAlto;
			
			target.addChild(bmp);
			
			if(_ant)
			{				
				target.removeChild(_ant)
			}
			
			_ant = bmp;			
		}
		public function destroy():void
		{		
			_ant = null;			
		}
	}
}