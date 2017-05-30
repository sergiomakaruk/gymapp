package com.sam.form
{
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;
	
	public class TextForm extends Sprite implements IInputForm
	{
		private const FLAG:Boolean = true;
		
		public static const DNI:String = "dni";
		public static const EMAIL:String = "email";
		public static const DATO:String = "dato";
		public static const NUMBER:String = "number";
		public static const DATE:String = "date";		
		public static const MULTILINE:String = "multiline";		
		public static const MULTIPLE:String = "multiple";	
		
		private const SIZE:uint = 57;
		private const COLOR:uint = 0xFFFFFF;
		private var ANCHO:uint = 260;		
		private const ALTO:uint = 18;
		private const ERRORCOLOR:uint  = 0xFF0000F;
		
		private var color:uint;
		private var formatsize:Number;
		private var multiline:uint;
		
		protected var target:TextField;
		private var formato:TextFormat;
		private var defaultMsg:String;
		private var errorMsg:String;
		private var type:String;
		private var _label:String;
		private var currentInput:String = "";
		private var comprobacionClass:ComprobacionClass;
		
		private var indicador:FormErrorClip;
		private var clip:DisplayObjectContainer;
		protected var hasToValidate:Boolean;
		
		public function get campo():Array
		{
			return [currentInput];
		}
		
		public function set campoMsg(s:String):void
		{
			var mensaje:String = s;
			if(mensaje !== "")
			{
				mensaje = errorMsg;
			}
			
			formato.color = ERRORCOLOR;			
			target.defaultTextFormat = formato;				
			target.text = mensaje;
			//currentInput = "";
		}
		
		public function get label():String
		{
			return _label;
		}
		
		public function get isReady():Boolean
		{
			return comprobacion();
		}
		
		public function setTabIndex(n:uint):void
		{
			this.target.tabEnabled = true;
			this.target.tabIndex = n;
		}	
		public function getTabIndex():uint
		{
			return this.target.tabIndex + 1;
		}
		
		public function TextForm(textContainer:MovieClip,								
								 messageType:String,
								 validationType:String,																
								 hasToValidate:Boolean = true)
		{				
			this.hasToValidate = hasToValidate;	
			this.target = textContainer.input;
			this.target.x = 6;
			//this.target.y-= 3;
			this.clip = textContainer;
			this._label = textContainer.name;			
			
			indicador = new FormErrorClip(textContainer.getChildByName("errorClip"));			
			
			var messages:MessageTextForm = new MessageTextForm();
			
			if(!MessageTextForm.isTest) this.defaultMsg = messages.getMessajes(messageType)[0];
			else this.defaultMsg = "";
			this.errorMsg = messages.getMessajes(messageType)[1];
			this.type = validationType;		
			
			//////
			//OJO COMENTEAR LA LINEA PARA QUE TOME LOS MENSAJES POR DEFAULT			
			//////
			this.defaultMsg = "";
			
			target.text = (!MessageTextForm.isTest) ? defaultMsg : messages.getMessajes(messageType)[0];			
			currentInput = target.text;
					
			ANCHO = target.width;			
		
			this.formato = target.getTextFormat();
			this.color = uint(0x2982BC);	
			
			this.clip.addChild(target);
								
			listeners();
			
			comprobacionClass = new ComprobacionClass(target,
													  type);				
		}
		public function addDefaultValue(str:String):void
		{
			this.currentInput = str;
			target.text = currentInput;
		}
	
		
		public function putIndicador():void
		{			
			indicador.show();
		}
		
		public function quitIndicador():void
		{
			indicador.hide();			
		}

		private function listeners():void
		{			
			target.addEventListener(FocusEvent.FOCUS_IN,onFocus);
			target.addEventListener(FocusEvent.FOCUS_OUT,outFocus);		
			
			target.addEventListener(Event.CHANGE,onChange);
			target.addEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		
		private function onChange(e:Event):void
		{
			//trace("CHANGE");			
			e.preventDefault();
			e.stopImmediatePropagation();
		}
		
		private function onFocus(e:FocusEvent):void
		{				
			formato.color = color;
			target.defaultTextFormat = formato;				
			
			//target.text = currentInput;			
			
			if(currentInput!=="" && currentInput!==defaultMsg)
			{				
				target.text = currentInput;
			}
			else
			{
				target.text = "";			
			}
					
		}
		
		private function outFocus(e:FocusEvent):void
		{	
			//if(target.text!== ""  && target.text!==errorMsg)
			if(target.text!==errorMsg)
			{
				currentInput = target.text;
			}		
			
			if(hasToValidate)
			{
				comprobacion();	
			}
		}		
		
		private function comprobacion():Boolean
		{
			if(hasToValidate)
			{
				var flag:Boolean;					
				
				if(target.text !== errorMsg && target.text !== "" && target.text!= this.defaultMsg)
				{
					flag  = comprobacionClass.checkField();
				}
				
				if(!flag)
				{
					putIndicador();
					formato.color = ERRORCOLOR;			
					target.defaultTextFormat = formato;
					target.text = errorMsg;	
				}
				else
				{
					quitIndicador();
				}			
				
				return flag;
			}
			else return true;		
		}
		
		private function onRemoved(e:Event):void
		{
			target.removeEventListener(FocusEvent.FOCUS_IN,onFocus);
			target.removeEventListener(FocusEvent.FOCUS_OUT,outFocus);
			target.removeEventListener(Event.CHANGE,onChange);
			target.removeEventListener(Event.REMOVED_FROM_STAGE,onRemoved);
		}
		
		public function destroy():void{};
	}
}