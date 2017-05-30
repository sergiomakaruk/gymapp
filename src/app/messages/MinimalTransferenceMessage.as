package app.messages
{
	import app.components.button.fbLogin.FbLoginButton;
	
	import flash.events.Event;
	
	import sm.fmwk.net.parseData.ParseData;
	import sm.fmwk.site.messages.TMAsset;
	import sm.fmwk.site.messages.TransferenceMessage;
	import sm.fmwk.ui.button.Button;
	import sm.utils.display.GetButton;
	import sm.utils.display.GetDrawedObjects;
	
	public class MinimalTransferenceMessage extends TransferenceMessage
	{

		private var fbLoginButton:FbLoginButton;
		public function MinimalTransferenceMessage(name:String, tracker:Boolean)
		{
			super(name, tracker);
		}
		override public function show(event:Event=null):void
		{
			addChildAt(GetDrawedObjects.getSprite(stage.stageWidth,stage.stageHeight,0,0),0);
			
			content.y = stage.stageHeight;
			addChild(content);
			
			//content.cartel.x = (stage.stageWidth - content.cartel.width) * .5;
			timeline.from(content.cartel,{blurFilter:{blurY:30,blurX:10},y:"100"},0.5,"quad");
			
			timeline.play();			
		}
	
		override protected function get content():TMAsset
		{
			if(!_content) _content = new MinimalTMA();
			return _content;
		}
		override public function onError(error:ParseData):void
		{
			this.setMessage(error.text);
			
			if(error.code == "-51")
			{
				if(!fbLoginButton) fbLoginButton = GetButton.button(content.btnFb,FbLoginButton) as FbLoginButton;		
				else fbLoginButton.show();		
				return;
			}	
			
			content.btnReintentar.show();
			content.btnCancelar.show();
		}
	}
}