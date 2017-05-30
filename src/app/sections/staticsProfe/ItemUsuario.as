package app.sections.staticsProfe
{
	import alducente.services.WebService;
	
	import app.data.usuarios.DataUsuario;
	import app.datatransferences.DataTransferenceTypes;
	import app.model.Model;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import nid.ui.controls.VirtualKeyBoardMail;
	import nid.ui.controls.vkb.KeyBoardEvent;
	import nid.ui.controls.vkb.KeyBoardTypes;
	
	import sm.fmwk.Fmwk;
	import sm.fmwk.data.core.AssetManager;
	import sm.utils.date.DateUtils;
	import sm.utils.display.GetImage;
	import sm.utils.events.CustomEvent;
	import sm.utils.loader.AssetLoader;
	
	public class ItemUsuario extends Sprite
	{
		
		public static const MANDAR_MAIL_USUARIO_AUSENCIA:String = 'MandarMailUsuarioAusencia';
		public static const MANDAR_MAIL_USUARIO_RENOVACION:String = 'MandarMailUsuarioRenovacion';
		//public static const RENOVAR_RUTINA_DESDE_ESTADISTICAS:String = 'RenovarRutinaDesdeEstadisticass';
		public static const SHOW_USER:String = 'showUser';
		
		public static var LOAD:Boolean = false;

		private var content:_itemUsuariosSP;
		private var data:DataUsuario;

		private static var ws:WebService;

		private var ejRenovar:TextField;
		
		public function ItemUsuario(data:DataUsuario)
		{
			super();
			this.data = data;
			trace(data);
			
			content = new _itemUsuariosSP();
			addChild(content);
			
			content._nombre.text = data.nombre;
			content._apellido.text = data.apellido;
			if(data.fecha_molinete)content._ingreso.text =DateUtils.format(data.fecha_molinete);
			if(data.fecha_rutina)content._vencimiento.text = DateUtils.format(data.fecha_rutina);
			if(data.sede)content._sede.text = data.sede;
			
			content._btnEnviarEmail.visible = false;
			content._BtnRenovar.visible = false;
			content._BtnSinRutina.visible = false;
			
			if(data.estado == 0)addBtnMail();
			if(data.rutinaVencida) addBtnRenovar();
			
			if(data.nuevoSinRutina){
				content._BtnSinRutina.visible = true;
				content._BtnSinRutina.addEventListener(MouseEvent.MOUSE_DOWN,onRenovarRutina); // hace la misma accion que renovar
			}
			
			this.addEventListener(Event.ADDED_TO_STAGE,onAdded);			
			
		}
		
		protected function onAdded(event:Event):void
		{				
			data.cb = onPhotoLoaded;
			Model.wsassets.add(data);
			content.addChild(data.foto);
			data.foto.x = data.foto.y = 5;
			data.foto.addEventListener(MouseEvent.MOUSE_DOWN,onScale);			
			
			//data.foto.addEventListener('phresize',onPhotoLoaded);
		}
		
		protected function onScale(event:MouseEvent):void
		{
			this.dispatchEvent(new CustomEvent(SHOW_USER,data));			
		}
		
		protected function onPhotoLoaded():void
		{
			//GetImage.centerAndScale(data.foto,50,50);
			GetImage.scale(data.foto,50,50);
			//data.foto.scaleX = 0.5;
			//data.foto.scaleY = 0.5;
			
		}		
		
		private function addBtnRenovar():void
		{
			content._BtnRenovar.visible = true;
			content._BtnRenovar.addEventListener(MouseEvent.MOUSE_DOWN,onRenovarRutina);
		}
		private function addBtnMail():void
		{
			content._btnEnviarEmail.visible = true;
			content._btnEnviarEmail.addEventListener(MouseEvent.MOUSE_DOWN,onMandalAusencia);
		}
		protected function onMandalAusencia(event:MouseEvent):void
		{
			teclado(onMandalEmail,getTxtAusencia);
		}
		
		protected function onRenovarRutina(event:MouseEvent):void
		{
			teclado(onSendRenovar,getTxtRenovar);
		}
		
		private function teclado(cb:Function,tex:Function):void{
			VirtualKeyBoardMail.getInstance().init(this);		
			VirtualKeyBoardMail.getInstance().addEventListener(KeyBoardEvent.SAVE,cb);
			VirtualKeyBoardMail.getInstance().keyboard.inputArea.height = 635;
			VirtualKeyBoardMail.getInstance().keyboard.inputArea.width = stage.stageWidth;
			//VirtualKeyBoardMail.getInstance().addEventListener(KeyBoardEvent.SAVE,onEmailSave);
			ejRenovar = new TextField();
			ejRenovar.wordWrap = true;
			ejRenovar.condenseWhite = true;
			ejRenovar.text = tex();
			VirtualKeyBoardMail.getInstance().target = { field:ejRenovar, fieldName:"Enviar email a usuario",keyboardType:KeyBoardTypes.ALPHABETS_UPPER };
		}
		private function format():void{
			data.txtRenovar = clearDelimeters(ejRenovar.text);
			data.txtRenovar = data.txtRenovar.replace('www.americansport.com.ar','<a href="http://www.americansport.com.ar">www.americansport.com.ar</a>');
			data.txtRenovar = data.txtRenovar.replace('Saludos!','<br>Saludos!');				
			VirtualKeyBoardMail.getInstance().hide();
		}
		
		private function onSendRenovar(e:Event):void{			
			format();
			this.dispatchEvent(new CustomEvent(MANDAR_MAIL_USUARIO_RENOVACION,data));	
		}
		protected function onMandalEmail(event:Event):void
		{
			format();
			this.dispatchEvent(new CustomEvent(MANDAR_MAIL_USUARIO_AUSENCIA,data));			
		}
		
		public function clearDelimeters(formattedString:String):String {     
			return formattedString.replace(/[\u000d\u000a\u0008]+/g,"<br>"); 
		}
		
		
		private function getTxtRenovar():String{
			/*Expiró tu plan de entrenamiento! Vení a renovarlo.
				Hola "Nombre de socio", ¿Cómo estás?
					Te envío este mail para avisarte que tu programación de entrenamiento para 30 días finalizó el “fecha de vencimiento de la última rutina”. Me gustaría que te acerques al club y me indiques como te sentiste con la misma para generar un nuevo plan, o cambiar y mejorar algunos aspectos del anterior teniendo en cuenta tus opiniones. Te espero en el área de tonificación muscular en estos días.
						
						Saludos!
						"Nombre del profesor que envia el mail"
			www.americansport.com.ar
			Por una vida mejor*/
			
			var str:String = "";
			str+= "Hola "+data.nombre+", ¿Cómo estás?";
			str+= "\n";
			str+= "Te envío este mail para avisarte que tu programación de entrenamiento para 30 días finalizó el "+DateUtils.format(data.fecha_rutina)+". Me gustaría que te acerques al club y me indiques como te sentiste con la misma para generar un nuevo plan, o cambiar y mejorar algunos aspectos del anterior teniendo en cuenta tus opiniones. Te espero en el área de tonificación muscular en estos días.";
			str+= "\n\n";	
			str+= "Saludos!";
			str+= "\n";
			str+= Model.profe.nombre;
			str+= "\n";
			str+= "www.americansport.com.ar";
			str+= "\n";
			str+= "Por una vida mejor";
			
			return str;
		}
		
		private function getTxtAusencia():String{
	
			var str:String = "";
			str+= "Hola "+data.nombre+", ¿Cómo estás?";
			str+= "\n";
			str+= "Hemos notado que te ausentaste al club en estos últimos días. Recordá que es fundamental ser consistente en el entrenamiento para poder lograr tus objetivos! Me gustaría que te acerques al club y me indiques si fue por algún motivo relacionado a tu programación de entrenamiento, si es así podemos hablar sobre cuál fue el problema y generar un nuevo plan que se adapte de mejor manera tus objetivos y por lo tanto que te motive más y que sea más efectivo! Te espero en el área de tonificación muscular en estos días.";
			str+= "\n\n";	
			str+= "Saludos!";
			str+= "\n";
			str+= Model.profe.nombre;
			str+= "\n";
			str+= "www.americansport.com.ar";
			str+= "\n";
			str+= "Por una vida mejor";
			
			return str;
		}
		
		
		
		
		
		
	}
}