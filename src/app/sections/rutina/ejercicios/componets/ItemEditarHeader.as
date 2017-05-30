package app.sections.rutina.ejercicios.componets
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class ItemEditarHeader extends Sprite
	{

		private var content:_itemEditarHeaderSP;
		public var id:uint;
		private var _isActive:Boolean;
		public function ItemEditarHeader(txt:String,id:uint,isActive:Boolean)
		{
			super();
			content = new _itemEditarHeaderSP();
			content._check.gotoAndStop(1);
			addChild(content);
			content._txt.text = txt;
			this.id = id;
			if(isActive)content._check.gotoAndPlay(5);
			this.mouseChildren = false;
			this.buttonMode = true;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN,change);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		
		protected function onRemoved(event:Event):void
		{
			this.removeEventListener(MouseEvent.MOUSE_DOWN,change);
			this.addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);			
		}
		
		public function get isActive():Boolean{
			return _isActive;
		}
		
		public function change(e:Event):void{
			_isActive = !_isActive;
			if(isActive)content._check.gotoAndPlay(5);
			else content._check.gotoAndStop(1);
		}
	}
}