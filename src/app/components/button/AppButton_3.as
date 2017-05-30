package app.components.button
{
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.external.ExternalInterface;
	
	import sm.fmwk.ui.button.Button;
	import sm.fmwk.ui.button.events.ButtonEvent;


	
	public class AppButton_3 extends Button
	{
		public function AppButton_3()
		{
			super();
			this.addEventListener(ButtonEvent.onCLICK,handleMouseDown2);
			//this.addEventListener(ButtonEvent.onUP,handleUpDown2);
			//this.addEventListener(ButtonEvent.onOUT,handleUpDown2);
		}
		
		override public function set face(val:DisplayObject):void{
			super.face = val;
			MovieClip(val)._over.alpha = 0;
		}
		
		
		protected function handleMouseDown2(event:ButtonEvent=null):void{
			
			TweenMax.to(MovieClip(face)._over,0.5,{alpha:1});	
		}
		
		protected function handleUpDown2(event:ButtonEvent=null):void{			
			TweenMax.to(MovieClip(face)._over,0.5,{alpha:0});	
		}
		
		override protected function setAsInactive():void{
			handleMouseDown2();
		}
		
		override protected function setAsActive():void{
			handleUpDown2();
		}
		
		public function setOvered():void{
			TweenMax.to(MovieClip(face)._over,1,{alpha:1,delay:0.1});	
			unlockeable = false;
			active = false;
		}		
	}
}