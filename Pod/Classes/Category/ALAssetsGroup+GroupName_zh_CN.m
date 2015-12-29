//
//  ALAssetsGroup+GroupName_zh_CN.m
//  QGGDraft
//
//  Created by taizi on 15/12/25.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import "ALAssetsGroup+GroupName_zh_CN.h"
#import <Photos/Photos.h>
@class PHAssetCollection;
@implementation ALAssetsGroup (GroupName_zh_CN)
- (NSString*)zh_CN_assetsGroupName {
    NSNumber* groupType = [self valueForProperty:ALAssetsGroupPropertyType];
    NSString *assetsGroupName = @"";
    switch ([groupType unsignedIntegerValue]) {
//        case ALAssetsGroupAlbum://来自我的电脑或者是在设备上创建
//        {
//            NSString* persistentID = [assetsGroup valueForProperty:ALAssetsGroupPropertyPersistentID];
//            if ([[persistentID substringWithRange:NSRangeFromString(@"0,8")] isEqualToString:@"00000000"])
//            {
//                NSLog(@"来自我的电脑");
//            }
//        }
//            break;
            
        case ALAssetsGroupSavedPhotos:
        {
            assetsGroupName = @"相机胶卷";
        }
            break;
        case ALAssetsGroupPhotoStream:
        {
           assetsGroupName = @"我的照片流";
        }
            break;
        default:
        {
             assetsGroupName = [self valueForProperty:ALAssetsGroupPropertyName];
        }
            break;
    }
    return assetsGroupName;
}
@end
