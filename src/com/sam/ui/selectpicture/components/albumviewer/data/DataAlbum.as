package com.sam.ui.selectpicture.components.albumviewer.data
{
	import com.sam.ui.selectpicture.SelectPicture;
	import com.sam.ui.selectpicture.components.albumviewer.view.components.FBPicturesContainer;
	import com.sam.ui.selectpicture.components.albumviewer.view.components.FbPicture;
	
	import flash.display.Sprite;

	public class DataAlbum
	{
		private var _albumObjId:String;
		private var _albumName:String;
		private var _count:uint;
		private var _fbPicture:FbPicture;
		private var _albumContainer:FBPicturesContainer;
		
		public function get albumObjId():String{return _albumObjId;}
		public function set albumObjId(value:String):void{_albumObjId=value;}
		
		public function get albumName():String{return _albumName;}
		public function set albumName(value:String):void{_albumName=value;}
		
		public function get fbPicture():FbPicture{return _fbPicture;}
		public function get albumContainer():FBPicturesContainer{return _albumContainer;}
		
		public function set count(value:uint):void{_count=value;}
		public function get count():uint{return _count;}
		
		public function DataAlbum()
		{
			_fbPicture = new FbPicture(true);
		}
		
		public function createAlbum(data:Object):void
		{			
			_albumContainer = new FBPicturesContainer();
		
			if(data.hasOwnProperty("data"))
			{
				for each(var picture:Object in data.data)
				{
					var clip:FbPicture = new FbPicture(false);
					clip.renderText(null,null);
					clip.name = "n" + picture.pid;
					clip.originalPicturePath = picture.images[0].src;
					//traceDimenssions(picture.images);					
					clip.originalPicturesSizes = [picture.images[1].width,picture.images[1].height];
					clip.validate();
					if(picture.hasOwnProperty("src") )
					{						
						clip.loadImage( SelectPicture.PROXY +  picture.src);
					}					
					
					clip.x = _albumContainer.width + 10;
					
					_albumContainer.addFBButton(clip);					
				}
			}
			_albumContainer.init();
		}
		private function traceDimenssions(arr:Array):void
		{
			for each(var tamano:Object in arr)
			{
				trace(tamano.width,tamano.height);
				trace("----");
			}
		}
		public function createPicture(url:String):void
		{			
			//trace(url);
			_fbPicture.name = "n"+ _albumObjId;			
			_fbPicture.loadImage(url);
			//_fbPicture.renderText(_albumName);		
		}
	}
}