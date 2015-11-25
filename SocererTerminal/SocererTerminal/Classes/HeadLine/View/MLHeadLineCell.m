//
//  MLHeadLineCell.m
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/25.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLHeadLineCell.h"
#import "MLHeadLine.h"
#import "UIImageView+WebCache.h"

@interface MLHeadLineCell ()

//特别注意: 不要与系统内部的子控件重名

//共三条线
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
// 共两条线
@property (weak, nonatomic) IBOutlet UILabel *detailTitleLabel;
// 共三条线
@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
// 共三条线
@property (weak, nonatomic) IBOutlet UILabel *replyLabel;

/** 第二张图片对象 */
@property (weak, nonatomic) IBOutlet UIImageView *imageViewTwo;
/** 第三张图片对象 */
@property (weak, nonatomic) IBOutlet UIImageView *imageViewThree;


@end

@implementation MLHeadLineCell

+ (NSString *)headlineCellWithIdentifier:(MLHeadLine *)headline
{
    if (headline.imgextra.count == 2) {
        return @"ImagesCell";
    }
    if (headline.isBigImage) {
        return @"BigImageCell";
    }
    return @"NewsCell";
}



- (void)setHeadline:(MLHeadLine *)headline
{
    _headline = headline;
    
    // 1. 为子控件设置数据
    self.titleLabel.text = headline.title;
    self.detailTitleLabel.text = headline.digest;
    self.replyLabel.text = [NSString stringWithFormat:@"%d跟帖",headline.replyCount];
    [self.iconImageView sd_setImageWithURL:[NSURL URLWithString:headline.imgsrc] placeholderImage:[UIImage imageNamed:@"loading"]];
    
    // 2. 如果是三张图片的cell模板时,需要为其它两个图片框设置图片
    if (headline.imgextra.count == 2) {
        
        // 2.1 设置第二张图片
        NSString *urlStringTwo = headline.imgextra[0][@"imgsrc"];
        [self.imageViewTwo sd_setImageWithURL:[NSURL URLWithString:urlStringTwo] placeholderImage:[UIImage imageNamed:@"loading"]];
        
        // 2.2 设置第三张图片
        NSString *urlStringThree = headline.imgextra[1][@"imgsrc"];
        [self.imageViewThree sd_setImageWithURL:[NSURL URLWithString:urlStringThree] placeholderImage:[UIImage imageNamed:@"loading"]];
    }
}

@end
