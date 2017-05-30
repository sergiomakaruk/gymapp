package app.sections
{
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import sm.fmwk.rblegs.events.section.SectionEvent;
	import sm.fmwk.site.section.ResponsivePage;
	import sm.fmwk.site.section.TimelinePage;
	import sm.fmwk.ui.button.Button;
	import sm.utils.display.GetButton;
	import sm.utils.display.GetDrawedObjects;
	
	public class AppSection extends ResponsivePage
	{
		private var _buttons:Vector.<Button>;
		private var lockButtonsShape:Sprite;
		
		public function AppSection(name:String, tracker:Boolean)
		{
			//tiene el control de los botones
			//hay funciones para lockear los q se registraron mediante la funcion addBtn
			//pero para lockear los que sean childs de clips q no extiendan a AppSection, pongo un shape transparente
			super(name, tracker);
			_buttons = new Vector.<Button>();
			//this.addName();
		}
		
		protected function addBtn(face:DisplayObject,handler:Function=null,type:Class=null):Button
		{
			var btn:Button = GetButton.pressButton(face,handler,type);
			_buttons.push(btn);
			return btn;
		}		
		protected function lockBtns():void
		{
			for each(var btn:Button in _buttons)btn.lock();
		}
		protected function unlockBtns():void
		{
			for each(var btn:Button in _buttons)btn.unlock();
		}
		override public function show(event:Event=null):void
		{
			lockButtonsShape = GetDrawedObjects.getSprite(stage.stageWidth,stage.stageHeight,0,0);
			addChild(lockButtonsShape);
			super.show();
		}
		override public function hide():void
		{
			if(lockButtonsShape)addChild(lockButtonsShape);
			super.hide();
		}
		override protected function pageShowed(e:Event=null):void
		{
			if(lockButtonsShape.stage)removeChild(lockButtonsShape);
			super.pageShowed();
		}
		override protected function pageHided(e:Event=null):void
		{
			for each(var btn:Button in _buttons)btn.destroy();
			_buttons = null;
			lockButtonsShape = null;
			super.pageHided(e);
		}
		
		override protected function changeAction(display:DisplayObject,btnClass:Class=null):Button
		{
			return GetButton.pressButton(display,this.pageChanged,btnClass);
		}
		
		override protected function completeAction(display:DisplayObject,btnClass:Class=null):Button
		{
			return GetButton.pressButton (display,this.pageCompleted,btnClass);
		}
		
		override protected function hideAction(display:DisplayObject,btnClass:Class=null):Button
		{
			return GetButton.pressButton(display,this.hide);
		}
		
		override protected function previousAction(display:DisplayObject,btnClass:Class=null):Button
		{
			return GetButton.pressButton(display,this.goPrevious);
		}
		
		
	}
}