package CustomClasses
{
	
	import CustomClasses.*;
	
	import flash.display.*;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.external.ExternalInterface;
	import flash.filters.BitmapFilterQuality;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	import mx.containers.VBox;
	import mx.controls.ColorPicker;
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.events.FlexEvent;
	import mx.graphics.codec.JPEGEncoder;
	
	public class ImageProcessing1 extends VBox
	{
		private var image:SaveableImage = new SaveableImage();
		
		public function ImageProcessing1()
		{
			
			[Embed("snellen_chart.jpg")]
			var img:Class;
			image.load(img);
			this.addEventListener(FlexEvent.CREATION_COMPLETE, completeHandler);
			
		}
		
		private function completeHandler(
			event:mx.events.FlexEvent):void{
			
			this.percentWidth = 100;
			this.percentHeight = 100;
			
			var label1:Label = new Label();
			label1.text = "Original Image";
			
			this.addChild(label1);
			
			var original:Bitmap = Bitmap(image.content);
			
			original.x = 5;
			original.y = 5;
			
			original.height = 480;
			original.width = 480;
			
			
			var imageA:SaveableImage = new SaveableImage();
			imageA.addChild(original);
			this.addChild(imageA);
			
			var duplicateB:Bitmap = new Bitmap( original.bitmapData.clone());
			
			var manipulateB:Bitmap = new Bitmap( original.bitmapData.clone());
			
			
			duplicateB.x = 700;
			duplicateB.y = 20;
			
			//resizePixels(duplicateB);
			
			duplicateB.height = 480;
			duplicateB.width = 480;
			
			
			
			manipulateB.height = 480;
			manipulateB.width = 480;
			
			
			/*var blur1:BlurFilter = new BlurFilter();
			blur1.blurX = 10;
			blur1.blurY = 10;
			blur1.quality = BitmapFilterQuality.MEDIUM;
			duplicateB.filters = [blur1];*/
			
			/*var imageB:Image = new Image();
			imageB.addChild(duplicateB);
			this.addChild(imageB);*/
			
			
			// write color values to text file 
			
			
			
			var bitmapdataduplicateB:BitmapData = duplicateB.bitmapData;
			var manipulateBdata:BitmapData = manipulateB.bitmapData;
			
			var red:Number = 0;
			var green:Number = 0;
			var blue:Number = 0;
			
			var count:Number = 0;
			var pixel:Number;
			
			
			for (var x:int = 0; x < bitmapdataduplicateB.width; x = x+16)
			{
				for (var y:int = 0; y < bitmapdataduplicateB.height; y = y+16)
				{
					pixel = bitmapdataduplicateB.getPixel(x, y);
					
					red += pixel >> 16 & 0xFF;
					green += pixel >> 8 & 0xFF;
					blue += pixel & 0xFF;
					
					count++;
					
					red /= count;
					green /= count;
					blue /= count;		
					
					var replaceColor:uint = red << 16 | green << 8 | blue;
					
					manipulateBdata.setPixel(x,y, replaceColor);
					
					red = green = blue =0;
					
				}
				
			}
			
			manipulateB.smoothing = true;
			
			manipulateB.width = 30;
			manipulateB.height = 30;
			
			manipulateB.x = 700;
			manipulateB.y = 20;
			
			
			/*var imageC:Image = new Image();
			imageC.addChild(manipulateB);
			this.addChild(imageC);*/
			
			var imageD:SaveableImage = new SaveableImage();
			imageD.addChild(manipulateB);
			this.addChild(imageD);
			
			
			
			
			// save image to local disk - to check 30 X 30 image
			
			var bitmapManipulateData:BitmapData = manipulateB.bitmapData;
			
			var jpgenc:JPEGEncoder = new JPEGEncoder(80);
			var imgByteArray:ByteArray = jpgenc.encode(bitmapManipulateData);
			
			
		}
		
		
		private function resizePixels(bitmap:Bitmap):void{
			
			var bitmapdataduplicateB:BitmapData = bitmap.bitmapData;
			var red:Number = 0;
			var green:Number = 0;
			var blue:Number = 0;
			
			var count:Number = 0;
			var pixel:Number;
			
			
			// calculate average color of whole image 
			for (var x:int = 0; x < bitmapdataduplicateB.width; x = x+16)
			{
				for (var y:int = 0; y < bitmapdataduplicateB.height; y = y+16)
				{
					pixel = bitmapdataduplicateB.getPixel(x, y);
					
					red += pixel >> 16 & 0xFF;
					green += pixel >> 8 & 0xFF;
					blue += pixel & 0xFF;
					
					count++
				}
			}
			
			red /= count;
			green /= count;
			blue /= count;
			
			var replaceColor:uint = red << 16 | green << 8 | blue; 
			
			
			
			/*
			for(var i:int =0;i<bitmapdataduplicateB.width;i = i+2)
			{
			for(var j:int =0;j<bitmapdataduplicateB.height;j = j+2)
			{
			bitmapdataduplicateB.setPixel(i, j , replaceColor);
			
			}
			
			}
			*/
			
			
			
			
			/*	
			var rawbytes:ByteArray = new ByteArray();
			// browse 30 pixels, take summary and set pixel data. 
			
			rawbytes = bitmapdataduplicateB.getPixels( new Rectangle(0,0,480,480));
			
			
			//browse through and set some values for 16 bits
			var count:int = 0;
			var red:Number = 0;
			var green:Number = 0;
			var blue:Number = 0;
			
			while(count < rawbytes.length)
			{
			
			
			red << 16 | green << 8 | blue;
			count = count + 1;	
			}
			
			rawbytes.position = 0;
			bitmapdataduplicateB.setPixels(new Rectangle(
			0,0,bitmapdataduplicateB.width,bitmapdataduplicateB.height/2),
			rawbytes);*/
		}
		
		public function averageColour( source:BitmapData ):uint
		{
			var red:Number = 0;
			var green:Number = 0;
			var blue:Number = 0;
			
			var count:Number = 0;
			var pixel:Number;
			
			for (var x:int = 0; x < source.width; x++)
			{
				for (var y:int = 0; y < source.height; y++)
				{
					pixel = source.getPixel(x, y);
					
					red += pixel >> 16 & 0xFF;
					green += pixel >> 8 & 0xFF;
					blue += pixel & 0xFF;
					
					count++
				}
			}
			
			red /= count;
			green /= count;
			blue /= count;
			
			
			
			return red << 16 | green << 8 | blue;
		}
	}
	
}
