package app.messages
{
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	import sm.fmwk.site.messages.TMAsset;
	import sm.utils.display.GetButton;
	import sm.fmwk.ui.button.Button;

	public class MinimalTMA extends TMAsset
	{		
		
		public function MinimalTMA()
		{
			super();
			init();
		}
		override public function init():void
		{			
			var content:TransferenceCartelSP = new TransferenceCartelSP();
			content.status_txt.text = "";			
			
			this._cartel = this;
			this._statusTxt = content.status_txt;
			
			this._btnfb = content.btnLogin;			
			this._btnfb .visible = false;
			
			this.createReintentarButton(content.btnReintentar);
			this.createCancelarButton(content.btnCancelar);
						
			addChild(content);	
		}
		
	}
}