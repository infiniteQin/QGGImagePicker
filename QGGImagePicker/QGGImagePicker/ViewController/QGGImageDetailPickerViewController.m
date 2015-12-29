//
//  QGGImageDetailPickerViewController.m
//  QGGDraft
//
//  Created by taizi on 15/12/28.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import "QGGImageDetailPickerViewController.h"
#import "QGGImagePickerDetailCell.h"
#import "UIImage+QGGRenderedColor.h"
#import "UIColor+hexFloatColor.h"
#import <Masonry.h>

static NSString *kQGGImagePickerDetailCellIdentify = @"QGGImagePickerDetailCell";

@interface QGGImageDetailPickerViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UIButton         *selectBtn;
@property (nonatomic, strong) UIButton         *okBtn;
@property (nonatomic, strong) UILabel          *numLabel;
@end

@implementation QGGImageDetailPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor blackColor];

    //navigationBar
    self.selectBtn = [[UIButton alloc] init];
    [self.selectBtn setImage:[UIImage imageNamed:@"btn_check"] forState:UIControlStateSelected];
    [self.selectBtn setImage:[UIImage imageNamed:@"btn_uncheck_b"] forState:UIControlStateNormal];
    [self.selectBtn sizeToFit];
    [self.selectBtn addTarget:self action:@selector(selectAsset) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.selectBtn];
    ALAsset *asset = self.assets[self.currIndex];
    self.selectBtn.selected = ([self.selectedAssets containsObject:asset]);
    //collectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:layout];
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    [self.collectionView registerClass:[QGGImagePickerDetailCell class] forCellWithReuseIdentifier:kQGGImagePickerDetailCellIdentify];
    self.collectionView.pagingEnabled = YES;
    [self.view addSubview:self.collectionView];
    NSIndexPath *currIndexPath = [NSIndexPath indexPathForRow:self.currIndex inSection:0];
    [self.collectionView scrollToItemAtIndexPath:currIndexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    //footerView
    [self setUpFooterView];
}

- (void) viewWillAppear:(BOOL)animated {
    //设置导航与状态栏视图
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithRenderColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5] renderSize:CGSizeMake(1., 1)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:[UIImage imageWithRenderColor:[UIColor clearColor] renderSize:CGSizeMake(1., 0.5)]];
}
- (void) viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithRenderColor:[UIColor whiteColor] renderSize:CGSizeMake(1., 1)] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setShadowImage:nil];
}

- (void) setUpFooterView {
    __weak typeof(self) wSelf = self;
    UIView *footerView = [UIView new];
    footerView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    [self.view addSubview:footerView];
    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@40);
        make.left.equalTo(wSelf.view);
        make.right.equalTo(wSelf.view);
        make.bottom.equalTo(wSelf.view);
    }];
    
    self.okBtn = [UIButton new];
    self.okBtn.enabled = ([self.selectedAssets count] > 0);
    [self.okBtn setTitle:@"完成" forState:UIControlStateNormal];
    self.okBtn.titleLabel.font = [UIFont systemFontOfSize:16.];
    [self.okBtn setTitleColor:[UIColor hexFloatColor:@"5186ff"] forState:UIControlStateNormal];
    [self.okBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [footerView addSubview:self.okBtn];
    [self.okBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(footerView);
        make.right.equalTo(footerView).offset(-15);
    }];
    [self.okBtn addTarget:self action:@selector(didFinishSelect) forControlEvents:UIControlEventTouchUpInside];
    
    self.numLabel = [UILabel new];
    self.numLabel.layer.masksToBounds = YES;
    self.numLabel.layer.cornerRadius = 21./2;
    self.numLabel.backgroundColor = [UIColor hexFloatColor:@"5186ff"];
    self.numLabel.font = [UIFont systemFontOfSize:14.];
    self.numLabel.textColor = [UIColor whiteColor];
    self.numLabel.textAlignment = NSTextAlignmentCenter;
    self.numLabel.text = [NSString stringWithFormat:@"%ld",(long)[self.selectedAssets count]];
    self.numLabel.hidden = !([self.selectedAssets count] > 0);
    [footerView addSubview:self.numLabel];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(21.));
        make.width.equalTo(@(21.));
        make.centerY.equalTo(footerView);
        make.right.equalTo(wSelf.okBtn.mas_left).offset(-6);
    }];
}

/**
 *  点击完成按钮
 */
- (void)didFinishSelect {
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewController:didFinishSelect:)]) {
        [self.delegate viewController:self didFinishSelect:self.selectedAssets];
    }
}

- (void)selectAsset {
    ALAsset *currAsset = self.assets[self.currIndex];
    if (self.selectBtn.selected) {
        self.selectBtn.selected = NO;
        if ([self.selectedAssets containsObject:currAsset]) {
            [self.selectedAssets removeObject:currAsset];
        }
    }else {
        self.selectBtn.selected = YES;
        if (![self.selectedAssets containsObject:currAsset]) {
            [self.selectedAssets addObject:currAsset];
        }
    }
    self.numLabel.text = [NSString stringWithFormat:@"%ld",(long)[self.selectedAssets count]];
    self.numLabel.hidden = !([self.selectedAssets count] > 0);
    self.okBtn.enabled = ([self.selectedAssets count] > 0);
    self.numLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView animateWithDuration:0.25 animations:^{
        self.numLabel.transform = CGAffineTransformIdentity;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.assets count];
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    QGGImagePickerDetailCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kQGGImagePickerDetailCellIdentify forIndexPath:indexPath];
    cell.asset = self.assets[indexPath.row];
    return cell;
}

#pragma mark UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [UIScreen mainScreen].bounds.size;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    NSInteger tempIndex = (scrollView.contentOffset.x+[UIScreen mainScreen].bounds.size.width/2)/[UIScreen mainScreen].bounds.size.width;
    if (_currIndex != tempIndex && tempIndex >= 0 && tempIndex < [self.assets count]) {
        _currIndex = tempIndex;
        ALAsset *currAsset = self.assets[self.currIndex];
        self.selectBtn.selected = [self.selectedAssets containsObject:currAsset];
        
    }
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
