package com.sam.ui.selectpicture.components.camera
{
	import com.greensock.TweenMax;
	import com.sam.ui.selectpicture.view.components.SelectPictureComponent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.StatusEvent;
	import flash.geom.Matrix;
	import flash.media.Camera;
	import flash.media.Video;
	
	import sm.fmwk.Fmwk;
	import sm.fmwk.ui.button.Button;
	import sm.fmwk.ui.button.events.ButtonEvent;
	import sm.utils.display.GetButton;
	import sm.utils.display.graphics.GetGraphics;
	import sm.utils.keyboard.Lister_ENTER_KEY;
	
	public class CameraSnapshot extends SelectPictureComponent
	{
		private const ANCHO:uint = 320;
		private const ALTO:uint = 240;
		
		private var youHasNoCamera:Button;

		private var content:camaraContainer;
		private var confinrmarMenu:MovieClip;

		private var snapShotBtn:Button;
		private var container:Sprite;

		private var video:Video;

		private var cam:Camera;

		private var volver:Button;

		private var bmd:BitmapData;
		
		public function CameraSnapshot()
		{
			content = new camaraContainer();
			content.btnSnapshot.visible = false;
			
			/*volver = GetButton.clickButton(content.volverBtn,onVolver);
			volver.visible = false;*/
			
			confinrmarMenu = content.menuConfirmar;
			confinrmarMenu.visible = false;
			confinrmarMenu.alpha = 0;
			addMenuButtons();
			
			youHasNoCamera = GetButton.clickButton(content.alerta,onCheck);
			youHasNoCamera.visible = false;				
			
			addChild(content);			
		}
		private function onVolver():void
		{
			this.dispatchEvent(new Event("volver",true));			
		}
		
		private function addMenuButtons():void
		{
			var btn:Button = GetButton.button(confinrmarMenu.btnConfirmar);
			btn.addEventListener(ButtonEvent.onCLICK,onMenuConfirmar);
			btn = GetButton.button(confinrmarMenu.btnReintentar);	
			btn.addEventListener(ButtonEvent.onCLICK,onMenuConfirmar);
		}		
		private function onMenuConfirmar(e:ButtonEvent):void
		{
			var btn:Button = e.target as Button;
			if(btn.face.name == "btnConfirmar")dispatchEvent(new Event(Event.COMPLETE));
			else
			{
				TweenMax.to(confinrmarMenu,0.3,{autoAlpha:0});
				snapShotBtn.active = true;
				snapShotBtn.visible = true;
				video.attachCamera(cam);
				btn.active = true;
			}			
		}
		override public function show():void
		{
			timeline.allFrom(content,{alpha:0});
			super.show();			
		}
		override protected function onShowed():void
		{
			checkCamara();
		}
		private function checkCamara():void
		{
			if(Camera.names.length==0)
			{	
				//volver.visible = true;
				GetGraphics.drawRect(youHasNoCamera,youHasNoCamera.width,youHasNoCamera.height);
				youHasNoCamera.visible = true;					
			}
			else
			{				
				addCamara();
			}
		}
		private function onCheck():void
		{
			if(Camera.names.length)
			{
				//volver.visible = false;
				youHasNoCamera.visible = false;
				youHasNoCamera.removeEventListener(MouseEvent.CLICK,onCheck);
				addCamara();				
			}
			else
			{				
				youHasNoCamera.active = true;
			}
		}	
		private function addCamara():void
		{				
			var names:Array = Camera.names;
			var name:String=null;
			for each(var cname:String in names)
			{
				if(cname != "")name=cname;
			}
			
			cam = Camera.getCamera();
			cam.addEventListener(StatusEvent.STATUS,onStatus);
			video = new Video(cam.width, cam.height);
			video.width = ANCHO;
			video.height = ALTO;
			video.attachCamera(cam);			
			
			container = new Sprite();
			container.addChild(video);
			container.scaleX = -1;
			container.x = ANCHO;
			
			content.insertCamera.addChild(container);
			TweenMax.from(video,1,{alpha:0});	
			
			content.btnSnapshot.visible = true;
			snapShotBtn = GetButton.clickButton(content.btnSnapshot,onSnapshot);
			//snapShotBtn.visible = false;
		}
		
		protected function onStatus(event:StatusEvent):void
		{
			 if(event.code ==  "Camera.Muted")
			 {
				 snapShotBtn.visible = false;
				 //new Lister_ENTER_KEY(snapShotBtn); 
			 }
			 else
			 {
				Fmwk.console(event); 
			 }			
		}
		
		private function onSnapshot():void
		{
			takePhoto();
			
			video.attachCamera(null);
			snapShotBtn.visible = false;
			TweenMax.to(confinrmarMenu,0.3,{autoAlpha:1});			
		}		
		private function takePhoto():void
		{
			bmd = new BitmapData(container.width,container.height,false);
			var matrix:Matrix = new Matrix();
			matrix.translate(-container.width,0);
			matrix.scale(-1,1);
			bmd.draw(container,matrix);
		}
		public function getFoto():BitmapData
		{			
			return bmd;
		}
		override public function destroy():void
		{
			if(video)video.attachCamera(null);		
			cam = null;			
			video = null;
			container = null;
			content = null;
			youHasNoCamera=null;		
			confinrmarMenu=null;			
			snapShotBtn=null;
		}
	}
}