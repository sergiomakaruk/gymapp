package
{
	import app.AppMessagesTypes;
	import app.AppSectionTypes;
	import app.context.AppContext;
	import app.datatransferences.AppDataTransference;
	import app.datatransferences.LogUtil;
	import app.datatransferences.TestDataTransference;
	import app.model.AppParseDataActor;
	
	import com.riaspace.nativeUpdater.NativeUpdater;
	
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.text.TextField;
	import flash.ui.Mouse;
	
	import nid.ui.controls.VirtualKeyBoardEjercicio;
	import nid.ui.controls.vkb.KeyBoardEvent;
	import nid.ui.controls.vkb.KeyBoardTypes;
	
	import sm.fmwk.Fmwk;
	import sm.fmwk.rblegs.RobotlegsMain;

	[SWF(width="1280",height="1024", frameRate="30", backgroundColor="#333333")]
	
	public class air_american_sport_rutinas extends RobotlegsMain
	{		
		public function air_american_sport_rutinas()
		{			
			//https://developers.facebook.com/docs/guides/games/requests/
			//data en Base64 tiene todo ResponseDebug
			
			//SE MUERTRA NUEVO EN TODOS LADOS
			// IF NULL SI EL DIA EXISTE
			
		/*	FALTA POR HACER:				
				-Servidor y envio de email y visualizacion de rutina*/
				//-TEAM VIEWER
			// Cuando el kiosco detecte en que sede esta, se puede filtrar el alumno por sede.
		}	
		
		override protected function doConfig():void
		{				
			if(Fmwk.appConfig('kiosko').indexOf('Sergio') == -1) Mouse.hide();
			
			LogUtil.defineAppId();
		}		
	
		override protected function startApp():void
		{			
			this.stage.scaleMode = "noScale";
			this.stage.align = "topLeft";
			
			Fmwk.dataTransferenceClass = new AppDataTransference();
			if(Fmwk.appConfig('test'))	Fmwk.dataTransferenceClass = new TestDataTransference();
			Fmwk.defaultTransferenceMessage = AppMessagesTypes.MINIMAL_TRANSFERENCE_MESSAGE;
			Fmwk.sections = new AppSectionTypes().sections;	
			Fmwk.messages = new AppMessagesTypes().messages;
			Fmwk.parseActor = new AppParseDataActor();	
			Fmwk.elasticApp = true;			
			
			var appContext:AppContext = new AppContext(this,false);
			
			/*VirtualKeyBoardEjercicio.getInstance().init(this);					
			VirtualKeyBoardEjercicio.getInstance().addEventListener(KeyBoardEvent.SAVE,onEmailSave);
			var t:TextField = new TextField();
			t.text = "Hola";
			VirtualKeyBoardEjercicio.getInstance().target = { field:t, fieldName:"Enviar email a usuario",keyboardType:KeyBoardTypes.ALPHABETS_LOWER };
*/
			appContext.init();	
		}
		
	}
}