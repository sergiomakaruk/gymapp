package app.sections.historial
{
	import app.components.button.AppButton;
	import app.data.rutinas.DataRutina;
	import app.events.AppEvents;
	import app.model.Model;
	import app.sections.AppSection;
	import app.sections.rutina.Rutina;
	import app.sections.rutina.TapScroller;
	import app.sections.rutina.msg.SalirMsg;
	
	import com.greensock.TimelineMax;
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import nid.ui.controls.VirtualKeyBoard;
	import nid.ui.controls.vkb.KeyBoardEvent;
	import nid.ui.controls.vkb.KeyBoardTypes;
	
	import sm.fmwk.ui.button.Button;
	import sm.fmwk.ui.button.events.ButtonEvent;
	import sm.utils.display.DPUtils;
	import sm.utils.display.GetButton;
	import sm.utils.display.GetDrawedObjects;
	import sm.utils.display.GetImage;
	import sm.utils.events.CustomEvent;
	
	public class HistorialSection extends AppSection
	{
		private var tapScroll:TapScroller;

		private var content:_edicionPerfilUsuarioSP;
		private var rutina:Rutina;

		private var menu:MenuCrearRutina;

		private var state:uint;

		public function HistorialSection(name:String, tracker:Boolean)
		{
			super(name, tracker);
		}
		
		override public function show(event:Event=null):void{
			content = new _edicionPerfilUsuarioSP();
			addChild(content);
			
			content._profe.text = Model.profe.nombre;
			content._nombre.text = Model.socio.nombre + " " + Model.socio.apellido;
			content._dni.text = Model.socio.dni;
			content._email.text = Model.socio.email;
			content._email.autoSize = "left";	
			
			if(Model.socio.hasFoto){
				GetImage.scale(Model.socio.foto,150,150);
				DPUtils.swap(Model.socio.foto,content._user_photo);
			}
			//content.addChild(Model.socio.foto);
			onEmailChange();
			
			addButton(content._btnCrearNuevoPlanDeEntrenamientoOptions);
			addButton(content._flechaVolver);			
			
			renderHistorial();
			
			VirtualKeyBoard.getInstance().init(this);		
			VirtualKeyBoard.getInstance().addEventListener(KeyBoardEvent.UPDATE,onEmailChange);
			VirtualKeyBoard.getInstance().addEventListener(KeyBoardEvent.SAVE,onEmailSave);
			
			content._btnEditarMail.addEventListener(MouseEvent.CLICK, toggleKeyboard);
			
			this.addEventListener("eventVolver",ocultarMenuNuevaRutina);
			
			super.show();
			
		}
		
		protected function ocultarMenuNuevaRutina(event:Event):void
		{
			TweenMax.to(menu,0.5,{x:stage.stageWidth,ease:Expo.easeOut,onComplete:onMenuComplete});			
		}
		
		override public function hide():void{
			this.removeEventListener("eventVolver",ocultarMenuNuevaRutina);
			VirtualKeyBoard.getInstance().removeEventListener(KeyBoardEvent.UPDATE,onEmailChange);
			VirtualKeyBoard.getInstance().removeEventListener(KeyBoardEvent.SAVE,onEmailSave);
			super.hide();
		}
		
		protected function onEmailSave(event:Event):void
		{
			this.dispatchEvent(new CustomEvent(AppEvents.HISTORIAL_MAIN_EVENT,{action:AppEvents.HISTORIAL_ACTUALIZAR_EMAIL,email:content._email.text}));
		}
		
		protected function onEmailChange(event:Event=null):void
		{
			trace(event);
			content._btnEditarMail.x = content._email.x + content._email.width + 50;			
		}
		
		private function toggleKeyboard(e:MouseEvent):void 
		{
			VirtualKeyBoard.getInstance().target = { field:content._email, fieldName:"Modifique su email",keyboardType:KeyBoardTypes.ALPHABETS_LOWER };
		}
		
		private function renderHistorial():void
		{
			var view:Array = [];
			for each(var data:DataRutina in Model.socio.rutinas.data){
				view.push(new ItemHistorialRutina(data));
			}
			
			var container:Sprite = DPUtils.getColumnsContainer(view,0,20,1);
			
			if(tapScroll)content.removeChild(tapScroll);
			tapScroll = new TapScroller(container,1150,650);
			content.addChild(tapScroll);
			tapScroll.x = 70;
			tapScroll.y = 330;			
		}
		
		protected function addButton(face:MovieClip):Button
		{
			var btn:Button = GetButton.button(face);
			btn.addEventListener(ButtonEvent.onDOWN,onDonwn);			
			//buttons.push(btn);
			btn.delayTime = 500;
			return btn;
		}
		
		protected function onDonwn(event:Event):void
		{
			var params:Object = {};
			switch(event.target.face.name){
				case '_btnCrearNuevoPlanDeEntrenamientoOptions':
						showNewMenu();return;
						;break;	
				case '_btnCrearNuevoPlanDeEntrenamiento':params.action = AppEvents.HISTORIAL_CREAR_NUEVA_RUTINA;break;//creo q n funciona mas esto
				case "_flechaVolver":
					volver();
					break;
			}
			
			dispatchEvent(new CustomEvent(AppEvents.HISTORIAL_MAIN_EVENT,params));
		}
		
		private function volver(e:Event=null):void
		{
			this.pageCompleted();
			return;
			/*
			switch(state){
				case 0:
					this.pageCompleted();
					break;
				case 1:
					if(menu.volver())TweenMax.to(menu,0.5,{x:stage.stageWidth,ease:Expo.easeOut,onComplete:onMenuComplete});	
					break;
			}
			*/
		}
		
		private function onMenuComplete():void{
			menu.destroy();
			content.removeChild(menu);
			menu = null;
			state = 0;
		}
		
		private function showNewMenu():void
		{
			Model.crearRutina();		
			
			menu = new MenuCrearRutina();
			content.addChild(menu);
			TweenMax.from(menu,0.5,{x:stage.stageWidth,ease:Expo.easeOut});	
			state = 1;
		}
		
		public function showRutina():void
		{
			trace("showRutina()");
			TweenMax.to(content,1,{x:-stage.stageWidth,ease:Expo.easeIn,onComplete:removeMenu});
			rutina = new Rutina();
			rutina.addEventListener(AppEvents.EDITAR_RUTINA_MAIN_EVENT,onVolver);			
			rutina.renderasEditarRutina();
			rutina.x = 270;
			TweenMax.from(rutina,1,{x:stage.stageWidth + 300,ease:Expo.easeOut,delay:1});
			addChild(rutina);
			
		}
		
		private function removeMenu():void{
			if(!menu)return;
			menu.destroy();
			content.removeChild(menu);
			menu = null;
		}
		
		protected function onVolver(event:CustomEvent):void
		{
			if(event.params.action == AppEvents.VOLVER)
			{
				renderHistorial();
				TweenMax.to(rutina,1,{x:stage.stageWidth + 300,ease:Expo.easeIn});
				TweenMax.to(content,1,{x:0,ease:Expo.easeOut,delay:1,onComplete:removeRutina});				
				
			}			
		}
		
		private function removeRutina():void{
			removeChild(rutina);
			rutina.destroy();			
		}
		
		
		
	}
}