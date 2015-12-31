# QGGImagePicker

[![CI Status](http://img.shields.io/travis/taizi/QGGImagePicker.svg?style=flat)](https://travis-ci.org/taizi/QGGImagePicker)
[![Version](https://img.shields.io/cocoapods/v/QGGImagePicker.svg?style=flat)](http://cocoapods.org/pods/QGGImagePicker)
[![License](https://img.shields.io/cocoapods/l/QGGImagePicker.svg?style=flat)](http://cocoapods.org/pods/QGGImagePicker)
[![Platform](https://img.shields.io/cocoapods/p/QGGImagePicker.svg?style=flat)](http://cocoapods.org/pods/QGGImagePicker)

##description
类是微信图片选择器的库

![image](https://raw.githubusercontent.com/infiniteQin/assets/master/QGGImagePicker/img.gif )

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

import "QGGImagePicker.h"

```
QGGImagePicker *imagePicker = [QGGImagePicker imagePickerWithRootView:self didFinishPick:^(NSArray<UIImage *> *images) {
		//选择图片完成
        for (UIImage *image in images) {
            [wSelf didPickImage:image];
        }
    } cancelPickBlock:^{
        NSLog(@"取消选择");
    } overMaxSelectNumBlock:^(UIViewController *currVC, NSInteger maxSelectNum) {
        NSLog(@"超出最大选择数");
    }];
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


