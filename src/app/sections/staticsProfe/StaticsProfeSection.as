package app.sections.staticsProfe
{
	import app.components.button.AppButton;
	import app.components.button.AppButton_2;
	import app.components.button.AppButton_3;
	import app.data.usuarios.DataUsuario;
	import app.model.Model;
	import app.sections.AppSection;
	import app.sections.rutina.TapScroller;
	
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import sm.fmwk.ui.button.Button;
	import sm.fmwk.ui.button.events.ButtonEvent;
	import sm.utils.date.DateUtils;
	import sm.utils.display.DPUtils;
	import sm.utils.display.GetButton;
	import sm.utils.display.GetImage;
	import sm.utils.events.CustomEvent;
	
	public class StaticsProfeSection extends AppSection
	{

		private var btn:AppButton_3;

		private var content:_staticsProfeSP;

		private var container:Sprite;
		private var tapScroll:TapScroller;

		private var currentFoto:DisplayObject;
		private var timer:Timer;
		public function StaticsProfeSection(name:String, tracker:Boolean)
		{
			super(name, tracker);
		}
		
		override public function show(event:Event=null):void{
			
			content = new _staticsProfeSP();
			addChild(content);
			
			content._profe.text = Model.profe.nombre;
			addButton(content._flechaVolver);
			
			var __data:Vector.<DataUsuario> = Model.profe.statics.getByType(1);
			content._listadoDeUsuarios._btnActivos._txt.text = "Activos ("+__data.length+")";
			__data = Model.profe.statics.getByType(0);
			content._listadoDeUsuarios._btnInactivos._txt.text = "Inactivos ("+__data.length+")";
			__data = Model.profe.statics.getByType(2);			
			content._listadoDeUsuarios._btnNuevos._txt.text = "Nuevos ("+__data.length+")";
			__data = Model.profe.statics.getByType(3);
			content._listadoDeUsuarios._btnVencidos._txt.text = "Con Plan Vencido ("+__data.length+")";
			
			btn = addButton(content._listadoDeUsuarios._btnActivos);
				
			addButton(content._listadoDeUsuarios._btnInactivos);
			addButton(content._listadoDeUsuarios._btnNuevos);
			addButton(content._listadoDeUsuarios._btnVencidos);
			
			GetButton.clickButton(content._btnVerInfo,verInfo).unlockeable = true;
			
			content._infoClip.alpha = 0;
			content._infoClip.visible = false;
			content._usuario.text = "";
			filter(1);
			super.show();
			
			btn.setOvered();
			
			
			this.addEventListener(ItemUsuario.SHOW_USER,onShowUser);
		}
		
		protected function onShowUser(event:CustomEvent):void
		{
			if(timer)onTimer();
			
			content._usuario.text = event.params.nombre + " " + event.params.apellido;			
			currentFoto = GetImage.copy(event.params.foto.getChildAt(0),false);
			TweenMax.from(currentFoto,0.2,{alpha:0});
			addChild(currentFoto);
			currentFoto.x = stage.stageWidth - currentFoto.width - 50;
			currentFoto.y = 70;				
			
			
			timer = new Timer(5000,1);
			timer.addEventListener(TimerEvent.TIMER,onTimer);
			timer.start();
			
		}
		
		protected function onTimer(event:TimerEvent = null):void
		{
			timer.stop();
			timer.removeEventListener(TimerEvent.TIMER,onTimer);
			timer = null;
			content._usuario.text = "";
			if(currentFoto) removeChild(currentFoto);
		}
		
		protected function addButton(face:MovieClip):AppButton_3
		{
			var btn:AppButton_3 = GetButton.button(face,AppButton_3) as AppButton_3;
			btn.addEventListener(ButtonEvent.onDOWN,onDonwn);			
			//buttons.push(btn);
		//	btn.delayTime = 500;
			return btn;
		}
		
		protected function onDonwn(event:Event):void
		{
			if(btn)btn.active = true;
			btn = event.target as AppButton_3;
			btn.active = false;
			var params:Object = {};
			switch(event.target.face.name){
			
				case "_flechaVolver":
					this.pageCompleted();
					break;
				
				case "_btnActivos":
					this.filter(1);
					break;
				
				case "_btnInactivos":
					this.filter(0);
					break;
				
				case "_btnNuevos":
					this.filter(2);
					break;
				
				case "_btnVencidos":
					this.filter(3);
					break;
				case "_btnVerInfo":
					this.verInfo();
					break;
			}
			
			//dispatchEvent(new CustomEvent(AppEvents.HISTORIAL_MAIN_EVENT,params));
		}
		
		private function verInfo():void
		{
			TweenMax.to(content._infoClip,0.5,{yoyo:true,repeat:1,autoAlpha:1,repeatDelay:8});
			
		}
		
		private function filter(tipo:uint):void{
			var __data:Vector.<DataUsuario> = Model.profe.statics.getByType(tipo);
			trace(__data);
			var views:Array = [];
			for each(var user:DataUsuario in __data){
				var uv:ItemUsuario = new ItemUsuario(user);
				
				views.push(uv);
			}
			
			
			
			if(container)container.parent.removeChild(container);
			if(tapScroll) {
				content._listadoDeUsuarios.removeChild(tapScroll);
				tapScroll = null;
			}
			container = DPUtils.getVerticalContainer(views,10);
			
			if(container.height > 580){				
				tapScroll = new TapScroller(container,1150,580);
				content._listadoDeUsuarios.addChild(tapScroll);
				tapScroll.y = 235;
				tapScroll.x = 50;
			}else{
				content._listadoDeUsuarios.addChild(container);	
				container.y = 235;
				container.x = 50;
			}			
			
		}
		
		protected function onScroll(event:Event):void
		{
			container.y = content.backgroundClip.y;
			
		}	
		
	}
}