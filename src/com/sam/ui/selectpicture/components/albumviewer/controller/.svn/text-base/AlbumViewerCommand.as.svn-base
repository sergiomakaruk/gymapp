package com.sam.ui.selectpicture.components.albumviewer.controller
{
	import com.puremvc.model.proxys.AssetTransferenceProxy;
	import com.puremvc.model.proxys.DataTransferenceProxy;
	import com.puremvc.model.proxys.FacebookTransferenceProxy;
	import com.sam.net.transferences.DataTransferenceData;
	import com.sam.ui.selectpicture.components.albumviewer.AlbumViewerTransferences;
	
	import org.puremvc.as3.interfaces.ICommand;
	import org.puremvc.as3.interfaces.INotification;
	import org.puremvc.as3.patterns.command.SimpleCommand;
	
	public class AlbumViewerCommand extends SimpleCommand implements ICommand
	{
		override public function execute( note:INotification ) : void    
		{
			var dataTranfereceData:DataTransferenceData = note.getBody() as DataTransferenceData;
			trace(">>>>> AlbumViewerCommand EXECUTE ");	
			trace(">>>>>>>>>> NOTE NAME: ",note.getName());
			trace(">>>>>>>>>> TRANSFERENCE TYPE: ",dataTranfereceData);		
						
			switch(dataTranfereceData.type)
			{	
				case AlbumViewerTransferences.LOAD_SELETED_ALBUM:
				case AlbumViewerTransferences.LOAD_ALBUMS:
					/*var dataProxy:DataTransferenceProxy;
					dataProxy = facade.retrieveProxy(DataTransferenceProxy.NAME) as DataTransferenceProxy;
					dataProxy.loadData(dataTranfereceData,false);*/
					var dataProxy:FacebookTransferenceProxy;
					dataProxy = facade.retrieveProxy(FacebookTransferenceProxy.NAME) as FacebookTransferenceProxy;									
					dataProxy.call(dataTranfereceData);
					break;					
				
				case AlbumViewerTransferences.LOAD_PICTURE:
					var assetProxy:AssetTransferenceProxy = facade.retrieveProxy(AssetTransferenceProxy.NAME) as AssetTransferenceProxy;
					assetProxy.loadAssest(dataTranfereceData);
					break;				
			}	
		}
	}
}