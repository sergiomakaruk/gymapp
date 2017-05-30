package com.sam.ui.selectpicture.view.components.menu
{
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import sm.fmwk.ui.button.Button;
	import sm.fmwk.ui.button.events.ButtonEvent;
	import sm.utils.animation.Timeline;
	
	public class SelectPictureButton extends Button
	{
		private var back:DisplayObject;
		private var nombre:DisplayObject;

		private var logo:DisplayObject;

		private var timeline:Timeline;
		public function SelectPictureButton()
		{
			super();
			
			this.addEventListener(ButtonEvent.onOVER,onOver);
			this.addEventListener(ButtonEvent.onOUT,onOut);
		}
		
		override public function set face(val:DisplayObject):void
		{
			super.face = val;
			
			//MovieClip(face).over.visible = false;
						
			//back = MovieClip(face).back as DisplayObject;
			//nombre = MovieClip(face).nombre;
			//logo = MovieClip(face).logo;
			
			//timeline = new Timeline(null,null,Timeline.QUAD);
			//timeline.paused = true;
			
			//var time:Number = 0.1;			
			
			//timeline.to(back,{tint:0xcccccc},time);
			//timeline.to(logo,{tint:0},time);
			//timeline.to(nombre,{tint:0},time);
		}
		private function onOver(e:Event=null):void
		{			
			//timeline.play();
		}
		
		private function onOut(e:Event=null):void
		{			
			//timeline.reverse();
		}
		
		override protected function setAsActive():void
		{
			this.unlock();
			MovieClip(face).gotoAndStop(2);
			//MovieClip(face).over.visible = false;
			onOut();
		}
		override protected function setAsInactive():void
		{
			this.lock();
			MovieClip(face).gotoAndStop(1);
			//MovieClip(face).over.visible = true;
			//this.parent.addChildAt(this,this.parent.numChildren - 2);
			onOver();
		}
	}
}