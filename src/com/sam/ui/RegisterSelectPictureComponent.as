package com.sam.ui
{
	import com.sam.ui.selectpicture.components.albumviewer.mediators.AlbumViewerMediator;
	import com.sam.ui.selectpicture.components.albumviewer.model.ModelAlbumViewer;
	import com.sam.ui.selectpicture.components.albumviewer.model.ModelAlbumViewerActor;
	import com.sam.ui.selectpicture.components.albumviewer.view.AlbumViewer;
	import com.sam.ui.selectpicture.components.camera.CameraSnapshot;
	import com.sam.ui.selectpicture.components.camera.CameraSnapshotMediator;
	import com.sam.ui.selectpicture.components.uploadfile.UploadImageFromDeskView;
	import com.sam.ui.selectpicture.components.uploadfile.UploadImageFromDeskViewMediator;
	import com.sam.ui.selectpicture.model.SelectPictureViewMediator;
	import com.sam.ui.selectpicture.view.SelectPictureView;
	
	import org.robotlegs.core.IInjector;
	import org.robotlegs.core.IMediatorMap;

	public class RegisterSelectPictureComponent
	{
		public function RegisterSelectPictureComponent(mediatorMap:IMediatorMap,injector:IInjector)
		{
			mediatorMap.mapView(SelectPictureView,SelectPictureViewMediator,SelectPictureView);
			
			mediatorMap.mapView(AlbumViewer,AlbumViewerMediator,AlbumViewer);
			
			mediatorMap.mapView(UploadImageFromDeskView,UploadImageFromDeskViewMediator,UploadImageFromDeskView);
			
			mediatorMap.mapView(CameraSnapshot,CameraSnapshotMediator,CameraSnapshot);
			
			injector.mapSingleton(ModelAlbumViewerActor);
			injector.mapSingleton(ModelAlbumViewer);
		}
	}
}