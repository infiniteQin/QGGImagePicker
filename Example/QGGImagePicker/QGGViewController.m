//
//  QGGViewController.m
//  QGGImagePicker
//
//  Created by taizi on 12/29/2015.
//  Copyright (c) 2015 taizi. All rights reserved.
//

#import "QGGViewController.h"
#import <QGGImagePicker/QGGImagePicker.h>

@interface QGGViewController ()

@end

@implementation QGGViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)testImagePicker:(id)sender {
    QGGImagePicker *imagePicker = [QGGImagePicker imagePickerWithRootView:self didFinishPick:^(NSArray<ALAsset *> *assets) {
        
    } cancelPickBlock:^{
        
    } overMaxSelectNumBlock:^(UIViewController *currVC, NSInteger maxSelectNum) {
        
    }];
    [imagePicker showDefaultImageLab];
}

@end
