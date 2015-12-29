//
//  QGGImagePickerViewControllerDelegate.h
//  QGGDraft
//
//  Created by taizi on 15/12/29.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ALAsset;
@protocol QGGImagePickerViewControllerDelegate <NSObject>
- (void) viewController:(UIViewController*)vc didSelectNumOverMaxNum:(NSInteger)maxSelectNum;
- (void) viewController:(UIViewController*)vc didFinishSelect:(NSArray<ALAsset*>*)assets;
- (void) cancelPick:(UIViewController*)vc;
@end
