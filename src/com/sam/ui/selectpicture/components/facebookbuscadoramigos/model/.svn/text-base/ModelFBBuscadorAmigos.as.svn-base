package com.sam.ui.selectpicture.components.facebookbuscadoramigos.model
{
	import com.puremvc.ApplicationFacade;
	import com.application.data.types.core.Data;
	import com.sam.events.CustomEvent;
	import com.sam.ui.selectpicture.SelectPicture;
	import com.sam.ui.selectpicture.components.facebookbuscadoramigos.FBBuscadorAmigosEvents;
	import com.sam.ui.selectpicture.components.facebookbuscadoramigos.FBBuscadorAmigosTransferences;
	import com.sam.ui.selectpicture.components.facebookbuscadoramigos.controller.FBBuscadorAmigosCommand;
	import com.sam.ui.selectpicture.components.facebookbuscadoramigos.view.buscador.ResultFriends;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	import org.puremvc.as3.interfaces.IFacade;
	
	public class ModelFBBuscadorAmigos extends EventDispatcher
	{
		private var _currentCallback:Function;
		private var _viewData:Vector.<ResultFriends>;
		
		public function get dataFriend():Vector.<ResultFriends>{return _viewData;}
		
		public function init():void
		{
			_viewData = new Vector.<ResultFriends>();
		}
		
		public function getFriends(uid:String,callBack:Function):void
		{
			_currentCallback = callBack;
			if(_viewData.length) _currentCallback();
			else
			{
				dispatchEvent(new CustomEvent(FBBuscadorAmigosEvents.LOAD_FRIENDS,{uid:uid}));
			}
		}
		public function parseFriends(data:Object):void
		{
			if(data.hasOwnProperty("amigos"))
			{
				for each(var friend:Object in data.amigos)
				{
					var resultFriend:ResultFriends = new ResultFriends();
					resultFriend.uid = friend.uid;
					resultFriend.friendName = friend.name;
					resultFriend.picturePath = SelectPicture.PROXY + friend.pic_square;
					resultFriend.init();
					_viewData.push(resultFriend);
				}
			}			
			_currentCallback();
		}
		
		///////////////////////////SINGLETON//////////////////////////////////
		private static var _instance:ModelFBBuscadorAmigos;
		public static function getInstance(facade:IFacade):ModelFBBuscadorAmigos
		{
			if(!_instance) 
			{
				_instance = new ModelFBBuscadorAmigos(new SingletonEnforcer());
				facade.registerCommand(FBBuscadorAmigosTransferences.START_FB_BUSCADOR_AMIGOS_TR,
					FBBuscadorAmigosCommand);
				facade.registerMediator(new ModelFBBuscadorAmigosMediator(_instance));			
			}
			return _instance;
		}
		
		public function ModelFBBuscadorAmigos(singleton:SingletonEnforcer)
		{
			init();
		}		
	}
}

class SingletonEnforcer{};