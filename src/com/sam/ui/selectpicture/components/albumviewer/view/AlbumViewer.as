package com.sam.ui.selectpicture.components.albumviewer.view
{

	import com.greensock.TweenMax;
	import com.sam.ui.paginador.PaginadorHorizontal;
	import com.sam.ui.paginador.PaginadorVertical;
	import com.sam.ui.scroll.ScrollView;
	import com.sam.ui.selectpicture.components.albumviewer.view.components.FBPicturesContainer;
	import com.sam.ui.selectpicture.view.components.SelectPictureComponent;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import sm.fmwk.ui.button.Button;
	
	public class AlbumViewer extends SelectPictureComponent
	{
		private var mainAlbums:FBPicturesContainer;
		private var currentPictures:FBPicturesContainer;
		private var h_scroll:ScrollView;
		private var content:albumViewerMC;

		private var volver:Button;
		private var _uid:String;

		public function get uid():String{return _uid;}
		public function get hasAlbum():Boolean{return currentPictures != null}
		
		public function AlbumViewer(uid:String)
		{
			super();
			_uid = uid;
			content = new albumViewerMC();	
			content.albumScrollClip.alpha = 0;
			//volver = GetButton.getClickListenedButton(content.volverBtn,onVolver,AppButton);
			//volver.visible = false;
			addChild(content);
			createScroll();		
		}
		
		private function onVolver():void
		{
			h_scroll.addContent(mainAlbums);
			currentPictures = null;
			//volver.visible = false;
			mainAlbums.active = true;				
		}
		private function createScroll():void
		{
			h_scroll = new ScrollView(false);
			//h_scroll.hasButtons = true;
			h_scroll.hasRuller = true;
			h_scroll.autoRemoved = false;
			//h_scroll.drawBack = true;
			
			h_scroll.x = content.scrollClip.x;
			h_scroll.y = content.scrollClip.y;
			h_scroll.addAssets(content.scrollClip);
			//h_scroll.x = content.backClip.x + ((content.backClip.width - h_scroll.width) / 2);
			//h_scroll.y = content.scrollClip.y;
			
			content.addChild(h_scroll);	
			h_scroll.init();	
			
			h_scroll.alpha = 0;
		}		
		
		public function changeAlbum(container:FBPicturesContainer):void
		{	
			trace("changeAlbum");
			currentPictures = container;
			//currentPictures.x = 5;
			currentPictures.y = -2;
			h_scroll.addContent(currentPictures);	
			//volver.active = true;
			//volver.visible = true;
			if(h_scroll.alpha == 0)TweenMax.to(h_scroll,0.3,{alpha:1});
		}
		
		/*public function addRootAlbums(container:FBPicturesContainer):void
		{
			trace("addRootAlbums");
			//container.addChild(GetDrawedObjects.getShape(100,100));
			mainAlbums = container;	
			mainAlbums.x = 5;
			mainAlbums.y = 5;
		
			h_scroll.addContent(mainAlbums);				
		}
		*/
		
		public function addRootAlbums(container:FBPicturesContainer):void
		{					
			/*var paginador:PaginadorVertical = new PaginadorVertical(140,180);
			mainAlbums = container;	
			mainAlbums.unlock();
			paginador.target = mainAlbums;			
			paginador.buttonUp = content.paginadorTest.btnUp;
			paginador.buttonDown = content.paginadorTest.btnDown;
			paginador.y = 10;
			paginador.moverAlto = 145;
			paginador.init();	
			
			content.paginadorTest.addChild(paginador);		*/	
			
			var h_scroll:ScrollView = new ScrollView(false);			
			h_scroll.hasRuller = true;
			h_scroll.autoRemoved = false;	
			h_scroll.drawBack = true;
			
			h_scroll.x = content.albumScrollClip.x;
			h_scroll.y = content.albumScrollClip.y;
			h_scroll.addAssets(content.albumScrollClip);		
			
			content.addChild(h_scroll);	
			h_scroll.init();	
			container.x = 8;
			container.y = 8;
			h_scroll.addContent(container);
			content.albumScrollClip.alpha = 1;
			TweenMax.from(h_scroll,0.3,{alpha:0});
		}
		public function lock():void
		{	
			if(currentPictures)currentPictures.active = false;
			if(mainAlbums)mainAlbums.active = false;
		}
		public function unlock():void
		{	
			if(currentPictures)currentPictures.active = true;
			if(mainAlbums)mainAlbums.active = true;
		}
		
		public function back():void
		{
			onVolver();			
		}
	}
}