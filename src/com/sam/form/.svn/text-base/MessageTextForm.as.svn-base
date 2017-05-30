package com.sam.form
{
	public class MessageTextForm
	{
		public static const ERRORCOLOR:uint = 0xFF0000;
		
		public static const NAME:String = "nombre";
		private const NAME_DEFAULT:String = "Ingrese su nombre";
		private const NAME_MSJ:String = "Debe ingresar su nombre";
		private const NAME_TEST:String = "UnNombre";
		
		public static const APELLIDO:String = "apellido";
		private const APELLIDO_DEFAULT:String = "Ingrese su apellido";
		private const APELLIDO_MSJ:String = "Debe ingresar su apellido";
		private const APELLIDO_TEST:String = "unApellido";
		
		public static const MENSAJE:String = "mensaje";
		private const MENSAJE_DEFAULT:String = "";
		private const MENSAJE_MSJ:String = "";
		private const MENSAJE_TEST:String = "Un mensaje";
		
		public static const DNI:String = "dni";
		private const DNI_DEFAULT:String = "Ingrese su dni";
		private const DNI_MSJ:String = "Debe ingresar su dni";
		private const DNI_TEST:String = "11111111";
		
		public static const EMAIL:String = "email";
		private const EMAIL_DEFAULT:String = "Ingrese su email";
		private const EMAIL_MSJ:String = "Email inválido";
		private const EMAIL_TEST:String = "cosmefulanito@test.com";
		
		public static const TEL:String = "telefono";
		private const TEL_DEFAULT:String = "Ingrese su telefono";
		private const TEL_MSJ:String = "Debe ingresar su telefono";
		private const TEL_TEST:String = "15-3030-5050";
		
		public static const DIRECCION:String = "direccion";
		private const DIRECCION_DEFAULT:String = "Ingrese su dirección";
		private const DIRECCION_MSJ:String = "Debe ingresar su dirección";
		private const DIRECCION_TEST:String = "direccion 066";
		
		public static const PROVINCIA:String = "provincia";
		private const PROVINCIA_DEFAULT:String = "Ingrese su provincia";
		private const PROVINCIA_MSJ:String = "Debe ingresar su provincia";
		private const PROVINCIA_TEST:String = "Venado tuerto";
		
		public static const COMPANIA:String = "compania";
		private const COMPANIA_DEFAULT:String = "Ingrese su compania de celular";
		private const COMPANIA_MSJ:String = "Debe ingresar su compania de celular";
		private const COMPANIA_TEST:String = "Personal";
		
		public static const DIA:String = "dia";
		private const DIA_DEFAULT:String = "Ingrese día";
		private const DIA_MSJ:String = "Debe ingresar un día";
		private const DIA_TEST:String = "07";
		
		public static var isTest:Boolean;
			
		public function MessageTextForm()
		{
			
		}
		public function getMessajes(type:String):Vector.<String> 
		{
			var vector:Vector.<String> = new Vector.<String>();
			switch(type)
			{
				case NAME:
					vector.push(NAME_DEFAULT);
					vector.push(NAME_MSJ);
					if(isTest) vector[0] = NAME_TEST;
					break;
				case APELLIDO:
					vector.push(APELLIDO_DEFAULT);
					vector.push(APELLIDO_MSJ);
					if(isTest) vector[0] = APELLIDO_TEST;
					break;
				case MENSAJE:
					vector.push(MENSAJE_DEFAULT);
					vector.push(MENSAJE_MSJ);
					if(isTest) vector[0] = MENSAJE_TEST;
					break;
				case DNI:
					vector.push(DNI_DEFAULT);
					vector.push(DNI_MSJ);
					if(isTest) vector[0] = DNI_TEST;
					break;
				case EMAIL:
					vector.push(EMAIL_DEFAULT);
					vector.push(EMAIL_MSJ);
					if(isTest) vector[0] = EMAIL_TEST;
					break;
				case TEL:
					vector.push(TEL_DEFAULT);
					vector.push(TEL_MSJ);
					if(isTest) vector[0] = TEL_TEST;
					break;
				case DIRECCION:
					vector.push(DIRECCION_DEFAULT);
					vector.push(DIRECCION_MSJ);
					if(isTest) vector[0] = DIRECCION_TEST;
					break;
				case PROVINCIA:
					vector.push(PROVINCIA_DEFAULT);
					vector.push(PROVINCIA_MSJ);
					if(isTest) vector[0] = PROVINCIA_TEST;
					break;				
				case COMPANIA:
					vector.push(COMPANIA_DEFAULT);
					vector.push(COMPANIA_MSJ);
					if(isTest) vector[0] = COMPANIA_TEST;
					break;
				case DIA:
					vector.push(DIA_DEFAULT);
					vector.push(DIA_MSJ);
					if(isTest) vector[0] = DIA_TEST;
					break;
				default:
					vector.push("");vector.push("");
			}
			return vector;
		}
	
	}
}