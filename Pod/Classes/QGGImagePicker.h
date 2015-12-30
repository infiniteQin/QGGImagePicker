//
//  QGGImagePicker.h
//  QGGDraft
//
//  Created by taizi on 15/12/24.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

typedef void (^QGGImageDidFinishPickBlock)(NSArray<UIImage*>* images);
typedef void (^QGGImageCancelPickBlock)();
typedef void (^QGGImagePickOverMaxSelectNumBlock)(UIViewController *currVC,NSInteger maxSelectNum);

@interface QGGImagePicker : NSObject

@property (nonatomic, assign) NSUInteger maxSelectNum;//默认为5
@property (nonatomic, assign) NSUInteger minSelectNum;//默认为1

/**
 *
 *  @param rootViewController    present from vc
 *  @param didPickBlock          完成选择BLOCK
 *  @param cancelPickBlock       取消选择BLOCK
 *  @param overMaxSelectNumBlock 超出选择数BLOCK
 *
 *  @return
 */
+ (instancetype)imagePickerWithRootView:(UIViewController *)rootViewController didFinishPick:(QGGImageDidFinishPickBlock)didPickBlock cancelPickBlock:(QGGImageCancelPickBlock)cancelPickBlock overMaxSelectNumBlock:(QGGImagePickOverMaxSelectNumBlock)overMaxSelectNumBlock;

/**
 *  跳转
 */
- (void)showDefaultImageLab;

@end
