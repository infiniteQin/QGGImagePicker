//
//  QGGImagePickerCollectionView.h
//  QGGDraft
//
//  Created by taizi on 15/12/25.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ALAsset;
@class ALAssetsGroup;

@protocol QGGImagePickerCollectionViewDelegate <NSObject>
- (void) didSelectNumOverMaxNum:(NSInteger)maxSelectNum;
- (void) didSelectAssetsChange:(NSArray<ALAsset*>*)assets;
- (void) didSelectItemAtIndex:(NSUInteger)index assets:(NSMutableArray<ALAsset*>*)assets selectAssets:(NSMutableArray<ALAsset*>*)selectAssets;
@end

@interface QGGImagePickerCollectionView : UICollectionView
@property (nonatomic, assign) id<QGGImagePickerCollectionViewDelegate> imagePickerCollectionViewDelegate;
@property (nonatomic, weak) ALAssetsGroup *assetsGroup; //weak
@property (nonatomic, assign) NSInteger   maxSelectNum; //选中最大数 默认5
@property (nonatomic, assign) NSInteger   minSelectNum; //选中最小数 默认1
@end
