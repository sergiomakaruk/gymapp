package com.sam.ui.selectpicture.components.friendsalbumsviewer.view
{
	import com.greensock.TweenMax;
	
	import sm.fmwk.ui.button.Button;
	import sm.fmwk.ui.button.events.ButtonEvent;

	import com.sam.ui.selectpicture.components.facebookbuscadoramigos.view.FBBuscadorAmigos;
	import com.sam.ui.selectpicture.view.components.SelectPictureComponent;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class FriendsAlbumsViewer extends SelectPictureComponent
	{
		private var _buscador:FBBuscadorAmigos;
		private var _currentAlbum:Sprite;
		private var volver:Button;
		
		public function FriendsAlbumsViewer()
		{
			super();
			init();
		}
		private function init():void
		{
			volver = new Button();
			volver.face = new bot_volverMc();			
			volver.addEventListener(ButtonEvent.onCLICK,onVolver);
			volver.alpha=0;
			volver.visible=false;
			volver.x = 12;
			volver.y = 418;
			addChild(volver);
		}
		private function onVolver(e:Event):void
		{
			_currentAlbum.mouseChildren = false;
			TweenMax.to(volver,0.3,{autoAlpha:0});
			TweenMax.to(_currentAlbum,0.3,{autoAlpha:0,delay:0.3,onComplete:removeAlbum});
		}
		private function removeAlbum():void
		{
			removeChild(_currentAlbum);	
			TweenMax.to(_buscador,0.3,{autoAlpha:1});
			_buscador.reset();
		}
		public function addBuscador(buscador:FBBuscadorAmigos):void
		{
			_buscador = buscador;
			addChild(_buscador);
		}
		public function addAlbum(album:Sprite):void
		{
			volver.unlock();
			_currentAlbum = album;
			TweenMax.to(_buscador,0.3,{autoAlpha:0});
			TweenMax.from(_currentAlbum,0.3,{autoAlpha:0,delay:0.3});
			TweenMax.to(volver,0.3,{autoAlpha:1,delay:0.6});
			addChild(_currentAlbum);
		}
		public function destroy():void
		{
			volver.removeEventListener(ButtonEvent.onCLICK,onVolver);
			volver = null;
			 _buscador  = null;
			 _currentAlbum = null;
		}
	}
}