package com.sam.ui.selectpicture.components.uploadfile
{
	import com.sam.ui.selectpicture.SelectPicture;
	
	import flash.display.*;
	import flash.events.*;
	import flash.net.*;
	import flash.utils.ByteArray;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sm.utils.events.CustomEvent;

	
	public class UploadImageFromDeskViewMediator extends Mediator
	{
			private var jagFileRefSave:FileReference = new FileReference();
		private var _bmd:BitmapData;
		private var loader:Loader;
			
		public function UploadImageFromDeskViewMediator()
		{		
			
		}
		override public function onRegister():void
		{		
			this.addViewListener(Event.SELECT,onClickSave);			
			this.addViewListener(Event.REMOVED_FROM_STAGE,onRemoved);			
			this.content.addEventListener(Event.COMPLETE,onComplete);
		}
		private function onRemoved(e:Event):void
		{
			content.removeEventListener(Event.COMPLETE,onComplete);
			this.removeViewListener(Event.SELECT,onClickSave);			
			this.removeViewListener(Event.REMOVED_FROM_STAGE,onRemoved);			
			content.destroy();
			loader = null;
			jagFileRefSave = null;
			_bmd = null;			
		}
		private function onComplete(e:Event):void
		{ 
			this.dispatch(new CustomEvent(SelectPicture.PICTURE_SELECTED,_bmd));			
		}
		private function onClickSave(e:Event):void
		{    
			content.setStatus("");	
			var imagesFilter:FileFilter = new FileFilter("Images", "*.jpg;*.gif;*.png");
			jagFileRefSave.browse([imagesFilter]);
			jagFileRefSave.addEventListener(Event.SELECT, selectedFile);
		}        
		private function selectedFile(e:Event):void
		{
			content.setStatus(jagFileRefSave.name);
			jagFileRefSave.addEventListener(Event.COMPLETE, loaded);
			jagFileRefSave.load();			
		}
		private function loaded(e:Event):void
		{			
			loader = new Loader();
			var rawBytes:ByteArray = jagFileRefSave.data;		
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, getBitmapData);			
			loader.loadBytes(rawBytes);			
		}
		private function getBitmapData(e:Event):void
		{
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, getBitmapData)
			
			var ancho:Number = loader.content.width;
			var alto:Number = loader.content.height;
		
			
			if(ancho < SelectPicture.MIN_WIDHT || alto < SelectPicture.MIN_HEIGHT)
			{
				content.setStatus("La imagen es muy pequeña");
			}
			else
			{
				_bmd = new BitmapData(ancho,alto,true,0x00000000);
				_bmd.draw(loader.content);
				content.addImage(new Bitmap(_bmd),jagFileRefSave.name);
				content.addContinueBtn();
			}			
		}
		private function get content():UploadImageFromDeskView
		{
			return this.viewComponent as UploadImageFromDeskView;
		}
	}
}