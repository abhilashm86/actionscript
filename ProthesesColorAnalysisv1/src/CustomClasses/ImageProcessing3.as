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
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	import mx.collections.ArrayCollection;
	import mx.collections.ArrayList;
	import mx.containers.VBox;
	import mx.controls.ColorPicker;
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.events.FlexEvent;
	import mx.graphics.codec.JPEGEncoder;
	
	public class ImageProcessing extends VBox
	{
		private var image:SaveableImage = new SaveableImage();
		
		public function ImageProcessing()
		{
			// include image here
			[Embed("snellen_chart.jpg")]
			var img:Class;
			image.load(img);
			this.addEventListener(FlexEvent.CREATION_COMPLETE, completeHandler);
			
		}
		
		private function completeHandler(
			event:mx.events.FlexEvent):void{
			
			
			var label1:Label = new Label();
			label1.text = "Original Image";
			
			this.addChild(label1);
			
			//to convert image to greyscale
			var matrix:Array = [0.3, 0.59, 0.11, 0, 0,
				0.3, 0.59, 0.11, 0, 0,
				0.3, 0.59, 0.11, 0, 0,
				0, 0, 0, 1, 0];
			
			var grayscaleFilter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			
			image.content.filters = [grayscaleFilter];
			var original:Bitmap = Bitmap(image.content);
			
			// set position here
			original.x = 5;
			original.y = 5;
			
			original.height = 480;
			original.width = 480;
			
			
			var imageA:SaveableImage = new SaveableImage();
			imageA.addChild(original);
			this.addChild(imageA);
			
			
			// used for pixel level manipulations in future 
			var duplicateB:Bitmap = new Bitmap( original.bitmapData.clone());
			var manipulateB:Bitmap = new Bitmap(original.bitmapData.clone());
			
			
			
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
			
			
			
			// write color values to text file 
			
			
			// extract the bitmap data
			var bitmapdataduplicateB:BitmapData = duplicateB.bitmapData;
			
			var manipulateBdata:BitmapData = manipulateB.bitmapData;
			
			
			var red:Number = 0;
			var green:Number = 0;
			var blue:Number = 0;
			
			var count:Number = 0;
			var pixel:Number;
			
			var printColors:Array = new Array();
			
			
			
			
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
					
					red = green = blue = 0;
					
				}
				
			}
			
			var bitmap3030:Bitmap = new Bitmap(manipulateBdata,"auto"  , false);
			
			// reduce it to 30 X 30 pixels 
			bitmap3030.width = 30;
			bitmap3030.height = 30;
			
			bitmap3030.x = 600;
			bitmap3030.y = 6;
			
			// show 30 X 30 image
			var imageD:SaveableImage = new SaveableImage();
			imageD.addChild(bitmap3030);
			this.addChild(imageD);
			
			
			// save image to local disk - to check 30 X 30 image
			
			/*	var bitmapManipulateData:BitmapData = manipulateB.bitmapData;
			
			var jpgenc:JPEGEncoder = new JPEGEncoder(80);
			var imgByteArray:ByteArray = jpgenc.encode(bitmapManipulateData);
			*/
			
			
			// copy from 30 X 30 image to 210 spaced between 7 pixels
			
			var bmp1:BitmapData = new BitmapData(210, 210, false, 0XFFFFFF);
			
			// paint black
			for(var i:int =0; i<bmp1.width; i= i+1)
			{
				for(var j:int = 0; j<bmp1.height; j= j+1)
				{
					// check multiples of 7
					if((i%7) !=0)
					{
						bmp1.setPixel(i, j, 0Xffffff);	
					}
				}
			}
			//copy image 30 X 30 to new 210 X 210 image
			
			manipulateB.width = 210;
			manipulateB.height = 210;
			
			var a:int = 7;
			var b:int = 7;
			
			var pixelArray:Array = new Array();
			
			for(var h:int =1; h< manipulateBdata.width; h= h+1)
			{
				for(var k:int = 1; k<manipulateBdata.height; k= k+1)
				{
					//store pixel values in array 
					pixelArray.push(manipulateBdata.getPixel(h,k));
					
				}
			}
			
			// write the pixel values to 210 X 210 image
			// reverse array to get elements first
			//pixelArray.reverse();
			
			for(var ii:int =7; ii<bmp1.width; ii= ii+7)
			{
				for(var jj:int = 7; jj<bmp1.height; jj= jj+7)
				{
					bmp1.setPixel(ii,jj,pixelArray.pop());
					
				}
			}
			
			var bmp210:Bitmap = new Bitmap(bmp1);
			
			bmp210.x = 600;
			bmp210.y = 400;
			
			var imageE:SaveableImage = new SaveableImage();
			imageE.addChild(bmp210);
			this.addChild(imageE);
			
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
