//
//  TVViewCell.m
//  TV
//
//  Created by 李明禄 on 15/12/20.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "TVViewCell.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVKit/AVKit.h>
@interface TVViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *tvNameLabel;

@end

@implementation TVViewCell

- (void)setTv:(TV *)tv {
    _tv = tv;
    self.tvNameLabel.text = tv.title;
    
}


@end
