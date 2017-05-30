package com.sam.ui.selectpicture.view.components
{
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import sm.fmwk.rblegs.events.page.PageEvent;
	import sm.utils.animation.Timeline;
	
	public class SelectPictureComponent extends Sprite
	{
		protected var timeline:Timeline;
		
		public function SelectPictureComponent()
		{
			timeline = new Timeline(onShowed,onHidded);
			timeline.from(this,{autoAlpha:0});
		}
		
		protected function onShowed():void
		{
						
		}
		public function show():void
		{
			timeline.play();
		}
		public function hide():void
		{
			timeline.reverse();
		}
		public function destroy():void{}
		private function onHidded():void
		{
			dispatchEvent(new PageEvent(PageEvent.PAGE_HIDED,null));
		}
	}
}