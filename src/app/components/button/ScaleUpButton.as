package app.components.button
{
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	
	import sm.fmwk.ui.button.events.ButtonEvent;
	import sm.fmwk.ui.custombutton.ScaleButton;
	import sm.utils.animation.Timeline;
	
	public class ScaleUpButton extends ScaleButton
	{
		private var __x:Number;
		
		public function ScaleUpButton(toScale:Number=1.1, ease:String="back", time:Number=0.3)
		{
			super(toScale, ease, time);			
		}
		
		override public function set face(val:DisplayObject):void{
			super.face = val;
			this.__x = face.y;
		}
		
		override protected function onOut(event:ButtonEvent=null):void
		{
			TweenMax.to(this,_time,{y:__x,scaleX:1,scaleY:1,ease:Timeline.getEase(_ease,false)});
		}
		override protected function onOver(event:ButtonEvent=null):void
		{
			TweenMax.to(this,_time,{y:__x-15,scaleX:_toScale,scaleY:_toScale,ease:Timeline.getEase(_ease)});		
		}
	}
}