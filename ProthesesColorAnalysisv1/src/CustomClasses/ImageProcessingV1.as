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
	
	public class ImageProcessingV1 extends VBox
	{
		private var image:SaveableImage = new SaveableImage();
		
		public function ImageProcessingV1()
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
			
			
			var red:Number = 0;
			var green:Number = 0;
			var blue:Number = 0;
			
			var count:Number = 0;
			var pixel:Number;
			
			var printColors:Array = new Array();
			
			//new bitmap for 30 X 30
			
			var bitmap30X30:BitmapData = new BitmapData(30, 30, false, 0X000000);
			
			for (var x:int = 0; x < original.bitmapData.width; x = x+16)
			{
				for (var y:int = 0; y < original.bitmapData.height; y = y+16)
				{
					/*for(var i1:int = x; i1<=15; i1++)
					{
					for(var j:int = y; j<=15; j++)
					{
					pixel = original.bitmapData.getPixel(i1, j);
					red += pixel >> 16 & 0xFF;
					green += pixel >> 8 & 0xFF;
					blue += pixel & 0xFF;
					count++;
					}
					}
					red = green = blue = 0;
					count = 1;*/
					
					var replaceColor:uint = red << 16 | green << 8 | blue;
					bitmap30X30.setPixel(x/16,y/16, original.bitmapData.getPixel(x,y));
					
					
					
				}
				
			}
			
			
			/*
			var bitmap30X30Display:Bitmap = new Bitmap(bitmap30X30,"auto",true);
			
			bitmap30X30Display.x = 500;
			bitmap30X30Display.y = 50;
			var imageF:SaveableImage = new SaveableImage();
			imageF.addChild(bitmap30X30Display);
			
			this.addChild(imageF);
			*/
			
			
			
			//copy image 30 X 30 to new 210 X 210 image
			
			var bitmap210X210:BitmapData = new BitmapData(210, 210, false, 0X000000);
			
			
			var pixelArray:Array = new Array();
			
			for(var h:int =0; h< bitmap30X30.width; h= h+1)
			{
				for(var k:int = 0; k<bitmap30X30.height; k= k+1)
				{
					//store pixel values in array 
					pixelArray.push(bitmap30X30.getPixel(h,k));
					
				}
			}
			
			// write the pixel values to 210 X 210 image
			// reverse array to get elements first
			pixelArray.reverse();
			
			for(var ii:int =0; ii<bitmap210X210.width; ii= ii+7)
			{
				for(var jj:int = 0; jj<bitmap210X210.height; jj= jj+7)
				{
					//to get 30 X 30 pixels
					bitmap210X210.setPixel(ii,jj,pixelArray.pop());
					
				}
			} 
			
			
			
			
			/*
			var rand:int = new int();
			var maxNum:int = 4;
			var minNum:int = 1;
			
			// defnition for distortion movement 
			var randParameter:int = 2;
			
			for(var i:int =0; i< bitmap210X210.width; i= i+1)
			{
			for(var j:int = 0; j<bitmap210X210.height; j= j+1)
			{
			rand = Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum;
			
			// check multiples of 7
			if((i%7) !=0)
			{
			if(rand == 1)  
			{
			bitmap210X210.setPixel(i + randParameter , j , bitmap210X210.getPixel(i, j));
			bitmap210X210.setPixel(i,j, 0X000000);
			}
			if(rand == 2)
			{
			bitmap210X210.setPixel(i , j + randParameter , bitmap210X210.getPixel(i, j));
			bitmap210X210.setPixel(i,j, 0X000000);
			}
			if(rand == 3)
			{
			bitmap210X210.setPixel(i - randParameter , j , bitmap210X210.getPixel(i, j));
			bitmap210X210.setPixel(i,j, 0X000000);
			}
			if(rand == 4)
			{
			bitmap210X210.setPixel(i, j - randParameter, bitmap210X210.getPixel(i, j));
			bitmap210X210.setPixel(i,j, 0X000000);
			
			}
			}
			}
			}*/
			
			var bmp210:Bitmap = new Bitmap(bitmap210X210);
			bmp210.x = 600;
			bmp210.y = 20;
			
			bmp210.width = 480;
			bmp210.height = 480;
			
			bmp210.rotationX= 10;
			bmp210.rotationY= -10;
 			
			/* 	
			// Gaussian blur
			var blur1:BlurFilter = new BlurFilter();
			blur1.blurX = 2;
			blur1.blurY = 2;
			blur1.quality = BitmapFilterQuality.MEDIUM;
			bmp210.filters = [blur1];*/
			
			
			
			var imageE:SaveableImage = new SaveableImage();
			imageE.addChild(bmp210);
			this.addChild(imageE);
			
		}
		
		
	}
	
}