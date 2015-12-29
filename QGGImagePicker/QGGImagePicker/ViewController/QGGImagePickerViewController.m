//
//  QGGImagePickerViewController.m
//  QGGDraft
//
//  Created by taizi on 15/12/24.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import "QGGImagePickerViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "QGGImagePickerCollectionView.h"
#import "ALAssetsGroup+GroupName_zh_CN.h"
#import <Masonry.h>
#import "UIColor+hexFloatColor.h"
#import "QGGImageDetailPickerViewController.h"

@interface QGGImagePickerViewController ()<QGGImagePickerCollectionViewDelegate>
@property (nonatomic, strong) QGGImagePickerCollectionView *imagePickerCollectionView;
@property (nonatomic, strong) ALAssetsLibrary              *assetsLibrary;
@property (nonatomic, strong) UIButton                     *preViewBtn;//预览
@property (nonatomic, strong) UIButton                     *okBtn;//完成
@property (nonatomic, strong) UILabel                      *numLabel;//选中数量
@property (nonatomic, strong) NSMutableArray<ALAsset*>     *selectAssets;
@end

@implementation QGGImagePickerViewController

- (instancetype)init
{
    self = [super init];
    if (self) {
        _assetsFilter = [ALAssetsFilter allPhotos];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.view.backgroundColor = [UIColor whiteColor];
    self.imagePickerCollectionView = [[QGGImagePickerCollectionView alloc] init];
    self.imagePickerCollectionView.maxSelectNum = self.maxSelectNum;
    self.imagePickerCollectionView.minSelectNum = self.minSelectNum;
    self.imagePickerCollectionView.imagePickerCollectionViewDelegate = self;
    [self.view addSubview:self.imagePickerCollectionView];
    [self setUpAssetsGroup:self.assetsGroup];
    __weak typeof(self) wSelf = self;
    [self.imagePickerCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.view);
        make.left.equalTo(wSelf.view);
        make.right.equalTo(wSelf.view);
        make.bottom.equalTo(wSelf.view).offset(-40);
    }];
    CGFloat onePix = 1.0/[UIScreen mainScreen].scale;
    
    UIView *footerView = [UIView new];
    footerView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:footerView];
    [footerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(wSelf.imagePickerCollectionView.mas_bottom);
        make.left.equalTo(wSelf.view);
        make.right.equalTo(wSelf.view);
        make.bottom.equalTo(wSelf.view);
    }];
    UIView *sepLine = [UIView new];
    sepLine.backgroundColor = [UIColor hexFloatColor:@"dadada"];
    [footerView addSubview:sepLine];
    [sepLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(footerView);
        make.left.equalTo(footerView);
        make.right.equalTo(footerView);
        make.height.equalTo(@(onePix));
    }];
    
    self.preViewBtn = [UIButton new];
    self.preViewBtn.enabled = NO;
    self.preViewBtn.titleLabel.font = [UIFont systemFontOfSize:16.];
    [self.preViewBtn setTitle:@"预览" forState:UIControlStateNormal];
    [self.preViewBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.preViewBtn setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [footerView addSubview:self.preViewBtn];
    [self.preViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(footerView);
        make.left.equalTo(footerView).offset(15);
    }];
    [self.preViewBtn addTarget:self action:@selector(preViewAssets) forControlEvents:UIControlEventTouchUpInside];
    
    self.okBtn = [UIButton new];
    self.okBtn.enabled = NO;
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
    [footerView addSubview:self.numLabel];
    [self.numLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(21.));
        make.width.equalTo(@(21.));
        make.centerY.equalTo(footerView);
        make.right.equalTo(wSelf.okBtn.mas_left).offset(-6);
    }];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.imagePickerCollectionView reloadData];
    [self updateFooterView];
}

- (void)cancel {
    if (self.delegate && [self.delegate respondsToSelector:@selector(cancelPick:)]) {
        [self.delegate cancelPick:self];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpAssetsGroup:(ALAssetsGroup *)assetsGroup {
    if (assetsGroup) {
        self.imagePickerCollectionView.assetsGroup = assetsGroup;
        self.navigationItem.title = [assetsGroup zh_CN_assetsGroupName];
    }else {
        [self setUpDefaultAsstsGroup];
    }
}

//加载相册
- (void)setUpDefaultAsstsGroup {
    __weak typeof(self) wSelf = self;
    //显示相册
    NSUInteger type = ALAssetsGroupSavedPhotos;
    [self.assetsLibrary enumerateGroupsWithTypes:type usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group){
            [group setAssetsFilter:wSelf.assetsFilter];
            if (group.numberOfAssets > 0){
                [wSelf setUpAssetsGroup:group];
                *stop = YES;
            }
        }
    } failureBlock:^(NSError *error) {
        
    }];
}

#pragma mark - ALAssetsLibrary
- (ALAssetsLibrary *)assetsLibrary {
    if (!_assetsLibrary) {
        static dispatch_once_t once_token;
        static ALAssetsLibrary *library;
        dispatch_once(&once_token, ^{
            library = [[ALAssetsLibrary alloc] init];
        });
        _assetsLibrary = library;
    }
    return _assetsLibrary;
}


#pragma mark - 没有访问权限提示
- (void)showNotAllowed {
    //没有权限时隐藏部分控件
    UIAlertView *alert;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 8.0) {
        alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                           message:@"请在设备的“设置”-“隐私”-“相机”中，找到对应APP更改"
                                          delegate:nil
                                 cancelButtonTitle:@"确定"
                                 otherButtonTitles:nil, nil];
    } else {
        alert = [[UIAlertView alloc] initWithTitle:@"提示"
                                           message:@"请先允许访问相机"
                                          delegate:self
                                 cancelButtonTitle:@"取消"
                                 otherButtonTitles:@"前往", nil];
    }
    [alert show];
}

#pragma mark -UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [[UIApplication sharedApplication] openURL:[NSURL  URLWithString:UIApplicationOpenSettingsURLString]];
    }
}

#pragma mark -QGGImageViewPickerCollectionViewDelegate
- (void) didSelectNumOverMaxNum:(NSInteger)maxSelectNum {
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewController:didSelectNumOverMaxNum:)]) {
        [self.delegate viewController:self didSelectNumOverMaxNum:maxSelectNum];
    }
}

- (void)didSelectAssetsChange:(NSArray<ALAsset *> *)assets {
    [self.selectAssets removeAllObjects];
    self.selectAssets = [NSMutableArray arrayWithArray:assets];
    [self updateFooterView];
}

- (void)updateFooterView {
    BOOL flag = ([self.selectAssets count] > 0);
    self.okBtn.enabled = flag;
    self.preViewBtn.enabled = flag;
    self.numLabel.hidden = !flag;
    self.numLabel.text = [NSString stringWithFormat:@"%ld",(long)[self.selectAssets count]];
    self.numLabel.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.1, 0.1);
    [UIView animateWithDuration:0.25 animations:^{
        self.numLabel.transform = CGAffineTransformIdentity;
    }];
}

- (void)didSelectItemAtIndex:(NSUInteger)index assets:(NSMutableArray<ALAsset *> *)assets selectAssets:(NSMutableArray<ALAsset *> *)selectAssets {
    self.selectAssets = selectAssets;
    QGGImageDetailPickerViewController *imgDetailPickerVC = [[QGGImageDetailPickerViewController alloc] init];
    imgDetailPickerVC.assets = [assets copy];
    imgDetailPickerVC.selectedAssets = self.selectAssets;
    imgDetailPickerVC.currIndex = index;
    imgDetailPickerVC.delegate = self.delegate;
    [self.navigationController pushViewController:imgDetailPickerVC animated:YES];
}


/**
 *  完成
 */
- (void)didFinishSelect {
    if (self.delegate && [self.delegate respondsToSelector:@selector(viewController:didFinishSelect:)]) {
        [self.delegate viewController:self didFinishSelect:self.selectAssets];
    }
}

/**
 *  预览
 */
- (void)preViewAssets {
    QGGImageDetailPickerViewController *imgDetailPickerVC = [[QGGImageDetailPickerViewController alloc] init];
    imgDetailPickerVC.assets = [self.selectAssets copy];
    imgDetailPickerVC.selectedAssets = self.selectAssets;
    imgDetailPickerVC.currIndex = 0;
    imgDetailPickerVC.delegate = self.delegate;
    [self.navigationController pushViewController:imgDetailPickerVC animated:YES];
}

- (NSMutableArray*)selectAssets {
    if (!_selectAssets) {
        _selectAssets = [NSMutableArray array];
    }
    return _selectAssets;
}

@end
