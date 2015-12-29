//
//  QGGImageGroupTableView.m
//  QGGDraft
//
//  Created by taizi on 15/12/24.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import "QGGImageGroupTableView.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIColor+hexFloatColor.h"
#import "QGGImageGroupCell.h"


static NSString *cellIdentifer = @"cell";

@interface QGGImageGroupTableView()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) ALAssetsLibrary *assetsLibrary;
@property (nonatomic, strong) NSMutableArray *groups;
@end


@implementation QGGImageGroupTableView

#pragma mark - init
- (instancetype)init {
    self = [super init];
    if (self) {
        [self initCommon];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self initCommon];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initCommon];
    }
    return self;
}

- (void)initCommon {
    self.delegate = self;
    self.dataSource = self;
    _assetsFilter = [ALAssetsFilter allPhotos];
    [self registerClass:[QGGImageGroupCell class] forCellReuseIdentifier:cellIdentifer];
    self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    self.separatorColor = [UIColor hexFloatColor:@"dadada"];
    self.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    self.backgroundColor = [UIColor whiteColor];
    [self setupGroup];
    self.tableFooterView = [UIView new];
}

//加载相册
- (void)setupGroup {
    [self.groups removeAllObjects];
    __weak typeof(self) wSelf = self;
    //显示相册
    NSUInteger type = ALAssetsGroupSavedPhotos | ALAssetsGroupPhotoStream |
    ALAssetsGroupLibrary | ALAssetsGroupAlbum | ALAssetsGroupEvent |
    ALAssetsGroupFaces  ;
    [self.assetsLibrary enumerateGroupsWithTypes:type usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                                          if (group){
                                              [group setAssetsFilter:wSelf.assetsFilter];
                                              if (group.numberOfAssets > 0){
                                                  if ([[group valueForProperty:ALAssetsGroupPropertyType] intValue]==ALAssetsGroupSavedPhotos){
                                                      [wSelf.groups insertObject:group atIndex:0];
                                                  } else if ([[group valueForProperty:ALAssetsGroupPropertyType] intValue]==ALAssetsGroupPhotoStream && self.groups.count>0){
                                                      [wSelf.groups insertObject:group atIndex:1];
                                                  } else {
                                                      [wSelf.groups addObject:group];
                                                  }
                                              }
                                          }else {
                                              [wSelf dataReload];
                                          }
                                      } failureBlock:^(NSError *error) {
                                          [wSelf showNotAllowedInfo];
                                      }];
}

#pragma mark - Reload Data
- (void)dataReload {
    if (self.groups.count == 0){
        //没有相册
        [self showNoAssets];
    }
    [self reloadData];
}

#pragma mark - Not allowed / No assets
- (void)showNotAllowedInfo {
    if (self.showNotAllowed) {
        self.showNotAllowed();
    }
}


- (void)showNoAssets {
//    NSLog(@"%s",__func__);
}


#pragma mark - UITableViewDelegate
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QGGImageGroupCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifer forIndexPath:indexPath];
    if(!cell){
        cell = [[QGGImageGroupCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifer];
        cell.separatorInset = UIEdgeInsetsMake(0, 57, 0, 0);
    }
    cell.assetsGroup = [self.groups objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groups.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 57.0;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, 57, 0, 0)];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    ALAssetsGroup *group = [self.groups objectAtIndex:indexPath.row];
    if (self.didSelectAssetsGroup) {
        self.didSelectAssetsGroup(group);
    }
}

#pragma mark - getter/setter
- (NSMutableArray *)groups {
    if (!_groups) {
        _groups = [[NSMutableArray alloc] init];
    }
    return _groups;
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

@end
