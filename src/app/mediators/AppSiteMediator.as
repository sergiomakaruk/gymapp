package app.mediators
{
	import app.AppSectionTypes;
	import app.datatransferences.DataTransferenceTypes;
	import app.model.Model;
	import app.sections.rutina.UtilsMail;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	import sm.fmwk.Fmwk;
	import sm.fmwk.net.transferences.DataTransferenceData;
	import sm.fmwk.net.transferences.SequenceTransferenceData;
	import sm.fmwk.rblegs.events.section.SectionEvent;
	import sm.fmwk.rblegs.events.transference.TransferenceCallbackEvent;
	import sm.fmwk.site.mediators.SiteMediator;
	
	//import sm.fmwk.site.stagerezise.StageResizeManager;
	
	public class AppSiteMediator extends SiteMediator
	{		

		private var timer:Timer;
		private var doTimer:Boolean;
		
		public function AppSiteMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			//managerStage.stage = this.site.stage;
			super.onRegister();
		}
		
		override public function init():void
		{	
			var s:SequenceTransferenceData = new SequenceTransferenceData();
			s.add(new DataTransferenceData(DataTransferenceTypes.GET_ALL_EXERCISES));
			s.add(new DataTransferenceData(DataTransferenceTypes.GET_INIT));
			s.add(new DataTransferenceData(DataTransferenceTypes.GET_ALL_USERS));
			s.add(new DataTransferenceData(DataTransferenceTypes.GET_VERSION_UPDATE_INFO));
			this.dispatch(new TransferenceCallbackEvent(s,onEjercicios));	
			
			this.site.stage.addEventListener(MouseEvent.MOUSE_DOWN,onActivity);
			sectionManager.addEventListener(SectionEvent.SECTION_ADDED,onSectionAdded);
		}
		
		protected function onSectionAdded(e:SectionEvent):void
		{
			switch(e.sectionName){
				case AppSectionTypes.EDIT_RUTINA:
				case AppSectionTypes.EDIT_RUTINAS_BASE:
				case AppSectionTypes.HISTORIAL_USUARIO:				
				case AppSectionTypes.EDIT_RUTINA:				
					doTimer = false;
					break;
				default:
					doTimer = true;
			}
			onActivity();
		}
		
		private function onActivity(e:Event=null):void{
			//onTimer();return;
			//trace(e);
			if(timer){
				timer.removeEventListener(TimerEvent.TIMER_COMPLETE,onTimer);
				timer.stop();				
			}
			
			if(!doTimer)return;
			
			timer = new Timer(1000 * uint(Fmwk.appConfig('carousel')) * 60 ,1);//1000
			timer.addEventListener(TimerEvent.TIMER_COMPLETE,onTimer);
			timer.start();
		}
		
		protected function onTimer(event:TimerEvent=null):void
		{
			//trace('logout and showpromos');
			
			if(sectionManager.currentSection.name != AppSectionTypes.PROMOS){
				Model.clean();						
				var section:String = AppSectionTypes.PROMOS;			
				this.dispatch(new SectionEvent(SectionEvent.SECTION_CHANGE,section));
			}
			
		}
		
		private function onEjercicios():void
		{
			var section:String = AppSectionTypes.LOGIN_PROFE;
			section = AppSectionTypes.LOGIN_USUARIO;
			//section = AppSectionTypes.PROMOS;
			//section = AppSectionTypes.PERFIL_PROFE;
			//section = AppSectionTypes.STATICS_PROFE;
			//section = AppSectionTypes.EDIT_RUTINAS_BASE;
			section = AppSectionTypes.HISTORIAL_USUARIO;
			//section = AppSectionTypes.VERSION_UPDATES_INFO;
			
			this.dispatch(new SectionEvent(SectionEvent.SECTION_CHANGE,section));
			onActivity();
			
			//UtilsMail.sendRutinaUpdate("sergiomakaruk@gmail.com","32392290");
		}
	}
}