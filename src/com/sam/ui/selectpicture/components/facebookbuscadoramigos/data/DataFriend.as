package com.sam.ui.selectpicture.components.facebookbuscadoramigos.data
{
	public class DataFriend
	{
		private var _uid:String;
		private var _picturePath:String;
		private var _name:String;
		
		public function get uid():String{return _uid;}
		public function get picturePath():String{return _picturePath;}
		public function get name():String{return _name;}
		
		public function set uid(value:String):void{_uid =value;}
		public function set picturePath(value:String):void{_picturePath =value;}
		public function set name(value:String):void{_name =value;}
		
		public function DataFriend()
		{
		}
	}
}