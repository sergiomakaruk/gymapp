package com.sam.form
{
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	
	public class FormErrorClip extends Sprite
	{
		private var _parent:DisplayObjectContainer;
		
		public function FormErrorClip(face:DisplayObject)
		{
			super();
			
			this.x = face.x;
			this.y = face.y;
			face.x = face.y = 0;
			this.name = face.name;
			_parent = face.parent;
			this.addChild(face);					
		}
		public function show():void
		{
			if(!this.stage)
			{
				_parent.addChild(this);
				TweenMax.to(this,0.3,{scaleX:1,scaleY:1,ease:Back.easeOut});
			}			
		}
		public function hide():void
		{
			if(this.stage)TweenMax.to(this,0.3,{scaleX:0,scaleY:0,ease:Back.easeOut,onComplete:remove});
		}
		private function remove():void
		{
			if(this.stage)_parent.removeChild(this);
		}
	}
}