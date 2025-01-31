//
//  02. Resizing Images to Fit the Screen using GeometryReader.swift
//  08_MoonShot
//
//  Created by Austin Roach on 2/12/21.
//

import Foundation

//02. Resizing Images to Fit the Screen Using GeometryReader

//When we create an Image view in SwiftUI, it will automatically size itself according to the dimensions of its contents. So, if the picture is 1000x500, the Image view will also be 1000x5000. This is sometimes what you want, but mostly you'll want to show how we can make an image fit the width of the user's screen using a new view type called GeometryReader.

//First, add some sort of image to your project. It doesn't matter what it is, as long as it's wider than the screen. I called min "Example", but obviously you should substitute your image name in the code below.

//Now, let's draw that image on the screen:

/*
 struct ContentView: View {
    var body: some View {
        VStack {
            Image("Example")
        }
    }
 }
 */

//Even in the preview you can see that's way too big for the available space. Images have the same frame() modifier as other views, so you might try to scale it down like this:

/*
 Image("Example")
    .frame(width: 300, height: 300)
 */

//However, that won't work - your image will still appear to be its full size. If you wna to know why, take a close look at the preview window: you'll see your image is full size, but there's now a blue box that's 300x300, sat in the middle. The image view's frame has been set correctly, but the content of the image is still shown as its original size.

//Try changing the image to this:

/*
 Image("Example")
    .frame(width:300, height: 300)
    .clipped()
 */

//Now you'll see things more clearly: our image view is indeed 300x300, but that's not really what we wanted. If you wanted the image contents to be resized too, we need to use the resizable() modifier like this:

/*
 Image("Example")
    .resizable()
    .frame(width: 300, height: 300)
 */

//That's better, but only just. Yes, the image is now being resized correctly, but it's probably looking squashed. My image was not square, so it looks distorted now that it's been resized into a square shape.

//To fix this we need to ask the image to resize itself properly, which can be done using the aspectRatio() modifier. This lets us provide an exact aspect ratio and how it should be applied, but if we skip the aspect ratio itself SwiftUI will automatically use the original aspect ratio.

//When it comes to the "how should it be applied" part, SwiftUI calls this the content mode and gives us two options: .fit means the entire image will fit inside the container even if that means leaving some parts of the view empty, and .fill means the view will have no empty parts even if that means some of our image lies outside the container.

//Try them both to see the difference for youself. Here is .fit mode applied:

/*Image("Example")
    .resizable()
    .aspectRatio(contentMode: .fit)
    .frame(width: 300, height: 300)
 */

//And here is .fill mode applied:
/*
 Image("Example")
    .resizable()
    .aspectRatio(contentMode: .fill)
    .frame(width: 300, height: 300)
 */

//All this works great if we want fixed-sized images, but very often you want images that automatically scale up to fill the screen in one or both dimensions. That is, rather than hard-coding a width of 300, what you really want to say is "make this image fill the width of the screen."

//SwiftUI gives us a dedicated tpe for this called GeometryReader, and it's remarkeably powerful. Yes, I know lots of SwiftUI is powerful, but honestly: what you can do with GeometryReader will blow you away.

//We'll go into much more detail on GeometryReader in project 15, but for now we're going to use it for one job: to make sure our image fills the full width of its container view.

//GeometryReader is a view just like the others we've used, except when we create it we'll we'll be handed a GeometryProxy object to use. This lets us query the environment: how big is the container? What position is our view? Are there any safe area insets? And so one.

//We can use this geometry proxy to set the width of our image, like this:

/*
 VStack {
    GeometryReader { geo in
        Image("Example")
            .resizabe()
            .aspectRatio(contentMode: .fit)
            .frame(width: geo.size.width, height: 300)
    }
 }
 */

//And now the image will fill the width of our screen regardless of what device we use.

//For our final trick, let's remove the height from the image, like this:

/*
 VStack {
    GeometryReader { geo in
        Image("Example")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: geo.size.width)
    }
 }
 */

//We've given SwiftUi enough information that is can automatically figure our the height: it knows te original width, it knows our target width, and it knows our content mode, so it understand how the target height of the image will b e proportional to the target width. 
