package com.senocular.display.transform.custom
{
	import com.senocular.display.transform.ControlUVScale;
	import com.senocular.display.transform.Cursor;
	
	import flash.display.Shape;
	import flash.display.Sprite;

	public class CustonControlUVScale extends ControlUVScale
	{
		public function CustonControlUVScale(u:Number = 1, v:Number = 1, mode:String = BOTH, cursor:Cursor = null)
		{
			super(u, v, mode,cursor);	
			add();
		}
		private function add():void
		{
			addChild(new crop_btn_scale_SP());
			return;
			var obj:Sprite = new Sprite();	
			obj.graphics.beginFill(0xFF0000);
			obj.graphics.drawCircle(0,0,5);			
			this.addChild(obj);
		}			
	}
}