//
//  UIImage+QGGRenderedColor.m
//  QGGDraft
//
//  Created by taizi on 15/12/29.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import "UIImage+QGGRenderedColor.h"

@implementation UIImage (QGGRenderedColor)

+ (UIImage *)imageWithRenderColor:(UIColor *)color renderSize:(CGSize)size{
    
    UIImage *image = nil;
    UIGraphicsBeginImageContext(size);
    [color setFill];
    CGContextFillRect(UIGraphicsGetCurrentContext(), CGRectMake(0., 0., size.width, size.height));
    image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
