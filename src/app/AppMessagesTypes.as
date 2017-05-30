package app
{
	import app.messages.MinimalTransferenceMessage;
	
	import sm.fmwk.site.core.DataPage;
	import sm.fmwk.site.mediators.TransferenceMessageMediator;
	import sm.fmwk.site.messages.TransferenceMessage;
	import sm.fmwk.site.section.MessagesTypes;

	public class AppMessagesTypes extends MessagesTypes
	{
			
		public static const MINIMAL_TRANSFERENCE_MESSAGE:String = "minimalTransferenceMessage";
		
		public static const BASES_Y_CONDICIONES:String = "basesYCondiciones";
		
		public function AppMessagesTypes()
		{				
			super();		
			
			this.message = new DataPage(MINIMAL_TRANSFERENCE_MESSAGE,MinimalTransferenceMessage,TransferenceMessageMediator);
	
		}
	}
}