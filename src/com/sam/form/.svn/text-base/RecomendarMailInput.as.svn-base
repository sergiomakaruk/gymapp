package  com.sam.form
{
	import flash.display.Sprite;
	
	
	public class RecomendarMailInput extends Sprite implements IInputForm
	{
		private var fields:Array;
		private var nameInput:TextForm;
		private var mailInput:TextForm;

		public function RecomendarMailInput() 
		{
			init();
		}
		
		private function init():void
		{
			fields = [];			
			
			var n1:uint;
			var n2:uint;
			
			switch (this.name)
			{
				case "campo1":
				n1 = 2;
				n2 = 3;
				break;
				
				case "campo2":
				n1 = 4;
				n2 = 5;
				break;
				
				case "campo3":
				n1 = 6;
				n2 = 7;
				break;
			}
			
			nameInput = new TextForm(nombre,								   
												   "",
												   "Debe ingresar su nombre",
												   TextForm.DATO,
												   n1,
												   0,
												   false);				
			
			mailInput = new TextForm(mail,									   
												   "",
												   "Email inválido",
												   TextForm.MAIL,
												   n2,
												   0,
												   false);								
	
			fields.push(nameInput);					
			fields.push(mailInput);			
		}
		
		public function get campo():Array
		{
			return [fields[0].campo,fields[1].campo];
		}
		
		public function set campoMsg(str:String):void
		{
			nameInput.campoMsg = str;
			mailInput.campoMsg = str;
			nameInput.putIndicador();
			mailInput.putIndicador();
		}
		
		public function get isReady():Boolean
		{		
			if(mailInput.isReady)
			{
				trace("MAIL",mailInput.isReady);
				return nameInput.isReady;
			}			
			
			if(String(mailInput.campo[0]) !==  "" && String(nameInput.campo[0]) ==  "")
			{	
				nameInput.quitIndicador();
				return false;	
			}			
						
			if(String(nameInput.campo[0]) ==  "")
			{
				nameInput.quitIndicador();
				mailInput.quitIndicador();
				mailInput.campoMsg = "";
				trace("TRUE");
				return true;
			}			
		
			return false;	
		}
		
		public function putIndicador():void
		{
			
		}
		
		public function quitIndicador():void
		{
			
		}

	}
	
}
