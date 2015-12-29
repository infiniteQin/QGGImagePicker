//
//  QGGImagePickerViewController.h
//  QGGDraft
//
//  Created by taizi on 15/12/24.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QGGImagePickerViewControllerDelegate.h"

@class ALAssetsGroup;
@class ALAssetsFilter;


@interface QGGImagePickerViewController : UIViewController
@property (nonatomic, assign) NSInteger maxSelectNum;
@property (nonatomic, assign) NSInteger minSelectNum;
@property (nonatomic, strong) ALAssetsGroup  *assetsGroup;
@property (nonatomic, weak)   ALAssetsFilter *assetsFilter;
@property (nonatomic, strong) id<QGGImagePickerViewControllerDelegate> delegate;
@end
