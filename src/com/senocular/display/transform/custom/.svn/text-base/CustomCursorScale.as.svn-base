package com.senocular.display.transform.custom
{
	import com.senocular.display.transform.CursorScale;
	
	public class CustomCursorScale extends CursorScale
	{
		public function CustomCursorScale(mode:String="both", rotationOffset:Number=0)
		{
			super(mode, rotationOffset);
		}
		
		override public function draw():void {
				
			addChild(new crop_cursor_btn_scale_SP());
			return;
			
			with (graphics){
				beginFill(0x00FF00, this.fillAlpha);
				lineStyle(this.lineThickness, 0xFF0000, this.lineAlpha);
				// right arrow
				moveTo(4.5, -0.5);
				lineTo(4.5, -2.5);
				lineTo(8.5, 0.5);
				lineTo(4.5, 3.5);
				lineTo(4.5, 1.5);
				lineTo(-0.5, 1.5);
				// left arrow
				lineTo(-3.5, 1.5);
				lineTo(-3.5, 3.5);
				lineTo(-7.5, 0.5);
				lineTo(-3.5, -2.5);
				lineTo(-3.5, -0.5);
				lineTo(4.5, -0.5);
				endFill();
			}
		}
	}
}