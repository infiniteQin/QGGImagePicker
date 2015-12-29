//
//  QGGImageGroupTableView.h
//  QGGDraft
//
//  Created by taizi on 15/12/24.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ALAssetsGroup;
@class ALAssetsFilter;

typedef void (^DidSelectAssetsGroup)(ALAssetsGroup *assetsGroup);
typedef void (^ShowNotAllowed)();

@interface QGGImageGroupTableView : UITableView

@property (nonatomic, copy)   DidSelectAssetsGroup  didSelectAssetsGroup;
@property (nonatomic, copy)   ShowNotAllowed        showNotAllowed;
@property (nonatomic, strong) ALAssetsFilter        *assetsFilter;//默认allPhoto

@end
