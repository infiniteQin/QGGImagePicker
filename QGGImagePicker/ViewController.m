//
//  ViewController.m
//  QGGImagePicker
//
//  Created by taizi on 15/12/29.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import "ViewController.h"
#import "QGGImagePicker.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)showImagePicker:(id)sender {
    QGGImagePicker *imagePicker = [QGGImagePicker imagePickerWithRootView:self didFinishPick:^(NSArray<ALAsset *> *assets) {
        
    } cancelPickBlock:^{
        
    } overMaxSelectNumBlock:^(UIViewController *currVC, NSInteger maxSelectNum) {
        
    }];
    imagePicker.maxSelectNum = 3;//默认为5
    [imagePicker showDefaultImageLab];
}

@end
