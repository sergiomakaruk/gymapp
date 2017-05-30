package com.formulario
{
	import com.greensock.TweenMax;
	import com.sam.ui.scroll.ScrollView;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	import sm.utils.display.GetButton;

	public class BasesYCondiciones extends Lightbox
	{
		private var scroll:ScrollView;
		private var face:MovieClip;
		
		public function BasesYCondiciones(face:MovieClip)
		{
			this.face = face;
			this.visible = false;
			super();
			var url:String = "bases/bases.txt";
			
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE,onBasesComplete);
			loader.load(new URLRequest(url));		
		}
		
		private function onBasesComplete(e:Event):void
		{			
			scroll = new ScrollView();
			scroll.drawBack = true;
			scroll.hasRuller = true;
			scroll.addAssets(face.scrollClip);
			scroll.init();
			addChild(scroll);
			
			GetButton.clickButton(face.scrollClip.btnCerrar,onClose);
			
			var t:TextField = face.input_txt;
			t.y = 0;
			t.x = 0;
			t.wordWrap = true;
			t.multiline = true;
			t.text = e.target.data.toString();			
			t.autoSize = "left";
					
			scroll.addContent(t);
			
			init(0,0.5,true);
			this.visible = true;			
		}
		override protected function doAnimationIn():void
		{
			_timeline.append(TweenMax.from(scroll,0.3,{alpha:0}));
		}
	}
}