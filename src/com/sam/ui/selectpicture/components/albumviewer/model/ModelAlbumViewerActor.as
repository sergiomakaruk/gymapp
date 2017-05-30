package com.sam.ui.selectpicture.components.albumviewer.model
{	

	import com.sam.ui.selectpicture.SelectPicture;
	import com.sam.ui.selectpicture.components.albumviewer.AlbumViewerEvents;
	import com.sam.ui.selectpicture.components.albumviewer.AlbumViewerTransferences;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.net.URLVariables;
	
	import hx.fmwk.serialization.Json;
	
	import org.robotlegs.mvcs.Actor;
	
	import sm.fmwk.net.parseData.ParseFacebook;
	import sm.fmwk.net.transferences.AssetTransferenceData;
	import sm.fmwk.net.transferences.facebook.API_FBTransferenceData;
	import sm.fmwk.net.transferences.facebook.FBTransferenceData;
	import sm.fmwk.net.utils.FacebookQueries;
	import sm.fmwk.rblegs.events.transference.TransferenceCallbackEvent;
	import sm.fmwk.rblegs.proxys.SequenceStaker;
	
	public class ModelAlbumViewerActor extends Actor
	{
		[Inject]
		public var staker:SequenceStaker;
		
		private var currentCallback:Function;
		
		public function ModelAlbumViewerActor()
		{				
		}

		public function getPicture(source:String,callback:Function):void
		{	
			currentCallback = callback;	
			
			var data:AssetTransferenceData = new AssetTransferenceData(source);
			this.dispatch(new TransferenceCallbackEvent(data,ongetPictureCallback));	
		}
		private function ongetPictureCallback():void
		{
			var asset:Bitmap = staker.lastTransference.data as Bitmap;
			currentCallback(asset)
		}
		public function getAlbums(uid:String,callback:Function):void
		{
			currentCallback = callback;
			var variables:Object = {};
			variables.q = FacebookQueries.getAlbumsByUserId();
			//variables.uid = uid; 
				
			var data:FBTransferenceData = new API_FBTransferenceData(API_FBTransferenceData.FLQ,variables);
			this.dispatch(new TransferenceCallbackEvent(data,onGetAlbumsCallback));			
		}
		private function onGetAlbumsCallback():void
		{
			var parseFaceboook:ParseFacebook = staker.lastTransference.data as ParseFacebook;
			parseFaceboook.parseAlbums();
			currentCallback(parseFaceboook.data);
		}
		
		public function getPicturesByAlbumId(aObjId:String,callback:Function):void
		{
			currentCallback = callback;
			var variables:Object = {};
			variables.q = FacebookQueries.getPhotosByAlbumId(aObjId);
			//variables.query = "SELECT src, width, height FROM photo_src WHERE photo_id = 10150219139839521"
			//variables.aid = e.params.aid;
			
			var data:FBTransferenceData = new API_FBTransferenceData(API_FBTransferenceData.FLQ,variables);
			this.dispatch(new TransferenceCallbackEvent(data,onGetPicturesByAlbumIdCallback));		
		}	
		private function onGetPicturesByAlbumIdCallback():void
		{
			var parseFaceboook:ParseFacebook = staker.lastTransference.data as ParseFacebook;
			parseFaceboook.parsePhotos()
			currentCallback(parseFaceboook.data);
		}			
		
	}
}