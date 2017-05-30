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

	
	public class GetFakeUserCommand extends Command
	{
		[Inject]
		public var staker:SequenceStaker;
		
		[Inject]
		public var theevent:CustomEvent;
		
		public function GetFakeUserCommand()//se usa a prueba en EditarRutinaBase
		{
			super();
		}
		
		override public function execute():void
		{			
			this.eventDispatcher.addEventListener(FinishTransferenceEvent.TRANSFERENCE_COMPLETE,onTransferenceComplete);
			this.eventDispatcher.addEventListener(MessageEvent.MESSAGE_REMOVED,onMessageRemoved);

			this.commandMap.detain(this);
				
			if(!Model.profe.logued){
				staker.add(new DataTransferenceData(DataTransferenceTypes.VALIDAR_PROFE,['060','060060']));
			}else{
				staker.add(new AppTokenDataTransferenceData(DataTransferenceTypes.BUSCA_SOCIO,['32392290','','']));
			}
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
			
			theevent.params();//ejecuta el callback
			this.commandMap.release(this);			
		}
		
		private function onTransferenceComplete(e:FinishTransferenceEvent):void
		{
			
			switch(e.msg)
			{
				/*
				case DataTransferenceTypes.VALIDAR_PROFE:					
				var level:uint=0;
				var sexo:uint=0;
				Model.profe.rutinaBase.populateAsRutinaBase(level,sexo);
				staker.add(new AppTokenDataTransferenceData(DataTransferenceTypes.RECUPERAR_RUTINA_BASE,[1,level,sexo]));
				break;
				*/
				
				case DataTransferenceTypes.VALIDAR_PROFE:
					staker.add(new AppTokenDataTransferenceData(DataTransferenceTypes.BUSCA_SOCIO,['32392290','','']));				
					break;	
				case DataTransferenceTypes.BUSCA_SOCIO:
					staker.add(new AppTokenDataTransferenceData(DataTransferenceTypes.GET_USER_PHOTO,[Model.socio.dni,Model.socio.numero,0]));	
					staker.add(new AppTokenDataTransferenceData(DataTransferenceTypes.HISTORIAL_RUTINAS,[Model.socio.idSocio]));					
					break;		
				case DataTransferenceTypes.HISTORIAL_RUTINAS:
					staker.add(new AppTokenDataTransferenceData(DataTransferenceTypes.GET_RUTINA,[Model.socio.rutinas.lastRutina]));					
					break;
			}
			
			/*if(!staker.hasData())
			{
				getJuegoEvent.callback();
				this.commandMap.release(this);
			}*/			
		}
	}
}