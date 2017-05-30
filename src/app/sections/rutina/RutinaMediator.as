package app.sections.rutina
{
	
	import app.commands.GetSetRutinaCommand;
	import app.data.ejercicios.DataEjercicio;
	import app.data.rutinas.DataIdRutinaBase;
	import app.datatransferences.AppTokenDataTransferenceData;
	import app.datatransferences.DataTransferenceTypes;
	import app.events.AppEvents;
	import app.model.Model;
	import app.sections.rutina.ejercicios.AbsEjercicioView;
	import app.sections.rutina.ejercicios.EjercicioView;
	import app.sections.rutina.ejercicios.IEjercicioView;
	import app.sections.rutina.ejercicios.PopupEditarEjercicios;
	import app.sections.rutina.menu.MenuRutina;
	import app.sections.rutina.msg.EliminarEjercicioMsg;
	import app.sections.rutina.msg.SalirMsg;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.printing.PaperSize;
	import flash.printing.PrintJob;
	import flash.printing.PrintJobOptions;
	import flash.printing.PrintJobOrientation;
	import flash.printing.PrintMethod;
	import flash.printing.PrintUIOptions;
	import flash.text.TextField;
	
	import sm.fmwk.net.transferences.DataTransferenceData;
	import sm.fmwk.net.transferences.SequenceTransferenceData;
	import sm.fmwk.net.transferences.TokenTransferenceData;
	import sm.fmwk.rblegs.events.transference.DataTransferenceEvent;
	import sm.fmwk.rblegs.events.transference.TransferenceEvent;
	import sm.fmwk.site.mediators.FmwkMediator;
	import sm.ui.ligthbox.Lightbox;
	import sm.utils.display.DPUtils;
	import sm.utils.display.GetDrawedObjects;
	import sm.utils.display.GetImage;
	import sm.utils.events.CustomEvent;

	public class RutinaMediator extends FmwkMediator
	{
		private var ejercicioAEliminar:DataEjercicio;

		private var msg:EliminarEjercicioMsg;

		private var popupeditarEjercicio:PopupEditarEjercicios;
		private var msgCancel:SalirMsg;
		
		public function RutinaMediator()
		{
			
			//quien guarda? RutinaMediator o PopupMediator
			//Armar un AbsMediator para la funcion de guardar Ejercicios (esta es la que va)
		}
		
		override public function onRegister():void{
			view.addEventListener(AppEvents.EDITAR_RUTINA_MAIN_EVENT,onEditarRutinaAction);
			//view.addEventListener(AppEvents.FINALIZAR_EDICION_EVENT,onFinalizarEdicion);
			super.onRegister();
		}
		
		override public function onRemove():void{
			view.removeEventListener(AppEvents.EDITAR_RUTINA_MAIN_EVENT,onEditarRutinaAction);
			//view.removeEventListener(AppEvents.FINALIZAR_EDICION_EVENT,onFinalizarEdicion);
			super.onRemove();
		}
				
		private function onEditarRutinaAction(event:CustomEvent):void
		{			
			switch(event.params.action){
		
				case AppEvents.ELIMINAR_EJERCICIO_DE_RUTINA_EVENT://AgregarEjercicioView
					eliminarEjercicio(event.target as IEjercicioView);break;	
				
				case AppEvents.AGREGAR_EJERCICIOS_POPUP_EVENT://MainMenu
					showPoppupAgregarEjercicios(event);break;
				case AppEvents.GUARDAR_CAMBIOS_AGREGAR_EJERCICIOS_A_RUTINA://menuEjercicios
					guardarEjerciciosNuevos();break;
				case AppEvents.CANCELAR_AGREGAR_POPUP_EVENT://menuEjercicios
					finalizarAgregadoEjercicios();break;	
				
				case AppEvents.EDITAR_EJERCICIOS_EVENT://MainMenu
					showAsEdiciondeEjercicios();break;
				case AppEvents.EDITAR_ESTE_EJERCICIO_EVENT://EjercicioView
					showEditarPopup(event);break;
				
				case AppEvents.CANCELAR_EDICION_ORDEN_EVENT://menuOrden
				case AppEvents.CANCELAR_EDICION_DIAS_EVENT://menuDias
				case AppEvents.CANCELAR_EDICION_EVENT://menuEjerciciosValores
					finalizarEdiciondeEjercicios();break;					
				
				case AppEvents.GUARDAR_CAMBIOS_ORDEN://menuOrden
				case AppEvents.GUARDAR_DIAS://menuDias
				case AppEvents.GUARDAR_CAMBIOS_VALORES://menuEjerciciosValores
					guardarEjerciciosEditados();break;	
				
				case AppEvents.EDITAR_DIAS://MainMenu
					showEditarDias();break;
				case AppEvents.SELECTED_DIA_BUTTON://DiasMenu
					Model.currentDataRutina.sectedDia = event.params.selected;break;	
				
				case AppEvents.ORDENAR_EJERCICIOS_POPUP_EVENT://MainMenu
					showOrdenarEjercicios();break;
				case AppEvents.SELECTED_DIA_ORDEN_BUTTON:
					content.mostrarPopupOrdenarEjercicios(event.params.selected);break;	
				
			
				/*case AppEvents.EDITAR_OBSERVACIONES:
					_toSaveHeaderIsObservaciones = true;
					content.renderMenu(MenuRutina.ORDEN_STATE);
					content.mostrarPopupdeHeader(true);break;
				case AppEvents.EDITAR_OBJETIVOS:
					_toSaveHeaderIsObservaciones = false;
					content.renderMenu(MenuRutina.ORDEN_STATE);
					content.mostrarPopupdeHeader(false);break;
				case AppEvents.CANCELAR_EDICION_HEADER_EVENT:
					content.renderMenu(MenuRutina.DEFAULT);	
					content.showAsdefaultStateEdition();
					break;
				*/
							
				case AppEvents.IMPRIMIR:
					imprimir();break;
				
				case AppEvents.ENVIAR_EMAIL:
					enviarEmail();break;
				
				case AppEvents.EDITAR_NOMBRE_DE_RUTINA_BASE:
					content.toggleKeyboard();break;
				case AppEvents.SAVE_EDITAR_NOMBRE_DE_RUTINA_BASE:
					editarNombredeRutinaBase();break;
			}			
		}
		
		private function editarNombredeRutinaBase():void
		{
			trace('ShowPopupDeEditarNombreRutinaBAse');
			this.dispatch(new CustomEvent(AppEvents.SETGET_RUTINA_COMMAND,{action:GetSetRutinaCommand.SAVE_NAME,cb:onNombreRutinaBAseEditado}));

		}
		
		private function onNombreRutinaBAseEditado():void
		{
			trace('TERMINADO - ShowPopupDeEditarNombreRutinaBAse');			
		}
		
		private function enviarEmail():void
		{	//return;
			msgCancel = new SalirMsg(4);
			content.stage.addChild(msgCancel);
			msgCancel.initMsg();
			msgCancel.addEventListener(Event.COMPLETE,onEnviarEmail);
			msgCancel.addEventListener(Event.REMOVED_FROM_STAGE,onCartelEliminarRemoved);		
		}	
		
		protected function onEnviarEmail(event:Event):void
		{
			msgCancel.close();	
			this.doTransference(new DataTransferenceData(DataTransferenceTypes.FUERZO_ENVIO_EMAIL,{rutina:Model.socio.rutinas.selectedRutina.getDataForEmail(),dni:Model.socio.dni,idrutina:Model.socio.rutinas.selectedRutina.sid}),onEmailEnviado);			
		}
		
		private function onEmailEnviado():void
		{
					
		}
		
		private function imprimir():void{
			
			var dp:DisplayObject = GetImage.copy(view.stage,true);
			view.stage.addChild(dp);
			//view.stage.nativeWindow.visible = false;
			
			
			
			var pj:PrintJob = new PrintJob(); 
			pj.orientation = PrintJobOrientation.PORTRAIT;	
			pj.selectPaperSize(PaperSize.A4);
						
			//http://stackoverflow.com/questions/3021557/as3-printing-problem-blanks-swf-after-print-or-cancel
			var printOption:PrintJobOptions = new PrintJobOptions();
			printOption.printAsBitmap = true;//Fmwk.appKey("printAsBitmap");
			printOption.printMethod = PrintMethod.BITMAP;
			
			
			var pagesToPrint:uint = 0; 
			if (pj.start()) 
			{ 
				
				var pages:Array = Model.currentDataRutina.getPrintPages(1450); //842//744 //1355
								
				/* Resize movie clip to fit within page width */
				if (pages[0].width > pj.pageWidth) {
					pages[0].width = pj.pageWidth;
					pages[0].scaleY = pages[0].scaleX;
				}
				
				if(pages[0].height > pj.pageHeight){
					pages[0].height = pj.pageHeight ;
					pages[0].scaleX = pages[0].scaleY;
				}
				
				for each(var page:Sprite in pages){
					
					var sp2:Sprite = new Sprite();
					page.width = pages[0].width;
					page.height = pages[0].height;
					//sp2.addChild(new Bitmap(bmp));
					sp2.addChild(page);
				//	view.stage.addChild(sp2);
					pj.addPage(sp2,null,printOption); 
					pagesToPrint++; 
				}			
				
				if (pagesToPrint > 0) 
				{ 
					pj.send(); 
					enviarEmail();
				} 				
			}			
				
			content.showAsdefaultStateEdition();
			view.stage.removeChild(dp);
			//view.stage.nativeWindow.visible = true;
			//view.stage.nativeWindow.activate();
			
		}
		
		private function showEditarPopup(event:CustomEvent):void
		{
			var data:DataEjercicio;	
			var hideButtons:Boolean;
			if(event.target is EjercicioView)	data = EjercicioView(event.target).data;		
			else{
				data = Model.currentDataRutina.ejercicios.find(AbsEjercicioView(event.target).data.sid,Model.currentDataRutina.sectedDia);
				hideButtons = true;
			}
			
			if(!popupeditarEjercicio){
				popupeditarEjercicio = new PopupEditarEjercicios(data,hideButtons);
				view.stage.addChild(popupeditarEjercicio);
				popupeditarEjercicio.init();
			}
			else {
				popupeditarEjercicio.setData(data,hideButtons);
				view.stage.addChild(popupeditarEjercicio);
			}			
		}
		
		private function showOrdenarEjercicios():void
		{
			content.renderMenu(MenuRutina.ORDEN_STATE);
			content.mostrarPopupOrdenarEjercicios(0);
		}
		
		private function showEditarDias():void
		{
			content.renderMenu(MenuRutina.EDITAR_DIAS_STATE);
			content.renderAsEditarDias();
		}
		
		private function finalizarEdiciondeEjercicios():void
		{
			msgCancel = new SalirMsg();
			content.stage.addChild(msgCancel);
			msgCancel.initMsg();
			msgCancel.addEventListener(Event.COMPLETE,onCancelOk);
			msgCancel.addEventListener(Event.REMOVED_FROM_STAGE,onCartelEliminarRemoved);
		}
		
		
		private function finalizarAgregadoEjercicios():void
		{	
			msgCancel = new SalirMsg();
			content.stage.addChild(msgCancel);
			msgCancel.initMsg();
			msgCancel.addEventListener(Event.COMPLETE,onCancelOk2);
			msgCancel.addEventListener(Event.REMOVED_FROM_STAGE,onCartelEliminarRemoved);
					
		}		
		
		protected function onCancelOk(event:Event):void
		{
			msgCancel.close();	
			Model.currentDataRutina.ejercicios.cancelEdition();//edita ejercicios
			content.showAsdefaultStateEdition();			
			content.renderMenu(MenuRutina.DEFAULT);				
		}		
		
		protected function onCancelOk2(event:Event):void
		{
			msgCancel.close();	
			Model.currentDataRutina.ejercicios.cancelSave();//agregar ejercicios
			content.showAsdefaultStateEdition();
			content.renderMenu(MenuRutina.DEFAULT);				
		}
		
		
		private function guardarEjerciciosEditados():void///se llama de varios eventos
		{
			content.showAsLoading();
			content.showAsdefaultStateEdition();
			content.renderMenu(MenuRutina.DEFAULT);
			this.dispatch(new CustomEvent(AppEvents.SETGET_RUTINA_COMMAND,{action:GetSetRutinaCommand.SET_EJERCICIOS_EDITADOS,cb:onMuchosEjerciciosGuardados}));
		}		
		
		private function guardarEjerciciosNuevos():void
		{
			content.showAsLoading();
			content.showAsdefaultStateEdition();
			content.renderMenu(MenuRutina.DEFAULT);
			
			this.dispatch(new CustomEvent(AppEvents.SETGET_RUTINA_COMMAND,{action:GetSetRutinaCommand.SET_EJERCICIOS_NUEVOS,cb:onMuchosEjerciciosGuardados}));
		}
		
		private function showPoppupAgregarEjercicios(evt:CustomEvent):void
		{
			content.mostrarPopupEjercicios(evt.params);	
			content.renderMenu(MenuRutina.EDITAR_EJERCICIOS_POPUP);
		}
		
		private function showAsEdiciondeEjercicios():void
		{
			content.showEditarEjercicios();	
			content.renderMenu(MenuRutina.EDITAR_EJERCICIOS_VALORES);
		}
		
		private function eliminarEjercicio(ejercicioView:IEjercicioView):void
		{
			//content.showAsLoading();
			ejercicioAEliminar = ejercicioView.data;
			trace(ejercicioAEliminar);
			msg = new EliminarEjercicioMsg(ejercicioView.data.nombre);
			content.stage.addChild(msg);
			msg.initMsg();
			msg.addEventListener(Event.COMPLETE,onEliminarEjercicioOk);
			msg.addEventListener(Event.REMOVED_FROM_STAGE,onCartelEliminarRemoved);
		
		}
		
		protected function onEliminarEjercicioOk(event:Event):void
		{
			this.dispatch(new CustomEvent(AppEvents.SETGET_RUTINA_COMMAND,{action:GetSetRutinaCommand.ELIMINAR_EJERCICIO,cb:onEjercicioEliminado,data:ejercicioAEliminar}));			
		}
		
		private function onEjercicioEliminado():void
		{
			msg.close();						
			Model.currentDataRutina.ejercicios.eliminar(ejercicioAEliminar,resolveDia());			
			ejercicioAEliminar = null;
			content.updateView();
			content.updatePopupEjercicios();
		}
		private function resolveDia():uint{
			return (ejercicioAEliminar.isTemplate) ? Model.currentDataRutina.sectedDia : ejercicioAEliminar.dia;
		}
		
		protected function onCartelEliminarRemoved(event:Event):void
		{
			var msg:Lightbox = event.target as Lightbox;
			msg.removeEventListener(Event.COMPLETE,onEliminarEjercicioOk);
			msg.removeEventListener(Event.COMPLETE,onCancelOk);//para que sirva para varios msg, remuevo los posibles listeners
			msg.removeEventListener(Event.COMPLETE,onCancelOk2);//para que sirva para varios msg, remuevo los posibles listeners
			msg.removeEventListener(Event.COMPLETE,onEnviarEmail);
			msg.removeEventListener(Event.REMOVED_FROM_STAGE,onCartelEliminarRemoved);
		}
		
		private function onMuchosEjerciciosGuardados():void
		{
			trace('onMuchosEjerciciosGuardados');
			Model.currentDataRutina.ejercicios.setAsSaved();
			content.showAsNOLoading();		
			content.updateView();			
		}
			
		private function get content():Rutina{return view as Rutina;}
	}
}