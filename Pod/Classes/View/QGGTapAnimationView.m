//
//  QGGTapAnimationView.m
//  QGGDraft
//
//  Created by taizi on 15/12/25.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import "QGGTapAnimationView.h"

@implementation QGGTapAnimationView

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    //执行触摸动画
    [self touchAnimation:touches];
}

//触摸动作的相关过程动画
- (void)touchAnimation:(NSSet<UITouch *> *)touches {
    UITouch *touch = [touches anyObject];
    CGPoint clickPoint = [touch locationInView:self];
    
    CALayer *clickLayer = [CALayer layer];
    clickLayer.backgroundColor = [UIColor whiteColor].CGColor;
    clickLayer.masksToBounds = YES;
    clickLayer.cornerRadius = 3;
    clickLayer.frame = CGRectMake(0, 0, 6, 6);
    clickLayer.position = clickPoint;
    clickLayer.opacity = 0.3;
    clickLayer.name = @"clickLayer";
    [self.layer addSublayer:clickLayer];
    
    CABasicAnimation* zoom = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    zoom.toValue = @38.0;
    zoom.duration = .4;
    
    CABasicAnimation *fadeout = [CABasicAnimation animationWithKeyPath:@"opacity"];
    fadeout.toValue = @0.0;
    fadeout.duration = .4;
    
    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 0.4;
    [group setAnimations:@[zoom,fadeout]];
    group.delegate = self;
    group.fillMode = kCAFillModeForwards;
    group.removedOnCompletion = NO;
    [clickLayer addAnimation:group forKey:@"animationKey"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (flag) {
        for (int i = 0; i < self.layer.sublayers.count; i++) {
            CALayer *obj = self.layer.sublayers[i];
            if (obj.name != nil && [@"clickLayer" isEqualToString:obj.name] && [obj animationForKey:@"animationKey"] == anim) {
                [obj removeFromSuperlayer];
            }
        }
    }
}

@end
