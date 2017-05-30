package app.sections.rutina.ejercicios
{
	import app.data.ejercicios.DataEjercicio;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	public class AbsEjercicioView extends Sprite implements IEjercicioView
	{
		
		protected var _data:DataEjercicio;
		public function get data():DataEjercicio
		{
			return _data;
		}
		
		public function get thehitarea():DisplayObject{
			return null;
		}
		
		public function AbsEjercicioView()
		{
			super();
		}
	}
}