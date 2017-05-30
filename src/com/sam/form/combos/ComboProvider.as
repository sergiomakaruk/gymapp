package com.sam.form.combos
{
	import com.sam.form.combos.DataCombo;
	
	public class ComboProvider
	{
		private var _data:Vector.<DataCombo>;
		public function get data():Vector.<DataCombo>{return _data;}
		
		public function ComboProvider(arrayOrVectorString:*=null)
		{
			_data = new Vector.<DataCombo>();
			if(arrayOrVectorString)for each(var value:String in arrayOrVectorString) add(value,value);			
		}
		
		public function add(id:String,value:String):void
		{
			_data.push(new DataCombo(id,value));
		}
	}
}