package app.data
{
	import flash.display.Bitmap;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import sm.utils.display.graphics.GetGraphics;
	import sm.utils.display.imagedata.GetImageData;
	import sm.utils.timer.TimerUtil;

	public class AppUtils
	{
		private static var filtro:Sprite;
		
		public static function getFiltro():Bitmap
		{
			if(!AppUtils.filtro)
			{
				var filtro:Sprite = new Sprite();			
				var cant:uint = 200;
				for (var i:uint=0;i<cant;i+=3)
				{
					for (var j:uint=0;j<cant;j+=3)
					{					
						var shape:Shape = new Shape();
						GetGraphics.drawCirle(shape,1);
						shape.y = j;
						shape.x = i;					
						filtro.addChild(shape);					
					}				
				}	
				filtro.cacheAsBitmap = true;
				
				AppUtils.filtro = filtro;
			}
			
			return new Bitmap(GetImageData.bitmapdata(AppUtils.filtro,true,200,200));
		}			
	}
}