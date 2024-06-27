YYImage
==============
[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://raw.githubusercontent.com/ibireme/YYImage/master/LICENSE)&nbsp;
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/v/YYImage.svg?style=flat)](http://cocoapods.org/pods/YYImage)&nbsp;
[![CocoaPods](http://img.shields.io/cocoapods/p/YYImage.svg?style=flat)](http://cocoadocs.org/docsets/YYImage)&nbsp;
[![Support](https://img.shields.io/badge/support-iOS%206%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)&nbsp;
[![Build Status](https://travis-ci.org/ibireme/YYImage.svg?branch=master)](https://travis-ci.org/ibireme/YYImage)

Image framework for iOS to display/encode/decode animated WebP, APNG, GIF, and more.<br/>
(It's a component of [YYKit](https://github.com/ibireme/YYKit))

![niconiconi~](https://raw.github.com/ibireme/YYImage/master/Demo/YYImageDemo/niconiconi@2x.gif
)

Features
==============
- Display/encode/decode animated image with these types:<br/>&nbsp;&nbsp;&nbsp;&nbsp;WebP, APNG, GIF.
- Display/encode/decode still image with these types:<br/>&nbsp;&nbsp;&nbsp;&nbsp;WebP, PNG, GIF, JPEG, JP2, TIFF, BMP, ICO, ICNS.
- Baseline/progressive/interlaced image decode with these types:<br/>&nbsp;&nbsp;&nbsp;&nbsp;PNG, GIF, JPEG, BMP.
- Display frame based image animation and sprite sheet animation.
- Dynamic memory buffer for lower memory usage.
- Fully compatible with UIImage and UIImageView class.
- Extendable protocol for custom image animation.
- Fully documented.

Usage
==============

### Display animated image
```objc
// File: ani@3x.gif
UIImage *image = [YYImage imageNamed:@"ani.gif"];
UIImageView *imageView = [[YYAnimatedImageView alloc] initWithImage:image];
[self.view addSubview:imageView];
```

### Display frame animation
```objc
// Files: frame1.png, frame2.png, frame3.png
NSArray *paths = @[@"/ani/frame1.png", @"/ani/frame2.png", @"/ani/frame3.png"];
NSArray *times = @[@0.1, @0.2, @0.1];
UIImage *image = [YYFrameImage alloc] initWithImagePaths:paths frameDurations:times repeats:YES];
UIImageView *imageView = [YYAnimatedImageView alloc] initWithImage:image];
[self.view addSubview:imageView];
```

### Display sprite sheet animation
```objc
// 8 * 12 sprites in a single sheet image
UIImage *spriteSheet = [UIImage imageNamed:@"sprite-sheet"];
NSMutableArray *contentRects = [NSMutableArray new];
NSMutableArray *durations = [NSMutableArray new];
for (int j = 0; j < 12; j++) {
   for (int i = 0; i < 8; i++) {
       CGRect rect;
       rect.size = CGSizeMake(img.size.width / 8, img.size.height / 12);
       rect.origin.x = img.size.width / 8 * i;
       rect.origin.y = img.size.height / 12 * j;
       [contentRects addObject:[NSValue valueWithCGRect:rect]];
       [durations addObject:@(1 / 60.0)];
   }
}
YYSpriteSheetImage *sprite;
sprite = [[YYSpriteSheetImage alloc] initWithSpriteSheetImage:img
                                                contentRects:contentRects
                                              frameDurations:durations
                                                   loopCount:0];
YYAnimatedImageView *imageView = [YYAnimatedImageView new];
imageView.size = CGSizeMake(img.size.width / 8, img.size.height / 12);
imageView.image = sprite;
[self.view addSubview:imageView];
```

### Animation control
```objc
YYAnimatedImageView *imageView = ...;
// pause:
[imageView stopAnimating];
// play:
[imageView startAnimating];
// set frame index:
imageView.currentAnimatedImageIndex = 12;
// get current status
image.currentIsPlayingAnimation;
```

### Image decoder
```objc
// Decode single frame:
NSData *data = [NSData dataWithContentsOfFile:@"/tmp/image.webp"];
YYImageDecoder *decoder = [YYImageDecoder decoderWithData:data scale:2.0];
UIImage image = [decoder frameAtIndex:0 decodeForDisplay:YES].image;
	
// Progressive:
NSMutableData *data = [NSMutableData new];
YYImageDecoder *decoder = [[YYImageDecoder alloc] initWithScale:2.0];
while(newDataArrived) {
   [data appendData:newData];
   [decoder updateData:data final:NO];
   if (decoder.frameCount > 0) {
       UIImage image = [decoder frameAtIndex:0 decodeForDisplay:YES].image;
       // progressive display...
   }
}
[decoder updateData:data final:YES];
UIImage image = [decoder frameAtIndex:0 decodeForDisplay:YES].image;
// final display...
```

### Image encoder
```objc
// Encode still image:
YYImageEncoder *jpegEncoder = [[YYImageEncoder alloc] initWithType:YYImageTypeJPEG];
jpegEncoder.quality = 0.9;
[jpegEncoder addImage:image duration:0];
NSData jpegData = [jpegEncoder encode];
 
// Encode animated image:
YYImageEncoder *webpEncoder = [[YYImageEncoder alloc] initWithType:YYImageTypeWebP];
webpEncoder.loopCount = 5;
[webpEncoder addImage:image0 duration:0.1];
[webpEncoder addImage:image1 duration:0.15];
[webpEncoder addImage:image2 duration:0.2];
NSData webpData = [webpEncoder encode];
```

### Image type detection
```objc
// Get image type from image data
YYImageType type = YYImageDetectType(data); 
if (type == YYImageTypePNG) ...
```
	
Installation
==============

### CocoaPods

1. Update cocoapods to the latest version.
2. Add `pod 'YYImage'` to your Podfile.
3. Run `pod install` or `pod update`.
4. Import \<YYImage/YYImage.h\>.
5. Notice: it doesn't include WebP subspec by default, if you want to support WebP format, you may add `pod 'YYImage/WebP'` to your Podfile.

### Carthage

1. Add `github "ibireme/YYImage"` to your Cartfile.
2. Run `carthage update --platform ios` and add the framework to your project.
3. Import \<YYImage/YYImage.h\>.
4. Notice: carthage framework doesn't include WebP component, if you want to support WebP format, use CocoaPods or install manually.

### Manually

1. Download all the files in the YYImage subdirectory.
2. Add the source files to your Xcode project.
3. Link with required frameworks:
	* UIKit
	* CoreFoundation
	* QuartzCore
	* ImageIO
	* Accelerate
	* CoreServices
	* libz
4. Import `YYImage.h`.
5. Notice: if you want to support WebP format, you may add `Vendor/WebP.framework`(static library) to your Xcode project.

FAQ
==============
_Q: Why I can't display WebP image?_

A: Make sure you added the `WebP.framework` in your project. You may call `YYImageWebPAvailable()` to check whether the WebP subspec is installed correctly.

_Q: Why I can't play APNG animation?_

A: You should disable the `Compress PNG Files` and `Remove Text Metadata From PNG Files` in your project's build settings. Or you can rename your APNG file's extension name with `apng`.

Documentation
==============
Full API documentation is available on [CocoaDocs](http://cocoadocs.org/docsets/YYImage/).<br/>
You can also install documentation locally using [appledoc](https://github.com/tomaz/appledoc).



Requirements
==============
This library requires `iOS 6.0+` and `Xcode 8.0+`.


License
==============
YYImage is provided under the MIT license. See LICENSE file for details.
