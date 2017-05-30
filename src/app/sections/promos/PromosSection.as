package app.sections.promos
{
	import app.data.clases.DataClase;
	import app.model.Model;
	import app.sections.AppSection;
	
	import com.greensock.TweenMax;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.utils.Timer;
	
	import sm.fmwk.Fmwk;
	import sm.utils.display.DPUtils;
	import sm.utils.display.GetImage;
	import sm.utils.loader.LoaderData;
	
	public class PromosSection extends AppSection
	{
		private var timer:Timer;

		private var index:uint;

		private var current:DisplayObject;

		private var nextImage:DisplayObject;

		private var hora:uint;

		private var minutos:uint;

		private var reloading:Boolean;
		
		public function PromosSection(name:String, tracker:Boolean)
		{
			super(name, tracker);
			
			//hay un  timer en este mediador, lo renueva para actualizar el cronograma
			//hay un timer en site mediator, que controla la actividad (click)
			//hay un listener click en este mediador, que lleva a login usuario si se clickea
			//el timer de la galería, es independiente
		}
		
		override public function show(event:Event=null):void{			
			super.show();			
			//startGallery();		
			loadClases();
		}
		
		private function loadClases():void
		{
			var loadData:LoaderData = new LoaderData(onInfoDate,'http://www.plandeentrenamiento.com.ar/horario.php');	
			//http://tuplandeentrenamientodigital.club/kiosko/2016/horario.php
		}
		
		private function onInfoDate(result:Object):void
		{
			var dias:Array = result.split(' ');			
			var dia:String;
			hora = dias[1];
			minutos = dias[2];
			switch(dias[0]){
				case 'Sunday':dia='domingo';break;
				case 'Monday':dia='lunes';break;
				case 'Tuesday':dia='martes';break;
				case 'Wednesday':dia='miercoles';break;
				case 'Thursday':dia='jueves';break;
				case 'Friday':dia='viernes';break;
				case 'Saturday':dia='sabado';break;			
			}
			trace(result);
			//poner aca un log en txt a ver si funciona esto, omejor, ponerlo al inicio del programa
			//trace(result);
			
			var sede:String = Model.datakiosco.getSedeNombre();
			////trace(Fmwk.appConfig('kiosko')+'clases/'+sede+'/'+dia+'.csv');
			
			var loadData:LoaderData = new LoaderData(onCSVClasesLoaded,Fmwk.appConfig('kiosko')+'clases/'+sede+'/'+dia+'.csv',onErrorCSV);
		}
		
		private function onErrorCSV():void
		{
			Model.promosToGallery = Model.promos.concat();
			if(!reloading)startGallery();	
		}
		
		private function onCSVClasesLoaded(clases:Object):void
		{
			//modificar el tiempo y el push del loop.
			
			var theClases:Array = clases.split('\n');
			trace('theClases',theClases.length);
			theClases.shift();
			
			var lasClases:Array = [];
			var dataClase:DataClase;
			for each(var clase:String in theClases){
				dataClase = new DataClase(clase);
				//lasClases.push(dataClase);
				if(dataClase.hora> hora)lasClases.push(dataClase);
				else if(dataClase.hora == hora && dataClase.minutos >= minutos)lasClases.push(dataClase);
			}
			trace('theClases',lasClases.length);
			if(lasClases.length == 0){
				Model.promosToGallery = Model.promos.concat();
				if(!reloading)startGallery();	
				return;
			}
			
			lasClases  = lasClases.slice(0,6);
			
			var asset:_clasesGymSP = new _clasesGymSP();
			asset.texContainer._input.text = '';			
			asset.texContainer._input.multiline = true;
			TextField(asset.texContainer._input).selectable = false;
			
					
			for each(var clasea:DataClase in lasClases){
				asset.texContainer._input.text+= clasea.horaStr + " " + clasea.descripcion ;
			}
			asset.texContainer._input.autoSize = TextFieldAutoSize.CENTER;
				
			//hago que entre cada imagen, aparezcan las actividades
			var newPromos:Array = [];
			for each(var dp:DisplayObject in Model.promos)
			{
				newPromos.push(dp);
				newPromos.push(asset);
			}
			Model.promosToGallery = newPromos;
			trace('Model.promosToGallery',Model.promosToGallery.length);
			//Model.promos.unshift(asset);
			if(!reloading)startGallery();	
		}
		
		private function startGallery():void
		{
			if(Model.promosToGallery.length > 1){
				timer = new Timer(1000 * 15,0);
				//timer = new Timer(1000 ,0);
				timer.addEventListener(TimerEvent.TIMER,showNext);
				timer.start();
			}
			
			showNext();			
		}
		
		private function showNext(e:Event=null):void
		{
			if(Model.promosToGallery.length == 1){
				if(timer)timer.stop();
				index = 0;
			}
			nextImage = Model.promosToGallery[index];			
			//if(current)TweenMax.to(current,0.3,{alpha:0});
			TweenMax.from(nextImage,0.5,{alpha:0,onComplete:remove});
			addChild(nextImage);			
			index++;
			if(index == Model.promosToGallery.length)index=0;
		}
		
		private function remove():void{			
			if(Model.promosToGallery.length == 1)return;
			if(current){
				removeChild(current);
				//current.alpha = 1;
			}
			
			current = nextImage;
		}
		
		override public function destroy():void{
			if(timer)timer.stop();
			super.destroy();
		}
		
		public function reload():void
		{
			reloading = true;
			loadClases();
			
		}
	}
}