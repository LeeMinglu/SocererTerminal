//
//  MLLeftDockMenu.m
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/24.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import "MLLeftDockMenu.h"

@implementation MLLeftDockMenu

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        //设置一个背景色
        self.backgroundColor = MLRandomColor;
        
        //创建子控件
        // 创建子控件
        [self setupButtonWithIcon:@"sidebar_nav_news" title:@"新闻"];
        
        [self setupButtonWithIcon:@"sidebar_nav_reading" title:@"订阅"];
        [self setupButtonWithIcon:@"sidebar_nav_photo" title:@"图片"];
        [self setupButtonWithIcon:@"sidebar_nav_video" title:@"视频"];
        [self setupButtonWithIcon:@"sidebar_nav_comment" title:@"跟帖"];
        [self setupButtonWithIcon:@"sidebar_nav_radio" title:@"电视"];
        
    }
    return self;
}

- (UIButton  *) setupButtonWithIcon:(NSString *)icon title:(NSString *)title {
    UIButton *btn = [[UIButton alloc] init];
    
    btn.tag = self.subviews.count;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:btn];
    
    //设置图片和文字
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:18];
    
    //设置背景颜色
    btn.backgroundColor = MLRandomColor;
    
    //设置按钮的内容左对齐
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    //设置间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    
    return btn;
    
}

//计算控件的frame
- (void)layoutSubviews {
    [super layoutSubviews];
    
    //设置按钮的frame
    
    NSUInteger btncount = self.subviews.count;
    
    CGFloat btnW = self.width;
    CGFloat btnH = self.height / btncount;
    
    for (int i =0; i < btncount; i++) {
        UIButton *btn = self.subviews[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.y = i * btnH;
    }
}

/**监听按钮点击*/
- (void)buttonClick:(UIButton *)button {
    
    //找出被点击按钮的索引
    [MLNoteCenter postNotificationName:MLLeftDockMenuDidSelectNotification object:nil userInfo:@{MLSelectedLeftDockMenuIndexKey : @(button.tag)}];
}

@end
