package app.events
{
	import flash.events.Event;
	
	public class ChangeFilterEvent extends Event
	{
		public static const CHANGE_FILTER:String = "changeFilter";
		private var _filter:String;

		public function get filter():String
		{
			return _filter;
		}

		
		public function ChangeFilterEvent(type:String,filter:String)
		{
			_filter = filter;
			super(type, false,false);
		}
	}
}