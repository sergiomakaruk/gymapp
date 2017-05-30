package com.sam.ui.selectpicture.components.friendsalbumsviewer.mediator
{
	import com.sam.ui.selectpicture.components.albumviewer.GetAlbumViewer;
	import com.sam.ui.selectpicture.components.facebookbuscadoramigos.FBBuscadorAmigosTransferences;
	import com.sam.ui.selectpicture.components.facebookbuscadoramigos.GetFBBuscadorAmigos;
	import com.sam.ui.selectpicture.components.facebookbuscadoramigos.data.DataFriend;
	import com.sam.ui.selectpicture.components.friendsalbumsviewer.view.FriendsAlbumsViewer;
	
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class FriendsAlbumsViewerMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "FriendsAlbumsViewerMediator";
		public function FriendsAlbumsViewerMediator( viewComponent:Object=null)
		{
			super(NAME, viewComponent);
		}
		public function start(uid:String):void
		{
			content.addBuscador(GetFBBuscadorAmigos.getBuscador(uid,facade));
			content.addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		override public function listNotificationInterests():Array
		{
			return [FBBuscadorAmigosTransferences.FRIEND_SELECTED];
		}
		override public function handleNotification(note:INotification):void
		{
			switch(note.getName())
			{
				case FBBuscadorAmigosTransferences.FRIEND_SELECTED:
					var uid:String = DataFriend(note.getBody()).uid;
					content.addAlbum(GetAlbumViewer.getAlbum(uid,facade));
					break;
			}
		}
		private function onRemoved(e:Event):void
		{
			content.removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
			this.facade.removeMediator(NAME);
			content.destroy();
		}
		private function get content():FriendsAlbumsViewer
		{
			return this.viewComponent  as FriendsAlbumsViewer;
		}
	}
}