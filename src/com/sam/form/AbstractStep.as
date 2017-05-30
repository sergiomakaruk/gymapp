package com.sam.form
{
	import flash.errors.IllegalOperationError;
	import flash.display.Sprite;
	import flash.text.*;
	import flash.events.*;
	
	public class AbstractStep extends Sprite implements IStepForm 
	{			
		private const SIZE:uint = 15;
		private const COLOR:uint = 0;
		private const ANCHO:uint = 200;
		
		protected var format:TextFormat;		
		
		public function init(e:Event):void
		{
			throw new IllegalOperationError("Abstract method:must be overridden in a subclass");
		}
		
		public function createFields():void
		{
			throw new IllegalOperationError("Abstract method:must be overridden in a subclass");
		}
		
		public function checkFields():Boolean
		{
			throw new IllegalOperationError("Abstract method:must be overridden in a subclass");
		}		
		
		public function getFields():void
		{
			throw new IllegalOperationError("Abstract method:must be overridden in a subclass");
		}
		
		public function cargando():void
		{
			throw new IllegalOperationError("Abstract method:must be overridden in a subclass");
		}
		
		public function cargado():void
		{
			throw new IllegalOperationError("Abstract method:must be overridden in a subclass");
		}
		
		public function closeForm():void
		{
			throw new IllegalOperationError("Abstract method:must be overridden in a subclass");
		}			
	}
}