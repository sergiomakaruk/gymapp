package app
{
	import sm.fmwk.site.messages.Message;
	
	public class AppMensaje extends Message
	{
		public function AppMensaje(name:String, tracker:Boolean)
		{
			super(name, tracker);
		}
	}
}