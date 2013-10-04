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
			
			//to convert image to greyscale
			var matrix:Array = [0.3, 0.59, 0.11, 0, 0,
				0.3, 0.59, 0.11, 0, 0,
				0.3, 0.59, 0.11, 0, 0,
				0, 0, 0, 1, 0];
			
			
			var grayscaleFilter:ColorMatrixFilter = new ColorMatrixFilter(matrix);
			
			image.content.filters = [grayscaleFilter];
			var original:Bitmap = Bitmap(image.content);
			
			
			original.height = 480;
			original.width = 480;
			
			
			var red:Number = 0;
			var green:Number = 0;
			var blue:Number = 0;
			
			var count:Number = 0;
			var pixel:Number;
			
			var printColors:Array = new Array();
			
			
			
			for (var x:int = 0; x < original.bitmapData.width; x = x+16)
			{
				for (var y:int = 0; y < original.bitmapData.height; y = y+16)
				{
					pixel = original.bitmapData.getPixel(x, y);
					
					red += pixel >> 16 & 0xFF;
					green += pixel >> 8 & 0xFF;
					blue += pixel & 0xFF;
					
					count++;
					
					red /= count;
					green /= count;
					blue /= count;		
					
					var replaceColor:uint = red << 16 | green << 8 | blue;
					
					original.bitmapData.setPixel(x,y, replaceColor);
					
					red = green = blue = 0;
					
				}
				
			}
			
			
			
			
			var rand:int = new int();
			var maxNum:int = 4;
			var minNum:int = 1;
			
			// defnition for distortion movement 
			var randParameter:int = 2;
			
			for(var i:int =0; i< original.bitmapData.width; i= i+1)
			{
				for(var j:int = 0; j<original.bitmapData.height; j= j+1)
				{
					rand = Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum;
					
					// check multiples of 7
					//if((i%7) !=0)
					//{
					if(rand == 1)  
					{
						original.bitmapData.setPixel(i + randParameter , j , 0X000000);
					}
					if(rand == 2)
					{
						original.bitmapData.setPixel(i , j + randParameter , 0X000000);
					}
					if(rand == 3)
					{
						original.bitmapData.setPixel(i + randParameter , j + randParameter , 0X000000);
					}
					if(rand == 4)
					{
						original.bitmapData.setPixel(i - randParameter , j - randParameter, 0X000000);
					}
					//}
				}
			}
			//copy image 30 X 30 to new 210 X 210 image
			
			
			var pixelArray:Array = new Array();
			
			for(var h:int =1; h< original.bitmapData.width; h= h+1)
			{
				for(var k:int = 1; k<original.bitmapData.height; k= k+1)
				{
					//store pixel values in array 
					pixelArray.push(original.bitmapData.getPixel(h,k));
					
				}
			}
			
			// write the pixel values to 210 X 210 image
			// reverse array to get elements first
			pixelArray.reverse();
			
			for(var ii:int =7; ii<original.bitmapData.width; ii= ii+7)
			{
				for(var jj:int = 7; jj<original.bitmapData.height; jj= jj+7)
				{
					original.bitmapData.setPixel(ii,jj,pixelArray.pop());
					
				}
			} 
			
			
			var bmp210:Bitmap = new Bitmap(original.bitmapData);
			bmp210.x = 600;
			bmp210.y = 20;
			
			bmp210.width = 210;
			bmp210.height = 210;
			
			
			
			
			// Gaussian blur
			var blur1:BlurFilter = new BlurFilter();
			blur1.blurX = 3;
			blur1.blurY = 3;
			blur1.quality = BitmapFilterQuality.HIGH;
			bmp210.filters = [blur1];
			
			
			
			var imageE:SaveableImage = new SaveableImage();
			imageE.addChild(bmp210);
			this.addChild(imageE);
			
		}
		
		
	}
	
}