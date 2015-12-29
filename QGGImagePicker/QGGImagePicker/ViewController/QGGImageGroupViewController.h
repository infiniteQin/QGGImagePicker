//
//  QGGImageGroupViewController.h
//  QGGDraft
//
//  Created by taizi on 15/12/24.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QGGImagePickerViewController.h"
#import "QGGImagePickerViewControllerDelegate.h"

@interface QGGImageGroupViewController : UIViewController
@property (nonatomic, assign) NSInteger maxSelectNum;
@property (nonatomic, assign) NSInteger minSelectNum;
@property (nonatomic, strong) id<QGGImagePickerViewControllerDelegate> pickerVCDelegate;
@end
