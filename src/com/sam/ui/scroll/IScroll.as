package com.sam.ui.scroll
{
	public interface IScroll
	{
		function init():void;
		function addView(asset:ScrollView):void
		function destroy():void;
		function reset():void;
	}
}