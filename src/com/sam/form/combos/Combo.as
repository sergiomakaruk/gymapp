package com.sam.form.combos
{
	import com.sam.form.FormErrorClip;
	import com.sam.form.IInputForm;
	import com.sam.form.MessageTextForm;
	import com.sam.ui.scroll.ScrollAssets;
	import com.sam.ui.scroll.ScrollView;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.FocusEvent;
	import flash.events.MouseEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	import sm.fmwk.ui.button.Button;
	import sm.utils.display.GetButton;
	import sm.utils.display.graphics.GetGraphics;
	
	public class Combo extends Sprite implements IInputForm
	{
		private var page:Stage;
		private var _maxHeight:Number;		
		private var _itemsPath:String;		
		private var errorClip:FormErrorClip;
		private var defaultMsg:String;
		private var errorMsg:String;
		private var _tab:uint;
		private var btn:Button;

		protected var itemSelected:ItemCombo;
		protected var _face:MovieClip;
		protected var _inputText:TextField;
		protected var scroll:ScrollView;
		protected var buttons:Vector.<ItemCombo>;
		protected var _items:ComboProvider;
		
		public function get label():String{return _face.name};
		
		public function get campo():Array{return [itemSelected.data.value]};	
		
		public function set campoMsg(str:String):void{_inputText.text=str};	
		
		public function get isReady():Boolean
		{
			return _inputText.text!="";
		}
		
		public function setTabIndex(n:uint):void
		{
			this._tab = n;	
		}
		public function getTabIndex():uint
		{
			///los combos no tienen tabIndex, por lo q devuelve lo mismo q recibio
			return _tab;
		}
		
		public function child(name:String,type:Class):*
		{
			return _face.getChildByName(name) as type;
		}
		
		public function Combo(messageType:String,
							  face:MovieClip,							  
							itemsOrPath:*)
		{
			_face = face;
			if(child("errorClip",DisplayObject)) errorClip = new FormErrorClip(child("errorClip",DisplayObject));
			_inputText = child("inputCombo",TextField);
			_inputText.text = "";
			
			btn = GetButton.clickButton(child("btnCombo",DisplayObject),onClickOpenBtn);
			
			var messages:MessageTextForm = new MessageTextForm();
			if(!MessageTextForm.isTest) this.defaultMsg = messages.getMessajes(messageType)[0];
			else this.defaultMsg = "";
			this.errorMsg = messages.getMessajes(messageType)[1];			
			
			scroll = new ScrollView();
			scroll.autoRemoved = false;
			scroll.hasRuller = true;
			scroll.drawBack = false;
			scroll.x = child("scrollClip",ScrollAssets).x;
			scroll.y = child("scrollClip",ScrollAssets).y;
			scroll.addAssets(child("scrollClip",ScrollAssets));
			scroll.init();
			//scroll.y = _face.height;
			
			buttons = new Vector.<ItemCombo>();			
			if(itemsOrPath is ComboProvider)
			{					
				_items = itemsOrPath as ComboProvider;
				addStageListener();
			}
			else if(itemsOrPath is Array || itemsOrPath is Vector.<String>)
			{		
				_items = new ComboProvider(itemsOrPath);		
				addStageListener();
			}
			else 
			{
				_itemsPath=itemsOrPath as String;
				var loader:URLLoader = new URLLoader();
				loader.addEventListener(Event.COMPLETE,onComplete);
				loader.load(new URLRequest(_itemsPath));
			}
		}
		
		protected function onComplete(event:Event):void
		{
			var comboStr:String = event.target.data;
			var arr:Array = comboStr.split("\n");			
			
			for (var i:uint = 0;i<arr.length;i++)
			{
				var str:String = arr[i];
				var n:int = str.search("\r");
				
				if(n>1) arr[i] = str.substr(0,n);
			}	
			
			_items = new ComboProvider(arr);	
			addStageListener();			
		}
		
		private function defaultValue():void
		{
			if(MessageTextForm.isTest) _inputText.text = _items[0];			
		}
		private function addStageListener():void
		{			
			if(_face.stage)init();
			else _face.addEventListener(Event.ADDED_TO_STAGE,init);
			
			_face.addEventListener(ItemCombo.COMBO_SELECTED,onSelected);	
			_face.addEventListener(FocusEvent.FOCUS_IN,onfocusIn);			
			defaultValue();
		}
		
		private function onfocusIn(event:FocusEvent):void
		{
			onClickOpenBtn();			
		}
		
		protected function onSelected(event:Event):void
		{			
			itemSelected = event.target as ItemCombo;		
			_inputText.text = itemSelected.data.id;
			onClickOpenBtn();
			quitIndicador();
			
			dispatchEvent(new Event(Event.SELECT));
		}
		public function init(e:Event=null):void
		{
			if(e) _face.removeEventListener(Event.ADDED_TO_STAGE,init);
			page = _face.stage;			
			
			getItems();			
		}		
		protected function getItems():void
		{
			
			var container:Sprite = new Sprite();
			for each(var dataCombo:DataCombo in _items.data)
			{				
				var result:ItemCombo = new ItemCombo(_face.width);
				result.data = dataCombo;
				//result.text = str;
				result.y = container.height;
				container.addChild(result);
				buttons.push(result);
			}
			
			//scroll.addChildAt(getBack(container),0);			
			scroll.addContent(container);
			//scroll.addChildAt(scroll.dragged,3);
			//	scroll.addChild(getBack(container,true));
		}			
		
		private function getBack(container:DisplayObject,isMarco:Boolean=false):DisplayObject
		{			
			var alto:Number = (container.height > scroll.maskclip.height) ? scroll.maskclip.height:container.height;		
			var shape:Shape = new Shape();
									
			if(isMarco)
			{
				GetGraphics.drawRect(shape,_face.width+5,alto,0,0,null,false,1,1,0xcccccc);
			}
			else 
			{
				GetGraphics.drawRect(shape,_face.width+5,alto,1,0xFFFFFF,null,false,0);
			}
			
			return shape;
		}
		
		protected function onClickOpenBtn():void
		{		
			btn.unlock();
			if(!scroll.stage)
			{			
				_face.parent.addChild(_face);
				_face.addChild(scroll);
			}
			else _face.removeChild(scroll);			
		}
		private function comprobacion():Boolean
		{
			var flag:Boolean;					
			
			if(_inputText.text !== errorMsg && _inputText.text !== "" && _inputText.text!= this.defaultMsg)
			{
				flag  = true;
			}
			
			if(!flag)
			{
				putIndicador();
			//	formato.color = ERRORCOLOR;		
				_inputText.textColor = MessageTextForm.ERRORCOLOR;
				_inputText.text = errorMsg;	
			}
			else
			{
				quitIndicador();
			}			
			
			return flag;			
		}
		public function destroy():void
		{			
			_face.removeEventListener(ItemCombo.COMBO_SELECTED,onSelected);
			_face.removeEventListener(FocusEvent.FOCUS_IN,onfocusIn);
			_face = null;
			for each(var btn:ItemCombo in buttons)btn.destroy();
		}
		
		//////////////////
		
		public function addDefaultValue(str:String):void{_inputText.text = str;}
		
		public function putIndicador():void{if(errorClip)errorClip.show()};
		
		public function quitIndicador():void{if(errorClip)errorClip.hide()};
		
	}
}