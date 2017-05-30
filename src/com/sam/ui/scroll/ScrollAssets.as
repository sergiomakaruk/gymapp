package com.sam.ui.scroll
{
	import flash.display.*;
	
	public class ScrollAssets extends MovieClip
	{
		private const MSG:String = "Clip no encontrado para armar el scroll ";
		private const DRAGGED:String = "draggedClip";
		private const RULER:String = "rulerClip";
		private const BACKGROUND:String = "backgroundClip";
		private const HIT_AREA_CLIP:String = "hitAreaClip";
		private const MASCARA:String = "mascaraClip";
		private const BTN_UP:String = "btnUp";
		private const BTN_DOWN:String = "btnDown";

		private var _dragged:Sprite;
		private var _maskclip:DisplayObject;
		private var _ruler:Sprite;
		private var _background:DisplayObject;
		private var _hitarea:DisplayObject;
		
		private var _upScrollButton:DisplayObject;
		private var _downScrollButton:DisplayObject;
		
		private var _hasButtons:Boolean;
		
		public function get dragged():Sprite{return _dragged;}
		public function get maskclip():DisplayObject{return _maskclip;}
		public function get ruler():Sprite{return _ruler;}
		public function get background():DisplayObject{return _background;}
		public function get hitareaClip():DisplayObject{return _hitarea;}
		
		public function get upScrollButton():DisplayObject{return _upScrollButton;}
		public function get downScrollButton():DisplayObject{return _downScrollButton;}
		
		public function get hasButtons():Boolean{return _hasButtons;}
		
		public function ScrollAssets()
		{
			super();
			checkChilds();
		}
		private function checkChilds():void
		{
			_dragged = this.getChildByName(this.DRAGGED) as Sprite;
			if(!_dragged) throw new Error(MSG + DRAGGED);
			
			_ruler = this.getChildByName(this.RULER) as Sprite;
			if(!_ruler) throw new Error(MSG + RULER);
			
			_background = this.getChildByName(this.BACKGROUND);
			if(!_background) throw new Error(MSG + BACKGROUND);
			
			_maskclip = this.getChildByName(this.MASCARA);
			if(!_maskclip) throw new Error(MSG + MASCARA);
			
			_hitarea = this.getChildByName(this.HIT_AREA_CLIP);
			if(!_hitarea) throw new Error(MSG + HIT_AREA_CLIP);
			
			_upScrollButton  = this.getChildByName(this.BTN_UP);
			_downScrollButton  = this.getChildByName(this.BTN_DOWN);
			
			if(_upScrollButton || _downScrollButton) this._hasButtons = true;
		}
	}
}