﻿package com.sam.form
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.text.TextField;
	
	import sm.utils.date.DateUtils;
	
	public class FechaInput extends EventDispatcher implements IInputForm
	{
		private var day:TextField;
		private var month:TextField;
		private var year:TextField;

		private var error:FormErrorClip;		
		private var hasToValidate:Boolean;
		
		public function get label():String{return "fecha"}
		
		public function get campo():Array{return [day.text , month.text , year.text]}
		
		public function set campoMsg(str:String):void{}
		
		public function get isReady():Boolean{return validateDate();}	
		
		public function setTabIndex(n:uint):void
		{			
			day.tabEnabled = true;
			day.tabIndex = n;
			
			month.tabEnabled = true;
			month.tabIndex = n + 1;
			
			year.tabEnabled = true;
			year.tabIndex = n + 2;
		}	
		
		public function getTabIndex():uint
		{
			return year.tabIndex + 1;
		}
		
		public function FechaInput(_face:MovieClip,hasToValidate:Boolean=true)
		{
			this.hasToValidate = hasToValidate;
			
			this.day = _face.dd
			this.month = _face.mm;
			this.year = _face.aaaa;				
			
			error = new FormErrorClip(_face.errorClip);			
			
			day.maxChars =2;
			day.restrict = "0-9";	
			day.text = "";
			
			month.maxChars = 2;
			month.restrict = "0-9";		
			month.text = "";
			
			
			year.maxChars = 4;
			year.restrict = "0-9";	
			year.text = "";
			
		}
				
		private function validateDate():Boolean
		{				
			/*var date:String = day.text + "-" + month.text + "-" + year.text;
			
			var month_:String 		= "(0?[1-9]|1[012])";
			var day_:String 			= "(0?[1-9]|[12][0-9]|3[01])";
			var year_:String 		= "([1-9][0-9]{3})";
			var separator:String 	= "([.\/ -]{1})";
			
			var usDate:RegExp = new RegExp("^" + day_ + separator + month_ + "\\2" + year_ + "$");
			var ukDate:RegExp = new RegExp("^" + day_ + separator + month_ + "\\2" + year_ + "$");
			
			return (usDate.test(date) || ukDate.test(date) ? true:false);*/
						
			if(hasToValidate)
			{
				if(!DateUtils.isDay(day.text))return false;
				if(!DateUtils.isMonth(month.text))return false;
				if(!DateUtils.isYear(year.text))return false;
			}			
			
			return true;
		}
		
		public function addDefaultValue(str:String):void{}
		public function putIndicador():void{error.show()}		
		public function quitIndicador():void{error.hide()}		
		public function destroy():void{};
	}
}