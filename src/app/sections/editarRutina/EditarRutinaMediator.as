package app.sections.editarRutina
{
	import app.sections.AppSectionMediator;
	import app.sections.rutina.Rutina;
	
	public class EditarRutinaMediator extends AppSectionMediator
	{
		public function EditarRutinaMediator()
		{
			super();
		}
		
		private function get content():Rutina{
			return view as Rutina;
		}
	}
}