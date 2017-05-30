package com.sam.ui.selectpicture.components.facebookbuscadoramigos.view
{
	import com.sam.ui.scroll.ScrollView;
	import com.sam.ui.selectpicture.components.facebookbuscadoramigos.view.buscador.BuscadorFriends;
	import com.sam.ui.selectpicture.components.facebookbuscadoramigos.view.buscador.ResultFriends;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class FBBuscadorAmigos extends Sprite
	{
		private var _data:Vector.<ResultFriends>;
		public function set data(value:Vector.<ResultFriends>):void{_data=value;}
		
		private var buscador:BuscadorFriends ;
		
		public function FBBuscadorAmigos()
		{
			super();
		}
		
		public function init():void
		{			
			var face:inputFriendNameSP = new inputFriendNameSP();
			addChild(face);		
			
			var scrollClip:ScrollView = new ScrollView();	
			scrollClip.autoRemoved = false;
			scrollClip.hasButtons = true;
			scrollClip.hasRuller = true;
			scrollClip.addAssets(new picturesContainerSP());
			
			buscador = new BuscadorFriends();
			buscador.data = _data;
			buscador.scrollView = scrollClip;
			buscador.inputText = face.friend_name_txt;
			buscador.resultsContainer = face.resultContainer;			
			buscador.init();			
		}
		public function reset():void
		{
			buscador.reset();
		}
	}
}