package com.sam.ui.selectpicture.components.uploadfile
{
	import com.greensock.TweenMax;
	import com.sam.ui.selectpicture.view.components.SelectPictureComponent;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import sm.fmwk.ui.button.Button;
	import sm.fmwk.ui.button.events.ButtonEvent;
	import sm.utils.display.GetButton;
	import sm.utils.display.GetImage;

	
	public class UploadImageFromDeskView extends SelectPictureComponent
	{	
		private var content:uploadImageClipSP;
		private var btn:Button;

		private var select:Button;
		
		public function UploadImageFromDeskView()
		{
			super();
			
			content = new uploadImageClipSP();
			content.status_txt.mouseEnabled = false;
			addChild(content);
			
			btn = GetButton.button(content.btnContinue);
			content.addChild(btn);
			btn.addEventListener(ButtonEvent.onCLICK,onEnd);
			btn.alpha = 0;
			btn.visible = false;
			
			select = GetButton.button(content.btnSelect);
			select.addEventListener(ButtonEvent.onCLICK,onClickSave);
		}
		override public function show():void
		{
			content.targetName_txt.text = "";
			this.timeline.allFrom(content,{alpha:0});
			super.show();
		}
		private function onClickSave(e:Event):void
		{
			select.unlock();
			TweenMax.to(btn,0.3,{autoAlpha:0});
			dispatchEvent(new Event(Event.SELECT));
		}
		private function onEnd(e:Event):void
		{
			dispatchEvent(new Event(Event.COMPLETE));
		}
		public function setStatus(str:String):void
		{
			content.status_txt.text = str;
		}
		public function addContinueBtn():void
		{
			TweenMax.to(btn,0.3,{autoAlpha:1});
		}
		override public function destroy():void
		{
			content.btnSelect.removeEventListener(MouseEvent.CLICK,onClickSave);
			btn.removeEventListener(ButtonEvent.onCLICK,onEnd);
			content = null;
			btn = null;
		}
		
		public function addImage(image:Bitmap,name:String):void
		{
			content.targetName_txt.text = name;
			
			//image.width = 150;
			//image.scaleY = image.scaleX;
			content.preview.addChild(GetImage.getCenterAndScaleImageFromOther(image,150,100));			
		}
	}
}
