package com.sam.ui.paginador
{
	import com.greensock.TweenMax;
	
	import sm.fmwk.ui.button.Button;
	
	public class ButtonPaginador extends Button
	{
		public function ButtonPaginador()
		{
			super();
		}
		override protected function setAsActive():void
		{
			//this.visible = true;
			//TweenMax.to(this,0.3,{autoAlpha:1,z:0,onComplete:DPUtils.sacarBlur,onCompleteParams:[this]});			
		}
		override protected function setAsInactive():void
		{
			//TweenMax.to(this,0.3,{autoAlpha:0.5,z:20});
			//this.visible = false;			
		}
	}
}