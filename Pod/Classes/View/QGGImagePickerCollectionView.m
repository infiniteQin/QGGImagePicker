//
//  QGGImagePickerCollectionView.m
//  QGGDraft
//
//  Created by taizi on 15/12/25.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import "QGGImagePickerCollectionView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "QGGImagePickerCell.h"

static NSString *kQGGImagePickerCellIdentify = @"QGGImagePickerCell";

@interface QGGImagePickerCollectionView ()<UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UICollectionViewDelegate,QGGImagePickerCellDelegate>

@end

@implementation QGGImagePickerCollectionView

- (instancetype)init {

    return [self initWithFrame:CGRectZero];

}

- (instancetype)initWithFrame:(CGRect)frame
{
    UICollectionViewFlowLayout *flowLayout=[[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    return [self initWithFrame:frame collectionViewLayout:flowLayout];

}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self initCommon];
    }
    return self;
}

- (void)initCommon {
    _minSelectNum = 1;
    _maxSelectNum = 5;
    self.delegate = self;
    self.dataSource = self;
    self.backgroundColor = [UIColor whiteColor];
    [self registerClass:[QGGImagePickerCell class] forCellWithReuseIdentifier:kQGGImagePickerCellIdentify];
}

-(void)setAssetsGroup:(ALAssetsGroup *)assetsGroup {
    _assetsGroup = assetsGroup;
    if (assetsGroup) {
        [self setUpAssets];
    }else {
        [self reloadData];
    }
}


#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.assets count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QGGImagePickerCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kQGGImagePickerCellIdentify forIndexPath:indexPath];
    cell.delegate = self;
    ALAsset *asset = self.assets[indexPath.row];
    cell.asset = asset;
    cell.isSelected = ([self.selectedAssets containsObject:asset]);
    return cell;
}

#pragma mark UICollectionViewDelegate
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(4, 0, 4, 0);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = (collectionView.bounds.size.width - 12)/4.0;
    return CGSizeMake(width, width);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 4.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 4.0;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"didSelect");
    if (self.imagePickerCollectionViewDelegate &&  [self.imagePickerCollectionViewDelegate respondsToSelector:@selector(didSelectItemAtIndex:assets:selectAssets:)]) {
        [self.imagePickerCollectionViewDelegate didSelectItemAtIndex:indexPath.row assets:self.assets selectAssets:self.selectedAssets];
    }
}


- (void)setUpAssets {
    [self.assets removeAllObjects];
    [self.selectedAssets removeAllObjects];
    if (self.imagePickerCollectionViewDelegate && [self.imagePickerCollectionViewDelegate respondsToSelector:@selector(didSelectAssetsChange:)]) {
        [self.imagePickerCollectionViewDelegate didSelectAssetsChange:self.selectedAssets];
    }
    __weak typeof(self) wSelf = self;
    [self.assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result) {
            [wSelf.assets insertObject:result atIndex:0];
//            [wSelf.assets addObject:result];
        }else if([self.assets count] > 0) {
            [wSelf reloadData];
        }
    }];
}

#pragma mark -QGGImagePickerCellDelegate

- (void) cell:(QGGImagePickerCell *)cell didSelectAsset:(ALAsset *)asset {
    if ([self.selectedAssets count] >= self.maxSelectNum) {//选择数大于最大选中数
        if (self.imagePickerCollectionViewDelegate && [self.imagePickerCollectionViewDelegate respondsToSelector:@selector(didSelectNumOverMaxNum:)]) {
            [self.imagePickerCollectionViewDelegate didSelectNumOverMaxNum:self.maxSelectNum];
        }
        return;
    }
    if (asset && ![self.selectedAssets containsObject:asset]) {
        [self.selectedAssets addObject:asset];
        if (self.imagePickerCollectionViewDelegate && [self.imagePickerCollectionViewDelegate respondsToSelector:@selector(didSelectAssetsChange:)]) {
            [self.imagePickerCollectionViewDelegate didSelectAssetsChange:self.selectedAssets];
        }
    }
    cell.isSelected = YES;
    
}

- (void) cell:(QGGImagePickerCell *)cell didUnSelectAsset:(ALAsset *)asset{
    if (asset && [self.selectedAssets containsObject:asset]) {
        [self.selectedAssets removeObject:asset];
        if (self.imagePickerCollectionViewDelegate && [self.imagePickerCollectionViewDelegate respondsToSelector:@selector(didSelectAssetsChange:)]) {
            [self.imagePickerCollectionViewDelegate didSelectAssetsChange:self.selectedAssets];
        }
    }
    cell.isSelected = NO;
}


@end
