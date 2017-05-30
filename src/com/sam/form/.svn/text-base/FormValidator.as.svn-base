package com.sam.form
{
	import flash.net.URLVariables;

	public class FormValidator
	{
		private var _inputs:Vector.<IInputForm>
		
		public function FormValidator()
		{
			_inputs = new Vector.<IInputForm>();
		}

		public function get inputs():Vector.<IInputForm>
		{
			return _inputs;
		}

		public function set inputs(value:Vector.<IInputForm>):void
		{
			_inputs = value;
		}
		
		public function checkFields():Boolean
		{
						
			//_registro ? datos=fields : datos=loginFields;		
			
			//return true;
			
			for each(var input:IInputForm in _inputs)
			{
				trace(input,"==>",input.label,input.isReady);
				if(input.isReady == false)
				{	
					input.putIndicador();
					doTrace();
					return false;
				}					
			}			
			
			doTrace();
			return true;//;combos.isReady;						
		}
		
		private function doTrace():void
		{
			trace("----------- END VALIDATION -------------- \n\n");
			
		}
		
		public function destroy():void
		{
			_inputs = null;			
		}
	}
}