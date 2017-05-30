package com.sam.form.combos
{
	import app.model.Model;
	
	import com.sam.form.FormErrorClip;
	import com.sam.form.IInputForm;
	import com.sam.form.MessageTextForm;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	
	import sm.utils.date.DateUtils;
	import sm.utils.timer.TimerUtil;

	public class ComboFecha extends Sprite implements IInputForm
	{
		private var _face:MovieClip;
		private var errorClip:FormErrorClip;
		private var _currentTabIndex:uint;

		private var dia:Combo;

		private var mes:Combo;

		private var anio:Combo;
		
		public function ComboFecha(face:MovieClip)
		{
			this._face = face;
			init();
		}
		
		private function init():void
		{	
			errorClip = new FormErrorClip(_face.errorClip);
			
			var _dias:Array = [];
			for (var i:uint=1;i<=31;i++)_dias.push(TimerUtil.format(i));
			
			var _mes:Array = [];
			for (i=1;i<=12;i++)_mes.push(TimerUtil.format(i));
			
			var _anios:Array = [];
			var date:Date = new Date();
			for (i=date.getFullYear();i>=1900;i--)_anios.push(i);
						
			dia = new Combo(MessageTextForm.DIA,_face.diaCombo,_dias);
			mes = new Combo(MessageTextForm.DIA,_face.mesCombo,_mes);
			anio = new Combo(MessageTextForm.DIA,_face.anioCombo,_anios);
						
			_face.diaCombo.addEventListener(MouseEvent.CLICK,onfocusIn);
			_face.mesCombo.addEventListener(MouseEvent.CLICK,onfocusIn);
			_face.anioCombo.addEventListener(MouseEvent.CLICK,onfocusIn);
		}
		
		private function onfocusIn(event:Event):void
		{		
			_face.parent.addChild(_face);			
		}
		private function validar():Boolean
		{			
			var d:String = dia.campo[0];
			var m:String = mes.campo[0];
			var a:String = anio.campo[0];					
			
			if(!DateUtils.isDay(d))return false;
			if(!DateUtils.isMonth(m))return false;
			if(!DateUtils.isYear(a))return false; 				
			
			return true;
			//return DateUtils.comprobarMayor(18,new Date(a,m,d),ApplicationModel.getInstance().currentDate);			
		}
		
		public function destroy():void
		{
			_face.diaCombo.removeEventListener(MouseEvent.CLICK,onfocusIn);
			_face.mesCombo.removeEventListener(MouseEvent.CLICK,onfocusIn);
			_face.anioCombo.removeEventListener(MouseEvent.CLICK,onfocusIn);
		}
		
		/////////////////////////////IInputForm
		public function get label():String{return _face.name}
		
		public function get campo():Array{return [dia.campo[0],mes.campo[0],anio.campo[0]]}
		
		public function get isReady():Boolean
		{
			if(validar()) 
			{
				this.quitIndicador();
				return true;
			}
			return false;
		}		
		
		public function set campoMsg(str:String):void{}	
		
		public function setTabIndex(n:uint):void{_currentTabIndex=n}
		public function getTabIndex():uint{return _currentTabIndex}	
		
		public function addDefaultValue(str:String):void{}
		
		public function putIndicador():void{if(errorClip)errorClip.show()};
		
		public function quitIndicador():void{if(errorClip)errorClip.hide()};
	}
}