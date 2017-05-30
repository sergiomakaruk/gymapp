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
	import sm.utils.loader.LoaderData;

	
	public class GetUserCommand extends Command
	{
		[Inject]
		public var staker:SequenceStaker;
		
		[Inject]
		public var theevent:CustomEvent;
		
		private const TOKEN:String = "368934881474680855";
		
		public function GetUserCommand()//en Login Usuario, con hardcode profesor
		{
			super();
		}
		
		override public function execute():void
		{			
			this.eventDispatcher.addEventListener(FinishTransferenceEvent.TRANSFERENCE_COMPLETE,onTransferenceComplete);
			this.eventDispatcher.addEventListener(MessageEvent.MESSAGE_REMOVED,onMessageRemoved);

			this.commandMap.detain(this);
			
			staker.add(new DataTransferenceData(DataTransferenceTypes.BUSCA_SOCIO,[theevent.params.dni,'','',TOKEN]));
			
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
				/*case DataTransferenceTypes.VALIDAR_PROFE:
					staker.add(new AppTokenDataTransferenceData(DataTransferenceTypes.BUSCA_SOCIO,['32392290','','']));				
					break;	*/
				case DataTransferenceTypes.BUSCA_SOCIO:					
					if(Model.socio.exists){
						staker.add(new DataTransferenceData(DataTransferenceTypes.HISTORIAL_RUTINAS,[Model.socio.idSocio,TOKEN]));	
						//staker.add(new DataTransferenceData(DataTransferenceTypes.FUERZO_ENVIO_EMAIL,[Model.socio.idSocio,TOKEN]));
					}									
					break;		
				case DataTransferenceTypes.HISTORIAL_RUTINAS:
					if(Model.socio.rutinas.lastRutina)staker.add(new DataTransferenceData(DataTransferenceTypes.GET_RUTINA,[Model.socio.rutinas.lastRutina,TOKEN]));					
					break;
				
				/*case DataTransferenceTypes.GET_RUTINA:
					trace("EEEE",Model.socio.rutinas.selectedRutina.getDataForEmail());
					staker.add(new DataTransferenceData(DataTransferenceTypes.FUERZO_ENVIO_EMAIL,{rutina:Model.socio.rutinas.selectedRutina.getDataForEmail()}));				
					break;*/
			}
			
			/*if(!staker.hasData())
			{
				getJuegoEvent.callback();
				this.commandMap.release(this);
			}	*/	
		}
	}
}