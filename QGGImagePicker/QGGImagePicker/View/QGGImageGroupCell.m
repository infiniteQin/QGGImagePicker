//
//  QGGImageGroupCell.m
//  QGGDraft
//
//  Created by taizi on 15/12/24.
//  Copyright © 2015年 Qingg. All rights reserved.
//

#import "QGGImageGroupCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <Masonry.h>
#import "ALAssetsGroup+GroupName_zh_CN.h"
@interface QGGImageGroupCell ()

@property (nonatomic, strong) UIImageView *groupImageView;
@property (nonatomic, strong) UILabel *groupTextLabel;

@end

@implementation QGGImageGroupCell

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpSubView];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUpSubView];
    }
    return self;
}

- (void)setUpSubView {
    __weak typeof(self) wSelf = self;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 57, 57)];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:imageView];
    self.groupImageView = imageView;
    
    UILabel *textLabel = [UILabel new];
    textLabel.font = [UIFont systemFontOfSize:15];
    textLabel.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:textLabel];
    self.groupTextLabel = textLabel;
    [self.groupTextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(wSelf.groupImageView.mas_right).offset(8);
        make.centerY.equalTo(wSelf.contentView);
    }];
    
    UIImageView *imgView = [UIImageView new];
    [self.contentView addSubview:imgView];
    imgView.image = [UIImage imageNamed:@"cell_arrow"];
    [imgView sizeToFit];
    
    [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(wSelf.contentView);
        make.right.equalTo(wSelf.contentView).offset(-14);
    }];
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setUpSubView];
    }
    return self;
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setAssetsGroup:(ALAssetsGroup *)assetsGroup {
    _assetsGroup = assetsGroup;
    
    CGImageRef posterImage = assetsGroup.posterImage;
    size_t height = CGImageGetHeight(posterImage);
    float scale = height / 78.0f;
    
    self.groupImageView.image = [UIImage imageWithCGImage:posterImage scale:scale orientation:UIImageOrientationUp];
    NSString *assetsGroupName = [_assetsGroup zh_CN_assetsGroupName];
    NSString *numOfAssets = [NSString stringWithFormat:@"(%ld)",(long)[assetsGroup numberOfAssets]];
    NSString *cellTitle = [NSString stringWithFormat:@"%@%@",assetsGroupName,numOfAssets];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:cellTitle];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:NSMakeRange(0, cellTitle.length)];
    [attrStr addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:NSMakeRange(assetsGroupName.length, numOfAssets.length)];
    self.groupTextLabel.attributedText = attrStr;
}

@end
