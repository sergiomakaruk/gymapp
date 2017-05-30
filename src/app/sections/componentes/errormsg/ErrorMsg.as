package app.sections.componentes.errormsg
{
	import app.components.button.AppButton;
	
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.Event;

	
	import sm.utils.display.GetButton;
	
	public class ErrorMsg extends Sprite
	{
		private var error:_errorMsg1SP;
		private var type:String;
		private var callback:Function;
		
		public function ErrorMsg(type:String,callback:Function)
		{
			super();
			this.type = type;
			this.callback = callback;
			this.addEventListener(Event.ADDED_TO_STAGE,init);
		}
		
		private function init(e:Event):void{
			error = new _errorMsg1SP();
			error._btn.gotoAndStop(1);
			switch(type){
				case "noplandeentrenamiento":error._btn.gotoAndStop(2);break;
			}
			
			error.x = (stage.stageWidth) *.5;
			error.y = (stage.stageHeight) *.5;
			addChild(error);
			
			TweenMax.from(error,0.5,{scaleX:0,scaleY:0});
			
			GetButton.pressButton(error._btn,onClick,AppButton);
		}
		
		private function onClick():void
		{
			TweenMax.to(error,0.5,{scaleX:0,scaleY:0,onComplete:complete});			
		}
		private function complete():void{
			this.removeEventListener(Event.ADDED_TO_STAGE,init);
			this.parent.removeChild(this);
			this.callback();
		}
	}
}