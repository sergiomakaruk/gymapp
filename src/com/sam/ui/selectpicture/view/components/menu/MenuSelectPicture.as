package com.sam.ui.selectpicture.view.components.menu
{
	import com.sam.ui.selectpicture.SelectPicture;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import sm.fmwk.ui.button.Button;
	import sm.fmwk.ui.button.ButtonsContainer;
	import sm.fmwk.ui.button.events.ButtonEvent;
	import sm.utils.display.GetButton;
	import sm.utils.events.CustomEvent;
	
	public class MenuSelectPicture extends ButtonsContainer
	{
		
		private var content:MovieClip;
		public function MenuSelectPicture()
		{
			super();
		}
		
		public function addAssets(assets:MovieClip):void
		{
			content = assets;
			addChild(content);
		}
		public function init():void
		{
			var toRender:Vector.<String> = new Vector.<String>();
			
			if(content)
			{
				if(content.getChildByName(SelectPicture.OWN_ALBUM)) toRender.push(SelectPicture.OWN_ALBUM);
				if(content.getChildByName(SelectPicture.FRIENDS_ALBUM)) toRender.push(SelectPicture.FRIENDS_ALBUM);
				if(content.getChildByName(SelectPicture.DISK_PICTURE)) content.getChildByName(SelectPicture.DISK_PICTURE).visible = false;//toRender.push(SelectPicture.DISK_PICTURE);
				if(content.getChildByName(SelectPicture.CAMERA_PICTURE)) toRender.push(SelectPicture.CAMERA_PICTURE);
			}
			else
			{
				trace("No pusimos el MC del Menu en MenuSelectPicture")
			}
				
			addButtons(toRender);
		}
		private function addButtons(tocreateButtons:Vector.<String>):void
		{
			for each(var nameObFaceInContent:String in tocreateButtons)
			{
				var face:DisplayObject = content.getChildByName(nameObFaceInContent);
				if(!face) throw new Error("no se encontro el clip "+nameObFaceInContent+" en MenuSelectPicture.addButtons()");
				/*var btn:SelectPictureButton = new SelectPictureButton();
				btn.face = face;
				btn.unlock();
				content.addChild(btn);
				btn.getFaceCoords();*/
				var btn:SelectPictureButton;
				btn = GetButton.button(face,SelectPictureButton) as SelectPictureButton;
				btn.name = nameObFaceInContent;				
				buttons.push(btn);
			}
			
			this.addClickListeners();						
		}
		override protected function onButtonClicked():void
		{
			this.lock();
			if(this.currentBtn) this.currentBtn.active = true;
			this.currentBtn = this.currentTarget;
			this.currentBtn.active = false;
					
			dispatchEvent(new CustomEvent(Event.CHANGE,{componentName:this.currentBtn.name}));
		}
		public function inicilizeDefaultComponent():void
		{			
			SelectPictureButton(buttons[0]).dispatchEvent(new Event(ButtonEvent.onCLICK));
		}
	}
}