﻿package com.formulario
{
	import app.components.button.AppButton;
	import app.sections.formulario.Combomedicus;
	import app.sections.formulario.OtrosText;
	
	import com.greensock.TweenMax;
	import com.sam.form.CheckBox;
	import com.sam.form.FechaInput;
	import com.sam.form.FormManager;
	import com.sam.form.IInputForm;
	import com.sam.form.InputTelefonoMultiText;
	import com.sam.form.MessageTextForm;
	import com.sam.form.TextForm;
	import com.sam.form.combos.Combo;
	import com.sam.form.combos.ComboFecha;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import sm.fmwk.ui.button.Button;
	import sm.fmwk.ui.button.events.ButtonEvent;
	import sm.utils.display.GetButton;
	import sm.utils.events.CustomEvent;
	
	public class Formclip extends Sprite
	{
		private var manager:FormManager;
		
		private var _face:MovieClip;
		public function set face(value:MovieClip):void{	_face = value;}
		
		private function child(childName:String):MovieClip
		{
			return _face.getChildByName(childName) as MovieClip;
		}
		
		
		public function Formclip()
		{			
			//addBases();			
			//MessageTextForm.isTest = true;
		}		
		public function getFormInput(id:String):IInputForm
		{
			return manager.getItem(id);
		}
		public function setError(msg:String):void
		{
			_face.status_txt.text = msg;
			manager.unlock();
		}
		public function init():void
		{	
			_face.status_txt.text = "";
			trace("Init Formclip");
			manager = new FormManager(onValidationTrue);
			
			var siValida:Boolean = true;
			var inputQueNoValida:Boolean = false;
			var combo:Combo;	
			
		/*	nombre_completo:<string>,
			dni:<string>,
			cel_area:<string>,
			cel_numero:<string>,
			cel_compania:<string>,
			email:<string>*/
			
			////INPUTS
			if(child("inputNombre"))
			{
				var nombre:TextForm = new TextForm(child("inputNombre"),MessageTextForm.NAME,TextForm.DATO,siValida);				
				manager.addItem(nombre,"nombre");
			}			
			
			if(child("inputApellido"))
			{
				var apellido:TextForm = new TextForm(child("inputApellido"),MessageTextForm.APELLIDO,TextForm.DATO,siValida);
				manager.addItem(apellido,"apellido");
			}
			
			if(child("inputFecha"))
			{
				var fecha:FechaInput = new FechaInput(child("inputFecha"),siValida);
				manager.addItem(fecha,"fecha");
			}
			
			if(child("inputEmail"))
			{
				var email:TextForm = new TextForm(child("inputEmail"),MessageTextForm.EMAIL,TextForm.EMAIL,siValida);
				manager.addItem(email,"email");
			}
			
			if(child("inputTel"))
			{
				var telefono:TextForm = new TextForm(child("inputTel"),MessageTextForm.TEL,TextForm.NUMBER,siValida);
				manager.addItem(telefono,"tel_num");
			}
			
			if(child("inputDni"))
			{
				var dni:TextForm = new TextForm(child("inputDni"),MessageTextForm.DNI,TextForm.DNI,siValida);
				manager.addItem(dni,"dni");
			}
			
			var socio_otro_texto:OtrosText;
			if(child("otras"))
			{
				socio_otro_texto = new OtrosText(child("otras").getChildByName("inputOtras") as MovieClip,MessageTextForm.MENSAJE,TextForm.DATO,false);
				manager.addItem(socio_otro_texto,"socio_otro_texto");
			}
			
			
			if(child("coberturaCombos"))
			{
				combo = new Combomedicus("",child("coberturaCombos"),"combos/cobertura.txt",socio_otro_texto);
				manager.addItem(combo,"cobertura");						
			}
			
			
			
			if(child("inputCelularMulti"))
			{
				var celularMulti:IInputForm = new InputTelefonoMultiText(child("inputCelularMulti"),true);
				manager.addItem(celularMulti,"cel_compania");
			}
			
			if(child("inputCompania"))
			{
				var compania:TextForm = new TextForm(child("inputCompania"),MessageTextForm.COMPANIA,TextForm.DATO,siValida);
				manager.addItem(compania,"compania");
			}
			
				
			
			////COMBOS
			if(child("sexoCombo"))
			{
				combo = new Combo("",child("sexoCombo"),"combos/sexo.txt");
				manager.addItem(combo,"sexo");						
			}
			
			
			
			////COMBOS
			if(child("inputComboFecha"))
			{
				var comboFecha:ComboFecha = new ComboFecha(child("inputComboFecha"));
				manager.addItem(comboFecha,"fecha");
			}
						
			if(child("inputMensaje"))
			{
				var mensaje:TextForm = new TextForm(child("inputMensaje"),MessageTextForm.MENSAJE,TextForm.MULTILINE,siValida);
				manager.addItem(mensaje,"consulta");
			}
			
			////COMBOS
			if(child("tiposCombos"))
			{
				combo = new Combo("",child("tiposCombos"),"combos/tipodepiel.txt");
				manager.addItem(combo,"tipoPiel");
			}			
			
			
					
			
			if(child("inputDireccion"))
			{
				var direccion:TextForm = new TextForm(child("inputDireccion"),MessageTextForm.DIRECCION,TextForm.MULTIPLE,siValida);
				manager.addItem(direccion,"direccion");
			}
			
			
			
			
			////COMBOS
			if(child("provinciasCombo"))
			{
				combo = new Combo(MessageTextForm.PROVINCIA,child("provinciasCombo"),"combos/provincias.txt");
				manager.addItem(combo,"provincia");
			}
			
						
			
			if(child("checkBoxClip"))
			{
				var check:CheckBox = GetButton.button(child("checkBoxClip"),CheckBox) as CheckBox;
				check.statusTxt = _face.status_txt;
				manager.addItem(check);
			}
			
			////AGREGO BOTON
			manager.addButton(child("btnSend"),AppButton);			
		}		
			
		private function showBases(e:ButtonEvent):void
		{
			trace("showBases");
		//	stage.addChild(new BasesMC());
		}
		private function onValidationTrue():void
		{
			_face.status_txt.text = "";
			
			var params:Object = {};
			manager.addToVariables(params);
			
			dispatchEvent(new CustomEvent(Event.COMPLETE,params));					
		}		
		
		public function destroy():void
		{
			manager.destroy();			
		}
		
		public function unlock():void
		{
			manager.unlock();			
		}
	}
}