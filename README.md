# QGGImagePicker

[![CocoaPods](http://img.shields.io/cocoapods/p/QGGImagePicker.svg?style=flat)](http://cocoapods.org/?q=QGGImagePicker)&nbsp; [![CocoaPods](http://img.shields.io/cocoapods/v/QGGImagePicker.svg?style=flat)](http://cocoapods.org/?q=QGGImagePicker)&nbsp; [![CocoaPods](http://img.shields.io/cocoapods/l/QGGImagePicker.svg?style=flat)](http://cocoapods.org/?q=QGGImagePicker)&nbsp; [![Support](https://img.shields.io/badge/support-iOS%207%2B%20-blue.svg?style=flat)](https://www.apple.com/nl/ios/)

##description
### 类似微信图片选择器的库

![image](https://raw.githubusercontent.com/infiniteQin/assets/master/QGGImagePicker/img.gif )

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

###Add Resource

btn\_back\_b
btn\_back
btn\_check
btn\_uncheck\_b
cell\_arrow

import "QGGImagePicker.h"

```
QGGImagePicker *imagePicker = [QGGImagePicker imagePickerWithRootView:self didFinishPick:^(NSArray<UIImage *> *images) {
		//选择图片完成
        NSLog(@"选择图片完成");
    } cancelPickBlock:^{
        NSLog(@"取消选择");
    } overMaxSelectNumBlock:^(UIViewController *currVC, NSInteger maxSelectNum) {
        NSLog(@"超出最大选择数");
    }];
imagePicker.maxSelectNum = 3; //默认1
imagePicker.maxSelectNum = 10;//默认5
[imagePicker showDefaultImageLab];
```

## Requirements
Need Masonry
## Installation

QGGImagePicker is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "QGGImagePicker"
```

## Author

taizi, changqin@ixiaopu.com

## License

QGGImagePicker is available under the MIT license. See the LICENSE file for more info.


