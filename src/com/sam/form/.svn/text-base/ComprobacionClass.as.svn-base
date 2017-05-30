package com.sam.form
{
	import flash.text.*;
	
	
	public class ComprobacionClass
	{	
		
		private var type:String;
		private var target:TextField;	
		private var comprobacion:Function;
		
		public function ComprobacionClass(target:TextField,
										  type:String)
		{
			this.target = target;			
			this.type = type;
			
			restrictTarget();
		}		
		
		private function restrictTarget():void
		{
			switch (type)
			{
				case TextForm.DNI:
				dni();
				comprobacion = ComprobacionDNI;
				break;
				
				case TextForm.NUMBER:
				numero();
				comprobacion = ComprobacionNumero;
				break; 
				
				case TextForm.EMAIL:
				mail();
				comprobacion = ComprobacionMail;
				break;
				
				case TextForm.DATE:
				fecha();
				comprobacion = ComprobacionFecha;
				break;
				
				case TextForm.DATO:
				dato();
				comprobacion = ComprobacionDato;
				break;
				
				case TextForm.MULTILINE:
				multiline();
				comprobacion = ComprobacionMultiline;
				break;
				
				case TextForm.MULTIPLE:
				multiple();
				comprobacion = ComprobacionMultiple;
				break;
			}
		}	
		
		public function checkField():Boolean
		{
			return comprobacion();
		}
		
		private function ComprobacionFecha():Boolean
		{
			var flag:Boolean;
			
			return flag;
		}
		
		private function ComprobacionMail():Boolean
		{
			var email:String = target.text;
			var pattern:RegExp = /^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
			return email.match(pattern) != null;
		}
		
		private function ComprobacionNumero():Boolean
		{			
			return true;
		}
		
		private function ComprobacionDNI():Boolean
		{			
			if(target.text.length >= 7)
			{
				return true
			}			
			return false;
		}
		
		private function ComprobacionDato():Boolean
		{
			var flag:Boolean = true;			
			return flag;
		}
		
		private function ComprobacionMultiline():Boolean
		{
			var flag:Boolean = true;			
			return flag;
		}
		
		private function ComprobacionMultiple():Boolean
		{
			var flag:Boolean = true;			
			return flag;
		}
		
		private function dni():void
		{
			target.restrict = "0-9";
			target.maxChars = 8;
		}	
		
		private function numero():void
		{
			target.restrict = "0-9 \\- \\.";
		//	String
		}	
		
		private function dato():void
		{
			target.restrict = "A-Z a-z Ññ ÁáÉéÍíÓóÚú";
			target.maxChars = 40;
		}
		
		private function multiple():void
		{
			target.restrict = "A-Z a-z 0-9";
			//target.maxChars = 40;
		}
		
		private function multiline():void
		{
			//Vacio
		}
		
		private function mail():void
		{
			//target.restrict = "A-Z a-z 0-9";
			target.maxChars = 40;
		}	
		
		private function fecha():void
		{
			//Hay que hacerla
		}			
	}
}