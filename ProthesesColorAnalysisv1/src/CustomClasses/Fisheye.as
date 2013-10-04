


/////////////////////////////////////////////////////
//  slicer
//	author 	   : frank reitberger
//	site 	   : http://www.prinzipiell.com
//	blog 	   : http://www.prinzipiell.com
//  copyright 2008
/////////////////////////////////////////////////////



package {
	
	// --------------------------------------------------------------------------------------------------
	
	///////////////////////////////////
	// import used classes
	///////////////////////////////////

	import flash.display.*;
	
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.ColorTransform;
	
	import flash.utils.*;
	import flash.events.*;
	import flash.filters.*;
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;		
	
	
	// --------------------------------------------------------------------------------------------------
	
	///////////////////////////////////
	// class
	///////////////////////////////////

	public class Fisheye{
		
		[Embed(source = "../library/verdana.ttf", fontFamily = "verdana", fontName = 'verdana', unicodeRange='U+0020-U+007E')] public var defaultTxt:String;		
		[Embed(source = "../shader/fisheye.pbj", mimeType = 'application/octet-stream')] private static const fisheye: Class;
		[Embed(source = "../library/pwd.jpg")] private var img:Class;
		
		
		private var container		  :DisplayObjectContainer;
		private var rootNode          :Sprite;
		private var origin			  :BitmapData;
		private var canvas		      :Bitmap;
		
		private var txt				  :TextField;
		private var txtDescription    :TextField;
		private var format			  :TextFormat;
		private var fs				  :int;
		private var ms				  :int;
		private var matrx			  :Matrix;
		
		private var shaderFilter	  :ShaderFilter; 
		private var fisheyeShader 	  :Shader         = new Shader( new fisheye() );
		
		private var vx				  :Number;
		private var vy			  	  :Number;
		


		private const erase			  :uint		      = 0x00FFFFFF;
		
		
		// --------------------------------------------------------------------------------------------------
		
		///////////////////////////////////
		// class constructor
		///////////////////////////////////	
		
 		public function Fisheye():void {
		
		}	
		
		
		// --------------------------------------------------------------------------------------------------
		
		///////////////////////////////////
		// launch
		///////////////////////////////////	
		
		public function launch( container:DisplayObjectContainer ):void {

			this.container 	  		 = container;
			this.canvas   			 = new img();
			
			this.vx					 = this.canvas.width  / 2;
			this.vy					 = this.canvas.height / 2;
			
			this.origin    			 = new BitmapData( this.canvas.width, this.canvas.height, true, this.erase );
			
			background();
			
			this.container.addChild( new Bitmap( this.origin ) );

			setupFilter();
			init();
			
		}
		
		// --------------------------------------------------------------------------------------------------
		
		///////////////////////////////////
		// setup: background
		//////////////////////////////////
		
		private function background():void {
			
			var overlay :Shape  = new Shape();
			
			var res		:uint	= 2;
			
			var colors  :Array  = [ 0x000033,0xCCCCCC ];
			var ratios  :Array  = new Array( 0, 255 );
			var alphas  :Array  = new Array( 1,1 );
		
			var mat     :Matrix = new Matrix();
			mat.createGradientBox( this.canvas.width, this.canvas.height);
			mat.tx = this.canvas.width / 2;
			mat.ty = this.canvas.height / 2.5;
			mat.rotate( Math.PI / 2 );
		
			overlay.graphics.beginGradientFill("linear", colors, alphas, ratios,mat);
			overlay.graphics.drawRect(0, 0, this.canvas.width, this.canvas.height);
			overlay.graphics.endFill();			
			
			this.container.addChild( overlay );
			
			
			
		}
		
		
		// --------------------------------------------------------------------------------------------------
		
		///////////////////////////////////
		// setup: filter(s)
		///////////////////////////////////	
		
		private function setupFilter():void {
			
			this.shaderFilter 		 = new ShaderFilter();  
			
			this.fisheyeShader.data.radius.value     = [ 400 ];	
			this.shaderFilter.shader = this.fisheyeShader;			

			this.origin.draw( this.canvas );
			this.origin.applyFilter( this.origin, this.origin.rect, new Point, this.shaderFilter );		

		}		
	
	
		// --------------------------------------------------------------------------------------------------
		
		///////////////////////////////////
		// initialize
		///////////////////////////////////		
		
		private function init():void {
			
			drawTxt();

		    this.container.addEventListener( Event.ENTER_FRAME, paint );
		
		}

		
		// --------------------------------------------------------------------------------------------------
		
		///////////////////////////////////
		// draw txt
		///////////////////////////////////	
		
		private function drawTxt():void {
			
			this.format			 	     = new TextFormat();
			format.font                  = "verdana";
			format.color 			     = 0xFFFFFF;
			format.size 			     = 10;	
			
			this.txt           		     = new TextField();
			this.txt.selectable 	     = false;
			this.txt.multiline 		     = false;
			this.txt.defaultTextFormat   = this.format;
			
			this.txt.x				     = 0;
			this.txt.y				     = 0;
			
			this.txt.filters		     = [ new GlowFilter( 0x000000, .8, 2, 2, 10, 2, false, false ) ];				
			
			this.txtDescription                   = new TextField();
			this.txtDescription.selectable        = false;
			this.txtDescription.multiline         = true;
			this.txtDescription.autoSize          = TextFieldAutoSize.LEFT;
			this.txtDescription.defaultTextFormat = this.format;
			this.txtDescription.text              = "Fisheye                                                       ...move your mouse.";
			
			this.txtDescription.x		   		  = 0;
			this.txtDescription.y		   		  = 480;

			this.txtDescription.filters	   		  = [ new GlowFilter( 0x000000, .8, 2, 2, 10, 2, false, false ) ];				

			this.container.addChild( this.txt );
			this.container.addChild( this.txtDescription );
		
		}
		
		
		// --------------------------------------------------------------------------------------------------
		
		///////////////////////////////////
		// paint
		///////////////////////////////////	
		
		private function paint( event:Event ):void {
			
			this.origin.lock();
			
			this.origin.draw( this.canvas );
			
			
			this.vx = this.container.mouseX;
			this.vy = this.container.mouseY;
			
			this.fisheyeShader.data.center_x.value   = [ this.vx ];
			this.fisheyeShader.data.center_y.value   = [ this.vy ];	
			
			this.origin.applyFilter( this.origin, this.origin.rect, new Point, this.shaderFilter );	
			this.origin.unlock();
			
	
			cntFPS();
		
		}		
		

		// --------------------------------------------------------------------------------------------------
		
		///////////////////////////////////
		// fps
		///////////////////////////////////			
		
		public function cntFPS():void {
			
			if ( getTimer() - 1000 > this.ms ) {
				 
				 this.ms 	    = getTimer();
				 this.txt.text  = this.fs.toString() + " FPS";
				 this.fs 	    = 0;
			
			} else {

				++this.fs;
			
			}
			
		}	
		

	}
	
}