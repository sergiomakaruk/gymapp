package app.sections.editarrutinabase
{
	import app.components.button.AppButton;
	import app.data.rutinas.DataIdRutinaBase;
	import app.events.AppEvents;
	import app.model.Model;
	import app.sections.AppSection;
	import app.sections.rutina.Rutina;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import sm.fmwk.ui.button.Button;
	import sm.fmwk.ui.button.events.ButtonEvent;
	import sm.utils.animation.Timeline;
	import sm.utils.display.GetButton;
	import sm.utils.display.GetDrawedObjects;
	import sm.utils.events.CustomEvent;
	
	public class EditarRutinaBaseSection extends AppSection
	{

		private var content:_EditarRutinasBaseSP;

		private var rutina:Rutina;
		private var state:int;
		
		private var idRutina:DataIdRutinaBase;

		private var level_1:Sprite;
		private var level_0:Sprite;
		private var level_2:Sprite;
		private var level_3:Sprite;

		private var timelineLevel1:Timeline;
		private var timelineLevel2:Timeline;
		private var timelineLevel3:Timeline;

		private var capa:DisplayObject;
		public var selectedBtn:MovieClip;
		
		public function EditarRutinaBaseSection(name:String, tracker:Boolean)
		{
			super(name, tracker);
			
			//el nombre de la rutina se deberia cambiar desde la rutina base, una vez creada. 
			//boton para cambiar el nombre, o popup inicial cuando la rutina no tiene nombre...tal vez, antes de salir de la rutina
		}
		
		override public function show(event:Event=null):void{
			content = new _EditarRutinasBaseSP();
			
			
			addChild(content);
			
			/*addButton(content._btnEspecificaHombre).visible = false;
			addButton(content._btnEspecificaMujer).visible = false;
			addButton(content._btnAvanzadoHombre);
			addButton(content._btnAvanzadoMujer);
			addButton(content._btnIntermedioHombre);
			addButton(content._btnIntermedioMujer);
			addButton(content._btnPrincipianteHombre);
			addButton(content._btnPrincipianteMujer);*/
			level_0 = new Sprite();
			level_1 = new Sprite();
			level_2 = new Sprite();
			level_3 = new Sprite();
			content.addChild(level_0);
			content.addChild(level_1);
			content.addChild(level_2);
			content.addChild(level_3);	
			
			
			content._btnEspecifica.visible = false;
			
			level_0.addChild(addButton(content._btnHombre));
			level_0.addChild(addButton(content._btnMujer));
			level_1.addChild(addButton(content._btnPrincipiante));
			level_1.addChild(addButton(content._btnIntermedio));
			level_1.addChild(addButton(content._btnAvanzado));
			//level_1.addChild(addButton(content._btnEspecifica));
			level_1.addChild(addButton(content._btnFuerza));
			level_1.addChild(addButton(content._btnPotencia));
			level_1.addChild(addButton(content._btnVolumen));
			level_1.addChild(addButton(content._btnResistencia));			
			level_2.addChild(addButton(content._btn1dia));
			level_2.addChild(addButton(content._btn2dias));
			level_2.addChild(addButton(content._btn3dias));
			level_2.addChild(addButton(content._btn4dias));
			level_3.addChild(addButton(content._btnOpcion1));
			level_3.addChild(addButton(content._btnOpcion2));
			level_3.addChild(addButton(content._btnOpcion3));
			level_3.addChild(addButton(content._btnOpcion4));
			level_3.addChild(addButton(content._btnOpcion5));
			
			content._btnOpcion2._txt.text = "Opción 2";
			content._btnOpcion3._txt.text = "Opción 3";
			content._btnOpcion4._txt.text = "Opción 4";
			content._btnOpcion5._txt.text = "Opción 5";
			
			state = 0;			
			
			previousAction(content._flechaVolver,AppButton);
			var flecha:DisplayObject = addButton(content._flechaVolver);
			flecha.x += 50;
			flecha.y += 50;
			
			super.show();
			
			var barra:Sprite = GetDrawedObjects.getSprite(300,stage.stageHeight-200,0,0);
			barra.y = 200;
			addChild(barra);
			
			//this.showrutinaBase();
		}
		
		
		private function addButton(face:MovieClip):Button{
			var btn:Button = GetButton.button(face,AppButton);
			btn.face = face;
			//btn.autoDestroy = true;
			btn.unlock();
			btn.addEventListener(ButtonEvent.onDOWN,onDonwn_2);
			btn.delayTime = 3000;
			content.addChild(btn);
			if(face.name == '_btnHombre' || face.name == '_btnMujer' || face.name == '_flechaVolver') {
				btn.visible = true;
			}else
			{
				btn.visible = false;
				btn.alpha = 0;
			}
			
			return btn;
		}
		
		protected function onDonwn_2(event:Event):void
		{	
			if(event.target.name == '_flechaVolver'){
				volver();
				return;
			}
			trace("STATE: ",state);
			switch(state){
				case 0:showLevel1(event.target as AppButton);break;
				case 1:showLevel2(event.target as AppButton);break;
				case 2:showLevel3(event.target as AppButton);break;
				case 3:getDiaAndloadRutinaBase(event.target as AppButton);break;
			}
		}
		
		private function getDiaAndloadRutinaBase(target:AppButton):void
		{
			switch(target.name){				
				
				case '_btnOpcion1':idRutina.opcion = 1;break;
				case '_btnOpcion2':idRutina.opcion = 2;break;
				case '_btnOpcion3':idRutina.opcion = 3;break;
				case '_btnOpcion4':idRutina.opcion = 4;break;
				case '_btnOpcion5':idRutina.opcion = 5;break;
				
			}
			selectedBtn = target.face as MovieClip;
			idRutina.nombre = content['_btnOpcion'+idRutina.opcion]._txt.text;
			loadRutinaBase();			
		}
		
		private function volver():void
		{
			if(state == 0)this.goPrevious();
			else if(state == 1)timelineLevel1.reverse();	
			else if(state == 2)timelineLevel2.reverse();	
			else if(state == 3)timelineLevel3.reverse();
			
			if(capa)addChild(capa);
		}
		
		private function showLevel1(target:AppButton):void
		{
			capa = GetDrawedObjects.getSprite(stage.stageWidth,stage.stageHeight,0,0);
			addChild(capa);
			idRutina = new DataIdRutinaBase();
			if(target.name == '_btnHombre')idRutina.genero = 1;
			else idRutina.genero = 0;
			
			timelineLevel1 = new Timeline(onTimelineLevelComplete,onTimelineLevelReverse);
			content.addChild(target);
			timelineLevel1.allTo(level_0,{autoAlpha:0});
			timelineLevel1.to(target,{y:312});
			timelineLevel1.to(target,{x:100});	
			timelineLevel1.allTo(level_1,{autoAlpha:1});
			timelineLevel1.play();
			level_0.addChild(target);
		}
		
		private function showLevel2(target:AppButton):void
		{
			addChild(capa);
			switch(target.name){
				case '_btnPrincipiante':idRutina.level = 1;loadRutinaBase();return;
				case '_btnIntermedio':idRutina.level = 2;loadRutinaBase();return;
				case '_btnAvanzado':idRutina.level = 3;loadRutinaBase();return;
				case '_btnEspecifica':idRutina.level = 4;loadRutinaBase();return;
					
				case '_btnFuerza':idRutina.tipo = 1;break;
				case '_btnPotencia':idRutina.tipo = 2;break;
				case '_btnVolumen':idRutina.tipo = 3;break;
				case '_btnResistencia':idRutina.tipo = 4;break;
				
			}
			//si pasa, no tiene level, son rutinas nuevas, del menu nuevo
			idRutina.level = 0;
			
			/*tipo: (1:fuerza / 2:volumen / 3:potencia / 4:resistencia)			
			dias:(1: 1 dias / 2: 2 dias, etc etc)			
			opcion:(1: opcion1, 2:opcion2, etc etc).*/
					
			timelineLevel2 = new Timeline(onTimelineLevelComplete,onTimelineLevelReverse);
			content.addChild(target);
			timelineLevel2.allTo(level_1,{autoAlpha:0});
			timelineLevel2.to(target,{y:312+120});
			timelineLevel2.to(target,{x:100});	
			timelineLevel2.allTo(level_2,{autoAlpha:1});
			timelineLevel2.play();
			level_1.addChild(target);
		}
		
		private function showLevel3(target:AppButton):void
		{
			addChild(capa);
			switch(target.name){				
					
				case '_btn1dia':idRutina.dias = 1;break;
				case '_btn2dias':idRutina.dias = 2;break;
				case '_btn3dias':idRutina.dias = 3;break;
				case '_btn4dias':idRutina.dias = 4;break;				
			}	
			
			//aca renderizo los nombres segun la categoria de dia elegido
			for(var i:uint = 1;i<5;i++)//dias
			{
				content['_btnOpcion' + i]._txt.text = 'Opción '+i;
			}
			
			var data:DataIdRutinaBase;
			for each(data in Model.profe.menuRutinaBase.data){
				if(data.tipo == idRutina.tipo && data.dias == idRutina.dias && data.genero == idRutina.genero){
					content['_btnOpcion' + data.opcion]._txt.text = data.nombre;						
				}
			}			
			
			
			timelineLevel3 = new Timeline(onTimelineLevelComplete,onTimelineLevelReverse);
			content.addChild(target);
			timelineLevel3.allTo(level_2,{autoAlpha:0});
			timelineLevel3.to(target,{y:312+120+120});
			timelineLevel3.to(target,{x:100});	
			timelineLevel3.allTo(level_3,{autoAlpha:1});
			timelineLevel3.play();
			level_2.addChild(target);
		}
		
		private function loadRutinaBase():void
		{
			TweenMax.delayedCall(2,clearStage);
			dispatchEvent(new CustomEvent(AppEvents.RECUPERAR_RUTINA_BASE_EVENT,idRutina));			
		}
		
		private function clearStage():void
		{
			if(capa.stage)removeChild(capa);			
		}
		
		private function onTimelineLevelReverse():void
		{
			state--;		
			if(capa.stage)removeChild(capa);
		}
		
		private function onTimelineLevelComplete():void
		{
			if(capa.stage)removeChild(capa);
			state++;			
		}
		
		protected function onDonwn(event:Event):void
		{	
			var isMen:uint = 1;
			var level:uint = 0;
			switch(event.target.face.name){
				case '_btnEspecificaHombre':level=4;break;
				case '_btnAvanzadoHombre':level=3;break;
				case '_btnIntermedioHombre':level=2;break;
				case '_btnPrincipianteHombre':level=1;break;
				case '_btnEspecificaMujer':level=4;isMen=0;break;
				case '_btnAvanzadoMujer':level=3;isMen=0;break;
				case '_btnIntermedioMujer':level=2;isMen=0;break;
				case '_btnPrincipianteMujer':level=1;isMen=0;break;
			}
			
			dispatchEvent(new CustomEvent(AppEvents.RECUPERAR_RUTINA_BASE_EVENT,[level,isMen]));
		}
		
		public function showrutinaBase():void
		{
			TweenMax.to(content,1,{x:-stage.stageWidth,ease:Expo.easeIn});
			rutina = new Rutina();
			rutina.addEventListener(AppEvents.EDITAR_RUTINA_MAIN_EVENT,onVolver);			
			rutina.renderasRutinaBase();
			rutina.x = 270;
			TweenMax.from(rutina,1,{x:stage.stageWidth + 300,ease:Expo.easeOut,delay:1});
			addChild(rutina);
		}
		
		private function removeRutina():void{
			removeChild(rutina);
			rutina.destroy();	
		}
		
		
		protected function onVolver(event:CustomEvent):void
		{
			if(event.params.action == AppEvents.VOLVER)
			{
				TweenMax.to(rutina,1,{x:stage.stageWidth + 300,ease:Expo.easeIn});
				TweenMax.to(content,1,{x:0,ease:Expo.easeOut,delay:1,onComplete:removeRutina});				
				
			}
			
		}
	}
}