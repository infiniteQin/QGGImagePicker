//
//  QGGImagePickerDetailCell.m
//  QGGDraft
//
//  Created by taizi on 15/12/28.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import "QGGImagePickerDetailCell.h"
#import <Masonry.h>

@interface QGGImagePickerDetailCell ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UIImageView  *imageView;
@end

@implementation QGGImagePickerDetailCell

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
    _scrollView = [UIScrollView new];
    _scrollView.delegate = self;
    //设置伸缩比例
    _scrollView.maximumZoomScale=5.0;
    _scrollView.minimumZoomScale=0.2;
    [self.contentView addSubview:_scrollView];
    _scrollView.backgroundColor = [UIColor blackColor];
    __weak typeof(self) wSelf = self;
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.contentView);
        make.left.equalTo(wSelf.contentView);
        make.right.equalTo(wSelf.contentView);
        make.bottom.equalTo(wSelf.contentView);
    }];
    _scrollView.contentSize = [UIScreen mainScreen].bounds.size;
    
    _imageView = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _imageView.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, [UIScreen mainScreen].bounds.size.height/2);
    _imageView.contentMode = UIViewContentModeScaleAspectFit;
    [_scrollView addSubview:_imageView];
    _imageView.backgroundColor = [UIColor blackColor];
    
}

-(void)setAsset:(ALAsset *)asset {
    _scrollView.zoomScale = 1.;
    _asset = asset;
    if ([asset isKindOfClass:[UIImage class]]) {
        _imageView.image = (UIImage *)asset;
    }else {
        _imageView.image = [UIImage imageWithCGImage:asset.aspectRatioThumbnail];
    }
}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return _imageView;
}

-(void)scrollViewDidZoom:(UIScrollView *)scrollView {
    
    CGFloat xcenter = scrollView.center.x , ycenter = scrollView.center.y;
    
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : xcenter;
    
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : ycenter;
    
    _imageView.center = CGPointMake(xcenter, ycenter);
    
}

@end
