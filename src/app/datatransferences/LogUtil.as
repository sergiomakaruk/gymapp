package app.datatransferences
{
	import app.model.Model;
	
	import flash.errors.IOError;
	import flash.filesystem.File;
	import flash.filesystem.FileMode;
	import flash.filesystem.FileStream;
	
	import hx.fmwk.serialization.Json;
	
	import sm.fmwk.Fmwk;
	import sm.fmwk.net.DataTransference;
	import sm.fmwk.net.transferences.DataTransferenceData;

	public class LogUtil
	{
		public function LogUtil()
		{
		}
		
		public static function logError(error:String,action:String):void{
			var fmwkurl:String ='file:///'+ replaceBackslashes(String(Fmwk.appConfig('kiosko')))+'logs/kiosco_n_'+ Model.datakiosco.id_kiosco +'.txt';
			var obj:Object = {};
			obj.ws = action;
			obj.msg = error;
			obj.time = new Date().toString();
			obj.appid = Model.datakiosco.id_kiosco;
			obj.socio = Model.socio.datajson();
			obj.profe = Model.profe.datajson();
			
			var str:String = Json.encode(obj) + '\n\n';
			
			prepend(fmwkurl,str);
		}
		
		public static function replaceBackslashes($string:String):String
		{
			return $string.replace(/\\/g, "/");
		}

		
		public static function defineAppId():Boolean{
			//1-Leo n directorio para ver si existe file que me diga el id
			//2-si no existe, leo el compartido para asiganar un id. Leo el ultimo, le sumo uno
			//3-guardo ese file de configuracion, y actualizo
			//4-si exite o ya lo cree, lo defino en la app
			
			
			/*
			case '1':str='Charcas';break;
			case '2':str='Flores';break;
			case '3':str='Caballito';break;
			case '4':str='Quilmes';break;
			case '5':str='Sergio';break;
			*/
			
			//1;0;2;1 (bnorte pb 1) - OK
			//1;0;2;2 (bnorte pb 2) - OK
			//1;1;1;3 (bnorte 1piso) - OK
			//2;3;1;4 (flores 3piso) - OK
			//2;4;1;5 (flores 4piso) - OK
			//3;1;1;6 (caballito 1piso) - OK
			//3;2;1;7 (caballito 2piso) - OK, pero el sistema es en ingles. Ver si funcionan las clases
			//4;0;1;8 (quilmes) - FALTA - no conecta
			
			var idfile:File = File.documentsDirectory.resolvePath('gymconfig/appconfig.txt');
			if(idfile.exists)
			{				
				var data:Array =	readFile(idfile).split(';');
				
				Model.datakiosco.id_sede = data[0];
				Model.datakiosco.piso = data[1];
				Model.datakiosco.kiosco_por_piso = data[2];
				Model.datakiosco.id_kiosco = data[3];
			}
			/*else{
				var fmwkurl:String ='file:///'+ replaceBackslashes(String(Fmwk.appConfig('kiosko')))+'appconfig/appconfig.txt';
				var ids:Array = readFile(fmwkurl).split(';');
				//trace(readFile(fmwkurl));
				var lastid:uint = ids[ids.length-2];
				var newid:uint = lastid+1;
				Model.app =	newid;
				write(idfile,newid.toString());
				append(fmwkurl,newid+';');
			}*/
			
			
			return false;
		}
		
		public static function resolvefile(pathorfile:*):File{
			var file:File;
			if(pathorfile is File){
				file = pathorfile;				
			}else {
				file = new File();
				file.url = pathorfile;
			}
			return file;
		}
		
		public static function prepend(pathorfile:*,value:String):void
		{
			var current:String = readFile(pathorfile);
			if(current)write(pathorfile,value+current);
		}
		
		public static function update(pathorfile:*,value:String,startIndex:int = 0):void
		{
			var file:File = resolvefile(pathorfile); 
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.UPDATE);
			fs.position = startIndex;
			fs.writeUTFBytes(value);
			fs.close();
		}
		
		public static function write(pathorfile:*,value:String):void
		{
			//crates the new file class from string that contains target url...
			var file:File = resolvefile(pathorfile); 
			//creates the new FileStream class used to actualy write/read/... the file...
			var fs:FileStream = new FileStream();
			//opens the file in write method
			fs.open(file,FileMode.WRITE);
			//writes the text in file (UTFBytes are normal text...)
			fs.writeUTFBytes(value);
			//closes the file after it is done writing...
			fs.close();
		}
		
		public static function append(pathorfile:*,value:String):void
		{
			var file:File = resolvefile(pathorfile); 
			var fs:FileStream = new FileStream();
			fs.open(file,FileMode.APPEND);
			fs.writeUTFBytes(value);
			fs.close();
		}
		
		public static function readFile(pathorfile:*,startIndex:uint=0,endIndex:uint=int.MAX_VALUE):String{
			
			try{
				var file:File = resolvefile(pathorfile); 					
				var resaults:String;			
				var fs:FileStream = new FileStream();			
				fs.open(file,FileMode.READ);		
				fs.position = startIndex;		
				resaults = fs.readUTFBytes(Math.min(endIndex-startIndex,fs.bytesAvailable));
				//trace("resaults",resaults);			
				fs.close();
				
				return resaults;
			}catch(e:Error){
				trace(e);
			}
			return null;
			
		}
	}
}


