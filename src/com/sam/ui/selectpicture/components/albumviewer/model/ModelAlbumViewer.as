package com.sam.ui.selectpicture.components.albumviewer.model
{
	import com.sam.ui.selectpicture.components.albumviewer.AlbumViewerEvents;
	import com.sam.ui.selectpicture.components.albumviewer.AlbumViewerTransferences;
	import com.sam.ui.selectpicture.components.albumviewer.controller.AlbumViewerCommand;
	import com.sam.ui.selectpicture.components.albumviewer.data.DataAlbum;
	import com.sam.ui.selectpicture.components.albumviewer.data.DataAlbums;
	
	import flash.display.Bitmap;
	import flash.events.EventDispatcher;
	
	import sm.fmwk.net.parseData.ParseFacebook;
	import sm.utils.events.CustomEvent;

	public class ModelAlbumViewer extends EventDispatcher
	{	
		[Inject]
		public var modelActor:ModelAlbumViewerActor;
		
		private var _currentCallback:Function;
		
		private var _data:Vector.<DataAlbums>;
		private var _currentDataAlbums:DataAlbums;
		private var _currentAlbum:DataAlbum;
	
		public function get dataAlbums():DataAlbums{return _currentDataAlbums;}
		public function get currentAlbum():DataAlbum{return _currentAlbum;}
		
		public function ModelAlbumViewer()
		{
			_data = new Vector.<DataAlbums>();
		}
		
		public function getAlbums(uid:String,callBack:Function):void
		{
			_currentCallback = callBack;
			_currentDataAlbums = this.getCurrentDataAlbums(uid);
			if(!_currentDataAlbums) 
			{
				_currentDataAlbums = new DataAlbums();
				_currentDataAlbums.uid = uid;
				_data.push(_currentDataAlbums);
				
				modelActor.getAlbums(uid,parseAlbums);			
			}
			else _currentCallback();			
		}	
		///On get Albums Complete
		private function parseAlbums(data:Object):void
		{
			_currentDataAlbums.createAlbums(data);
			_currentCallback();
		}
		
		public function getPicturesByAlbumId(aObjId:String,uid:String,callBack:Function):void
		{
			_currentCallback = callBack;
			_currentDataAlbums = this.getCurrentDataAlbums(uid);
			_currentAlbum = _currentDataAlbums.getAlbumById(aObjId);
			if(_currentAlbum.albumContainer) _currentCallback();
			else
			{
				modelActor.getPicturesByAlbumId(aObjId,parseSelectedAlbum);	
			}
		}
		//on selectedAlbum Complete
		private function parseSelectedAlbum(data:Object):void
		{
			_currentAlbum.createAlbum(data);
			_currentCallback();
		}
		
		public function getPicture(source:String,callBack:Function):void
		{
			_currentCallback = callBack;
			var params:Object = {source:source};
			modelActor.getPicture(source,parsePicture);
		}
		//onLoadPictureComplete
		private function parsePicture(bitmap:Bitmap):void
		{		
			_currentCallback(bitmap.bitmapData);
		}
	
		private function getCurrentDataAlbums(uid:String):DataAlbums
		{
			for each(var dataA:DataAlbums in _data)
			{
				if(dataA.uid == uid)return dataA
			}
			return null;
		}
		public function destroy():void
		{
			throw new Error("Falta destruir ModelAlbumViewer");
		}

	
	}
}