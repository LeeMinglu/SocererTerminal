//
//  UIBarButtonItem+HMExtension.m
//  高仿网易新闻
//
//  Created by apple on 15/11/15.
//  Copyright © 2015年 itheima. All rights reserved.
//

#import "UIBarButtonItem+HMExtension.h"

@implementation UIBarButtonItem (HMExtension)

+ (instancetype)itemWithImage:(NSString *)image highImage:(NSString *)highImage target:(id)target action:(SEL)action
{
    // 创建按钮
    UIButton *button = [[UIButton alloc] init];
    [button setImage:[UIImage imageNamed:image] forState:UIControlStateNormal];
    
    // 如果没有高亮图片,那么就不进行设置
    if (highImage) {
        [button setImage:[UIImage imageNamed:highImage] forState:UIControlStateHighlighted];
    }
    
    // 获取背景图片的尺寸大小
    button.frame = (CGRect){CGPointZero, button.currentBackgroundImage.size};
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    // 将按钮包装成item对象返回
    return [[self alloc] initWithCustomView:button];
}

@end
