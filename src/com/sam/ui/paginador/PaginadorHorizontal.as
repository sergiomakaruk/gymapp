package com.sam.ui.paginador
{
	import com.greensock.TweenMax;
	import com.greensock.easing.*;
	
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import sm.fmwk.ui.button.ButtonsContainer;
	import sm.utils.display.GetButton;
	import sm.utils.display.GetDrawedObjects;

	public class PaginadorHorizontal extends ButtonsContainer
	{		
		private const MARGEN:uint = 10;
		private var _ancho:uint;
		private var _alto:uint;
		
		private var mascara:Shape;
		private var container:Sprite;
		private var _target:DisplayObject;
		private var _left:ButtonPaginador;
		private var _right:ButtonPaginador;
		
		public function set ancho(value:uint):void{_ancho=value;}
		public function set alto(value:uint):void{_alto=value;}
		public function set target(value:DisplayObject):void{_target=value;}
		public function set buttonLeft(face:DisplayObject):void{getButtonFromFace(face,true)};
		public function set buttonRight(face:DisplayObject):void{getButtonFromFace(face,false)};
		
		public function PaginadorHorizontal()
		{
			
		}
		
		public function init():void
		{
			check();
			mascara = GetDrawedObjects.getShape(_ancho,_alto,0,0.5);
			container = new Sprite();
			container.addChild(mascara);
			container.mask = mascara;
			container.addChild(_target);
			
			container.x = 90;//_left.width + MARGEN;
			container.y = 715;
			addChild(container);
			if(checkVisible())this.addClickListeners();
		}
		override protected function onButtonClicked():void
		{			
			this.lock();
			this.currentBtn = this.currentTarget;
			if(this.currentBtn == this._right)
			{
				move(true);
			}
			else move(false);				
		}
		private function move(isToRight:Boolean):void
		{
			var x:Number = getX(isToRight);
			var time:Number = Math.abs(_target.x - x) / _ancho;
			TweenMax.to(_target,time,{x:x,ease:Quad.easeOut,onComplete:onComplete});
		}
		private function onComplete():void
		{
			this.unlock();
			if(_left != this.currentBtn)_left.active = true;
			else _right.active = true;
		}
		private function getX(isToRight:Boolean):Number
		{
			var n:Number;
			var limit:Number;
			if(isToRight)
			{
				n =  _target.x - _ancho;
				limit = -_target.width + _ancho;
				if(n<limit)
				{
					_right.active = false;
					n= limit;
				}
			}
			else
			{
				n =  _target.x + _ancho;
				limit=0;
				if(n>limit)
				{
					_left.active = false;
					n=limit
				}
			}
			
			return n;
		}
		private function checkVisible():Boolean
		{
			if(_target.width < _ancho)
			{
				_left.visible = false;
				_right.visible = false;
				return false;
			}
			return true;
		}
		private function check():void
		{
			if(_ancho==0) throw new Error("Paginador.ancho not defined");
			if(_alto==0) throw new Error("Paginador.alto not defined");
			if(!_left) throw new Error("Paginador.buttonLeft not defined");
			if(!_right) throw new Error("Paginador.buttonRight not defined");
		}
		private function getButtonFromFace(face:DisplayObject,isLeft:Boolean):void
		{
			/*var btn:ButtonPaginador = new ButtonPaginador();
				btn.face = face;
				btn.x = face.x;
				btn.y = face.y;
				btn.face.x = btn.face.y = 0;*/
				
			var btn:ButtonPaginador = GetButton.button(face,ButtonPaginador) as ButtonPaginador;
			if(!isLeft) 
			{
				_right = btn;
			//	btn.x = _ancho + MARGEN * 2 + btn.width ;
				btn.unlock();
			}
			else 
			{
				_left = btn;
				//_left.active = false;				
			}
				
			//btn.y = _alto*.5 - 30;
			addChild(btn);
			buttons.push(btn);
		}
	}	
}