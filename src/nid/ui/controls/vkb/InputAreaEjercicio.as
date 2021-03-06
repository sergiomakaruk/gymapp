package nid.ui.controls.vkb 
{
	import flash.display.GradientType;
	import flash.display.Shape;
	import flash.display.SpreadMethod;
	import flash.display.Sprite;
	import flash.filters.DropShadowFilter;
	import flash.geom.Matrix;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	/**
	 * ...
	 * @author Nidin P Vinayakan
	 */
	public class InputAreaEjercicio extends Sprite 
	{
		public var fieldName:TextField;
		public var targetField:TextField;
		
		internal var bg:Shape;
		internal var fieldBg:Shape;
		
		public function InputAreaEjercicio() 
		{
			configUI();
		}
		override public function set width(value:Number):void 
		{
			
			bg.width = value;
			fieldBg.width = value - 40;
			targetField.width = fieldBg.width - 20;		
			//trace(value,targetField.width);
		}
		override public function set height(value:Number):void 
		{
			bg.height = value + 80 ;
			fieldBg.height = value ;
			targetField.height = fieldBg.height - 20;
		}
		private function configUI():void 
		{
			var fillType:String = GradientType.LINEAR;
			var colors:Array = [0xFFFFFF, 0xCCCCCC];
			var alphas:Array = [1, 1];
			var ratios:Array = [0x00, 0xFF];
			var matr:Matrix = new Matrix();
			matr.createGradientBox(100, 200, 90, 0, 0);
			var spreadMethod:String = SpreadMethod.PAD;
			bg = new Shape();
			bg.graphics.beginGradientFill(fillType, colors, alphas, ratios, matr, spreadMethod);        
			bg.graphics.drawRect(0, 0, 100, 200);
			bg.graphics.endFill();
			bg.graphics.beginFill(0x333333);
			bg.graphics.drawRect(0, 0, 100, 1);
			bg.graphics.endFill();
			//addChild(bg);
			
			var format:TextFormat = new TextFormat("Arial", 20, 0x000000, true);
			
			fieldName = new TextField();
			fieldName.defaultTextFormat = format;
			fieldName.autoSize = TextFieldAutoSize.LEFT;
			fieldName.selectable = false;
			fieldName.text = 'Input Field Name';
			//addChild(fieldName);
			fieldName.x = 10;
			fieldName.y = 10;
			
			fieldBg = new Shape();
			fieldBg.graphics.beginFill(0xffffff);
			fieldBg.graphics.drawRect(0, 0, 80, 100);
			fieldBg.graphics.endFill();
			//addChild(fieldBg);
			fieldBg.x = 20
			fieldBg.y = 60;
			
			fieldBg.filters = [new DropShadowFilter(1,45,0,1,4,4,1,3,true)];
			
			targetField = new TextField();
			targetField.type = TextFieldType.INPUT;
			targetField.multiline = true;
			targetField.wordWrap = true;
			
			//targetField.autoSize = TextFieldAutoSize.LEFT;
			targetField.defaultTextFormat = format;
			targetField.text = 'Input Field';
			targetField.width = 70;
			targetField.height = 0;
			//targetField.border = true;
			addChild(targetField);
			targetField.alpha = 0;
			
			targetField.x = - 500;
			targetField.y = 0;
		}
		
	}

}