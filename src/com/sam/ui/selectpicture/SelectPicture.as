package com.sam.ui.selectpicture
{
	
	/*
	Este componente inicializa el menu y alterna los subcomponentes.
	Cada subcomponente Dispara una notificacion PICTURE_SELECTED, con un objeto Bitmapdata.
	El mediador que instancie este componente debe escuchar esta notificacion	
	*/
	import com.sam.ui.selectpicture.model.SelectPictureViewMediator;
	import com.sam.ui.selectpicture.view.SelectPictureView;
	
	import flash.display.MovieClip;

	public class SelectPicture
	{
		public static var PROXY:String = "";//"http://ms03.hostarg.net/facebook_aziatop/etijetate/site/home/proxy/proxy.php?url=";
		
		public static const MIN_WIDHT:uint = 0;
		public static const MIN_HEIGHT:uint = 0;
		
		//notification
		public static const PICTURE_SELECTED:String = "pictureSelected";
		
		//Los botones se tienen que llamar así. Si existe en boton, se crea el boton p el componente. MenuSelecPicture
		public static const OWN_ALBUM:String = "ownAlbum";
		public static const FRIENDS_ALBUM:String = "friendsAlbum";
		public static const DISK_PICTURE:String = "diskPicture";
		public static const CAMERA_PICTURE:String = "cameraPicture";
		
		private var _component:SelectPictureView;
		
		public function get component():SelectPictureView{return _component;}
	
		public function init(assets:MovieClip):void
		{
			_component.createMenu(assets.menuSelect);		
			_component.menu.init();
			_component.init();
		}		
		
		public function SelectPicture()
		{
			_component = new SelectPictureView();	
		}		
	}
}
