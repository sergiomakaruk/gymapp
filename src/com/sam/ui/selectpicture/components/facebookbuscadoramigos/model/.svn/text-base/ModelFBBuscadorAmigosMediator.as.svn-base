package com.sam.ui.selectpicture.components.facebookbuscadoramigos.model
{
	import com.puremvc.ApplicationFacade;
	import com.puremvc.view.section.SectionTypes;
	import com.sam.events.CustomEvent;
	import com.sam.net.transferences.DataTransferenceData;
	import com.sam.ui.selectpicture.components.facebookbuscadoramigos.FBBuscadorAmigosEvents;
	import com.sam.ui.selectpicture.components.facebookbuscadoramigos.FBBuscadorAmigosTransferences;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLVariables;
	
	import org.puremvc.as3.interfaces.IMediator;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.mediator.Mediator;
	
	public class ModelFBBuscadorAmigosMediator extends Mediator implements IMediator
	{
		public static const NAME:String = "ModelFBBuscadorAmigosMediator";
		
		public function ModelFBBuscadorAmigosMediator( viewComponent:Object=null)
		{
			super(NAME, viewComponent);
			
			listeners();
		}
		override public function listNotificationInterests():Array
		{
			return [ApplicationFacade.TRANSFERENCE_MESSAGE_FINISH];
		}
		override public function handleNotification(note:INotification):void
		{
			var data:DataTransferenceData = note.getBody() as DataTransferenceData;
			switch(data.type)
			{
				case FBBuscadorAmigosTransferences.GET_FRIENDS:
					content.parseFriends(data.data);
					break;
			}
		}
		private function listeners():void
		{
			content.addEventListener(FBBuscadorAmigosEvents.LOAD_FRIENDS,onLoadFriends);
		}
		private function onLoadFriends(e:CustomEvent):void
		{
			var uid:String = e.params.uid;
			var variables:Object = {};
			variables.uid = uid;
			var data:DataTransferenceData = new DataTransferenceData(FBBuscadorAmigosTransferences.GET_FRIENDS,variables);
			data.notification = FBBuscadorAmigosTransferences.START_FB_BUSCADOR_AMIGOS_TR;
			this.sendNotification(ApplicationFacade.MESSAGE_CHANGED,data,SectionTypes.MINIMAL_TRANSFERENCE);
		}
		private function get content():ModelFBBuscadorAmigos
		{
			return this.viewComponent as ModelFBBuscadorAmigos;
		}
	}
}