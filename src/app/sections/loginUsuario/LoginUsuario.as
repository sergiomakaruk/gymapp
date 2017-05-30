package app.sections.loginUsuario
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
	import flash.events.MouseEvent;
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


	public class LoginUsuario extends AppSection
	{
		private var content:_loginUsuarioSP;

		private var teclado:TecladoNumerico;

		private var btn:Button;
	
		
		public function LoginUsuario(name:String, tracker:Boolean)
		{
			super(name, tracker);
			
		}
		
		override public function show(event:Event=null):void
		{				
			content = new _loginUsuarioSP();
			addChild(content);			
						
			teclado = new TecladoNumerico();
			teclado.x = stage.stageWidth - teclado.width;
			teclado.addEventListener(TecladoNumerico.KEY_NUMBER_EVENT,onUpdate);
			teclado.addEventListener(TecladoNumerico.KEY_ENTER,onEnter);
			//teclado.addEventListener(Event.COMPLETE,onEnter);
			addChild(teclado);
			teclado.x = stage.stageWidth;
			
			content._usuarioLogin._dni._input.text = "";
			TextField(content._usuarioLogin._dni._input).maxChars = 30;
			//teclado.focus = content._usuarioLogin._dni._input;
			content._usuarioLogin._dni._input.addEventListener(FocusEvent.FOCUS_IN,onInitLogin);
			
			//content._dni._input.addEventListener(Event.CHANGE,onUpdate);
			
			content._usuarioLogin._error.visible = false;
			
			changeAction(content._usuarioLogin._perfilProfesor,AppButton);
			btn = GetButton.pressButton(content._usuarioLogin._volverBtn,onVolver,AppButton);
			btn.visible = false;
			btn.alpha = 0;	
			btn.delayTime = 1000;
			super.show();		
			
			//throw new Error("HACER QUE EVENT CHANGE ESTE DENTRO DE TECLADO");
		}
		
		private function onVolver():void
		{
			TweenMax.to(teclado,0.5,{x:stage.stageWidth});
			TweenMax.to(content._usuarioLogin,0.5,{x:427});
			TweenMax.to(btn,0.5,{autoAlpha:0,x:'-350'});
			content._usuarioLogin._dni._input.addEventListener(FocusEvent.FOCUS_IN,onInitLogin);
			
			//btn.active = true;
			//btn.unlock();
		}
		
		private function onInitLogin(e:FocusEvent):void
		{
			content._usuarioLogin._dni._input.removeEventListener(FocusEvent.FOCUS_IN,onInitLogin);
			teclado.focus = content._usuarioLogin._dni._input;
			TweenMax.to(teclado,0.5,{x:stage.stageWidth - teclado.width});
			TweenMax.to(content._usuarioLogin,0.5,{x:75});
			TweenMax.to(btn,0.5,{autoAlpha:1,x:'350'});
		}
		
		protected function onUpdate(event:Event):void
		{
			//trace(content._dni._input.length)
			/*if(content._dni._input.length <8) focus.appendText(event.params.toString());*/
			if(teclado.focus.length >=7){
				content._usuarioLogin._error.visible = false;
				//teclado.loseStageFocus();
			}
		}
		
		protected function onEnter(event:Event):void
		{		
			trace(event);
			if(valid()){
				content._usuarioLogin._error.visible = false;
				teclado.lock();
				teclado.loseStageFocus();
				pageCompleted();
			}
			else{
				content._usuarioLogin._error.visible = true;
			}
		}
		
		private function valid():Boolean
		{
			return content._usuarioLogin._dni._input.length >=7;
		}
		
		public function get login():String{
			return content._usuarioLogin._dni._input.text;
		}
		
		
		
		 override public function resize(data:DataResize):void
		{
			// if(circle)			circle.y = stage.stageHeight - 10 - circle.height;
		}
		
		 public function showError():void
		 {
			 addChild(new ErrorMsg("dnisocio",relogin));
		 }
		 
		 public function relogin():void
		 {
			 teclado.unlock();
			 content._usuarioLogin._dni._input.text = "";
			 teclado.focus = content._usuarioLogin._dni._input;
		 }
	}
}