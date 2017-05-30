package app.components.menu
{
	
	import app.AppMessagesTypes;
	import app.AppSectionTypes;
	import app.components.button.AppButton;
	import app.model.Model;
	import app.sections.rutina.msg.SalirMsg;
	
	import com.greensock.TweenMax;
	
	import flash.desktop.NativeApplication;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import mx.core.ButtonAsset;
	
	import sm.fmwk.Fmwk;
	import sm.fmwk.site.core.DataPage;
	import sm.fmwk.site.interfases.IAnimationFlowComponent;
	import sm.fmwk.site.section.SectionTypes;
	import sm.fmwk.ui.button.Button;
	import sm.fmwk.ui.button.events.ButtonEvent;
	import sm.fmwk.ui.custombutton.LabelButton;
	import sm.ui.ligthbox.Lightbox;
	import sm.utils.animation.Timeline;
	import sm.utils.display.GetButton;
	import sm.utils.display.GetDrawedObjects;
	
	public class Menu extends Sprite implements IAnimationFlowComponent
	{		
		private var _currentBtn:Button;
		private var menu:MovieClip;
		private var menu2:MovieClip;
		private var buttons:Vector.<Button>;

		private var close:_btnExit;
		private var msgCancel:SalirMsg;

		private var _closeClave:Sprite;


		
		public function set sectionAdded(sectionName:String):void{
			
			switch(sectionName){
				
				case AppSectionTypes.LOGIN_PROFE:
				case AppSectionTypes.LOGIN_USUARIO:				
					_closeClave.visible = true;						
					break;
				
				
				case AppSectionTypes.EDIT_RUTINA:
				case AppSectionTypes.EDIT_RUTINAS_BASE:
				case AppSectionTypes.PERFIL_PROFE:
				case AppSectionTypes.HISTORIAL_USUARIO:
					_closeClave.visible = false;	
					close.visible = true;
					break;
		
				default:		
					_closeClave.visible = false;
					close.visible = false;
					break;
			}
			
			
		}

		
		public function Menu()
		{
			
		}
		public function init():void{
			close = new _btnExit();
			close.y = 5;
			close.x = stage.stageWidth - close.width - 5;
			close.visible = false;
			
			close.addEventListener(MouseEvent.CLICK,msgCancelHandler);
			addChild(close);
			
			_closeClave = new Sprite();
			_closeClave.addChild(GetDrawedObjects.getShape(100,100,0,0));
			_closeClave.y = 0;
			_closeClave.x = stage.stageWidth - _closeClave.width;
			
			_closeClave.addEventListener(MouseEvent.CLICK,msgClaveHandler);
			this.stage.addChild(_closeClave);
		}
		
		private function msgCancelHandler(e:Event):void
		{
			msgCancel = new SalirMsg(2);
			stage.addChild(msgCancel);
			msgCancel.initMsg();
			msgCancel.addEventListener(Event.COMPLETE,onClose);
			msgCancel.addEventListener(Event.REMOVED_FROM_STAGE,onCartelEliminarRemoved);
		}
		
		private function msgClaveHandler(e:Event):void
		{
			msgCancel = new SalirMsg(5);
			stage.addChild(msgCancel);
			msgCancel.configKeyBoard();
			//msgCancel.addEventListener(Event.COMPLETE,onClose);
			//msgCancel.addEventListener(Event.REMOVED_FROM_STAGE,onCartelEliminarRemoved);
		}
		
		protected function onCartelEliminarRemoved(event:Event):void
		{
			var msg:Lightbox = event.target as Lightbox;
			msg.removeEventListener(Event.COMPLETE,onClose);
			msg.removeEventListener(Event.REMOVED_FROM_STAGE,onCartelEliminarRemoved);
		}
		
		protected function onClose(event:Event):void
		{
			NativeApplication.nativeApplication.exit(); 			
		}

		
		//--------- IAnimationFlowComponent --------------//
		public function animationBeforeRemoveSection(sectionName:String):Timeline
		{
			var timeline:Timeline = new Timeline();
			timeline.to(this,{y:"-10"});
			
			return timeline;
		}
		public function animationBeforeAddSection(sectionName:String):Timeline
		{
			var timeline:Timeline = new Timeline();
			this.y+=10;
			
			return timeline;
		}
		
		private function noTween():void
		{
			this.y+=10;			
		}
		
		
	}
}