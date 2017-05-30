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

	public class PaginadorVertical extends ButtonsContainer
	{		
		private const MARGEN:uint = 10;
		private var _ancho:uint;
		private var _alto:uint;
		
		private var mascara:Shape;
		private var container:Sprite;
		private var _target:DisplayObject;
		private var _up:ButtonPaginador;
		private var _down:ButtonPaginador;

		private var _moverAlto:uint;
		
		///Este setter define cuantos px se mueve por vez. Si no se setea, se toma el valor del alo de la mascara.
		public function set moverAlto(value:uint):void{_moverAlto=value;}
		public function set target(value:DisplayObject):void{_target=value;}
		public function set buttonUp(face:DisplayObject):void{getButtonFromFace(face,false)};
		public function set buttonDown(face:DisplayObject):void{getButtonFromFace(face,true)};
		
		public function PaginadorVertical(ancho:uint,alto:uint)
		{
			_ancho = ancho;
			_alto = alto;
		}
		
		public function init():void
		{
			check();
			mascara = GetDrawedObjects.getShape(_ancho,_alto,0,0.5);
			container = new Sprite();
			container.addChild(mascara);
			container.mask = mascara;
			container.addChild(_target);
			
			_target.x = (_ancho - _target.width) * .5;
			if(_moverAlto == 0) _moverAlto = _alto;
			
			addChild(container);
			if(checkVisible())this.addClickListeners();
		}
		override protected function onButtonClicked():void
		{			
			this.active = false;
			this.currentBtn = this.currentTarget;
			if(this.currentBtn == this._down)
			{
				move(true);
			}
			else move(false);				
		}
		private function move(isToDown:Boolean):void
		{
			var y:Number = getY(isToDown);
			var time:Number = Math.abs(_target.y - y) / _moverAlto;
			TweenMax.to(_target,time,{y:y,ease:Quad.easeOut,onComplete:onComplete});
		}
		private function onComplete():void
		{
			this.active = true;
						
			if(this.currentBtn == this._down)
			{				
				if(_target.y + _target.height > _moverAlto) _down.active = true;
			}
			else
			{
				if(_target.y < 0) _up.active = true;
			}			
		}
		private function getY(isToDown:Boolean):Number
		{			
			var n:Number;
			var limit:Number;
			if(isToDown)
			{
				n =  _target.y - _moverAlto;
				limit = -_target.height + _moverAlto;
				if(n<limit)
				{
					_down.active = false;
					n= limit;
				}
			}
			else
			{
				n =  _target.y + _moverAlto;
				limit=0;
				if(n>limit)
				{
					_up.active = false;
					n=limit
				}
			}
			
			return n;
		}
		private function checkVisible():Boolean
		{
			if(_target.height < _alto)
			{
				_up.visible = false;
				_down.visible = false;
				return false;
			}
			return true;
		}
		private function check():void
		{
			if(_ancho==0) throw new Error("Paginador.ancho not defined");
			if(_alto==0) throw new Error("Paginador.alto not defined");
			if(!_up) throw new Error("Paginador.buttonLeft not defined");
			if(!_down) throw new Error("Paginador.buttonRight not defined");
		}
		private function getButtonFromFace(face:DisplayObject,isDownBtn:Boolean):void
		{
			var btn:ButtonPaginador = GetButton.button(face,ButtonPaginador);				
				
			if(isDownBtn) 
			{
				_down = btn;				
			}
			else 
			{
				_up = btn;	
				btn.active = false;
			}
			
			buttons.push(btn);
		}
	}	
}