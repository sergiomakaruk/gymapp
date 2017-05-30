package app.sections.perfilprofesor
{
	import app.components.button.AppButton;
	import app.components.button.AppButton_2;
	import app.datatransferences.LogUtil;
	import app.model.Model;
	import app.sections.AppSection;
	import app.sections.componentes.TecladoNumerico;
	import app.sections.componentes.errormsg.ErrorMsg;
	
	import com.greensock.TweenMax;
	import com.riaspace.nativeUpdater.NativeUpdater;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import sm.fmwk.Fmwk;
	import sm.fmwk.ui.button.Button;
	import sm.utils.display.GetButton;
	
	public class PerfilProfesor extends AppSection
	{
		private var teclado:TecladoNumerico;

		private var content:_perfilProfeSP;
		
		public function PerfilProfesor(name:String, tracker:Boolean)
		{
			super(name, tracker);
		}
		
		override public function show(event:Event=null):void{
			
			if(!Model.update){
				
				var update:NativeUpdater = new NativeUpdater();
				update.updateApplication();
			}			
			//LogUtil.logError(Model.update.toString(),"Model.update");
			
			content = new _perfilProfeSP();
			addChild(content);
			
			content._nombreProfe.text = Model.profe.nombre;
			
			teclado = new TecladoNumerico();
			teclado.x = stage.stageWidth - teclado.width;
			teclado.addEventListener(TecladoNumerico.KEY_NUMBER_EVENT,onUpdate);
			teclado.addEventListener(TecladoNumerico.KEY_ENTER,onEnter);
			//teclado.addEventListener(Event.COMPLETE,onEnter);
			addChild(teclado);
			
			content._dni._input.text = "";
			TextField(content._dni._input).maxChars = 30;
			teclado.focus = content._dni._input;	
					
			content._error.visible = false;
			
			completeAction(content._btnRutinas,AppButton);
			
			var btn:Button = GetButton.pressButton(content._flechaVolver,onVolver);
			btn = GetButton.pressButton(content._btnVerRendimiento,onVerStatics);
			btn = GetButton.pressButton(content._btnVerUpdate,onVerInfoUpdate);
			
			/*var myPattern:RegExp = /---/g;
			var str:String = String(Fmwk.appConfig('dataactualizacion')).replace(myPattern,'\n');
			content._datosUpdate._datos.text = str;
			content._datosUpdate._titulo.text = Fmwk.appConfig('tituloversion');*/
						
			content._datosinfokiosco.visible = false;	
			content._datosinfokiosco.alpha = 0;
			content._datosinfokiosco._datos.text = Model.datakiosco.getSedeNombre() + '\n' + Model.datakiosco.piso  + '\n' + Model.datakiosco.id_kiosco;
			
			content._btnVerInfoKiosco.addEventListener(MouseEvent.MOUSE_DOWN,onVerInfo);
			TextField(content._btnVerUpdate._txt).text = "Ver novedades de versión " + Model.datakiosco.version;
			TextField(content._btnVerUpdate._txt).y -=20;
		
	
			super.show();
		}
		
				
			
		protected function onVerInfo(event:MouseEvent):void
		{
			TweenMax.to(content._datosinfokiosco,0.5,{yoyo:true,repeat:1,autoAlpha:1,repeatDelay:8});
			
		}
		
		private function onVerInfoUpdate():void
		{
			this.dispatchEvent(new Event("verVersionUpdates"));			
		}
		
		private function onVerStatics():void
		{
			this.dispatchEvent(new Event("verStatics"));			
		}
		
		private function onVolver():void
		{
			this.dispatchEvent(new Event("backBtn"));			
		}
		
		protected function onUpdate(event:Event):void
		{
			if(teclado.focus.length >=7){
				content._error.visible = false;				
			}
		}
		
		protected function onEnter(event:Event):void
		{			
			if(valid()){
				content._error.visible = false;
				teclado.lock();
				teclado.loseStageFocus();
				pageChanged();
			}
			else{
				content._error.visible = true;
			}
		}
		
		private function valid():Boolean
		{
			return content._dni._input.length >=7;
		}
		
		public function get login():String{
			return content._dni._input.text;
		}
		
		public function showError():void
		{
			addChild(new ErrorMsg("dnisocio",relogin));
		}
		
		private function relogin():void
		{
			teclado.unlock();
			//content._dni._input.text = "";
			teclado.focus = content._dni._input;
		}
		
		public function showNoPlanDeEntrenamiento():void
		{
			addChild(new ErrorMsg("noplandeentrenamiento",onNoPlan));			
		}
		
		private function onNoPlan():void
		{
			teclado.unlock();			
		}
	}
}