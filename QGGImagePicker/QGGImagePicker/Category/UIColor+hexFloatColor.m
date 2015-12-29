//
//  UIColor+hexFloatColor.m
//  XiangQu
//
//  Created by yandi on 14/10/28.
//  Copyright (c) 2014年 Qiuyin. All rights reserved.
//

#import "UIColor+hexFloatColor.h"

@implementation UIColor (hexFloatColor)
+ (UIColor *)hexFloatColor:(NSString *)hexStr {
    return [self hexFloatColor:hexStr alpha:1.];
}

+ (UIColor *)hexFloatColor:(NSString *)hexStr alpha:(CGFloat)alpha{
    if (hexStr.length < 6)
        return nil;
    
    unsigned int red_, green_, blue_;
    NSRange exceptionRange;
    exceptionRange.length = 2;
    
    //red
    exceptionRange.location = 0;
    [[NSScanner scannerWithString:[hexStr substringWithRange:exceptionRange]]scanHexInt:&red_];
    
    //green
    exceptionRange.location = 2;
    [[NSScanner scannerWithString:[hexStr substringWithRange:exceptionRange]]scanHexInt:&green_];
    
    //blue
    exceptionRange.location = 4;
    [[NSScanner scannerWithString:[hexStr substringWithRange:exceptionRange]]scanHexInt:&blue_];
    
    UIColor *resultColor = [UIColor colorWithRed:red_/255.0 green:green_/255.0 blue:blue_/255.0 alpha:alpha];
    return resultColor;
}
@end
