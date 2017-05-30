package com.sam.form
{
	import com.sam.events.ButtonEvent;
	import com.sam.ui.button.Button;
	import com.sam.utils.date.DateUtils;
	import com.sam.utils.getDisplayObjects.GetButton;
	import com.sam.utils.keyboard.Lister_ENTER_KEY;
	
	import flash.display.*;
	import flash.events.Event;
	import flash.text.TextField;
	
	public class DDMMYYYY extends MovieClip
	{		
		private var day:TextField;
		private var month:TextField;
		private var year:TextField;
		private var status:TextField;

		private var btn:Button;
		private var _currentDate:Date;
		public function set currentDate(value:Date):void{_currentDate = value;}
		
		public function DDMMYYYY()
		{
			super();
		}
		public function addFields(dd:TextField,mm:TextField,year:TextField,status:TextField):void
		{		
			day = dd
			month = mm;
			this.year = year;
			this.status = status;
			status.text = "";
			
			var input1:TextForm = new TextForm(day,"dd","dd",TextForm.NUMBER,0);
			var input2:TextForm = new TextForm(month,"mm","mm",TextForm.NUMBER,0);
			var input3:TextForm = new TextForm(year,"aaaa","aaaa",TextForm.NUMBER,0);
			
			day.maxChars = 2;
			day.restrict = "0-9";
			
			month.maxChars = 2;
			month.restrict = "0-9";
			
			year.maxChars = 4;
			year.restrict = "0-9";			
		}
		public function addButton(face:DisplayObject):void
		{
			btn = GetButton.getCustomButtonFromFace(face,Button);
			btn.addEventListener(ButtonEvent.onCLICK,checkDate);
			
			var enter:Lister_ENTER_KEY = new Lister_ENTER_KEY(btn,true);
		}		
		protected function checkDate(event:Event=null):void
		{
			status.text = "";
			if(validateDate())
			{
				if(DateUtils.comprobarMayor(18,new Date(year.text,uint(month.text)-1,day.text),_currentDate))
				{
					dispatchEvent(new Event(Event.COMPLETE));
					return;
				}
				else
				{					
					status.text = "Debes ser mayor de 18 años";
				}				
			}
			else
			{				
				status.text = "Fecha inválida";
			}	
			
			btn.unlock();
		}
		private function validateDate():Boolean
		{		
			return true;
			
			var date:String = day.text + "-" + month.text + "-" + year.text;
			
			var month_:String 		= "(0?[1-9]|1[012])";
			var day_:String 			= "(0?[1-9]|[12][0-9]|3[01])";
			var year_:String 		= "([1-9][0-9]{3})";
			var separator:String 	= "([.\/ -]{1})";
			
			var usDate:RegExp = new RegExp("^" + month_ + separator + day_ + "\\2" + year_ + "$");
			var ukDate:RegExp = new RegExp("^" + day_ + separator + month_ + "\\2" + year_ + "$");
			
			return (usDate.test(date) || ukDate.test(date) ? true:false);
		}		
		
		public function validate():void
		{
			checkDate();			
		}
	}
}