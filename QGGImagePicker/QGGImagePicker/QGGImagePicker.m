//
//  QGGImagePicker.m
//  QGGDraft
//
//  Created by taizi on 15/12/24.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import "QGGImagePicker.h"
#import "QGGImageGroupViewController.h"
#import "QGGImagePickerViewController.h"

@interface QGGImagePicker ()<QGGImagePickerViewControllerDelegate>

@property (nonatomic, copy)   QGGImageDidFinishPickBlock didFinishPickBlock;
@property (nonatomic, copy)   QGGImageCancelPickBlock    cancelPickBlock;
@property (nonatomic, copy)   QGGImagePickOverMaxSelectNumBlock overMaxSelectNumBlock;

@property (nonatomic, weak) UIViewController *rootViewController;

@end

@implementation QGGImagePicker

+ (instancetype)imagePickerWithRootView:(UIViewController *)rootViewController didFinishPick:(QGGImageDidFinishPickBlock)didPickBlock cancelPickBlock:(QGGImageCancelPickBlock)cancelPickBlock overMaxSelectNumBlock:(QGGImagePickOverMaxSelectNumBlock)overMaxSelectNumBlock {
    QGGImagePicker *picker = [self imagePickerWithRootView:rootViewController];
    picker.didFinishPickBlock = didPickBlock;
    picker.cancelPickBlock = cancelPickBlock;
    picker.overMaxSelectNumBlock = overMaxSelectNumBlock;
    return picker;
}

+ (instancetype)imagePickerWithRootView:(UIViewController *)rootViewController {
    QGGImagePicker *picker = [[QGGImagePicker alloc] init];
    picker.rootViewController = rootViewController;
    picker.maxSelectNum = 3;
    picker.minSelectNum = 1;
    return picker;
}

- (void)showDefaultImageLab {
    QGGImageGroupViewController *imageGroupVC = [[QGGImageGroupViewController alloc] init];
    imageGroupVC.pickerVCDelegate = self;
    imageGroupVC.maxSelectNum = self.maxSelectNum;
    imageGroupVC.minSelectNum = self.minSelectNum;
    
    QGGImagePickerViewController *imgPickerVC = [[QGGImagePickerViewController alloc] init];
    imgPickerVC.delegate = self;
    imgPickerVC.maxSelectNum = self.maxSelectNum;
    imgPickerVC.minSelectNum = self.minSelectNum;
    
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:imageGroupVC];
    [nav setViewControllers:@[imageGroupVC,imgPickerVC]];
    [self.rootViewController presentViewController:nav animated:YES completion:NULL];
}

#pragma mark QGGImagePickerViewControllerDelegate
- (void) viewController:(UIViewController *)vc didSelectNumOverMaxNum:(NSInteger)maxSelectNum {
//    NSLog(@"选中数超过最大数%ld",maxSelectNum);
    if (self.overMaxSelectNumBlock) {
        self.overMaxSelectNumBlock(vc,maxSelectNum);
    }
}

- (void)viewController:(UIViewController *)vc didFinishSelect:(NSArray<ALAsset *> *)assets {
    __weak typeof(self) wSelf = self;
    [vc dismissViewControllerAnimated:YES completion:^{
        if (wSelf.didFinishPickBlock) {
            wSelf.didFinishPickBlock(assets);
        }
    }];
}

- (void)cancelPick:(UIViewController *)vc {
    __weak typeof(self) wSelf = self;
    [vc dismissViewControllerAnimated:YES completion:^{
        if (wSelf.cancelPickBlock) {
            wSelf.cancelPickBlock();
        }
    }];
}

@end
