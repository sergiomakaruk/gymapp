package app.sections.historial
{
	import app.components.button.AppButton;
	import app.data.rutinas.DataIdRutinaBase;
	import app.events.AppEvents;
	import app.model.Model;
	import app.sections.rutina.ejercicios.componets.ItemEditarHeader;
	import app.sections.rutina.menu.AbsMenu;
	
	import com.greensock.TweenMax;
	import com.greensock.easing.Expo;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import sm.fmwk.ui.button.Button;
	import sm.fmwk.ui.button.events.ButtonEvent;
	import sm.utils.animation.Timeline;
	import sm.utils.display.DPUtils;
	import sm.utils.display.GetButton;
	import sm.utils.display.GetDrawedObjects;
	import sm.utils.events.CustomEvent;
	
	public class MenuCrearRutina extends Sprite
	{
		
		public var level:uint;
		public var sexo:uint;

		private var content:_CrearRutinaMenuSP;
		private var viewsObservaciones:Array;
		private var viewsObjetivos:Array;
		public var isObservaciones:Boolean;

		

		private var objetivos:_editorDeObjetivosSP;
		private var observaciones:_editorDeObjetivosSP;
		
		private var state:uint = 0;

		private var twobs:TweenMax;

		private var animating:Boolean;

		private var level_1:Sprite;
		private var level_0:Sprite;
		private var level_2:Sprite;
		private var level_3:Sprite;
		
		private var timeline:Timeline;
		private var timelineLevel1:Timeline;
		private var timelineLevel2:Timeline;
		private var timelineLevel3:Timeline;
		private var timelineLevel4:Timeline;
		private var idRutina:DataIdRutinaBase;
		private var timelineLevel5:Timeline;
		private var capa:Sprite;
		
		public function MenuCrearRutina()
		{
			super();
			
			content = new _CrearRutinaMenuSP();
			addChild(content);
			
			level_0 = new Sprite();
			level_1 = new Sprite();
			level_2 = new Sprite();
			level_3 = new Sprite();
			content.addChild(level_0);
			content.addChild(level_1);
			content.addChild(level_2);
			content.addChild(level_3);
			
			level_0.addChild(addButton(content._btnHombre));
			level_0.addChild(addButton(content._btnMujer));
			level_1.addChild(addButton(content._btnPrincipiante));
			level_1.addChild(addButton(content._btnIntermedio));
			level_1.addChild(addButton(content._btnAvanzado));
			level_1.addChild(addButton(content._btnEspecifica));
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
			
			
			addButton(content._flechaVolver_2);
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);
			
			//addChild(content._flechaVolver_2);
		}
		
		protected function onAdded(event:Event):void
		{
			this.removeEventListener(Event.ADDED_TO_STAGE,onAdded);
			var barra:Sprite = GetDrawedObjects.getSprite(300,stage.stageHeight-300,0,0);		
			barra.y = 200;
			addChild(barra);
			
		}
		
		protected function removeButton(face:MovieClip):void
		{			
			face.removeEventListener(MouseEvent.MOUSE_DOWN,onDonwn_2);			
		}
		
		
		
		private function addButton(face:MovieClip):Button{
			var btn:Button = GetButton.button(face,AppButton);
			btn.face = face;
			//btn.autoDestroy = true;
			btn.unlock();
			btn.addEventListener(ButtonEvent.onDOWN,onDonwn_2);
			btn.delayTime = 1000;
			content.addChild(btn);
			if(face.name == '_btnHombre' || face.name == '_btnMujer' || face.name == '_flechaVolver_2') {
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
			if(event.target.name == '_flechaVolver_2'){
				volver();
				return;
			}
			trace("STATE: ",state);
			switch(state){
				case 0:showLevel1(event.target as AppButton);break;
				case 1:showLevel2(event.target as AppButton);break;
				case 2:showLevel3(event.target as AppButton);break;
				case 3:getDiaAndShowObjetivos(event.target as AppButton);break;
			}
		}
		
		private function getDiaAndShowObjetivos(target:AppButton):void
		{
			switch(target.name){				
				
				case '_btnOpcion1':idRutina.opcion = 1;break;
				case '_btnOpcion2':idRutina.opcion = 2;break;
				case '_btnOpcion3':idRutina.opcion = 3;break;
				case '_btnOpcion4':idRutina.opcion = 4;break;
				case '_btnOpcion5':idRutina.opcion = 5;break;
				
			}
			
			timelineLevel4 = new Timeline(onTimelineLevelComplete,onTimelineLevelReverse);
			content.addChild(target);
			timelineLevel4.allTo(level_3,{autoAlpha:0});
			timelineLevel4.to(target,{y:312+120+120+120});
			timelineLevel4.to(target,{x:100});	
			
			showObjetivos(timelineLevel4);			
			
			timelineLevel4.play();
			level_3.addChild(target);		
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
				case '_btnPrincipiante':idRutina.level = 1;showObservacionesFromState1(target);return;
				case '_btnIntermedio':idRutina.level = 2;showObservacionesFromState1(target);return;
				case '_btnAvanzado':idRutina.level = 3;showObservacionesFromState1(target);return;
				case '_btnEspecifica':idRutina.level = 4;showObservacionesFromState1(target);return;
					
				case '_btnFuerza':idRutina.tipo = 1;break;
				case '_btnPotencia':idRutina.tipo = 2;break;
				case '_btnVolumen':idRutina.tipo = 3;break;
				case '_btnResistencia':idRutina.tipo = 4;break;
				
			}
			//si pasa, no tiene level, son rutinas nuevas, del menu nuevo
			idRutina.level = 0;
	
			
			timelineLevel2 = new Timeline(onTimelineLevelComplete,onTimelineLevelReverse);
			content.addChild(target);
			timelineLevel2.allTo(level_1,{autoAlpha:0});
			timelineLevel2.to(target,{y:312+120});
			timelineLevel2.to(target,{x:100});	
			timelineLevel2.allTo(level_2,{autoAlpha:1});
			timelineLevel2.play();
			level_1.addChild(target);
		}
		
		private function showObservacionesFromState1(target:DisplayObject):void{
			timelineLevel2 = new Timeline(onTimelineLevelComplete,onTimelineLevelReverse);
			content.addChild(target);
			timelineLevel2.allTo(level_1,{autoAlpha:0});
			timelineLevel2.to(target,{y:312+120});
			timelineLevel2.to(target,{x:100});	
			
			showObjetivos(timelineLevel2);			
			
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
		
		private function onTimelineLevelReverse():void
		{
			if(capa.stage)removeChild(capa);
			state--;			
		}
		
		private function onTimelineLevelComplete():void
		{
			if(capa.stage)removeChild(capa);
			state++;			
		}
		
		private function loadRutinaBase():void
		{
			//dispatchEvent(new CustomEvent(AppEvents.RECUPERAR_RUTINA_BASE_EVENT,idRutina));
			trace('loadRutinaBase()');
		}


		/*private function loadRutinaBase(level:uint):void
		{
			this.dispatchEvent(new CustomEvent(AppEvents.HISTORIAL_MAIN_EVENT,{action:AppEvents.RECUPERAR_RUTINA_BASE_EVENT,level:level}));			
		}*/
		
		private function showObjetivos(timeline:Timeline):void
		{
			//state = 2;
			objetivos = new _editorDeObjetivosSP();
			objetivos.y = 260;
		
			viewsObjetivos = [];
			var items:Array =  Model.objetivos;
			//trace(items);
			for(var i:uint=0;i<items.length;i++){
				viewsObjetivos.push(new ItemEditarHeader(items[i],i,false));
			}
			
			var container:Sprite = DPUtils.getColumnsContainer(viewsObjetivos,0,10,1);
			container.x =( stage.stageWidth - container.width)*.5;
			container.y = 130;
			objetivos.addChild(container);
			
			objetivos._flechaContinuar.y = container.y + container.height;
			objetivos._flechaContinuar.x = container.x + container.width + 100;
			objetivos._flechaContinuar.addEventListener(MouseEvent.MOUSE_DOWN,onContinuaraObservaciones);
			
			addChild(objetivos);
			timeline.from(objetivos,{x:stage.stageWidth});
			//timeline2.from(objetivos,{x:stage.stageWidth,ease:Expo.easeInOut});
			//timeline2.play();
		}
		
		private function showObservaciones(timeline:Timeline):void{
			//state = 3;
			//animating = false;
			observaciones = new _editorDeObjetivosSP();
			observaciones.y = 260;			
			observaciones._txt.text = "Elige Observaciones";
			
			
			viewsObservaciones  = [];
			var items:Array = Model.observaciones ;
			//trace(items);
			for(var i:uint=0;i<items.length;i++){
				viewsObservaciones.push(new ItemEditarHeader(items[i],i,false));
			}
			
			var container:Sprite = DPUtils.getColumnsContainer(viewsObservaciones,0,10,1);
			container.x =( stage.stageWidth - container.width)*.5;
			container.y = 130;
			observaciones.addChild(container);
			
			observaciones._flechaContinuar.y = container.y + container.height;
			observaciones._flechaContinuar.x = container.x + container.width + 100;
			observaciones._flechaContinuar.addEventListener(MouseEvent.MOUSE_DOWN,onGuardar);
			//animating = true;
			addChild(observaciones);
			timeline.from(observaciones,{x:stage.stageWidth});
			//twobs = TweenMax.from(observaciones,0.3,{x:stage.stageWidth,ease:Expo.easeInOut,onComplete:ontwonscomplete,onReverseComplete:ontwobsreverse});	
		}
		
		private function ontwonscomplete():void{
			animating = false;
		}
		
		private function ontwobsreverse():void{
			state = 2;
			animating = false;
			removeChild(observaciones);
			observaciones = null;
		}
		
		
		private function onContinuaraObservaciones(e:Event):void{
			objetivos._flechaContinuar.removeEventListener(MouseEvent.MOUSE_DOWN,onContinuaraObservaciones);
			Model.currentDataRutina.objetivos = getObjetivos();
			trace(state,"Model.currentDataRutina.objetivos ",Model.currentDataRutina.objetivos );
			isObservaciones = true;	
			
			var timeline:Timeline;
			if(state == 2){
				timelineLevel3 = new Timeline(onTimelineLevelComplete,onTimelineLevelReverse);	
				timeline = timelineLevel3;				
			}
			else{
				timelineLevel5 = new Timeline(onTimelineLevelComplete,onTimelineLevelReverse);	
				timeline = timelineLevel5;	
			}
						
			timeline.to(objetivos,{x:-2000});
			showObservaciones(timeline);			
			timeline.play();
		}
		
		protected function onGuardar(event:MouseEvent):void
		{
			
			Model.currentDataRutina.observaciones = getObservaciones();
			trace("Model.currentDataRutina.observaciones ",Model.currentDataRutina.observaciones );
			var params:Object = {};				
				params.action = AppEvents.HISTORIAL_CREAR_NUEVA_RUTINA;		
				params.dataIdRutina = idRutina;
				dispatchEvent(new CustomEvent(AppEvents.HISTORIAL_MAIN_EVENT,params));			
			
		}
		
		
		private function volver():void
		{
			if(state == 0)dispatchEvent(new Event("eventVolver",true));
			else if(state == 1)timelineLevel1.reverse();	
			else if(state == 2)timelineLevel2.reverse();	
			else if(state == 3)timelineLevel3.reverse();
			else if(state == 4)timelineLevel4.reverse();
			else if(state == 5)timelineLevel5.reverse();
			
			addChild(capa);
		}
		
		private function getObjetivos():String
		{
			var actives:Array = [];
			for each(var it:ItemEditarHeader in viewsObjetivos){
				if(it.isActive)actives.push(it.id);
			}
			return actives.join(',');
		}
		
		private function getObservaciones():String
		{
			var actives:Array = [];
			for each(var it:ItemEditarHeader in viewsObservaciones){
				if(it.isActive)actives.push(it.id);
			}
			return actives.join(',');
		}
		
		public function destroy():void
		{
			// TODO Auto Generated method stub
			
		}
	}
}