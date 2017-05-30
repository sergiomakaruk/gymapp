package app.sections.rutina.ejercicios
{
	import app.components.button.AppButton;
	import app.data.ejercicios.DataEjercicio;
	import app.events.AppEvents;
	
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import sm.fmwk.Fmwk;
	import sm.fmwk.ui.button.Button;
	import sm.utils.display.DPUtils;
	import sm.utils.display.GetButton;
	import sm.utils.display.GetImage;
	import sm.utils.events.CustomEvent;
	
	public class AgregarEjercicioView extends AbsEjercicioView
	{
		
		private var content:_ejercicioParaAgregarSP;
		private var image:DisplayObject;

		private var btnVer:Button;

		private var btnEliminar:Button;

		private var btnAgregar:Button;
		
		private var btnEditar:Button;
			
		
		public function AgregarEjercicioView(data:DataEjercicio)
		{
			super();
			
			this._data = data;
			
			content = new _ejercicioParaAgregarSP();
			addChild(content);
			
			 content._nombre.text = data.nombre;		
			
			btnVer = GetButton.pressButton(content._btnVer,onVerVideo,AppButton);
			btnVer.unlockeable = true;
			btnVer.autoDestroy = false;
			btnEliminar = GetButton.pressButton(content._btnEliminar,onEliminar,AppButton);	
			btnEliminar.delayTime = 1000;
			btnEliminar.autoDestroy = false;
			btnAgregar = GetButton.pressButton(content._btnAgregar,onAgregar,AppButton);	
			btnAgregar.delayTime = 1000;
			btnAgregar.autoDestroy = false;
			
			btnEditar = GetButton.pressButton(content._btnEditar,onEditar,AppButton);	
			btnEditar.delayTime = 1000;
			btnEditar.autoDestroy = false;
			btnEditar.visible = false;
			btnEditar.alpha = 0;			
			
			//image = DPUtils.swap(GetImage.getImage(Fmwk.appConfig('kiosko')+'images/8.jpg',onFoto),content._foto);
			image = DPUtils.swap(GetImage.getImage(Fmwk.appConfig('kiosko')+'images/'+data.sid+'.jpg',onFoto),content._foto); 

		}
		
		public function showEditBtn():void
		{
			TweenMax.to(btnEditar,0.5,{autoAlpha:1});			
		}
		
		private function onFoto():void
		{
			if(image.height > 178){
				var im:DisplayObject = GetImage.getCenterAndScaleImageFromOther(image,179,178);
				DPUtils.swap(im,image);
				image = im;
			}			
			
			image.width = 132;
			image.scaleY = image.scaleX;			
		}
		
		private function onEliminar():void
		{
			this.dispatchEvent(new CustomEvent(AppEvents.EDITAR_RUTINA_MAIN_EVENT,{action:AppEvents.ELIMINAR_EJERCICIO_DE_RUTINA_EVENT}));	//RutinaMediator		
		}		
		
		private function onAgregar():void
		{
			dispatchEvent(new CustomEvent(AppEvents.AGREGAR_ESTE_EJERCICIO_EVENT,data));   //PopupAgregarMediator
		}
		
		private function onEditar():void
		{
			dispatchEvent(new CustomEvent(AppEvents.EDITAR_RUTINA_MAIN_EVENT,{action:AppEvents.EDITAR_ESTE_EJERCICIO_EVENT}));   //PopupAgregarMediator
		}		
		
		private function onVerVideo():void
		{			
			dispatchEvent(new CustomEvent(AppEvents.SHOW_VIDEO,data));			
		}
		
		public function render(estaAgregado:Boolean,toSave:Boolean):void
		{			
			if(estaAgregado){
				btnEliminar.visible = true;				
				btnAgregar.visible = false;
				content._okIcon.visible = true;
			}else{
				btnAgregar.visible = true;
				btnEliminar.visible = false;
				content._okIcon.visible = false;				
			}
			
			content._isNuevo.visible = toSave;
			btnEditar.visible = toSave;	
		}		
	}
}