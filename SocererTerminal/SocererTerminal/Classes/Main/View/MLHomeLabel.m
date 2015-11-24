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
        self.scale = 0.0;
    }
    return self;
}

- (void)setScale:(CGFloat)scale {
    _scale = scale;
    
    //颜色渐变
    self.textColor = [UIColor colorWithRed:scale green:0.0 blue:0.0 alpha:1.0];
    
    //大小渐变
    CGFloat minWHScale = 0.6;
    CGFloat whScale = minWHScale + scale * (1 - minWHScale);
    self.transform =CGAffineTransformMakeScale(scale, scale);
}

@end
