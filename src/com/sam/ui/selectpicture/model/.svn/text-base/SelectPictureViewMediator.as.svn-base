package com.sam.ui.selectpicture.model
{
	import com.sam.ui.selectpicture.SelectPicture;
	import com.sam.ui.selectpicture.components.albumviewer.view.AlbumViewer;
	import com.sam.ui.selectpicture.components.camera.CameraSnapshot;
	import com.sam.ui.selectpicture.components.friendsalbumsviewer.view.FriendsAlbumsViewer;
	import com.sam.ui.selectpicture.components.uploadfile.UploadImageFromDeskView;
	import com.sam.ui.selectpicture.view.SelectPictureView;
	import com.sam.ui.selectpicture.view.components.SelectPictureComponent;
	
	import flash.display.DisplayObject;
	import flash.events.*;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sm.utils.events.CustomEvent;

	
	public class SelectPictureViewMediator extends Mediator
	{				
		public function SelectPictureViewMediator()
		{					
		}
		
		override public function onRegister():void
		{
			this.addViewListener(Event.CHANGE,onChangeComponent);				
		}
		private function onChangeComponent(e:CustomEvent):void
		{
			var componentName:String = e.params.componentName;
			var currentComponent:SelectPictureComponent;
			trace("componentName",componentName);
			switch(componentName)
			{
				case SelectPicture.OWN_ALBUM:					
					currentComponent = new AlbumViewer("");			
					break;
				
			/*	case SelectPicture.FRIENDS_ALBUM:
					currentComponent = GetFriendsAlbumViewer.getFriendsAlbumViewer("",this.facade);					
					break;
				*/
				case SelectPicture.DISK_PICTURE:
					currentComponent = new UploadImageFromDeskView();
					break;
				
				case SelectPicture.CAMERA_PICTURE:
					currentComponent = new CameraSnapshot();
					break;
					
				default:trace("no se encontro un componente ",componentName," en SelectPictureViewMediator.onChangeComponent()");
			}			
				
			content.changeComponent(currentComponent);
		}
		
		protected function get content():SelectPictureView
		{
			return viewComponent as SelectPictureView;
		}
	}
}