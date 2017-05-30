package app.components.button.fbLogin
{
	import flash.display.DisplayObject;
	
	import sm.fmwk.ui.button.Button;
	
	public class FbLoginButton extends Button
	{
		public function FbLoginButton()
		{
			super();			
			this.active = true;
		}
		
		override public function set face(val:DisplayObject):void
		{
			val.visible = true;
			super.face = val;
		}
		
		override public function show():void
		{
			this.visible = true;
			this.active = true;
		}
		override public function hide():void
		{
			this.visible = false;
			this.active = false;
		}
	}
}