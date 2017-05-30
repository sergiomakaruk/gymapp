package app.sections.perfilUsuario
{
	import app.components.button.AppButton;
	import app.model.Model;
	import app.sections.AppSection;
	import app.sections.rutina.Rutina;
	
	import flash.events.Event;
	
	import sm.fmwk.data.core.DataResize;
	import sm.utils.display.GetButton;
	
	public class PerfilUsuario extends AppSection
	{

		private var rutina:Rutina;
		public function PerfilUsuario(name:String, tracker:Boolean)
		{
			super(name, tracker);
		}
		
		override public function show(event:Event=null):void{
			trace("SHOW", Model.socio.rutinas.selectedRutina.ejercicios.ejercicios);
			super.show();
			
			rutina = new Rutina();
			addChild(rutina);
			rutina.render();
			
			var face:_volverFlecha = new _volverFlecha();
			addChild(face);
			face.x = face.y = 55;
			completeAction(face,AppButton);
			
			stage.dispatchEvent(new Event(Event.RESIZE));
		}
		
		override public function resize(data:DataResize):void{
			if(rutina)rutina.x = (stage.stageWidth - rutina.width) *.5;
		}
	}
}