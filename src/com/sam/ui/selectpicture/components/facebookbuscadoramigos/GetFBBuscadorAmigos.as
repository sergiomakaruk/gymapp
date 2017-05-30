package com.sam.ui.selectpicture.components.facebookbuscadoramigos
{
	import com.puremvc.ApplicationFacade;
	import com.sam.ui.selectpicture.components.facebookbuscadoramigos.controller.FBBuscadorAmigosCommand;
	import com.sam.ui.selectpicture.components.facebookbuscadoramigos.mediators.FBBuscadorAmigosMediator;
	import com.sam.ui.selectpicture.components.facebookbuscadoramigos.view.FBBuscadorAmigos;
	
	import org.puremvc.as3.interfaces.IFacade;

	public class GetFBBuscadorAmigos
	{
		public static function getBuscador(uid:String,facade:IFacade):FBBuscadorAmigos
		{
			var buscador:FBBuscadorAmigos = new FBBuscadorAmigos();						
		
			var mediator:FBBuscadorAmigosMediator =  new FBBuscadorAmigosMediator(buscador);
			facade.registerMediator(mediator);	
			mediator.start(uid);
			
			return buscador;	
		}
	}
}