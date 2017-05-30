package app.components.button.fbLogin
{
	import app.datatransferences.DataTransferenceTypes;
	
	import org.robotlegs.mvcs.Mediator;
	
	import sm.fmwk.net.transferences.JSDataTransferenceData;
	import sm.fmwk.rblegs.events.transference.DataTransferenceEvent;
	import sm.fmwk.rblegs.events.transference.StartTransferenceEvent;
	import sm.fmwk.rblegs.proxys.SequenceStaker;
	import sm.fmwk.ui.button.Button;
	import sm.fmwk.ui.button.events.ButtonEvent;
	
	public class FBLoginButtonMediator extends Mediator
	{
		[Inject]
		public var staker:SequenceStaker;
		
		public function FBLoginButtonMediator()
		{
			super();
		}
		override public function onRegister():void
		{
			this.addViewListener(ButtonEvent.onCLICK,onLogin);				
		}
		
		private function onLogin(e:ButtonEvent):void
		{		
			//content.active = true;
			content.hide();
			staker.unshift(staker.lastTransference);
			staker.unshift(new JSDataTransferenceData(DataTransferenceTypes.JS_GET_USER,null));				
			staker.start();		
		}	
		private function get content():FbLoginButton
		{
			return this.viewComponent as FbLoginButton;
		}
	}
}