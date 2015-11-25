//
//  UIBarButtonItem+MLExtension.m
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/25.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "UIBarButtonItem+MLExtension.h"

@implementation UIBarButtonItem (MLExtension)
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
