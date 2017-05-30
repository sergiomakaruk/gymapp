package com.sam.form
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	import flash.net.URLVariables;
	import flash.display.IBitmapDrawable;
	
	public interface IStepForm extends IEventDispatcher,IBitmapDrawable
	{		
		function init(e:Event):void;
		
		//function get registro():Boolean;
		
		function showRegistered():void; 
		
		function createFields():void; 
		
		function checkFields():Boolean; 		
		
		function getFields(variables:URLVariables):void; 
		
		function cargando():void; 
		
		function cargado():void; 
		
		function closeForm():void; 		
		
		function set WServMsg(str:String):void;
	}
}