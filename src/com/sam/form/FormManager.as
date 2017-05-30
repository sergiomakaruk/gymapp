package com.sam.form
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import sm.fmwk.ui.button.Button;
	import sm.utils.display.GetButton;
	import sm.utils.keyboard.Lister_ENTER_KEY;

	public class FormManager extends Sprite
	{
		private var _onValidationTrue:Function;
		private var formValidator:FormValidator;
		private var sendButton:Button;
		private var fields:Vector.<Object>;
		
		public function get inputs():Vector.<IInputForm>{return formValidator.inputs}
		
		public function FormManager(onValidationTrue:Function)
		{
			fields = new Vector.<Object>();
			_onValidationTrue = onValidationTrue;
			formValidator = new FormValidator();
		}
		public function getItem(id:String):IInputForm
		{
			for each(var itemObj:Object in  fields)
			{
				if(itemObj["id"]== id)
				{
					return itemObj["item"] as IInputForm;
				}
			}
			return null;
		}
		public function addItem(item:IInputForm,id:String=""):void
		{
			if(fields.length)
			{
				//trace(id,IInputForm(fields[fields.length-1]["item"]).getTabIndex());
				item.setTabIndex(IInputForm(fields[fields.length-1]["item"]).getTabIndex());
			}
			else item.setTabIndex(0);
			
			formValidator.inputs.push(item);			
			if(id!="")fields.push({item:item,id:id});			
		}
		public function addButton(face:DisplayObject,type:Class=null):void
		{
			sendButton = GetButton.clickButton(face,onSend,type);		
			//sendButton.addEventListener(ButtonEvent.onCLICK,onSend);
			new Lister_ENTER_KEY(sendButton,true);
		}
		protected function onSend(event:Event=null):void
		{						
			if(formValidator.checkFields())
			{
				_onValidationTrue();					
			}
			else
			{
				sendButton.unlock();
			}			
		}
		public function addToVariables(vars:Object):void
		{
			for each(var obj:Object in this.fields)
			{	
				if(obj.id == "cobertura")
				{
					/*socio_medicus:<string(1)|(S/N)>,
					socio_otro:<string(100)|(Osde|Omint|Swiss Medical|Galeno|Otro)>,*/								
									
					var isMedicus:Array = IInputForm(obj.item).campo;					
					vars.socio_medicus = (isMedicus[0] == "Medicus") ? "1" : "0";	
					vars.socio_otro = (isMedicus[0] != "Medicus") ? isMedicus[0] :"";
				}
				else if(obj.id == "fecha")
				{
					var date:Array = IInputForm(obj.item).campo;
					vars.dia = date[0];
					vars.mes = date[1];
					vars.anio = date[2];
				}
				else if(obj.id == "sexo")
				{
					vars[obj.id] = String(IInputForm(obj.item).campo[0]).toLowerCase();
				}
				else if(obj.id == "cel_compania")
				{
					vars.cel_area = IInputForm(obj.item).campo[0];
					vars.cel_numero = IInputForm(obj.item).campo[1];
				}
				else vars[obj.id] = IInputForm(obj.item).campo[0];
			}
		}
		public function destroy():void
		{	
			sendButton.destroy();
			sendButton = null;
			_onValidationTrue = null;
			
			for each( var input:IInputForm in this.inputs)input.destroy();
			
			formValidator.destroy();
			formValidator = null;
		}
		
		public function validate():void
		{
			onSend();			
		}
		public function unlock():void
		{
			sendButton.active = true;
		}
	}
}