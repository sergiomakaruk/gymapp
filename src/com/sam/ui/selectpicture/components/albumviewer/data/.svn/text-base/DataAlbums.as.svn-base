package com.sam.ui.selectpicture.components.albumviewer.data
{
	import com.sam.ui.selectpicture.SelectPicture;
	import com.sam.ui.selectpicture.components.albumviewer.view.components.FBPicturesContainer;
	
	import sm.utils.object.GetObject;

	public class DataAlbums
	{		
		private var _uid:String;
		private var _albums:Vector.<DataAlbum>;		
		private var _albumsContainer:FBPicturesContainer;
		
		public function get albumsContainer():FBPicturesContainer{return _albumsContainer;}
		public function get albums():Vector.<DataAlbum>{return _albums;}
		
		public function set uid(value:String):void{_uid=value;}
		public function get uid():String{return _uid;}
		
		public function DataAlbums()
		{
			
		}
		
		public function createAlbums(data:Object):void
		{
			_albums = new Vector.<DataAlbum>();
			_albumsContainer = new FBPicturesContainer();
				
			if(data.hasOwnProperty("data"))
			{
				for each(var album:Object in data.data)
				{
					GetObject.traceObj(album);
					
					var dataAlbum:DataAlbum = new DataAlbum();
					dataAlbum.albumObjId = album.object_id;
					
					dataAlbum.albumName = album.name;
					dataAlbum.count = album.size;						
					if(dataAlbum.count > 0)
					{			
						
						if(album.hasOwnProperty("cover_pid") && album.hasOwnProperty("src"))
						{	
										
						
							//dataAlbum.createPicture(SelectPicture.PROXY + album.cover.src);
						//var str:String = "https://graph.facebook.com/" + album.object_id + "/picture&access_token=" + NetUtils.TOKEN;
						//trace(str);
							dataAlbum.createPicture(SelectPicture.PROXY + album.src);
							
							_albumsContainer.addFBButton(dataAlbum.fbPicture);			
							_albums.push(dataAlbum);							
						}
					}					
				}
			}
			if(_albums.length)_albumsContainer.init();
			else _albumsContainer.noData();
			trace(">>>>>>>>> ---- ALBUMS LENGHT ",_albums.length);
		}
		
		public function getAlbumById(albumObjId:String):DataAlbum
		{
			for each(var album:DataAlbum in _albums)
			{
				if(album.albumObjId == albumObjId)return album;				
			}
			return null
		}
	}
}