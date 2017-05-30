package app.commands
{
	import app.datatransferences.AppTokenDataTransferenceData;
	import app.datatransferences.DataTransferenceTypes;
	import app.model.Model;
	
	import org.robotlegs.mvcs.Command;
	
	import sm.fmwk.net.transferences.DataTransferenceData;
	import sm.fmwk.rblegs.events.message.MessageEvent;
	import sm.fmwk.rblegs.events.transference.FinishTransferenceEvent;
	import sm.fmwk.rblegs.proxys.SequenceStaker;
	import sm.utils.events.CustomEvent;

	
	public class GetProfeUserCommand extends Command
	{
		[Inject]
		public var staker:SequenceStaker;
		
		[Inject]
		public var theevent:CustomEvent;

		
		public function GetProfeUserCommand()
		{
			super();
		}
		
		override public function execute():void
		{			
			this.eventDispatcher.addEventListener(FinishTransferenceEvent.TRANSFERENCE_COMPLETE,onTransferenceComplete);
			this.eventDispatcher.addEventListener(MessageEvent.MESSAGE_REMOVED,onMessageRemoved);

			this.commandMap.detain(this);
			
			staker.add(new AppTokenDataTransferenceData(DataTransferenceTypes.BUSCA_SOCIO,[theevent.params.dni,'','']));
			
			/*if(Model.instance.user)
			{
				getJuegoEvent.callback();
			}
			else
			{
				staker.add(new JSDataTransferenceData(DataTransferenceTypes.JS_GET_SESSION,null));
				staker.start();
			}*/			
			
			staker.start();
		}
		
		private function onMessageRemoved(e:MessageEvent):void
		{
			this.eventDispatcher.removeEventListener(FinishTransferenceEvent.TRANSFERENCE_COMPLETE,onTransferenceComplete);
			this.eventDispatcher.removeEventListener(MessageEvent.MESSAGE_REMOVED,onMessageRemoved);
			end();	
		}
		
		private function end():void
		{
			
			theevent.params.cb();//ejecuta el callback
			this.commandMap.release(this);		
			
		}
		
		private function onTransferenceComplete(e:FinishTransferenceEvent):void
		{
			switch(e.msg)
			{
				
				case DataTransferenceTypes.BUSCA_SOCIO:					
					if(Model.socio.exists){
						staker.add(new AppTokenDataTransferenceData(DataTransferenceTypes.GET_USER_PHOTO,[Model.socio.dni,Model.socio.numero,0]));	
						staker.add(new AppTokenDataTransferenceData(DataTransferenceTypes.HISTORIAL_RUTINAS,[Model.socio.idSocio]));	
					}									
					break;		
				/*case DataTransferenceTypes.HISTORIAL_RUTINAS:
					staker.add(new AppTokenDataTransferenceData(DataTransferenceTypes.GET_RUTINA,[Model.socio.rutinas.lastRutina]));					
					break;*/
			}
			
		}
	}
}