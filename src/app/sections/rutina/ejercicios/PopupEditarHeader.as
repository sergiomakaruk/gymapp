package app.sections.rutina.ejercicios
{
	import app.model.Model;
	import app.sections.rutina.ejercicios.componets.ItemEditarHeader;
	import app.sections.rutina.menu.AbsMenu;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import sm.utils.display.DPUtils;
	
	public class PopupEditarHeader extends AbsMenu
	{
		private var views:Array;
		public var isObservaciones:Boolean;
		
		public function PopupEditarHeader(isObservaciones:Boolean)
		{
			super();
			
			this.isObservaciones = isObservaciones;
			
			var content:_editarHeaderPupupSP = new _editarHeaderPupupSP();
			addChild(content);
			
			if(isObservaciones)content._header.text = "Editar Observaciones";
			else content._header.text = "Editar Objetivos";
			
			views = [];
			var items:Array = (isObservaciones) ? Model.observaciones : Model.objetivos;
			
			for(var i:uint=0;i<items.length;i++){
				views.push(new ItemEditarHeader(items[i],i,Model.currentDataRutina.checkHeader(i,isObservaciones)));
			}
			
			var container:Sprite = DPUtils.getColumnsContainer(views,0,10,1);
			container.x = 45;
			container.y = 105;
		}
		
		public function getActives():String{
			var to:Array = [];
				for each(var item:ItemEditarHeader in views){
					if(item.isActive)to.push(item.id);
				}
				return to.join(',');
		}
		
		public function destroy():void
		{
			// TODO Auto Generated method stub
			
		}
	}
}