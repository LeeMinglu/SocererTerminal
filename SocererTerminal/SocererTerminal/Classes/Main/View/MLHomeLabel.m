//
//  MLHomeLabel.m
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/24.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLHomeLabel.h"

@implementation MLHomeLabel

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.textAlignment = NSTextAlignmentCenter;
        self.font = [UIFont systemFontOfSize:20];
        self.userInteractionEnabled = YES;
//        self.backgroundColor = [UIColor colorWithRed:((float)arc4random_uniform(256) / 255.0) green:((float)arc4random_uniform(256) / 255.0) blue:((float)arc4random_uniform(256) / 255.0) alpha:1.0];
        self.scale = 0.0;
    }
    return self;
}
//根据scale设置文字的大小入颜色
- (void)setScale:(CGFloat)scale {
    _scale = scale;
    
    //颜色渐变
    self.textColor = [UIColor colorWithRed:scale green:0.0 blue:0.0 alpha:1.0];
    
    //大小渐变
    CGFloat minWHScale = 0.6;
    CGFloat whScale = minWHScale + scale * (1 - minWHScale);
    self.transform =CGAffineTransformMakeScale(whScale, whScale);
}

@end
