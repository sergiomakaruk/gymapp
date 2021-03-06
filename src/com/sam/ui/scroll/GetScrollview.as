package com.sam.ui.scroll
{
	import flash.display.DisplayObject;
	import flash.text.TextField;

	public class GetScrollview
	{
		public static function getScroll(assets:ScrollAssets,hasRuler:Boolean=true,hasButtons:Boolean=false,hasToDrawBack:Boolean=false,alphaBack:Number=0,content:DisplayObject=null):ScrollView
		{
			var scroll:ScrollView = new ScrollView();
			scroll.hasButtons = hasButtons;
			scroll.hasRuller = hasRuler;
			scroll.drawBack = hasToDrawBack;
			scroll.alphaBack = alphaBack;
			scroll.x = assets.x;
			scroll.y = assets.y;
			assets.x = assets.y = 0;
			assets.parent.addChildAt(scroll,assets.parent.getChildIndex(assets));
			scroll.addAssets(assets);
			scroll.init();
			if(content) scroll.addContent(content);
			
			return scroll;
		}
		
		public static function formatTextField(textField:TextField,input:String):TextField
		{
			textField.wordWrap = true;
			textField.multiline = true;
			textField.autoSize = "left";
			textField.text = input;
			textField.x = 0;
			textField.y = 300;
			
			return  textField;
		}
	}
}