package com.sam.ui.selectpicture.components.camera
{
	import com.sam.ui.selectpicture.SelectPicture;
	
	import flash.events.Event;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sm.utils.events.CustomEvent;

	
	public class CameraSnapshotMediator extends Mediator
	{			
		public function CameraSnapshotMediator()
		{				
		}
		override public function onRegister():void
		{
			this.addViewListener(Event.REMOVED_FROM_STAGE,onRemoved);
			this.addViewListener(Event.COMPLETE,onComplete);
		}
		protected function onComplete(event:Event):void
		{		
			this.dispatch(new CustomEvent(SelectPicture.PICTURE_SELECTED,content.getFoto()));
		}
		
		private function onRemoved(e:Event):void
		{
			this.removeViewListener(Event.REMOVED_FROM_STAGE,onRemoved);
			this.removeViewListener(Event.COMPLETE,onComplete);		
			content.destroy();
		}
		private function get content():CameraSnapshot
		{
			return this.viewComponent  as CameraSnapshot;
		}
	}
}