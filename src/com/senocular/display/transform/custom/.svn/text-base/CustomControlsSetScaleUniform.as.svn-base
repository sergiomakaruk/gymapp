/*
Copyright (c) 2010 Trevor McCauley

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE. 
*/
package com.senocular.display.transform.custom {
	import com.senocular.display.transform.ControlBorder;
	import com.senocular.display.transform.ControlCursor;
	import com.senocular.display.transform.ControlMove;
	import com.senocular.display.transform.ControlUVScale;
	import com.senocular.display.transform.CursorMove;
	import com.senocular.display.transform.CursorRegistration;
	import com.senocular.display.transform.CursorScale;
	
	/**
	 * This control set is a subset of ControlSetStandard that does not contain
	 * rotation controls and shows scale controls only on the corners of a
	 * target object.
	 * @author Trevor McCauley
	 */
	public dynamic class CustomControlsSetScaleUniform extends Array {
		
		/**
		 * Constructor for creating new ControlSetScaleCorners instances.
		 */
		public function CustomControlsSetScaleUniform(){
			
			var moveCursor:CustomCursorMove = new CustomCursorMove();
			var scaleCursorB:CustomCursorScale = new CustomCursorScale(ControlUVScale.BOTH, 0);
			var scaleCursorB90:CustomCursorScale = new CustomCursorScale(ControlUVScale.BOTH, 90);
			var registrationCursor:CursorRegistration = new CursorRegistration();
			
			super(
				new CustomControlBorder_PUNTEADO(),
				new ControlMove(moveCursor),
				new CustonControlUVScale(0, 0, ControlUVScale.UNIFORM, scaleCursorB),
				new CustonControlUVScale(0, 1, ControlUVScale.UNIFORM, scaleCursorB90),
				new CustonControlUVScale(1, 0, ControlUVScale.UNIFORM, scaleCursorB90),
				new CustonControlUVScale(1, 1, ControlUVScale.UNIFORM, scaleCursorB),
				null,//new ControlRegistration(registrationCursor),
				new ControlCursor()
			);
		}
	}
}