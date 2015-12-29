//
//  QGGImagePickerCell.h
//  QGGDraft
//
//  Created by taizi on 15/12/25.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>
@class QGGImagePickerCell;

@protocol QGGImagePickerCellDelegate <NSObject>

- (void) cell:(QGGImagePickerCell*)cell didSelectAsset:(ALAsset*)asset;
- (void) cell:(QGGImagePickerCell*)cell didUnSelectAsset:(ALAsset*)asset;

@end

@interface QGGImagePickerCell : UICollectionViewCell
@property (nonatomic, weak)   ALAsset       *asset;
@property (nonatomic, assign) BOOL          isSelected;
@property (nonatomic, assign) id<QGGImagePickerCellDelegate> delegate;
@end
