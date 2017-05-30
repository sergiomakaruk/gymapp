package com.sam.ui.selectpicture.view
{
	import com.sam.ui.selectpicture.view.components.SelectPictureComponent;
	import com.sam.ui.selectpicture.view.components.menu.MenuSelectPicture;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import sm.fmwk.rblegs.events.page.PageEvent;
	
	public class SelectPictureView extends Sprite
	{	
		private var _content:Sprite;
		private var _menu:MenuSelectPicture;
		public function get menu():MenuSelectPicture{return _menu;}
		private var _currentComponent:SelectPictureComponent;
		
		public function get content():Sprite
		{
			if(!_content) _content = new Sprite();
			return _content;
		}	
	
		public function SelectPictureView()
		{
			super();
			addChild(content);
			//content.gotoAndStop(1);
		}
		public function createMenu(menuAsset:MovieClip):void
		{
			_menu = new MenuSelectPicture();
			menu.addAssets(menuAsset);
			addChild(menu);
			_menu.x = menuAsset.x;
			_menu.y = menuAsset.y;
			menuAsset.x = menuAsset.y = 0; 
		}
		public function init():void
		{
			menu.inicilizeDefaultComponent();
		}
		public function changeComponent(component:SelectPictureComponent):void
		{
			menu.active = true;
			//component.y = 200;
			if(_currentComponent)
			{
				_currentComponent.addEventListener(PageEvent.PAGE_HIDED,onHidded);
				_currentComponent.hide();
			}
			else
			{
				component.show();
				addChild(component);
			}
			_currentComponent = component;			
		}
		private function onHidded(e:Event):void
		{
			var component:SelectPictureComponent = e.target as SelectPictureComponent;
			removeChild(component);
			_currentComponent.show();
			addChild(_currentComponent);
		}
	}
}