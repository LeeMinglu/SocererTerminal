//
//  MLBottomTabBar.h
//  SocererTerminal
//
//  Created by 李明禄 on 15/11/23.
//  Copyright © 2015年 SocererGroup. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MLBottomTabBar;

// 设置协议 - 将自定义内部被点击的按钮索引传给tabBarController.进行切换控制器
@protocol MLBottomTabBarDelegate <NSObject>

@optional
- (void)buttomTabBar:(MLBottomTabBar *)tabBar didClickButtonTabBarWithIndex:(int)index;



@end

@interface MLBottomTabBar : UIView
@property (nonatomic, weak) id<MLBottomTabBarDelegate> delegate;

/** 实现一个通过传入两张图片,添加底部bottomBarBtn的方法 */
- (void)addBottomBarButtonWithImage:(NSString *)normal selected:(NSString *)selected;
@end
