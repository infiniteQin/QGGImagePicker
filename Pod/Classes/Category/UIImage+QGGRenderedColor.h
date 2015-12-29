//
//  UIImage+QGGRenderedColor.h
//  QGGDraft
//
//  Created by taizi on 15/12/29.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QGGRenderedColor)
+ (UIImage *)imageWithRenderColor:(UIColor *)color renderSize:(CGSize)size;
@end
