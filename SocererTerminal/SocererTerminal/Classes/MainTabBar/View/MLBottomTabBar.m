//
//  MLBottomTabBar.m
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/23.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLBottomTabBar.h"
#import "MLBottomTabBarBtn.h"

@interface MLBottomTabBar ()
/**
 *  记录当前选择的按钮
 */
@property (nonatomic, weak) UIButton *selectedButton;

@end

@implementation MLBottomTabBar

- (void)addBottomBarButtonWithImage:(NSString *)normal selected:(NSString *)selected {
    
    //1.创建一个按钮
    MLBottomTabBarBtn *btn = [[MLBottomTabBarBtn alloc] init];
    
    //2.设置按钮的背景图片
    [btn setBackgroundImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [btn setBackgroundImage:[UIImage imageNamed:selected] forState:UIControlStateSelected];
    
    //3.把按钮添加到底部的bottomTabBar中
    [self addSubview:btn];
    
    //4.为按钮添加监听的事件
    [btn addTarget:self action:@selector(didClickTabBarButton:) forControlEvents:UIControlEventTouchUpInside];
    
}

//tabbarButton点击事件
- (void)didClickTabBarButton:(UIButton *)button {
    //1.让当前被选中的按钮取消选中状态
    self.selectedButton.selected = NO;
    
    //2.设置传进来的button为选中状态
    button.selected = YES;
    
    //3.将传进来的按钮设置为显示状态
    self.selectedButton = button;
    
    //4.获取当前选中按钮的索引,调用代理协议的方法,让tabBarController来切换当前显示的子控制器
    int index = (int)button.tag;
    
    
    //判断代理是否实现了协议中的方法,如果实现了就调用
    if ([self.delegate respondsToSelector:@selector(buttomTabBar:didClickButtonTabBarWithIndex:)]) {
        
        [self.delegate buttomTabBar:self didClickButtonTabBarWithIndex:index];
    }
  
}

- (void)layoutSubviews {
    [super layoutSubviews];
    //获取总按钮的长度
    NSUInteger count = self.subviews.count;
    
    //设置frame
    CGFloat w = self.frame.size.width / count;
    CGFloat h = self.frame.size.height;
    CGFloat y = 0;
    
    for (int i = 0; i < count; i++) {
        CGFloat x = i * w;
        UIButton *button = self.subviews[i];
        button.frame = CGRectMake(x, y, w, h);
        
        //为每一个按钮绑定一个tag值
        button.tag = i;
        if (i == 0) {
            button.selected = YES;
            self.selectedButton = button;
        }
        
    }
}


@end
