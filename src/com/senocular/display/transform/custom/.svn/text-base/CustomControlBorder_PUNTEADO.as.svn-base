package com.senocular.display.transform.custom
{
	import com.senocular.display.transform.ControlBorder;
	import com.senocular.display.transform.TransformTool;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.events.Event;
	
	import sm.utils.display.graphics.GetGraphics;
	import sm.utils.number.NumberUtils;
	
	public class CustomControlBorder_PUNTEADO extends ControlBorder
	{
		public function CustomControlBorder_PUNTEADO()
		{
			super();
		}
		/**
		 * @inheritDoc
		 */
		override public function redraw(event:Event):void {
			super.redraw(event);
			
			var lineStyle:uint = 3;
			var ancho:uint = 1;
			var separacion:uint = 10;
			var color:uint = 0;
			
			var tool:TransformTool = this.tool;
			if (tool == null){
				return;
			}
			
			with (graphics){
				clear();
				lineStyle(ancho, color, this.lineAlpha);
				//moveTo(tool.topLeft.x, tool.topLeft.y);
				//lineTo(tool.topRight.x, tool.topRight.y);
				//lineTo(tool.bottomRight.x, tool.bottomRight.y);
				//lineTo(tool.bottomLeft.x, tool.bottomLeft.y);
				//lineTo(tool.topLeft.x, tool.topLeft.y);
			}
			GetGraphics.lineaPunteada(this,tool.topLeft.x, tool.topLeft.y,tool.topRight.x, tool.topRight.y,ancho,separacion,color,lineStyle);
			GetGraphics.lineaPunteada(this,tool.topRight.x, tool.topRight.y,tool.bottomRight.x, tool.bottomRight.y,ancho,separacion,color,lineStyle);
			GetGraphics.lineaPunteada(this,tool.bottomRight.x, tool.bottomRight.y,tool.bottomLeft.x, tool.bottomLeft.y,ancho,separacion,color,lineStyle);
			GetGraphics.lineaPunteada(this,tool.bottomLeft.x, tool.bottomLeft.y,tool.topLeft.x, tool.topLeft.y,ancho,separacion,color,lineStyle);
		}
		
		
	}
}