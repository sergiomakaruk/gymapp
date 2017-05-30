package app.components.button
{
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	
	import flash.display.DisplayObject;
	
	import sm.fmwk.ui.button.events.ButtonEvent;
	import sm.fmwk.ui.custombutton.OverOutButton;
	
	public class MenuBtn extends OverOutButton
	{
		private var or:Number;
		public function MenuBtn()
		{
			super();
		}
		
		override public function set face(val:DisplayObject):void
		{
			super.face = val;
			or = this.x;
		}
		
		override protected function onOver(event:ButtonEvent=null):void
		{
			TweenMax.to(this,0.3,{x:or + 20,ease:Expo.easeOut});
		}
		
		override protected function onOut(event:ButtonEvent=null):void
		{
			TweenMax.to(this,0.3,{x:or,ease:Expo.easeOut});
		}
		
	}
}