package com.sam.ui.selectpicture.components.facebookbuscadoramigos.controller
{
	import com.puremvc.model.proxys.DataTransferenceProxy;
	import com.sam.net.transferences.DataTransferenceData;

	import com.sam.ui.selectpicture.components.facebookbuscadoramigos.FBBuscadorAmigosTransferences;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class FBBuscadorAmigosCommand extends SimpleCommand implements ICommand
	{
		public static const NAME:String = "FBBuscadorAmigosCommand";
		
		override public function execute( note:INotification ) : void    
		{
		//	trace("FBBuscadorAmigosCommand EXECUTE",note);
			var dataTranfereceData:DataTransferenceData = note.getBody() as DataTransferenceData;
						
			switch(dataTranfereceData.type)
			{					
				case FBBuscadorAmigosTransferences.GET_FRIENDS:
					var dataProxy:DataTransferenceProxy;
					dataProxy = facade.retrieveProxy(DataTransferenceProxy.NAME) as DataTransferenceProxy;
					dataProxy.loadData(dataTranfereceData,false);
					break;								
			}	
		}
	}
}