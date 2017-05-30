package com.sam.ui.selectpicture.components.albumviewer.view.components
{	
	import com.sam.ui.selectpicture.SelectPicture;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BitmapDataChannel;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import sm.fmwk.ui.custombutton.BorderButtons;
	import sm.fmwk.ui.custombutton.BorderMaskedButton;
	import sm.fmwk.ui.preload.SpinningPreloader;
	import sm.utils.display.GetImage;
	import sm.utils.display.graphics.GetGraphics;
	import sm.utils.matrix.GetMatrixFilter;
	
	public class FbPicture extends BorderMaskedButton
	{
		public static const ANCHO:uint = 100;
		public static const ALTO:uint = 65;
		
		private var preloader:SpinningPreloader;
		private var _content:FB_albumClip;
		private var _image:Bitmap;
		private var _isAlbum:Boolean;
		private var _originalPicturePath:String;
		private var _imageLoaded:Boolean;
		private var _originalPicturesSizes:Array;
		private var _isInvalidPicture:Boolean;
		
		public function set originalPicturePath(value:String):void{_originalPicturePath = value;}
		public function get originalPicturePath():String{return _originalPicturePath;}
		public function set originalPicturesSizes(value:Array):void{_originalPicturesSizes=value;}
		
		public function get isAlbum():Boolean{return _isAlbum};
		
		public function FbPicture(_isAlbum:Boolean)
		{
			super(0xFFFFFF,5);
			
			this._isAlbum = _isAlbum;
			_content = new FB_albumClip();	
			GetGraphics.drawRect(this,ANCHO,ALTO,0xFFF);
			addChild(_content);				
			
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
		}	
		public function validate():void
		{
			trace(_originalPicturesSizes[0],SelectPicture.MIN_WIDHT ,"||", _originalPicturesSizes[1],SelectPicture.MIN_HEIGHT);
			if(_originalPicturesSizes[0]<SelectPicture.MIN_WIDHT || _originalPicturesSizes[1]<SelectPicture.MIN_HEIGHT)
			{
				_isInvalidPicture = true;
				this.useHandCursor = false;
				this.buttonMode = false;
				this.removeListeners();
			}
		}
		public function loadImage(url:String):void
		{			
			_image = GetImage.getImage(url,onComplete);			
		}
		private function onComplete():void
		{
			_imageLoaded = true;
			this.removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
			this.removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			destroyPreloader();			
			var bmp:Bitmap = GetImage.getCenterAndScaleImageFromOther(_image,ANCHO,ALTO);		
			face = bmp;		
		
			if(_isInvalidPicture)
			{
				GetMatrixFilter.desaturate(bmp);
				var error:Sprite =  new errorImagenSP();
				error.x = (ANCHO - error.width ) *.5;
				error.y = (ALTO - error.height ) *.5;
				addChild(error);
			}
			else
			{
				this.addListeners();
			}
		}
		private function onAdded(e:Event):void
		{
			if(!_imageLoaded)
			{
				preloader = new SpinningPreloader(this,ANCHO/2,ALTO/2,15,24,4,2,0x368BC1);
				preloader.start();
			}
		}
		private function onRemoved(e:Event):void
		{
			destroyPreloader();
		}
		private function destroyPreloader():void
		{
			if(preloader)
			{
				preloader.stop();
				preloader.destroy();
				preloader = null;
			}
		}
		public function renderText(name:String,count:String=null):void
		{
			if(!name && !count)
			{
				//_content.removeChild(_content.album_name_txt);				
				return;
			}
			
			var maxChars:uint = 22;
			var t:TextField = _content.album_name_txt;
			t.text = (name.length>maxChars) ? name.substr(0,maxChars) + "..." : name;
			t.y = ALTO;
			t.width = ANCHO;
			t.wordWrap = true;				
			t.autoSize = TextFieldAutoSize.LEFT;			
			/*
			var t2:TextField = _content.pictures_lenght_txt;			
			t2.y = t.y + t.height;
			t2.text = count + " fotos";*/
		}
		override protected function setAsActive():void
		{
			super.onOut();
		}
		override protected function setAsInactive():void
		{
			super.onOver();
		}
	}
}