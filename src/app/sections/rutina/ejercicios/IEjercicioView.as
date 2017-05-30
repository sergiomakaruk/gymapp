package app.sections.rutina.ejercicios
{
	import app.data.ejercicios.DataEjercicio;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	
	import nid.interfaces.IDisplayObject;

	public interface IEjercicioView extends IDisplayObject
	{
		function get data():DataEjercicio;
		function get thehitarea():DisplayObject;
		
	}
}