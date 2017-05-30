package app.sections.rutina.ejercicios
{
	import app.data.ejercicios.DataEjercicio;
	import app.model.Model;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import sm.utils.display.DPUtils;
	
	public class PopupOrdenarEjercicios extends Sprite
	{

		private var content:_ordenarrEjercicioPopupSP;

		private var container:Sprite;
		public function PopupOrdenarEjercicios()
		{
			super();
			
			content = new _ordenarrEjercicioPopupSP();
			addChild(content);
		}
		
		
		
		public function change(dia:uint):void
		{			
			for each(var ej:DataEjercicio in Model.currentDataRutina.ejercicios.dias[dia]){
				ej.view.renderAsEditOrder();
			}
			
			if(container)content.removeChild(container);
			container = DPUtils.getColumnsContainer(Model.currentDataRutina.ejercicios.dias[dia],20,20,2,'view');
			container.y = 120;
			container.x = 30;
			content.addChild(container);
			
			
			if(container.height > 900){
				
				/*for each(ej in Model.currentDataRutina.ejercicios.dias[dia]){
					ej.view.renderAsEditOrder(true);
				}*/
				
				content.removeChild(container);
				container = DPUtils.getColumnsContainer(Model.currentDataRutina.ejercicios.dias[dia],20,20,2,'viewMini');
				container.y = 120;
				container.x = 30;
				content.addChild(container);
				
			}
		}

		
		public function destroy():void
		{
			// TODO Auto Generated method stub
			
		}
	}
}