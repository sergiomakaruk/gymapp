package com.sam.ui.selectpicture.components.facebookbuscadoramigos.mediators
{
	import com.sam.events.CustomEvent;
	import com.sam.ui.selectpicture.components.facebookbuscadoramigos.FBBuscadorAmigosEvents;
	import com.sam.ui.selectpicture.components.facebookbuscadoramigos.FBBuscadorAmigosTransferences;
	import com.sam.ui.selectpicture.components.facebookbuscadoramigos.data.DataFriend;
	import com.sam.ui.selectpicture.components.facebookbuscadoramigos.model.ModelFBBuscadorAmigos;
	import com.sam.ui.selectpicture.components.facebookbuscadoramigos.view.FBBuscadorAmigos;
	
	import flash.events.Event;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class FBBuscadorAmigosMediator extends Mediator implements IMediator
	{
		public const NAME:String = "FBBuscadorAmigosMediator";
		
		private var model:ModelFBBuscadorAmigos;
		
		public function FBBuscadorAmigosMediator( viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			addAutoRemove();
			listeners();
		}
	
	public function start(uid:String):void
	{		
		model = ModelFBBuscadorAmigos.getInstance(this.facade);		
		model.getFriends(uid,onFriends);
	}
	private function onFriends():void
	{
		content.data = model.dataFriend;
		content.init();
	}
	private function listeners():void
	{
		content.addEventListener(FBBuscadorAmigosEvents.FRIEND_SELECTED_EVENT,onFriendSelected);
	}
	private function onFriendSelected(e:CustomEvent):void
	{		
		this.sendNotification(FBBuscadorAmigosTransferences.FRIEND_SELECTED,e.params);
	}
	private function addAutoRemove():void
	{
		content.addEventListener(Event.REMOVED_FROM_STAGE,onContentRemoved);			
	}
	private function onContentRemoved(event:Event):void
	{
		content.removeEventListener(Event.REMOVED_FROM_STAGE,onContentRemoved);
		this.facade.removeMediator(NAME);		
	}
	private function get content():FBBuscadorAmigos
	{
		return viewComponent as FBBuscadorAmigos;
	}
	}
}