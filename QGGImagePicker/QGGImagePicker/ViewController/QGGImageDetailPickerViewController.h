//
//  QGGImageDetailPickerViewController.h
//  QGGDraft
//
//  Created by taizi on 15/12/28.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "QGGImagePickerViewControllerDelegate.h"

@interface QGGImageDetailPickerViewController : UIViewController
@property (nonatomic, strong) NSMutableArray<ALAsset*> *assets;
@property (nonatomic, weak) NSMutableArray<ALAsset*> *selectedAssets;
@property (nonatomic, assign) NSInteger currIndex;
@property (nonatomic, assign) id<QGGImagePickerViewControllerDelegate> delegate;
@end
