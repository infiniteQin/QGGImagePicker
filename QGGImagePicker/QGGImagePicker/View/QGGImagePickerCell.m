//
//  QGGImagePickerCell.m
//  QGGDraft
//
//  Created by taizi on 15/12/25.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import "QGGImagePickerCell.h"
#import "QGGTapAnimationView.h"
#import <Masonry.h>

@interface QGGImagePickerCell ()
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIButton    *btn;
@end

@implementation QGGImagePickerCell

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setUpViews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpViews];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpViews];
    }
    return self;
}

- (void)setUpViews {
    __weak typeof(self) wSelf = self;
    
    //imageview
    _imageView = [UIImageView new];
    _imageView.userInteractionEnabled = YES;
    _imageView.layer.masksToBounds = YES;
    _imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_imageView];
    [_imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.contentView);
        make.left.equalTo(wSelf.contentView);
        make.right.equalTo(wSelf.contentView);
        make.bottom.equalTo(wSelf.contentView);
    }];
    
    //btn
    _btn = [UIButton new];
    [self.contentView addSubview:_btn];
    [_btn setImage:[UIImage imageNamed:@"btn_uncheck_b"] forState:UIControlStateNormal];
    [_btn setImage:[UIImage imageNamed:@"btn_check"] forState:UIControlStateSelected];
    [_btn sizeToFit];
    [_btn addTarget:self action:@selector(selectOrRemoveAsset) forControlEvents:UIControlEventTouchDown];
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.contentView).offset(4);
        make.right.equalTo(wSelf.contentView).offset(-4);
    }];
    
//    QGGTapAnimationView *tapAnimationView = [QGGTapAnimationView new];
//    tapAnimationView.multipleTouchEnabled = YES;
//    tapAnimationView.backgroundColor = [UIColor grayColor];
//    [self.contentView addSubview:tapAnimationView];
//    [tapAnimationView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(wSelf.contentView);
//        make.left.equalTo(wSelf.contentView);
//        make.right.equalTo(wSelf.contentView);
//        make.bottom.equalTo(wSelf.contentView);
//    }];
}


- (void)selectOrRemoveAsset {
    if (!self.isSelected) {//选中
        if (self.delegate && [self.delegate respondsToSelector:@selector(cell:didSelectAsset:)]) {
            [self.delegate cell:self didSelectAsset:self.asset];
        }
    }else {//取消选中
        if (self.delegate && [self.delegate respondsToSelector:@selector(cell:didUnSelectAsset:)]) {
            [self.delegate cell:self didUnSelectAsset:self.asset];
        }
    }
}

- (void)setAsset:(ALAsset *)asset {
    _asset = asset;
    if ([asset isKindOfClass:[UIImage class]]) {
        _imageView.image = (UIImage *)asset;
    }else {
        _imageView.image = [UIImage imageWithCGImage:asset.aspectRatioThumbnail];
    }
}

- (void)setIsSelected:(BOOL)isSelected {
    _isSelected = isSelected;
    self.btn.selected = isSelected;
}

@end
