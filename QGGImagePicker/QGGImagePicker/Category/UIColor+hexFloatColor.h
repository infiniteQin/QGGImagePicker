//
//  UIColor+hexFloatColor.h
//  XiangQu
//
//  Created by yandi on 14/10/28.
//  Copyright (c) 2014年 Qiuyin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (hexFloatColor)
+ (UIColor *)hexFloatColor:(NSString *)hexStr;
+ (UIColor *)hexFloatColor:(NSString *)hexStr alpha:(CGFloat)alpha;
@end
