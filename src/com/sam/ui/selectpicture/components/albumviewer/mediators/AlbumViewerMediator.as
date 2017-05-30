package com.sam.ui.selectpicture.components.albumviewer.mediators
{
	import com.sam.ui.selectpicture.SelectPicture;
	import com.sam.ui.selectpicture.components.albumviewer.AlbumViewerEvents;
	import com.sam.ui.selectpicture.components.albumviewer.AlbumViewerTransferences;
	import com.sam.ui.selectpicture.components.albumviewer.data.DataAlbum;
	import com.sam.ui.selectpicture.components.albumviewer.data.DataAlbums;
	import com.sam.ui.selectpicture.components.albumviewer.model.ModelAlbumViewer;
	import com.sam.ui.selectpicture.components.albumviewer.model.ModelAlbumViewerActor;
	import com.sam.ui.selectpicture.components.albumviewer.view.AlbumViewer;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.*;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sm.utils.events.CustomEvent;
	
	public class AlbumViewerMediator extends Mediator
	{	
		[Inject]
		public var model:ModelAlbumViewer;

		private var _dataAlbums:DataAlbums;
		private var _currentAlbum:DataAlbum;
		
		public function AlbumViewerMediator()
		{								
		}
		override public function onRegister():void
		{
			this.addViewListener(AlbumViewerEvents.GET_PICTURES_BY_ALBUM_ID_EVENT,onGetAlbum);
			this.addViewListener(AlbumViewerEvents.GET_PICTURE_EVENT,onGetPicture);
						
			start();
		}
		public function start():void
		{						
			model.getAlbums(content.uid,createAlbums);
		}
		//callbak
		private function createAlbums():void
		{					
			content.addRootAlbums(model.dataAlbums.albumsContainer);
		}	
		//callbak
		private function addSelectedAlbum():void
		{			
			content.changeAlbum(model.currentAlbum.albumContainer);
			content.unlock();
		}
		private function onGetAlbum(e:CustomEvent):void
		{
			content.lock();
			model.getPicturesByAlbumId(e.params.aid,content.uid,addSelectedAlbum);			
		}
		private function onGetPicture(e:CustomEvent):void
		{
			content.lock();
			model.getPicture(e.params.source,onPictureSelected);
		}
		private function onPictureSelected(bmd:BitmapData):void
		{			
			this.dispatch(new CustomEvent(SelectPicture.PICTURE_SELECTED,bmd));
		}
	
		private function get content():AlbumViewer
		{
			return viewComponent as AlbumViewer;
		}
	}
}