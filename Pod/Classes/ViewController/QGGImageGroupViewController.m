//
//  QGGImageGroupViewController.m
//  QGGDraft
//
//  Created by taizi on 15/12/24.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import "QGGImageGroupViewController.h"
#import "QGGImageGroupTableView.h"
#import "QGGImagePicker.h"

@interface QGGImageGroupViewController ()<UIAlertViewDelegate>

@property (nonatomic,strong) QGGImageGroupTableView *imageGroupTableView;

@end

@implementation QGGImageGroupViewController

- (void)viewDidLoad {
    //
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    self.navigationItem.title = @"照片";
    self.imageGroupTableView = [[QGGImageGroupTableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.imageGroupTableView];
    
    __weak typeof(self) wSelf = self;
    self.imageGroupTableView.showNotAllowed = ^(){//没权限提醒
        [wSelf showNotAllowed];
    };
    self.imageGroupTableView.didSelectAssetsGroup = ^(ALAssetsGroup *assetsGroup) {//
        QGGImagePickerViewController *imagePickerVC = [[QGGImagePickerViewController alloc] init];
        imagePickerVC.assetsGroup = assetsGroup;
        imagePickerVC.delegate = wSelf.pickerVCDelegate;
        imagePickerVC.maxSelectNum = wSelf.maxSelectNum;
        imagePickerVC.minSelectNum = wSelf.minSelectNum;
        [wSelf.navigationController pushViewController:imagePickerVC animated:YES];
    };
}

- (void)cancel {
    if (self.pickerVCDelegate && [self.pickerVCDelegate respondsToSelector:@selector(cancelPick:)]) {
        [self.pickerVCDelegate cancelPick:self];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
