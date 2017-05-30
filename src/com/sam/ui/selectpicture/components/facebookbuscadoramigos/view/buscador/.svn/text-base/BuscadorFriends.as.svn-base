package com.sam.ui.selectpicture.components.facebookbuscadoramigos.view.buscador
{
	import com.sam.events.ButtonEvent;
	import com.sam.events.CustomEvent;
	import com.sam.ui.button.Button;
	import com.sam.ui.scroll.ScrollView;
	import com.sam.ui.selectpicture.components.facebookbuscadoramigos.FBBuscadorAmigosEvents;
	import com.sam.ui.selectpicture.components.facebookbuscadoramigos.data.DataFriend;
	
	import flash.display.*;
	import flash.display.DisplayObjectContainer;
	import flash.events.*;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;

	public class BuscadorFriends extends EventDispatcher
	{
		private const SEARCH_ID:String = "seachID_";
		private var _errorText:TextField;
		private var _inputText:TextField;
		private var _resultsContainer:MovieClip;
		private var _results:Vector.<ResultFriends>;	
		private var contenedor:MovieClip;
		private var result:ResultFriends;
		private var scrollClip:ScrollView;
		private var _targetArr:Vector.<ResultFriends>;
		
		public function set scrollView(value:ScrollView):void{scrollClip=value;}
		public function set errorText(value:TextField):void{_errorText = value;}
		public function set data(value:Vector.<ResultFriends>):void{_targetArr = value;}
		public function set resultsContainer(value:MovieClip):void{_resultsContainer = value;}		
		public function set inputText(value:TextField):void{_inputText = value;_inputText.text="";}
				
		public function BuscadorFriends()
		{
		}
		
		public function init():void
		{
			if(_inputText.stage)_inputText.stage.focus = _inputText;
			_resultsContainer.addEventListener(Event.SELECT,onSelected);
			_inputText.addEventListener(Event.CHANGE,onChange);
			_inputText.addEventListener(Event.ADDED_TO_STAGE,reset);
			
			var _currentTarget:Sprite = new Sprite();
			_resultsContainer.addChild(_currentTarget);	
					
			_resultsContainer.addChild(scrollClip);
			scrollClip.init();
									
			hideErrorMsg();
		}	
		public function reset(e:Event=null):void
		{
			if(_inputText.stage)_inputText.stage.focus = _inputText;
			_inputText.text = "";
			hideErrorMsg();
		}
		private function onSelected(event:Event):void
		{			
			//trace("selected");
			_inputText.text = ResultFriends(event.target).friendName;
			if(scrollClip.stage)_resultsContainer.removeChild(scrollClip);

			var params:DataFriend = new DataFriend();
			params.uid = ResultFriends(event.target).uid;
			_inputText.dispatchEvent(new CustomEvent(FBBuscadorAmigosEvents.FRIEND_SELECTED_EVENT,params));
		}		
		private function onChange(e:Event = null):void
		{
			if(e !== null)
			{
				e.stopImmediatePropagation();
			}	
			
			if(contenedor !== null)
			{
				if(scrollClip.stage)_resultsContainer.removeChild(scrollClip);
				
				//contenedor.parent.removeChild(contenedor);
				contenedor = null;
			}
			
			if(_inputText.text == "")
			{						
				hideErrorMsg();
				//_results = new Vector.<ResultFriends>();
				return;				
			}
			
			buscar();
		}
		
		private function buscar():void
		{
			/*var arr:Array =  _targetArr.concat();			
			arr.sort(0);*/
			
			var result:Vector.<ResultFriends> = new Vector.<ResultFriends>();
			
			for each (var clip:ResultFriends in _targetArr)
			{
				//trace(str);
				if(checkStr(clip.friendName))
				{
					result.push(clip);
				}
			}			
			
			if(result.length)crear(result);
			else showErrorMsg();
		}		
		private function showErrorMsg():void
		{
			if(_errorText)_errorText.visible = true;		
		}	
		private function hideErrorMsg():void
		{
			if(_errorText)_errorText.visible = false;	
		}
		private function crear(toShow:Vector.<ResultFriends>):void
		{
			hideErrorMsg();
			/*if(contenedor !== null)
			{
				contenedor.parent.removeChild(contenedor);
			}*/
			
			_results = new Vector.<ResultFriends>();
			_resultsContainer.addChild(scrollClip);
			
			contenedor = new MovieClip();					
			
			for each (var clip:ResultFriends in toShow)
			{				
				clip.y = contenedor.height;				
				contenedor.addChild(clip);							
				_results.push(clip);				
			}
			
			contenedor.cacheAsBitmap = true;
			scrollClip.addContent(contenedor);				
		}
		
		private function checkStr(str:String):Boolean
		{
			var temp:String = str.slice(0,_inputText.text.length);
			if(temp.toLowerCase() == _inputText.text.toLowerCase())
			{				
				return true;
			}			
			
			return false;
		}
	}
}