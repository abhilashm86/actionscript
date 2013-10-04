/*Bitmap06
This is an update to Bitmap05 that uses an image that is 
embedded in the SWF file rather than a separate 
downloaded image file. This eliminates the requirement
to make the following change to the configuration file
at:

C:\Program Files\Adobe\Flex Builder 3\sdks\3.2.0\
frameworks\flex-config.xml

<!-- Prevents SWFs from accessing the network. -->
<use-network>false</use-network>

The behavior of this program is identical to the
behavior of Bitmap05.
*********************************************************/
package CustomClasses{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	
	import mx.containers.VBox;
	import mx.controls.Image;
	import mx.controls.Label;
	import mx.core.Container;
	import mx.events.FlexEvent;
	
	import spark.components.BorderContainer;

	//====================================================//
	
	public class Driver extends VBox {
		private var image:Image = new Image();
		
		public function Driver(){//constructor
			//Make the VBox visible.
			setStyle("backgroundColor",0xFFFF00);
			setStyle("backgroundAlpha",1.0);
			
			[Embed("shape.jpg")]
			var img:Class;
			image.load(img);
			
			//Note that the type of completion event specified
			// here is different from the type of completion
			// event used in Bitmap05.
			this.addEventListener(FlexEvent.CREATION_COMPLETE,
				completeHandler);
		} //end constructor
		//--------------------------------------------------//
		
		//This handler method is executed when the VBox has
		// been fully created. Note that the type of the
		// incoming parameter is more specific than was the
		// case in Bitmap05. However, it isn't used in this
		// program.
		private function completeHandler(
			event:mx.events.FlexEvent):void{
			//Get and save a reference to a Bitmap object
			// containing the content of the image file. This
			// statement is different from Bitmap05.
			var original:Bitmap = Bitmap(image.content);
			
			//Everything beyond this point is identical to
			// Bitmap05 except that the IO error handler was
			// removed. It isn't needed for an embedded image
			// file.
			
			//Set the width and height of the VBox object based
			// on the size of the original bitmap.
			this.width = original.width + 10;
			this.height = 3*original.height + 12;
			
			//Encapsulate the bitmap in an Image object and add
			// the Image object to the VBox. Display it at
			// x=5 and y=0
			original.x = 5;
			original.y = 0;
			var imageA:Image = new Image();
			imageA.addChild(original);
			this.addChild(imageA);
			
			//Clone the original bitmap to create a duplicate.
			var duplicateB:Bitmap = new Bitmap(
				original.bitmapData.clone());
			//Place the duplicate bitmap below the original in
			// the VBox. There is a six-pixel downward shift
			// that I am unable to explain at this time. The
			// shift produces a gap of about six pixels between
			// the two images.
			duplicateB.x = 300;
			duplicateB.y = 20;
			
			var imageB:Image = new Image();
			imageB.addChild(duplicateB);
			this.addChild(imageB);
			
			//Modify this duplicate.
			modify(duplicateB);
			
			//Clone the original bitmap to create another
			// duplicate.
			var duplicateC:Bitmap = new Bitmap(
				original.bitmapData.clone());
			//Place the duplicateC below the other two in the
			// VBox.
			duplicateC.x = 700;
			duplicateC.y = 20;
			
			// added by abhilash
			
			var l1:Label = new Label();
			l1.text = "Original Image";
			l1.x = 0;
			l1.y= 5; 
			this.addChild(l1);
			
			var imageC:Image = new Image();
			imageC.addChild(duplicateC);
			this.addChild(imageC);
			
			//Modify the pixels as above to add some color to
			// the image.
			modify(duplicateC);
			//Now invert the colors in the top half of this
			// bitmap. Note that the magenta and green colors
			// swap positions.
			invert(duplicateC);
			
		} //end completeHandler
		//--------------------------------------------------//
		
		//This method modifies the pixels in the incoming
		// bitmap in a variety of ways.
		private function modify(bitmap:Bitmap):void{
			//Get the BitmapData object from the incoming
			// Bitmap object.
			var bitmapData:BitmapData = bitmap.bitmapData;
			
			//Process pixels using the getPixels and
			// setPixels methods.
			
			//Get a rectangular array of pixels comprising
			// 50 columns by 8 rows in a one-dimensional
			// array of bytes. The bytes are ordered in the
			// array as row 0, row 1, etc.  Each pixel is
			// represented by four consecutive bytes in ARGB
			// order.
			var rawBytes:ByteArray = new ByteArray();
			rawBytes = bitmapData.getPixels(
				new Rectangle(10,10,50,8));
			
			//Set the colors of the top four rows to magenta
			// and the color of the bottom four rows to
			// green. Don't modify alpha.
			var cnt:uint = 1;
			while(cnt < rawBytes.length){
				if(cnt < rawBytes.length/2){
					rawBytes[cnt] = 255;
					rawBytes[cnt + 1] = 0;
					rawBytes[cnt + 2] = 255;
				}else{
					rawBytes[cnt] = 0;
					rawBytes[cnt + 1] = 255;
					rawBytes[cnt + 2] = 0;
				} //end if-else
				
				cnt += 4;//Increment the counter by 4.
			}//end while loop
			
			//Put the modified pixels back in the bitmapData
			// object.
			rawBytes.position = 0;//this is critical
			bitmapData.setPixels(
				new Rectangle(10,10,50,8),rawBytes);
			
			
			//Process pixels using the setPixel32 method.
			
			//Put a magenta border on the left edge and a
			// cyan border on the right edge. Note that the
			// byte values in the 32-bit pixel are in ARGB order
			// and the border thickness is two pixels.
			for(var row:uint = 0;row < bitmapData.height;
				row++){
				bitmapData.setPixel32(0,row,0xFFFF00FF);
				bitmapData.setPixel32(1,row,0xFFFF00FF);
				bitmapData.setPixel32(bitmapData.width - 1,
					row,0xFF00FFFF);
				bitmapData.setPixel32(bitmapData.width - 2,
					row,0xFF00FFFF);
			}//end for loop
			
			//Put a cyan border along the top edge and a
			// magenta border along the bottom edge.
			for(var col:uint = 0;col < bitmapData.width;
				col++){
				bitmapData.setPixel32(col,0,0xFF00FFFF);
				bitmapData.setPixel32(col,1,0xFF00FFFF);
				bitmapData.setPixel32(col,bitmapData.height - 1,
					0xFFFF00FF);
				bitmapData.setPixel32(col,bitmapData.height - 2,
					0xFFFF00FF);
				
			} //End for loop
			
		} //end modify method
		//--------------------------------------------------//
		
		//This method inverts all of the pixels in the top
		// half of the incoming bitmap.
		private function invert(bitmap:Bitmap):void{
			//Get the BitmapData object.
			var bitmapData:BitmapData = bitmap.bitmapData;
			
			//Get a one-dimensional byte array of pixel data
			// from the top half of the bitmapData object
			var rawBytes:ByteArray = new ByteArray();
			rawBytes = bitmapData.getPixels(new Rectangle(
				0,0,bitmapData.width,bitmapData.height/2));
			
			//Invert the colors by subtracting each color
			// component value from 255.
			var cnt:uint = 1;
			while(cnt < rawBytes.length){
				rawBytes[cnt] = 255 - rawBytes[cnt];
				rawBytes[cnt + 1] = 255 - rawBytes[cnt + 1];
				rawBytes[cnt + 2] = 255 - rawBytes[cnt + 2];
				
				cnt += 4;//increment the counter
			}//end while loop
			
			//Put the modified pixels back in the bitmapData
			// object.
			rawBytes.position = 0;//this is critical
			bitmapData.setPixels(new Rectangle(
				0,0,bitmapData.width,bitmapData.height/2),
				rawBytes);
			
		} //end invert method
		//--------------------------------------------------//
		
	} //end class
} //end package