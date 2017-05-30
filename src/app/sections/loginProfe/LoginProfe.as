package app.sections.loginProfe
{
	import app.components.button.AppButton;
	import app.sections.AppSection;
	import app.sections.componentes.TecladoNumerico;
	import app.sections.componentes.errormsg.ErrorMsg;
	
	import com.greensock.TweenMax;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.KeyboardEvent;
	import flash.geom.Rectangle;
	import flash.text.ReturnKeyLabel;
	import flash.text.StageText;
	import flash.text.TextField;
	import flash.ui.Keyboard;
	
	import sm.fmwk.Fmwk;
	import sm.fmwk.data.core.DataResize;
	import sm.fmwk.ui.button.Button;
	import sm.utils.display.GetButton;
	import sm.utils.display.GetDrawedObjects;
	import sm.utils.events.CustomEvent;


	public class LoginProfe extends AppSection
	{

		private var content:_loginProfeSP;

		private var teclado:TecladoNumerico;
		
		private var btn:Button;

		
		public function LoginProfe(name:String, tracker:Boolean)
		{
			super(name, tracker);			
		}
		
		override public function show(event:Event=null):void
		{				
			content = new _loginProfeSP();
			addChild(content);
			
			content._loginProfesor._clave._input.text = "";
			content._loginProfesor._clave._input.maxChars = 3;
			TextField(content._loginProfesor._contrasena._input).displayAsPassword = true;					
			
			
			content._loginProfesor._contrasena._input.y+=25;
			content._loginProfesor._contrasena._input.text = "";
			content._loginProfesor._contrasena._input.maxChars = 6;
			
			teclado = new TecladoNumerico();
			teclado.x = stage.stageWidth - teclado.width;
			//teclado.addEventListener(TecladoNumerico.KEY_NUMBER_EVENT,onUpdate);
			teclado.addEventListener(Event.COMPLETE,onKeyBoarComplete);
			addChild(teclado);
									
			teclado.focus = content._loginProfesor._clave._input;
			
			content._loginProfesor._clave._input.addEventListener(FocusEvent.FOCUS_IN,onFocusin);
			content._loginProfesor._contrasena._input.addEventListener(FocusEvent.FOCUS_IN,onFocusin);	
			
			changeAction(content._loginProfesor._perfilUsuario,AppButton);
					
			super.show();						
		}		
		
		protected function onKeyBoarComplete(event:Event):void
		{
			if(teclado.focus == content._loginProfesor._clave._input)teclado.focus = content._loginProfesor._contrasena._input;
			else if(teclado.focus == content._loginProfesor._contrasena._input){
				teclado.lock();
				teclado.loseStageFocus();
				pageCompleted();
			}
		}
		
		private function onFocusin(e:FocusEvent):void
		{
			if(teclado.focus != TextField(e.target))teclado.focus = TextField(e.target);		
		}
		
			
		public function get login():Array{
			return [content._loginProfesor._clave._input.text,content._loginProfesor._contrasena._input.text];
		}
		
		
		
		 override public function resize(data:DataResize):void
		{
			// if(circle)			circle.y = stage.stageHeight - 10 - circle.height;
		}
		
		 public function showError():void
		 {
			 addChild(new ErrorMsg("dnisocio",relogin));
		 }
		 
		 private function relogin():void
		 {
			 teclado.unlock();
			 content._loginProfesor._contrasena._input.text = "";
			 teclado.focus = content._loginProfesor._contrasena._input;
		 }
	}
}